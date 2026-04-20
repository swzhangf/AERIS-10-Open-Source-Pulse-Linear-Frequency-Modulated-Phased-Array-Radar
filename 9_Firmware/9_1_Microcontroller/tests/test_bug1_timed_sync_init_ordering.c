/*******************************************************************************
 * test_bug1_timed_sync_init_ordering.c
 *
 * Bug #1 (FIXED): ADF4382A_SetupTimedSync() was called BEFORE
 * manager->initialized was set to true. SetupTimedSync checks
 * `manager->initialized` and returned -2 (NOT_INIT), silently failing.
 *
 * Post-fix behavior:
 *   1. Manager_Init sets initialized=true BEFORE calling sync setup.
 *   2. SetupTimedSync succeeds during init (2 driver calls: TX + RX).
 *   3. Sync setup failure is no longer swallowed — init returns error.
 ******************************************************************************/
#include "adf4382a_manager.h"
#include <assert.h>
#include <stdio.h>

int main(void)
{
    ADF4382A_Manager mgr;
    int ret;

    printf("=== Bug #1 (FIXED): Timed sync init ordering ===\n");

    /* ---- Test A: Init returns OK and sync is configured ---- */
    spy_reset();
    ret = ADF4382A_Manager_Init(&mgr, SYNC_METHOD_TIMED);

    printf("  Manager_Init returned: %d (expected 0=OK)\n", ret);
    assert(ret == ADF4382A_MANAGER_OK);
    printf("  PASS: Init returned OK\n");

    /* ---- Test B: Timed sync register writes DID reach the driver ---- */
    int timed_sync_count = spy_count_type(SPY_ADF4382_SET_TIMED_SYNC);
    printf("  SPY_ADF4382_SET_TIMED_SYNC records: %d (expected 2 — TX + RX)\n", timed_sync_count);
    assert(timed_sync_count == 2);
    printf("  PASS: Timed sync configured for both TX and RX during init\n");

    /* ---- Test C: Manager is initialized ---- */
    assert(mgr.initialized == true);
    printf("  PASS: manager->initialized == true\n");

    /* ---- Test D: Init fails if sync setup fails ---- */
    /* Configure mock to make timed sync fail */
    spy_reset();
    extern int mock_adf4382_set_timed_sync_retval;
    mock_adf4382_set_timed_sync_retval = -1;
    ret = ADF4382A_Manager_Init(&mgr, SYNC_METHOD_TIMED);
    printf("  Manager_Init with failing sync: %d (expected non-zero)\n", ret);
    assert(ret != ADF4382A_MANAGER_OK);
    printf("  PASS: Init fails when sync setup fails (error no longer swallowed)\n");

    /* Verify manager is NOT left in initialized state on failure */
    assert(mgr.initialized == false);
    printf("  PASS: manager->initialized == false after sync failure\n");

    /* Restore mock */
    mock_adf4382_set_timed_sync_retval = 0;

    /* Cleanup */
    ADF4382A_Manager_Deinit(&mgr);

    printf("=== Bug #1 (FIXED): ALL TESTS PASSED ===\n\n");
    return 0;
}
