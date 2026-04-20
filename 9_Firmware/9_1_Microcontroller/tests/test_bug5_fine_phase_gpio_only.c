/*******************************************************************************
 * test_bug5_fine_phase_gpio_only.c
 *
 * Bug #5 (FIXED): ADF4382A_SetFinePhaseShift() was a GPIO-only placeholder.
 * For intermediate duty_cycle values it just set GPIO HIGH — same as max.
 *
 * Fix: Intermediate duty cycles now use TIM3 PWM output (CH2 for TX, CH3 for
 * RX). The PWM output is low-pass filtered externally to produce a DC voltage
 * proportional to the delay. Edge cases (0 and max) still use static GPIO.
 *
 * Test strategy (post-fix):
 *   1. duty=0 → PWM stopped, GPIO LOW (no change).
 *   2. duty=MAX → PWM stopped, GPIO HIGH (no change).
 *   3. duty=500 (intermediate) → SPY_TIM_SET_COMPARE + SPY_TIM_PWM_START
 *      recorded, NO static GPIO write for the DELADJ pin.
 *   4. Verify compare value matches the duty cycle.
 ******************************************************************************/
#include "adf4382a_manager.h"
#include <assert.h>
#include <stdio.h>

int main(void)
{
    ADF4382A_Manager mgr;
    int ret;

    printf("=== Bug #5 (FIXED): SetFinePhaseShift uses TIM PWM ===\n");

    /* Setup: init manager */
    spy_reset();
    ret = ADF4382A_Manager_Init(&mgr, SYNC_METHOD_TIMED);
    assert(ret == ADF4382A_MANAGER_OK);

    /* ---- Test A: duty_cycle=0 → PWM stopped, GPIO LOW ---- */
    spy_reset();
    ret = ADF4382A_SetFinePhaseShift(&mgr, 0, 0);
    assert(ret == ADF4382A_MANAGER_OK);

    int pwm_stop_count = spy_count_type(SPY_TIM_PWM_STOP);
    int gpio_writes = spy_count_type(SPY_GPIO_WRITE);
    printf("  duty=0: PWM_STOP=%d GPIO_WRITE=%d\n", pwm_stop_count, gpio_writes);
    assert(pwm_stop_count == 1);  /* stop PWM before driving GPIO */
    assert(gpio_writes >= 1);     /* at least one GPIO write (LOW) */

    /* Verify the GPIO write is LOW */
    int idx = spy_find_nth(SPY_GPIO_WRITE, 0);
    const SpyRecord *r = spy_get(idx);
    assert(r != NULL && r->value == GPIO_PIN_RESET);
    printf("  PASS: duty=0 → PWM stopped + GPIO LOW\n");

    /* ---- Test B: duty_cycle=MAX → PWM stopped, GPIO HIGH ---- */
    spy_reset();
    ret = ADF4382A_SetFinePhaseShift(&mgr, 0, DELADJ_MAX_DUTY_CYCLE);
    assert(ret == ADF4382A_MANAGER_OK);

    pwm_stop_count = spy_count_type(SPY_TIM_PWM_STOP);
    gpio_writes = spy_count_type(SPY_GPIO_WRITE);
    printf("  duty=MAX(%d): PWM_STOP=%d GPIO_WRITE=%d\n",
           DELADJ_MAX_DUTY_CYCLE, pwm_stop_count, gpio_writes);
    assert(pwm_stop_count == 1);
    assert(gpio_writes >= 1);

    idx = spy_find_nth(SPY_GPIO_WRITE, 0);
    r = spy_get(idx);
    assert(r != NULL && r->value == GPIO_PIN_SET);
    printf("  PASS: duty=MAX → PWM stopped + GPIO HIGH\n");

    /* ---- Test C: duty_cycle=500 (intermediate) → TIM PWM ---- */
    spy_reset();
    ret = ADF4382A_SetFinePhaseShift(&mgr, 0, 500);  /* device=0 (TX) */
    assert(ret == ADF4382A_MANAGER_OK);

    int pwm_start_count = spy_count_type(SPY_TIM_PWM_START);
    int set_compare_count = spy_count_type(SPY_TIM_SET_COMPARE);
    gpio_writes = spy_count_type(SPY_GPIO_WRITE);
    printf("  duty=500: PWM_START=%d SET_COMPARE=%d GPIO_WRITE=%d\n",
           pwm_start_count, set_compare_count, gpio_writes);
    assert(pwm_start_count == 1);
    assert(set_compare_count == 1);
    assert(gpio_writes == 0);  /* No static GPIO write for intermediate */

    /* Verify compare value is 500 */
    idx = spy_find_nth(SPY_TIM_SET_COMPARE, 0);
    r = spy_get(idx);
    assert(r != NULL);
    printf("  SET_COMPARE value=%u (expected 500)\n", r->value);
    assert(r->value == 500);

    /* Verify TIM channel is CH2 (TX device = 0 → TIM_CHANNEL_2 = 0x04) */
    idx = spy_find_nth(SPY_TIM_PWM_START, 0);
    r = spy_get(idx);
    assert(r != NULL);
    printf("  PWM_START channel=0x%02X (expected 0x%02X = TIM_CHANNEL_2)\n",
           r->pin, TIM_CHANNEL_2);
    assert(r->pin == TIM_CHANNEL_2);
    printf("  PASS: duty=500 → TIM PWM with correct compare value\n");

    /* ---- Test D: RX device (1) uses TIM_CHANNEL_3 ---- */
    spy_reset();
    ret = ADF4382A_SetFinePhaseShift(&mgr, 1, 750);  /* device=1 (RX) */
    assert(ret == ADF4382A_MANAGER_OK);

    idx = spy_find_nth(SPY_TIM_PWM_START, 0);
    r = spy_get(idx);
    assert(r != NULL);
    printf("  RX PWM_START channel=0x%02X (expected 0x%02X = TIM_CHANNEL_3)\n",
           r->pin, TIM_CHANNEL_3);
    assert(r->pin == TIM_CHANNEL_3);

    idx = spy_find_nth(SPY_TIM_SET_COMPARE, 0);
    r = spy_get(idx);
    assert(r != NULL && r->value == 750);
    printf("  RX SET_COMPARE value=%u (expected 750)  OK\n", r->value);
    printf("  PASS: RX device uses TIM_CHANNEL_3 with correct compare\n");

    /* Cleanup */
    ADF4382A_Manager_Deinit(&mgr);

    printf("\n=== Bug #5: ALL TESTS PASSED (post-fix) ===\n\n");
    return 0;
}
