/*******************************************************************************
 * test_bug4_phase_shift_before_check.c
 *
 * Bug #4 (FIXED): In main.cpp, the init return code is now checked BEFORE
 * calling SetPhaseShift/StrobePhaseShift. If init fails, Error_Handler()
 * is called immediately — phase shift functions are never reached.
 *
 * Post-fix test:
 *   1. Successful init: phase shift calls happen after error check (normal).
 *   2. Failed init: Error_Handler is called, phase shift never executes.
 ******************************************************************************/
#include "adf4382a_manager.h"
#include <assert.h>
#include <stdio.h>

/* Track whether Error_Handler was called */
static int error_handler_called = 0;
void Error_Handler(void) { error_handler_called = 1; }

/* Globals that main.cpp would declare */
uint8_t GUI_start_flag_received = 0;
uint8_t USB_Buffer[64] = {0};

/* Track whether phase shift was called */
static int phase_shift_called = 0;

/*
 * Extracted from main.cpp — FIXED version.
 * Error check happens BEFORE phase shift calls.
 */
static int lo_init_sequence_extracted(ADF4382A_Manager *lo_manager)
{
    int ret;

    ret = ADF4382A_Manager_Init(lo_manager, SYNC_METHOD_TIMED);

    /* [Bug #4 FIXED] Error check happens FIRST */
    if (ret != ADF4382A_MANAGER_OK) {
        Error_Handler();
        return 1;
    }

    /* Phase shift only called after successful init */
    phase_shift_called = 1;
    int ps_ret = ADF4382A_SetPhaseShift(lo_manager, 500, 500);
    (void)ps_ret;

    int strobe_tx_ret = ADF4382A_StrobePhaseShift(lo_manager, 0);
    int strobe_rx_ret = ADF4382A_StrobePhaseShift(lo_manager, 1);
    (void)strobe_tx_ret;
    (void)strobe_rx_ret;

    return 0;
}

int main(void)
{
    ADF4382A_Manager mgr;

    printf("=== Bug #4 (FIXED): Phase shift after init check ===\n");

    /* ---- Test A: Successful init — phase shift happens normally ---- */
    spy_reset();
    error_handler_called = 0;
    phase_shift_called = 0;
    mock_adf4382_init_retval = 0;

    int result = lo_init_sequence_extracted(&mgr);
    assert(result == 0);
    assert(error_handler_called == 0);
    assert(phase_shift_called == 1);
    printf("  PASS: Successful init — phase shift called after error check\n");

    int init_count = spy_count_type(SPY_ADF4382_INIT);
    printf("  ADF4382_INIT calls: %d (expected 2: TX+RX)\n", init_count);
    assert(init_count == 2);

    int total_gpio_writes = spy_count_type(SPY_GPIO_WRITE);
    printf("  GPIO writes: %d (includes CE, DELADJ, DELSTR, phase)\n", total_gpio_writes);
    assert(total_gpio_writes > 0);
    printf("  PASS: Phase shift GPIO writes observed\n");

    ADF4382A_Manager_Deinit(&mgr);

    /* ---- Test B: Failed init — Error_Handler called, NO phase shift ---- */
    printf("\n  Testing with failed TX init...\n");
    spy_reset();
    error_handler_called = 0;
    phase_shift_called = 0;
    mock_adf4382_init_retval = -1;

    result = lo_init_sequence_extracted(&mgr);
    assert(result == 1);
    assert(error_handler_called == 1);
    assert(phase_shift_called == 0);
    printf("  PASS: Error_Handler called, phase shift NOT called (FIXED)\n");
    printf("  Phase shift no longer executes on uninitialized manager\n");

    /* Reset mock */
    mock_adf4382_init_retval = 0;

    printf("=== Bug #4 (FIXED): ALL TESTS PASSED ===\n\n");
    return 0;
}
