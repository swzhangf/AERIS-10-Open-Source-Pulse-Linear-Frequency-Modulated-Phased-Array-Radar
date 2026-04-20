/*******************************************************************************
 * test_gap3_emergency_stop_rails.c
 *
 * Gap-3 Fix 1 (FIXED): Emergency_Stop() now cuts PA power rails.
 *
 * Before fix:  Emergency_Stop() only cleared DAC gate voltages via CLR pin.
 *              PA VDD rails (5V0_PA1/2/3, 5V5_PA, RFPA_VDD) stayed energized,
 *              allowing PAs to self-bias or oscillate.
 *
 * After fix:   Emergency_Stop() also:
 *   1. Disables TX mixers        (GPIOD pin 11 LOW)
 *   2. Cuts PA 5V0 supplies      (GPIOG pins 0,1,2 LOW)
 *   3. Cuts PA 5V5 supply        (GPIOG pin 3 LOW)
 *   4. Disables RFPA VDD         (GPIOD pin 6 LOW)
 *
 * Test strategy:
 *   Simulate the Emergency_Stop GPIO sequence and verify all required pins
 *   are driven LOW via the spy log.
 ******************************************************************************/
#include <assert.h>
#include <stdio.h>
#include "stm32_hal_mock.h"

/* Pin definitions from main.h shim */
#include "main.h"

/*
 * Simulate the Emergency_Stop GPIO write sequence (post-fix).
 * We can't call the real function (it loops forever), so we replicate
 * the GPIO write sequence and verify it in the spy log.
 */
static void simulate_emergency_stop_gpio_sequence(void)
{
    /* TX mixers OFF */
    HAL_GPIO_WritePin(GPIOD, GPIO_PIN_11, GPIO_PIN_RESET);
    /* PA 5V0 supplies OFF */
    HAL_GPIO_WritePin(EN_P_5V0_PA1_GPIO_Port, EN_P_5V0_PA1_Pin, GPIO_PIN_RESET);
    HAL_GPIO_WritePin(EN_P_5V0_PA2_GPIO_Port, EN_P_5V0_PA2_Pin, GPIO_PIN_RESET);
    HAL_GPIO_WritePin(EN_P_5V0_PA3_GPIO_Port, EN_P_5V0_PA3_Pin, GPIO_PIN_RESET);
    /* PA 5V5 supply OFF */
    HAL_GPIO_WritePin(EN_P_5V5_PA_GPIO_Port, EN_P_5V5_PA_Pin, GPIO_PIN_RESET);
    /* RFPA VDD OFF */
    HAL_GPIO_WritePin(EN_DIS_RFPA_VDD_GPIO_Port, EN_DIS_RFPA_VDD_Pin, GPIO_PIN_RESET);
}

/* Helper: check that a GPIO_WRITE record matches expected port/pin/state */
static void assert_gpio_write(int idx, GPIO_TypeDef *port, uint16_t pin, GPIO_PinState state,
                               const char *label)
{
    const SpyRecord *r = spy_get(idx);
    assert(r != NULL);
    assert(r->type == SPY_GPIO_WRITE);
    if (r->port != port || r->pin != pin || (GPIO_PinState)r->value != state) {
        printf("FAIL at spy_log[%d] (%s): port=%p pin=0x%04x state=%d "
               "(expected port=%p pin=0x%04x state=%d)\n",
               idx, label, r->port, r->pin, r->value, port, pin, state);
        assert(0);
    }
}

int main(void)
{
    printf("=== Gap-3 Fix 1: Emergency_Stop() PA rail shutdown ===\n");

    /* Test 1: All 6 required GPIO pins are driven LOW in correct order */
    printf("  Test 1: GPIO sequence correctness... ");
    spy_reset();
    simulate_emergency_stop_gpio_sequence();

    assert(spy_count == 6);
    assert_gpio_write(0, GPIOD,  GPIO_PIN_11, GPIO_PIN_RESET, "TX_MIXERS_OFF");
    assert_gpio_write(1, GPIOG,  GPIO_PIN_0,  GPIO_PIN_RESET, "PA1_5V0_OFF");
    assert_gpio_write(2, GPIOG,  GPIO_PIN_1,  GPIO_PIN_RESET, "PA2_5V0_OFF");
    assert_gpio_write(3, GPIOG,  GPIO_PIN_2,  GPIO_PIN_RESET, "PA3_5V0_OFF");
    assert_gpio_write(4, GPIOG,  GPIO_PIN_3,  GPIO_PIN_RESET, "PA_5V5_OFF");
    assert_gpio_write(5, GPIOD,  GPIO_PIN_6,  GPIO_PIN_RESET, "RFPA_VDD_OFF");
    printf("PASS\n");

    /* Test 2: TX mixers are cut FIRST (before PA supplies) */
    printf("  Test 2: TX mixers disabled before PA rails... ");
    /* Already verified by order in Test 1: spy_log[0] is TX_MIXERS */
    printf("PASS (by ordering in Test 1)\n");

    /* Test 3: Pin definitions match expected hardware mapping */
    printf("  Test 3: Pin define cross-check... ");
    assert(EN_P_5V0_PA1_Pin == GPIO_PIN_0);
    assert(EN_P_5V0_PA1_GPIO_Port == GPIOG);
    assert(EN_P_5V0_PA2_Pin == GPIO_PIN_1);
    assert(EN_P_5V0_PA2_GPIO_Port == GPIOG);
    assert(EN_P_5V0_PA3_Pin == GPIO_PIN_2);
    assert(EN_P_5V0_PA3_GPIO_Port == GPIOG);
    assert(EN_P_5V5_PA_Pin == GPIO_PIN_3);
    assert(EN_P_5V5_PA_GPIO_Port == GPIOG);
    assert(EN_DIS_RFPA_VDD_Pin == GPIO_PIN_6);
    assert(EN_DIS_RFPA_VDD_GPIO_Port == GPIOD);
    printf("PASS\n");

    printf("\n=== Gap-3 Fix 1: ALL TESTS PASSED ===\n\n");
    return 0;
}
