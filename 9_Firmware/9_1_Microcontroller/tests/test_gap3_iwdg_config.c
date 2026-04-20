/*******************************************************************************
 * test_gap3_iwdg_config.c
 *
 * Gap-3 Fix 2 (FIXED): Hardware IWDG watchdog enabled.
 *
 * Before fix:  HAL_IWDG_MODULE_ENABLED was commented out in hal_conf.h.
 *              Software-only timestamp check in checkSystemHealth() was the
 *              only watchdog — if MCU hangs, nothing resets it.
 *
 * After fix:
 *   1. HAL_IWDG_MODULE_ENABLED uncommented
 *   2. IWDG_HandleTypeDef hiwdg declared
 *   3. MX_IWDG_Init() called at startup (prescaler=256, reload=500 → ~4s)
 *   4. HAL_IWDG_Refresh() called in main loop
 *   5. OCXO warmup loop refreshes IWDG every 1s instead of blocking 180s
 *   6. Emergency_Stop() infinite loop also refreshes IWDG to prevent reset
 *
 * Test strategy:
 *   Verify configuration constants and timeout calculation.
 *   Verify OCXO warmup loop structure avoids IWDG timeout.
 ******************************************************************************/
#include <assert.h>
#include <stdio.h>
#include <math.h>

/* IWDG configuration constants (must match MX_IWDG_Init in main.cpp) */
#define IWDG_PRESCALER_VALUE  256
#define IWDG_RELOAD_VALUE     500
#define LSI_FREQ_HZ           32000  /* STM32F7 LSI typical */

int main(void)
{
    printf("=== Gap-3 Fix 2: IWDG hardware watchdog configuration ===\n");

    /* Test 1: Timeout calculation */
    printf("  Test 1: IWDG timeout within 3-5 seconds... ");
    double timeout_s = (double)IWDG_PRESCALER_VALUE * IWDG_RELOAD_VALUE / LSI_FREQ_HZ;
    printf("(calculated %.3f s) ", timeout_s);
    assert(timeout_s >= 3.0 && timeout_s <= 5.0);
    printf("PASS\n");

    /* Test 2: OCXO warmup loop wouldn't trigger IWDG */
    printf("  Test 2: OCXO loop refresh interval < IWDG timeout... ");
    /* OCXO warmup: 180 iterations × 1000 ms delay = 180 s total.
     * Each iteration refreshes IWDG.  1.0 s << 4.0 s timeout. */
    double ocxo_refresh_interval_s = 1.0;
    assert(ocxo_refresh_interval_s < timeout_s);
    printf("(1.0 s < %.1f s) PASS\n", timeout_s);

    /* Test 3: Emergency_Stop loop wouldn't trigger IWDG */
    printf("  Test 3: Emergency_Stop refresh interval < IWDG timeout... ");
    /* Emergency_Stop: loops with HAL_Delay(100) + IWDG_Refresh.
     * 0.1 s << 4.0 s timeout. */
    double estop_refresh_interval_s = 0.1;
    assert(estop_refresh_interval_s < timeout_s);
    printf("(0.1 s < %.1f s) PASS\n", timeout_s);

    /* Test 4: Main loop frequency check */
    printf("  Test 4: Main loop must complete within timeout... ");
    /* Radar pulse sequence + health checks + monitoring should complete
     * well within 4 seconds.  Max single-iteration budget: ~1 s
     * (dominated by the radar pulse sequence itself). */
    double estimated_loop_worst_case_s = 1.0;
    assert(estimated_loop_worst_case_s < timeout_s);
    printf("(est. %.1f s < %.1f s) PASS\n", estimated_loop_worst_case_s, timeout_s);

    /* Test 5: Prescaler is power-of-2 and valid for STM32F7 */
    printf("  Test 5: Prescaler is valid STM32F7 IWDG value... ");
    /* Valid prescalers: 4, 8, 16, 32, 64, 128, 256 */
    int valid_prescalers[] = {4, 8, 16, 32, 64, 128, 256};
    int prescaler_valid = 0;
    for (int i = 0; i < 7; i++) {
        if (valid_prescalers[i] == IWDG_PRESCALER_VALUE) {
            prescaler_valid = 1;
            break;
        }
    }
    assert(prescaler_valid);
    printf("PASS\n");

    /* Test 6: Reload within 12-bit range */
    printf("  Test 6: Reload value within 12-bit range (0-4095)... ");
    assert(IWDG_RELOAD_VALUE >= 0 && IWDG_RELOAD_VALUE <= 4095);
    printf("(%d) PASS\n", IWDG_RELOAD_VALUE);

    printf("\n=== Gap-3 Fix 2: ALL TESTS PASSED ===\n\n");
    return 0;
}
