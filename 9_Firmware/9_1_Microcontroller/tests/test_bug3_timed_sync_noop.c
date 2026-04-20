/*******************************************************************************
 * test_bug3_timed_sync_noop.c
 *
 * Bug #3 (FIXED): ADF4382A_TriggerTimedSync() was a no-op — it only printed
 * messages but performed no hardware action.
 *
 * Fix: Implemented a sw_sync pulse (set true → 10us delay → set false) on
 * both TX and RX devices, mirroring EZSync's trigger pattern. With
 * timed_sync_setup already programmed, the devices synchronize their output
 * dividers to the SYNCP/SYNCN clock edge when sw_sync is asserted.
 *
 * Test strategy (post-fix):
 *   1. Initialize manager with SYNC_METHOD_TIMED.
 *   2. Reset spy log, call TriggerTimedSync().
 *   3. Verify 4 SPY_ADF4382_SET_SW_SYNC records (TX set, RX set, TX clear,
 *      RX clear) — same count as EZSync.
 *   4. Verify the set/clear ordering is correct.
 ******************************************************************************/
#include "adf4382a_manager.h"
#include <assert.h>
#include <stdio.h>

int main(void)
{
    ADF4382A_Manager mgr;
    int ret;

    printf("=== Bug #3 (FIXED): TriggerTimedSync now issues hw actions ===\n");

    /* Setup: init the manager with timed sync */
    spy_reset();
    ret = ADF4382A_Manager_Init(&mgr, SYNC_METHOD_TIMED);
    assert(ret == ADF4382A_MANAGER_OK);

    /* ---- Test A: TriggerTimedSync produces 4 sw_sync calls ---- */
    spy_reset();
    ret = ADF4382A_TriggerTimedSync(&mgr);
    printf("  TriggerTimedSync returned: %d (expected 0=OK)\n", ret);
    assert(ret == ADF4382A_MANAGER_OK);

    int sw_sync_count = spy_count_type(SPY_ADF4382_SET_SW_SYNC);
    printf("  SPY_ADF4382_SET_SW_SYNC records: %d (expected 4)\n", sw_sync_count);
    assert(sw_sync_count == 4);
    printf("  PASS: TriggerTimedSync issues 4 SPI sw_sync calls\n");

    /* ---- Test B: Verify ordering: set(TX), set(RX), clear(TX), clear(RX) ---- */
    printf("\n  Checking sw_sync call ordering:\n");
    int sw_idx = 0;
    for (int i = 0; i < spy_count; i++) {
        const SpyRecord *r = spy_get(i);
        if (!r || r->type != SPY_ADF4382_SET_SW_SYNC) continue;

        printf("    sw_sync[%d]: dev=%s value=%d", sw_idx,
               (r->extra == (void *)mgr.tx_dev) ? "TX" : "RX",
               r->value);

        switch (sw_idx) {
            case 0:  /* TX set */
                assert(r->extra == (void *)mgr.tx_dev);
                assert(r->value == 1);
                printf("  OK (TX set)\n");
                break;
            case 1:  /* RX set */
                assert(r->extra == (void *)mgr.rx_dev);
                assert(r->value == 1);
                printf("  OK (RX set)\n");
                break;
            case 2:  /* TX clear */
                assert(r->extra == (void *)mgr.tx_dev);
                assert(r->value == 0);
                printf("  OK (TX clear)\n");
                break;
            case 3:  /* RX clear */
                assert(r->extra == (void *)mgr.rx_dev);
                assert(r->value == 0);
                printf("  OK (RX clear)\n");
                break;
            default:
                assert(0 && "Unexpected extra sw_sync call");
        }
        sw_idx++;
    }
    assert(sw_idx == 4);
    printf("  PASS: Ordering is correct (set TX, set RX, clear TX, clear RX)\n");

    /* ---- Test C: Compare with EZSync — both should produce 4 sw_sync calls ---- */
    mgr.sync_method = SYNC_METHOD_EZSYNC;
    spy_reset();
    ret = ADF4382A_TriggerEZSync(&mgr);
    assert(ret == ADF4382A_MANAGER_OK);
    int ezsync_count = spy_count_type(SPY_ADF4382_SET_SW_SYNC);
    printf("\n  EZSync sw_sync count: %d (expected 4, same as timed sync)\n",
           ezsync_count);
    assert(ezsync_count == 4);
    printf("  PASS: Both sync methods now issue the same hw trigger pattern\n");

    /* Cleanup */
    mgr.sync_method = SYNC_METHOD_TIMED;
    ADF4382A_Manager_Deinit(&mgr);

    printf("\n=== Bug #3: ALL TESTS PASSED (post-fix) ===\n\n");
    return 0;
}
