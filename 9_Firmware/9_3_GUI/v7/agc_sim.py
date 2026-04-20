"""
v7.agc_sim -- Bit-accurate AGC simulation matching rx_gain_control.v.

Provides stateful, frame-by-frame AGC processing for the Raw IQ Replay
mode and offline analysis.  All gain encoding, clamping, and attack/decay/
holdoff logic is identical to the FPGA RTL.

Classes:
  - AGCState       -- mutable internal AGC state (gain, holdoff counter)
  - AGCFrameResult -- per-frame AGC metrics after processing

Functions:
  - signed_to_encoding  -- signed gain (-7..+7) -> 4-bit encoding
  - encoding_to_signed  -- 4-bit encoding -> signed gain
  - clamp_gain          -- clamp to [-7, +7]
  - apply_gain_shift    -- apply gain_shift to 16-bit IQ arrays
  - process_agc_frame   -- run one frame through AGC, update state
"""

from __future__ import annotations

from dataclasses import dataclass, field

import numpy as np


# ---------------------------------------------------------------------------
# FPGA AGC parameters (rx_gain_control.v reset defaults)
# ---------------------------------------------------------------------------
AGC_TARGET_DEFAULT = 200   # host_agc_target (8-bit)
AGC_ATTACK_DEFAULT = 1     # host_agc_attack (4-bit)
AGC_DECAY_DEFAULT = 1      # host_agc_decay  (4-bit)
AGC_HOLDOFF_DEFAULT = 4    # host_agc_holdoff (4-bit)


# ---------------------------------------------------------------------------
# Gain encoding helpers (match RTL signed_to_encoding / encoding_to_signed)
# ---------------------------------------------------------------------------

def signed_to_encoding(g: int) -> int:
    """Convert signed gain (-7..+7) to gain_shift[3:0] encoding.

    [3]=0, [2:0]=N  ->  amplify  (left shift) by N
    [3]=1, [2:0]=N  ->  attenuate (right shift) by N
    """
    if g >= 0:
        return g & 0x07
    return 0x08 | ((-g) & 0x07)


def encoding_to_signed(enc: int) -> int:
    """Convert gain_shift[3:0] encoding to signed gain."""
    if (enc & 0x08) == 0:
        return enc & 0x07
    return -(enc & 0x07)


def clamp_gain(val: int) -> int:
    """Clamp to [-7, +7] (matches RTL clamp_gain function)."""
    return max(-7, min(7, val))


# ---------------------------------------------------------------------------
# Apply gain shift to IQ data (matches RTL combinational logic)
# ---------------------------------------------------------------------------

def apply_gain_shift(
    frame_i: np.ndarray,
    frame_q: np.ndarray,
    gain_enc: int,
) -> tuple[np.ndarray, np.ndarray, int]:
    """Apply gain_shift encoding to 16-bit signed IQ arrays.

    Returns (shifted_i, shifted_q, overflow_count).
    Matches the RTL: left shift = amplify, right shift = attenuate,
    saturate to +/-32767 on overflow.
    """
    direction = (gain_enc >> 3) & 1  # 0=amplify, 1=attenuate
    amount = gain_enc & 0x07

    if amount == 0:
        return frame_i.copy(), frame_q.copy(), 0

    if direction == 0:
        # Left shift (amplify)
        si = frame_i.astype(np.int64) * (1 << amount)
        sq = frame_q.astype(np.int64) * (1 << amount)
    else:
        # Arithmetic right shift (attenuate)
        si = frame_i.astype(np.int64) >> amount
        sq = frame_q.astype(np.int64) >> amount

    # Count overflows (post-shift values outside 16-bit signed range)
    overflow_i = (si > 32767) | (si < -32768)
    overflow_q = (sq > 32767) | (sq < -32768)
    overflow_count = int((overflow_i | overflow_q).sum())

    # Saturate to +/-32767
    si = np.clip(si, -32768, 32767).astype(np.int16)
    sq = np.clip(sq, -32768, 32767).astype(np.int16)

    return si, sq, overflow_count


# ---------------------------------------------------------------------------
# AGC state and per-frame result dataclasses
# ---------------------------------------------------------------------------

@dataclass
class AGCConfig:
    """AGC tuning parameters (mirrors FPGA host registers 0x28-0x2C)."""

    enabled: bool = False
    target: int = AGC_TARGET_DEFAULT    # 8-bit peak target
    attack: int = AGC_ATTACK_DEFAULT    # 4-bit attenuation step
    decay: int = AGC_DECAY_DEFAULT      # 4-bit gain-up step
    holdoff: int = AGC_HOLDOFF_DEFAULT  # 4-bit frames to hold


