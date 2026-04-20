"""
v7.hardware — Hardware interface classes for the PLFM Radar GUI V7.

Provides:
  - FT2232H radar data + command interface via production radar_protocol module
  - STM32USBInterface for GPS data only (USB CDC)

The FT2232H interface uses the production protocol layer (radar_protocol.py)
which sends 4-byte {opcode, addr, value_hi, value_lo} register commands and
parses 0xAA data / 0xBB status packets from the FPGA.
"""

import sys
import os
import logging
from typing import ClassVar

from .models import USB_AVAILABLE

if USB_AVAILABLE:
    import usb.core
    import usb.util

# Import production protocol layer — single source of truth for FPGA comms
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from radar_protocol import (  # noqa: F401 — re-exported for v7 package
    FT2232HConnection,
    FT601Connection,
    RadarProtocol,
    Opcode,
    RadarAcquisition,
    RadarFrame,
    StatusResponse,
    DataRecorder,
)

logger = logging.getLogger(__name__)


# =============================================================================
# STM32 USB CDC Interface — GPS data ONLY
# =============================================================================

class STM32USBInterface:
    """
    Interface for STM32 USB CDC (Virtual COM Port).

    Used ONLY for receiving GPS data from the MCU.

    FPGA register commands are sent via the USB data interface — either
    FT2232HConnection (production) or FT601Connection (premium), both
    from radar_protocol.py. The old send_start_flag() / send_settings()
    methods have been removed — they used an incompatible magic-packet
    protocol that the FPGA does not understand.
    """

    STM32_VID_PIDS: ClassVar[list[tuple[int, int]]] = [
        (0x0483, 0x5740),   # STM32 Virtual COM Port
        (0x0483, 0x3748),   # STM32 Discovery
        (0x0483, 0x374B),
        (0x0483, 0x374D),
        (0x0483, 0x374E),
        (0x0483, 0x3752),
    ]

    def __init__(self):
        self.device = None
        self.is_open: bool = False
        self.ep_in = None
        self.ep_out = None

    # ---- enumeration -------------------------------------------------------

    def list_devices(self) -> list[dict]:
        """List available STM32 USB CDC devices."""
        if not USB_AVAILABLE:
            logger.warning("pyusb not available — cannot enumerate STM32 devices")
            return []

        devices = []
        try:
            for vid, pid in self.STM32_VID_PIDS:
                found = usb.core.find(find_all=True, idVendor=vid, idProduct=pid)
                for dev in found:
                    try:
                        product = (usb.util.get_string(dev, dev.iProduct)
                                   if dev.iProduct else "STM32 CDC")
                        serial = (usb.util.get_string(dev, dev.iSerialNumber)
                                  if dev.iSerialNumber else "Unknown")
                        devices.append({
                            "description": f"{product} ({serial})",
                            "vendor_id": vid,
                            "product_id": pid,
                            "device": dev,
                        })
                    except (usb.core.USBError, ValueError):
                        devices.append({
                            "description": f"STM32 CDC (VID:{vid:04X}, PID:{pid:04X})",
                            "vendor_id": vid,
                            "product_id": pid,
                            "device": dev,
                        })
        except (usb.core.USBError, ValueError) as e:
            logger.error(f"Error listing STM32 devices: {e}")
        return devices

    # ---- open / close ------------------------------------------------------

    def open_device(self, device_info: dict) -> bool:
        """Open STM32 USB CDC device."""
        if not USB_AVAILABLE:
            logger.error("pyusb not available — cannot open STM32 device")
            return False

        try:
            self.device = device_info["device"]

            if self.device.is_kernel_driver_active(0):
                self.device.detach_kernel_driver(0)

            self.device.set_configuration()
            cfg = self.device.get_active_configuration()
            intf = cfg[(0, 0)]

            self.ep_out = usb.util.find_descriptor(
                intf,
                custom_match=lambda e: (
                    usb.util.endpoint_direction(e.bEndpointAddress)
                    == usb.util.ENDPOINT_OUT
                ),
            )
            self.ep_in = usb.util.find_descriptor(
                intf,
                custom_match=lambda e: (
                    usb.util.endpoint_direction(e.bEndpointAddress)
                    == usb.util.ENDPOINT_IN
                ),
            )

            if self.ep_out is None or self.ep_in is None:
                logger.error("Could not find STM32 CDC endpoints")
                return False

            self.is_open = True
            logger.info(f"STM32 USB device opened: {device_info.get('description', '')}")
            return True
        except (usb.core.USBError, ValueError) as e:
            logger.error(f"Error opening STM32 device: {e}")
            return False

    def close(self):
        """Close STM32 USB device."""
        if self.device and self.is_open:
            try:
                usb.util.dispose_resources(self.device)
            except usb.core.USBError as e:
                logger.error(f"Error closing STM32 device: {e}")
        self.is_open = False
        self.device = None
        self.ep_in = None
        self.ep_out = None

    # ---- GPS data I/O ------------------------------------------------------

    def read_data(self, size: int = 64, timeout: int = 1000) -> bytes | None:
        """Read GPS data from STM32 via USB CDC."""
        if not self.is_open or self.ep_in is None:
            return None
        try:
            data = self.ep_in.read(size, timeout=timeout)
            return bytes(data)
        except usb.core.USBError:
            # Timeout or other USB error
            return None
