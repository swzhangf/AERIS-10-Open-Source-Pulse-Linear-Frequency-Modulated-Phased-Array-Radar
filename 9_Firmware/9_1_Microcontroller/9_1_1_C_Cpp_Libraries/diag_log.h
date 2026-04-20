/***************************************************************************//**
 *   @file   diag_log.h
 *   @brief  Bring-up diagnostic logging macros for AERIS-10 radar system.
 *
 *   Provides timestamped, subsystem-tagged diagnostic output over USART3.
 *   All output is observation-only instrumentation -- no behavioral changes.
 *
 *   Usage:
 *     #include "diag_log.h"
 *     DIAG("LO", "TX init returned %d", ret);
 *     DIAG_WARN("CLK", "PLL2 not locked after %lu ms", timeout);
 *     DIAG_ERR("PA", "IDQ out of range: %d mA", idq_ma);
 *     DIAG_REG("LO", "TX reg 0x58", reg_val);
 *     DIAG_GPIO("LO", "TX_LKDET", port, pin);
 *
 *   Compile-time control:
 *     #define DIAG_DISABLE   -- suppress all DIAG output
 *     #define DIAG_VERBOSE   -- include file:line in every message
 *
 *   @author AERIS-10 Bring-up Instrumentation
 *   @date   2026
 *******************************************************************************/

#ifndef DIAG_LOG_H
#define DIAG_LOG_H

#include <stdio.h>
#include <stdint.h>
#include "stm32f7xx_hal.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Core DIAG macro -- timestamped, subsystem-tagged printf.
 * Uses HAL_GetTick() for millisecond timestamps.
 * Output format: "[  12345 ms] LO: TX init returned -2\n"
 */
#ifndef DIAG_DISABLE

#ifdef DIAG_VERBOSE
#define DIAG(subsys, fmt, ...) \
    printf("[%7lu ms] %s: " fmt " (%s:%d)\n", \
           (unsigned long)HAL_GetTick(), subsys, ##__VA_ARGS__, __FILE__, __LINE__)
#else
#define DIAG(subsys, fmt, ...) \
    printf("[%7lu ms] %s: " fmt "\n", \
           (unsigned long)HAL_GetTick(), subsys, ##__VA_ARGS__)
#endif

/* Severity-tagged variants */
#define DIAG_WARN(subsys, fmt, ...) \
    printf("[%7lu ms] %s WARN: " fmt "\n", \
           (unsigned long)HAL_GetTick(), subsys, ##__VA_ARGS__)

#define DIAG_ERR(subsys, fmt, ...) \
    printf("[%7lu ms] %s **ERR**: " fmt "\n", \
           (unsigned long)HAL_GetTick(), subsys, ##__VA_ARGS__)

/* Register read diagnostic -- prints hex value */
#define DIAG_REG(subsys, name, val) \
    printf("[%7lu ms] %s: %s = 0x%02X\n", \
           (unsigned long)HAL_GetTick(), subsys, name, (unsigned int)(val))

/* Register read diagnostic -- 32-bit variant */
#define DIAG_REG32(subsys, name, val) \
    printf("[%7lu ms] %s: %s = 0x%08lX\n", \
           (unsigned long)HAL_GetTick(), subsys, name, (unsigned long)(val))

/* GPIO pin state diagnostic */
#define DIAG_GPIO(subsys, name, port, pin) \
    printf("[%7lu ms] %s: GPIO %s = %s\n", \
           (unsigned long)HAL_GetTick(), subsys, name, \
           (HAL_GPIO_ReadPin(port, pin) == GPIO_PIN_SET) ? "HIGH" : "LOW")

/* Boolean condition diagnostic */
#define DIAG_BOOL(subsys, name, val) \
    printf("[%7lu ms] %s: %s = %s\n", \
           (unsigned long)HAL_GetTick(), subsys, name, (val) ? "YES" : "NO")

/* Section separator for init sequence readability */
#define DIAG_SECTION(title) \
    printf("[%7lu ms] ======== %s ========\n", \
           (unsigned long)HAL_GetTick(), title)

/* Elapsed time helper -- use with a captured start tick */
#define DIAG_ELAPSED(subsys, label, start_tick) \
    printf("[%7lu ms] %s: %s took %lu ms\n", \
           (unsigned long)HAL_GetTick(), subsys, label, \
           (unsigned long)(HAL_GetTick() - (start_tick)))

#else /* DIAG_DISABLE */

#define DIAG(subsys, fmt, ...)              ((void)0)
#define DIAG_WARN(subsys, fmt, ...)         ((void)0)
#define DIAG_ERR(subsys, fmt, ...)          ((void)0)
#define DIAG_REG(subsys, name, val)         ((void)0)
#define DIAG_REG32(subsys, name, val)       ((void)0)
#define DIAG_GPIO(subsys, name, port, pin)  ((void)0)
#define DIAG_BOOL(subsys, name, val)        ((void)0)
#define DIAG_SECTION(title)                 ((void)0)
#define DIAG_ELAPSED(subsys, label, start)  ((void)0)

#endif /* DIAG_DISABLE */

/*
 * Subsystem tag constants -- use these for consistency:
 *   "CLK"   -- AD9523 clock generator
 *   "LO"    -- ADF4382A LO synthesizers (manager level)
 *   "LO_DRV" -- ADF4382 low-level driver
 *   "BF"    -- ADAR1000 beamformer
 *   "PA"    -- Power amplifier bias/monitoring
 *   "FPGA"  -- FPGA communication and handshake
 *   "USB"   -- USB data path (FT2232H production / FT601 premium)
 *   "PWR"   -- Power sequencing and rail monitoring
 *   "IMU"   -- IMU/GPS/barometer sensors
 *   "MOT"   -- Stepper motor/scan mechanics
 *   "SYS"   -- System-level init, health, safe-mode
 */

#ifdef __cplusplus
}
#endif

#endif /* DIAG_LOG_H */