@dataclass
class AGCState:
    """Mutable internal AGC state — persists across frames."""

    gain: int = 0                # signed gain, -7..+7
    holdoff_counter: int = 0     # frames remaining before gain-up allowed
    was_enabled: bool = False    # tracks enable transitions


@dataclass
class AGCFrameResult:
    """Per-frame AGC metrics returned by process_agc_frame()."""

    gain_enc: int = 0         # gain_shift[3:0] encoding applied this frame
    gain_signed: int = 0      # signed gain for display
    peak_mag_8bit: int = 0    # pre-gain peak magnitude (upper 8 of 15 bits)
    saturation_count: int = 0  # post-gain overflow count (clamped to 255)
    overflow_raw: int = 0     # raw overflow count (unclamped)
    shifted_i: np.ndarray = field(default_factory=lambda: np.array([], dtype=np.int16))
    shifted_q: np.ndarray = field(default_factory=lambda: np.array([], dtype=np.int16))


# ---------------------------------------------------------------------------
# Per-frame AGC processing (bit-accurate to rx_gain_control.v)
# ---------------------------------------------------------------------------

def quantize_iq(frame: np.ndarray) -> tuple[np.ndarray, np.ndarray]:
    """Quantize complex IQ to 16-bit signed I and Q arrays.

    Input: 2-D complex array (chirps x samples) — any complex dtype.
    Output: (frame_i, frame_q) as int16.
    """
    frame_i = np.clip(np.round(frame.real), -32768, 32767).astype(np.int16)
    frame_q = np.clip(np.round(frame.imag), -32768, 32767).astype(np.int16)
    return frame_i, frame_q


def process_agc_frame(
    frame_i: np.ndarray,
    frame_q: np.ndarray,
    config: AGCConfig,
    state: AGCState,
) -> AGCFrameResult:
    """Run one frame through the FPGA AGC inner loop.

    Mutates *state* in place (gain and holdoff_counter).
    Returns AGCFrameResult with metrics and shifted IQ data.

    Parameters
    ----------
    frame_i, frame_q : int16 arrays (any shape, typically chirps x samples)
    config : AGC tuning parameters
    state  : mutable AGC state from previous frame
    """
    # --- PRE-gain peak measurement (RTL lines 133-135, 211-213) ---
    abs_i = np.abs(frame_i.astype(np.int32))
    abs_q = np.abs(frame_q.astype(np.int32))
    max_iq = np.maximum(abs_i, abs_q)
    frame_peak_15bit = int(max_iq.max()) if max_iq.size > 0 else 0
    peak_8bit = (frame_peak_15bit >> 7) & 0xFF

    # --- Handle AGC enable transition (RTL lines 250-253) ---
    if config.enabled and not state.was_enabled:
        state.gain = 0
        state.holdoff_counter = config.holdoff
    state.was_enabled = config.enabled

    # --- Determine effective gain encoding ---
    if config.enabled:
        effective_enc = signed_to_encoding(state.gain)
    else:
        effective_enc = signed_to_encoding(state.gain)

    # --- Apply gain shift + count POST-gain overflow ---
    shifted_i, shifted_q, overflow_raw = apply_gain_shift(
        frame_i, frame_q, effective_enc)
    sat_count = min(255, overflow_raw)

    # --- AGC update at frame boundary (RTL lines 226-246) ---
    if config.enabled:
        if sat_count > 0:
            # Clipping: reduce gain immediately (attack)
            state.gain = clamp_gain(state.gain - config.attack)
            state.holdoff_counter = config.holdoff
        elif peak_8bit < config.target:
            # Signal too weak: increase gain after holdoff
            if state.holdoff_counter == 0:
                state.gain = clamp_gain(state.gain + config.decay)
            else:
                state.holdoff_counter -= 1
        else:
            # Good range (peak >= target, no sat): hold, reset holdoff
            state.holdoff_counter = config.holdoff

    return AGCFrameResult(
        gain_enc=effective_enc,
        gain_signed=state.gain if config.enabled else encoding_to_signed(effective_enc),
        peak_mag_8bit=peak_8bit,
        saturation_count=sat_count,
        overflow_raw=overflow_raw,
        shifted_i=shifted_i,
        shifted_q=shifted_q,
    )
