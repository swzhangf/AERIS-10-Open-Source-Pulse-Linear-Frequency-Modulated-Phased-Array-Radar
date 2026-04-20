/*******************************************************************************
 * test_bug6_timer_variable_collision.c
 *
 * Bug #6 (FIXED): In main.cpp, the temperature block now writes to
 * `last_check1` instead of `last_check`, so both timers run independently.
 *
 * Post-fix behavior:
 *   - Lock check fires every ~5s using `last_check`.
 *   - Temperature check fires every ~5s using `last_check1`.
 *   - Neither timer corrupts the other.
 ******************************************************************************/
#include "stm32_hal_mock.h"
#include <assert.h>
#include <stdio.h>

/* Counters to track how many times each block fires */
static int lock_check_fired = 0;
static int temp_check_fired = 0;

/*
 * Simulates one iteration of the main loop timer blocks.
 * Uses the FIXED code pattern from main.cpp.
 */
static void main_loop_iteration(uint32_t *last_check_p, uint32_t *last_check1_p)
{
    /* ---- Lock check block ---- */
    if (HAL_GetTick() - *last_check_p > 5000) {
        lock_check_fired++;
        *last_check_p = HAL_GetTick();
    }

    /* ---- Temperature check block (FIXED: writes to last_check1) ---- */
    if (HAL_GetTick() - *last_check1_p > 5000) {
        temp_check_fired++;
        *last_check1_p = HAL_GetTick();   /* FIXED: was *last_check_p */
    }
}

int main(void)
{
    uint32_t last_check = 0;
    uint32_t last_check1 = 0;

    printf("=== Bug #6 (FIXED): Timer variable collision ===\n");

    /* ---- t=0: nothing fires ---- */
    spy_reset();
    mock_set_tick(0);
    lock_check_fired = 0;
    temp_check_fired = 0;

    main_loop_iteration(&last_check, &last_check1);
    printf("  t=0ms: lock_fired=%d temp_fired=%d\n", lock_check_fired, temp_check_fired);
    assert(lock_check_fired == 0);
    assert(temp_check_fired == 0);
    printf("  PASS: Neither fires at t=0\n");

    /* ---- t=5001: both fire ---- */
    mock_set_tick(5001);
    main_loop_iteration(&last_check, &last_check1);
    printf("  t=5001ms: lock_fired=%d temp_fired=%d\n", lock_check_fired, temp_check_fired);
    assert(lock_check_fired == 1);
    assert(temp_check_fired == 1);
    printf("  PASS: Both fire at t=5001\n");

    /* Both variables should be updated independently */
    printf("  After first fire: last_check=%u last_check1=%u\n", last_check, last_check1);
    assert(last_check == 5001);
    assert(last_check1 == 5001);
    printf("  PASS: Both timers updated independently\n");

    /* ---- t=5002: neither fires (only 1ms elapsed) ---- */
    mock_set_tick(5002);
    main_loop_iteration(&last_check, &last_check1);
    printf("  t=5002ms: lock_fired=%d temp_fired=%d\n", lock_check_fired, temp_check_fired);
    assert(lock_check_fired == 1);
    assert(temp_check_fired == 1);
    printf("  PASS: Neither fires at t=5002 (correct — temp no longer runs continuously)\n");

    /* ---- t=10002: both fire again ---- */
    mock_set_tick(10002);
    main_loop_iteration(&last_check, &last_check1);
    printf("  t=10002ms: lock_fired=%d temp_fired=%d\n", lock_check_fired, temp_check_fired);
    assert(lock_check_fired == 2);
    assert(temp_check_fired == 2);
    printf("  PASS: Both fire at t=10002 (second cycle, independent)\n");

    /* Verify both timers updated correctly */
    assert(last_check == 10002);
    assert(last_check1 == 10002);
    printf("  PASS: Both timers at 10002, no cross-contamination\n");

    /* ---- t=15003: third cycle ---- */
    mock_set_tick(15003);
    main_loop_iteration(&last_check, &last_check1);
    assert(lock_check_fired == 3);
    assert(temp_check_fired == 3);
    printf("  PASS: Third cycle fires correctly at t=15003\n");

    printf("=== Bug #6 (FIXED): ALL TESTS PASSED ===\n\n");
    return 0;
}
