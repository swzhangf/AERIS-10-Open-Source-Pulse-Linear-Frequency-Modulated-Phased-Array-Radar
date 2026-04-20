/*******************************************************************************
 * test_bug15_htim3_dangling_extern.c
 *
 * Bug #15 (FIXED): adf4382a_manager.c declared `extern TIM_HandleTypeDef htim3`
 *   but main.cpp had no `TIM_HandleTypeDef htim3` definition and no
 *   `MX_TIM3_Init()` call. The extern resolved to nothing → linker error or
 *   zero-initialized BSS → PWM calls operate on unconfigured timer hardware.
 *
 * Fix:
 *   - Added `TIM_HandleTypeDef htim3;` definition in main.cpp (line ~117)
 *   - Added `static void MX_TIM3_Init(void)` prototype + implementation
 *   - Added `MX_TIM3_Init();` call in peripheral init sequence
 *   - TIM3 configured for PWM mode: Prescaler=71, Period=999 (=DELADJ_MAX_DUTY_CYCLE),
 *     CH2 (TX DELADJ) and CH3 (RX DELADJ) in PWM1 mode
 *
 * Test strategy:
 *   1. Verify htim3 is defined (not just extern) in the mock environment
 *   2. Verify SetFinePhaseShift works with the timer (reuses test_bug5 pattern)
 *   3. Verify PWM start/stop on both channels works without crash
 ******************************************************************************/
#include "adf4382a_manager.h"
#include <assert.h>
#include <stdio.h>

int main(void)
{
    ADF4382A_Manager mgr;
    int ret;

    printf("=== Bug #15 (FIXED): htim3 defined + TIM3 PWM configured ===\n");

    /* Test 1: htim3 exists and has a valid id */
    printf("  Test 1: htim3 is defined (id=%u)... ", htim3.id);
    assert(htim3.id == 3);
    printf("PASS\n");

    /* Test 2: Init manager, then use SetFinePhaseShift which exercises htim3 */
    spy_reset();
    ret = ADF4382A_Manager_Init(&mgr, SYNC_METHOD_TIMED);
    assert(ret == ADF4382A_MANAGER_OK);
    printf("  Test 2: Manager init OK\n");

    /* Test 3: Intermediate duty cycle on TX (CH2) → PWM start + set compare */
    spy_reset();
    ret = ADF4382A_SetFinePhaseShift(&mgr, 0, 500);
    assert(ret == ADF4382A_MANAGER_OK);

    int pwm_starts = spy_count_type(SPY_TIM_PWM_START);
    int set_compares = spy_count_type(SPY_TIM_SET_COMPARE);
    printf("  Test 3: TX duty=500 → PWM_START=%d SET_COMPARE=%d... ",
           pwm_starts, set_compares);
    assert(pwm_starts == 1);
    assert(set_compares == 1);

    /* Verify the timer used is htim3 (id=3) */
    int idx = spy_find_nth(SPY_TIM_PWM_START, 0);
    const SpyRecord *r = spy_get(idx);
    assert(r != NULL && r->value == 3);  /* htim3.id == 3 */
    printf("timer_id=%u (htim3) PASS\n", r->value);

    /* Test 4: Intermediate duty cycle on RX (CH3) */
    spy_reset();
    ret = ADF4382A_SetFinePhaseShift(&mgr, 1, 300);
    assert(ret == ADF4382A_MANAGER_OK);

    idx = spy_find_nth(SPY_TIM_PWM_START, 0);
    r = spy_get(idx);
    assert(r != NULL);
    printf("  Test 4: RX duty=300 → channel=0x%02X (expected 0x%02X=CH3) timer_id=%u... ",
           r->pin, TIM_CHANNEL_3, r->value);
    assert(r->pin == TIM_CHANNEL_3);
    assert(r->value == 3);
    printf("PASS\n");

    /* Test 5: duty=0 stops PWM gracefully */
    spy_reset();
    ret = ADF4382A_SetFinePhaseShift(&mgr, 0, 0);
    assert(ret == ADF4382A_MANAGER_OK);

    int pwm_stops = spy_count_type(SPY_TIM_PWM_STOP);
    printf("  Test 5: duty=0 → PWM_STOP=%d... ", pwm_stops);
    assert(pwm_stops == 1);
    printf("PASS\n");

    ADF4382A_Manager_Deinit(&mgr);

    printf("\n=== Bug #15: ALL TESTS PASSED (post-fix) ===\n\n");
    return 0;
}
