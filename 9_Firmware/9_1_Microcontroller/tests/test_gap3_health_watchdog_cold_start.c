/*******************************************************************************
 * test_gap3_health_watchdog_cold_start.c
 *
 * Safety bug: checkSystemHealth()'s internal watchdog (step 9, pre-fix) had two
 * linked defects that, once ERROR_WATCHDOG_TIMEOUT was escalated to
 * Emergency_Stop() by the overtemp/watchdog PR, would false-latch the radar:
 *
 *   (1) Cold-start false trip:
 *         static uint32_t last_health_check = 0;
 *         if (HAL_GetTick() - last_health_check > 60000) { ... }
 *       On the very first call, last_health_check == 0, so once the MCU has
 *       been up >60 s (which is typical after the ADAR1000 / AD9523 / ADF4382
 *       init sequence) the subtraction `now - 0` exceeds 60 000 ms and the
 *       watchdog trips spuriously.
 *
 *   (2) Stale-timestamp after early returns:
 *         last_health_check = HAL_GetTick();   // at END of function
 *       Every earlier sub-check (IMU, BMP180, GPS, PA Idq, temperature) has an
 *       `if (fault) return current_error;` path that skips the update. After a
 *       cumulative 60 s of transient faults, the next clean call compares
 *       `now` against the long-stale `last_health_check` and trips.
 *
 * After fix:  Watchdog logic moved to function ENTRY. A dedicated cold-start
 *             branch seeds the timestamp on the first call without checking.
 *             On every subsequent call, the elapsed delta is captured FIRST
 *             and last_health_check is updated BEFORE any sub-check runs, so
 *             early returns no longer leave a stale value.
 *
 * Test strategy:
 *   Extract the post-fix watchdog predicate into a standalone function that
 *   takes a simulated HAL_GetTick() value and returns whether the watchdog
 *   should trip. Walk through boot + fault sequences that would have tripped
 *   the pre-fix code and assert the post-fix code does NOT trip.
 ******************************************************************************/
#include <assert.h>
#include <stdint.h>
#include <stdio.h>

/* --- Post-fix watchdog state + predicate, extracted verbatim --- */
static uint32_t last_health_check = 0;

/* Returns 1 iff this call should raise ERROR_WATCHDOG_TIMEOUT.
   Updates last_health_check BEFORE returning (matches post-fix behaviour). */
static int health_watchdog_step(uint32_t now_tick)
{
    if (last_health_check == 0) {
        last_health_check = now_tick;   /* cold start: seed only, never trip */
        return 0;
    }
    uint32_t elapsed = now_tick - last_health_check;
    last_health_check = now_tick;       /* update BEFORE any early return */
    return (elapsed > 60000) ? 1 : 0;
}

/* Test helper: reset the static state between scenarios. */
static void reset_state(void) { last_health_check = 0; }

int main(void)
{
    printf("=== Safety fix: checkSystemHealth() watchdog cold-start + stale-ts ===\n");

    /* ---------- Scenario 1: cold-start after 60 s of init must NOT trip ---- */
    printf("  Test 1: first call at t=75000 ms (post-init) does not trip... ");
    reset_state();
    assert(health_watchdog_step(75000) == 0);
    printf("PASS\n");

    /* ---------- Scenario 2: first call far beyond 60 s (PRE-FIX BUG) ------- */
    printf("  Test 2: first call at t=600000 ms still does not trip... ");
    reset_state();
    assert(health_watchdog_step(600000) == 0);
    printf("PASS\n");

    /* ---------- Scenario 3: healthy main-loop pacing (10 ms period) -------- */
    printf("  Test 3: 1000 calls at 10 ms intervals never trip... ");
    reset_state();
    (void)health_watchdog_step(1000);  /* seed */
    for (int i = 1; i <= 1000; i++) {
        assert(health_watchdog_step(1000 + i * 10) == 0);
    }
    printf("PASS\n");

    /* ---------- Scenario 4: stale-timestamp after a burst of early returns -
       Pre-fix bug: many early returns skipped the timestamp update, so a
       later clean call would compare `now` against a 60+ s old value. Post-fix,
       every call (including ones that would have early-returned in the real
       function) updates the timestamp at the top, so this scenario is modelled
       by calling health_watchdog_step() on every iteration of the main loop. */
    printf("  Test 4: 70 s of 100 ms-spaced calls after seed do not trip... ");
    reset_state();
    (void)health_watchdog_step(50000);   /* seed mid-run */
    for (int i = 1; i <= 700; i++) {     /* 70 s @ 100 ms */
        int tripped = health_watchdog_step(50000 + i * 100);
        assert(tripped == 0);
    }
    printf("PASS\n");

    /* ---------- Scenario 5: genuine stall MUST trip ------------------------ */
    printf("  Test 5: real 60+ s gap between calls does trip... ");
    reset_state();
    (void)health_watchdog_step(10000);              /* seed */
    assert(health_watchdog_step(10000 + 60001) == 1);
    printf("PASS\n");

    /* ---------- Scenario 6: exactly 60 s gap is the boundary -- do NOT trip
       Post-fix predicate uses strict >60000, matching the pre-fix comparator. */
    printf("  Test 6: exactly 60000 ms gap does not trip (boundary)... ");
    reset_state();
    (void)health_watchdog_step(10000);
    assert(health_watchdog_step(10000 + 60000) == 0);
    printf("PASS\n");

    /* ---------- Scenario 7: trip, then recover on next paced call ---------- */
    printf("  Test 7: after a genuine stall+trip, next paced call does not re-trip... ");
    reset_state();
    (void)health_watchdog_step(5000);                      /* seed */
    assert(health_watchdog_step(5000 + 70000) == 1);       /* stall -> trip */
    assert(health_watchdog_step(5000 + 70000 + 10) == 0);  /* resume paced */
    printf("PASS\n");

    /* ---------- Scenario 8: HAL_GetTick() 32-bit wrap (~49.7 days) ---------
       Because we subtract unsigned 32-bit values, wrap is handled correctly as
       long as the true elapsed time is < 2^32 ms. */
    printf("  Test 8: tick wrap from 0xFFFFFF00 -> 0x00000064 (200 ms span) does not trip... ");
    reset_state();
    (void)health_watchdog_step(0xFFFFFF00u);
    assert(health_watchdog_step(0x00000064u) == 0);  /* elapsed = 0x164 = 356 ms */
    printf("PASS\n");

    printf("\n=== Safety fix: ALL TESTS PASSED ===\n\n");
    return 0;
}
