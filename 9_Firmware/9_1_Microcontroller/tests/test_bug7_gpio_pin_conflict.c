/*******************************************************************************
 * test_bug7_gpio_pin_conflict.c
 *
 * Bug #7 (FIXED): adf4382a_manager.h previously defined GPIOG pins 0-9 for
 * ADF4382 signals, conflicting with CubeMX main.h which assigns:
 *   - GPIOG pins 0-5 → PA enables + clock enables
 *   - GPIOG pins 6-15 → ADF4382 signals
 *
 * The fix updated manager.h pin definitions to match CubeMX:
 *   RX: LKDET=PIN_6, DELADJ=PIN_7, DELSTR=PIN_8, CE=PIN_9, CS=PIN_10
 *   TX: LKDET=PIN_11, DELSTR=PIN_12, DELADJ=PIN_13, CS=PIN_14, CE=PIN_15
 *
 * Test strategy (post-fix):
 *   1. Verify each manager.h pin definition matches the CubeMX-correct value.
 *   2. Verify NO manager.h pin overlaps with PA/clock enable pins (0-5).
 *   3. Verify all manager.h pins are in the GPIOG 6-15 range.
 ******************************************************************************/
#include <assert.h>
#include <stdio.h>
#include <stdint.h>

#include "stm32_hal_mock.h"
#include "adf4382a_manager.h"

/* ---- CubeMX-correct pin definitions from main.h ---- */
#define CUBEMX_ADF4382_RX_LKDET_Pin   GPIO_PIN_6
#define CUBEMX_ADF4382_RX_DELADJ_Pin  GPIO_PIN_7
#define CUBEMX_ADF4382_RX_DELSTR_Pin  GPIO_PIN_8
#define CUBEMX_ADF4382_RX_CE_Pin      GPIO_PIN_9
#define CUBEMX_ADF4382_RX_CS_Pin      GPIO_PIN_10

#define CUBEMX_ADF4382_TX_LKDET_Pin   GPIO_PIN_11
#define CUBEMX_ADF4382_TX_DELSTR_Pin  GPIO_PIN_12
#define CUBEMX_ADF4382_TX_DELADJ_Pin  GPIO_PIN_13
#define CUBEMX_ADF4382_TX_CS_Pin      GPIO_PIN_14
#define CUBEMX_ADF4382_TX_CE_Pin      GPIO_PIN_15

/* PA/clock enable pins that must NOT be used by ADF4382 manager */
#define PA_CLK_ENABLE_MASK  (GPIO_PIN_0 | GPIO_PIN_1 | GPIO_PIN_2 | \
                             GPIO_PIN_3 | GPIO_PIN_4 | GPIO_PIN_5)

int main(void)
{
    printf("=== Bug #7 (FIXED): GPIO pin mapping — verify CubeMX match ===\n\n");

    /* ---- 1. Verify RX pin definitions match CubeMX ---- */
    printf("  RX pin verification:\n");

    printf("    RX_LKDET_Pin  = 0x%04X  expected 0x%04X (GPIO_PIN_6)  ",
           (unsigned)RX_LKDET_Pin, (unsigned)CUBEMX_ADF4382_RX_LKDET_Pin);
    assert(RX_LKDET_Pin == CUBEMX_ADF4382_RX_LKDET_Pin);
    printf("OK\n");

    printf("    RX_DELADJ_Pin = 0x%04X  expected 0x%04X (GPIO_PIN_7)  ",
           (unsigned)RX_DELADJ_Pin, (unsigned)CUBEMX_ADF4382_RX_DELADJ_Pin);
    assert(RX_DELADJ_Pin == CUBEMX_ADF4382_RX_DELADJ_Pin);
    printf("OK\n");

    printf("    RX_DELSTR_Pin = 0x%04X  expected 0x%04X (GPIO_PIN_8)  ",
           (unsigned)RX_DELSTR_Pin, (unsigned)CUBEMX_ADF4382_RX_DELSTR_Pin);
    assert(RX_DELSTR_Pin == CUBEMX_ADF4382_RX_DELSTR_Pin);
    printf("OK\n");

    printf("    RX_CE_Pin     = 0x%04X  expected 0x%04X (GPIO_PIN_9)  ",
           (unsigned)RX_CE_Pin, (unsigned)CUBEMX_ADF4382_RX_CE_Pin);
    assert(RX_CE_Pin == CUBEMX_ADF4382_RX_CE_Pin);
    printf("OK\n");

    printf("    RX_CS_Pin     = 0x%04X  expected 0x%04X (GPIO_PIN_10) ",
           (unsigned)RX_CS_Pin, (unsigned)CUBEMX_ADF4382_RX_CS_Pin);
    assert(RX_CS_Pin == CUBEMX_ADF4382_RX_CS_Pin);
    printf("OK\n");

    /* ---- 2. Verify TX pin definitions match CubeMX ---- */
    printf("\n  TX pin verification:\n");

    printf("    TX_LKDET_Pin  = 0x%04X  expected 0x%04X (GPIO_PIN_11) ",
           (unsigned)TX_LKDET_Pin, (unsigned)CUBEMX_ADF4382_TX_LKDET_Pin);
    assert(TX_LKDET_Pin == CUBEMX_ADF4382_TX_LKDET_Pin);
    printf("OK\n");

    printf("    TX_DELSTR_Pin = 0x%04X  expected 0x%04X (GPIO_PIN_12) ",
           (unsigned)TX_DELSTR_Pin, (unsigned)CUBEMX_ADF4382_TX_DELSTR_Pin);
    assert(TX_DELSTR_Pin == CUBEMX_ADF4382_TX_DELSTR_Pin);
    printf("OK\n");

    printf("    TX_DELADJ_Pin = 0x%04X  expected 0x%04X (GPIO_PIN_13) ",
           (unsigned)TX_DELADJ_Pin, (unsigned)CUBEMX_ADF4382_TX_DELADJ_Pin);
    assert(TX_DELADJ_Pin == CUBEMX_ADF4382_TX_DELADJ_Pin);
    printf("OK\n");

    printf("    TX_CS_Pin     = 0x%04X  expected 0x%04X (GPIO_PIN_14) ",
           (unsigned)TX_CS_Pin, (unsigned)CUBEMX_ADF4382_TX_CS_Pin);
    assert(TX_CS_Pin == CUBEMX_ADF4382_TX_CS_Pin);
    printf("OK\n");

    printf("    TX_CE_Pin     = 0x%04X  expected 0x%04X (GPIO_PIN_15) ",
           (unsigned)TX_CE_Pin, (unsigned)CUBEMX_ADF4382_TX_CE_Pin);
    assert(TX_CE_Pin == CUBEMX_ADF4382_TX_CE_Pin);
    printf("OK\n");

    /* ---- 3. Verify NO overlap with PA/clock enable pins (0-5) ---- */
    printf("\n  PA/clock enable conflict check:\n");

    uint16_t all_adf_pins = RX_LKDET_Pin | RX_DELADJ_Pin | RX_DELSTR_Pin |
                            RX_CE_Pin | RX_CS_Pin |
                            TX_LKDET_Pin | TX_DELSTR_Pin | TX_DELADJ_Pin |
                            TX_CS_Pin | TX_CE_Pin;

    uint16_t overlap = all_adf_pins & PA_CLK_ENABLE_MASK;
    printf("    ADF4382 pin mask:    0x%04X\n", (unsigned)all_adf_pins);
    printf("    PA/CLK enable mask:  0x%04X\n", (unsigned)PA_CLK_ENABLE_MASK);
    printf("    Overlap:             0x%04X  ", (unsigned)overlap);
    assert(overlap == 0);
    printf("OK (no conflicts)\n");

    /* ---- 4. Verify all pins are unique (no two signals share a pin) ---- */
    printf("\n  Pin uniqueness check:\n");
    uint16_t pins[] = {
        RX_LKDET_Pin, RX_DELADJ_Pin, RX_DELSTR_Pin, RX_CE_Pin, RX_CS_Pin,
        TX_LKDET_Pin, TX_DELSTR_Pin, TX_DELADJ_Pin, TX_CS_Pin, TX_CE_Pin
    };
    const char *names[] = {
        "RX_LKDET", "RX_DELADJ", "RX_DELSTR", "RX_CE", "RX_CS",
        "TX_LKDET", "TX_DELSTR", "TX_DELADJ", "TX_CS", "TX_CE"
    };
    int n = sizeof(pins) / sizeof(pins[0]);
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (pins[i] == pins[j]) {
                printf("    FAIL: %s and %s both map to 0x%04X\n",
                       names[i], names[j], (unsigned)pins[i]);
                assert(0 && "Duplicate pin mapping detected");
            }
        }
    }
    printf("    All 10 pins are unique  OK\n");

    /* ---- 5. Verify all ports are GPIOG ---- */
    printf("\n  Port verification:\n");
    assert(RX_LKDET_GPIO_Port == GPIOG);
    assert(RX_DELADJ_GPIO_Port == GPIOG);
    assert(RX_DELSTR_GPIO_Port == GPIOG);
    assert(RX_CE_GPIO_Port == GPIOG);
    assert(RX_CS_GPIO_Port == GPIOG);
    assert(TX_LKDET_GPIO_Port == GPIOG);
    assert(TX_DELSTR_GPIO_Port == GPIOG);
    assert(TX_DELADJ_GPIO_Port == GPIOG);
    assert(TX_CS_GPIO_Port == GPIOG);
    assert(TX_CE_GPIO_Port == GPIOG);
    printf("    All pins on GPIOG  OK\n");

    printf("\n=== Bug #7: ALL TESTS PASSED (post-fix) ===\n\n");
    return 0;
}
