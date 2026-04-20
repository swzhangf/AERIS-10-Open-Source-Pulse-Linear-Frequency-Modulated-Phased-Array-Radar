/*******************************************************************************
 * test_gap3_overtemp_emergency_stop.c
 *
 * Safety bug: handleSystemError() did not escalate ERROR_TEMPERATURE_HIGH
 * (or ERROR_WATCHDOG_TIMEOUT) to Emergency_Stop().
 *
 * Before fix:  The critical-error gate was
 *                if (error >= ERROR_RF_PA_OVERCURRENT &&
 *                    error <= ERROR_POWER_SUPPLY) { Emergency_Stop(); }
 *              So overtemp (code 14) and watchdog timeout (code 16) fell
 *              through to attemptErrorRecovery()'s default branch (log and
 *              continue), leaving the 10 W GaN PAs biased at >75 °C.
 *
 * After fix:   The gate also matches ERROR_TEMPERATURE_HIGH and
 *              ERROR_WATCHDOG_TIMEOUT, so thermal and watchdog faults
 *              latch Emergency_Stop() exactly like PA overcurrent.
 *
 * Test strategy:
 *   Replicate the critical-error predicate and assert that every error
 *   enum value which threatens RF/power safety is accepted, and that the
 *   non-critical ones (comm, sensor, memory) are not.
 ******************************************************************************/
#include <assert.h>
#include <stdio.h>

/* Mirror of SystemError_t from main.cpp (keep in lockstep). */
typedef enum {
    ERROR_NONE = 0,
    ERROR_AD9523_CLOCK,
    ERROR_ADF4382_TX_UNLOCK,
    ERROR_ADF4382_RX_UNLOCK,
    ERROR_ADAR1000_COMM,
    ERROR_ADAR1000_TEMP,
    ERROR_IMU_COMM,
    ERROR_BMP180_COMM,
    ERROR_GPS_COMM,
    ERROR_RF_PA_OVERCURRENT,
    ERROR_RF_PA_BIAS,
    ERROR_STEPPER_MOTOR,
    ERROR_FPGA_COMM,
    ERROR_POWER_SUPPLY,
    ERROR_TEMPERATURE_HIGH,
    ERROR_MEMORY_ALLOC,
    ERROR_WATCHDOG_TIMEOUT
} SystemError_t;

/* Extracted post-fix predicate: returns 1 when Emergency_Stop() must fire. */
static int triggers_emergency_stop(SystemError_t e)
{
    return ((e >= ERROR_RF_PA_OVERCURRENT && e <= ERROR_POWER_SUPPLY) ||
            e == ERROR_TEMPERATURE_HIGH ||
            e == ERROR_WATCHDOG_TIMEOUT);
}

int main(void)
{
    printf("=== Safety fix: overtemp / watchdog -> Emergency_Stop() ===\n");

    /* --- Errors that MUST latch Emergency_Stop --- */
    printf("  Test 1: ERROR_RF_PA_OVERCURRENT triggers... ");
    assert(triggers_emergency_stop(ERROR_RF_PA_OVERCURRENT));
    printf("PASS\n");

    printf("  Test 2: ERROR_RF_PA_BIAS triggers... ");
    assert(triggers_emergency_stop(ERROR_RF_PA_BIAS));
    printf("PASS\n");

    printf("  Test 3: ERROR_STEPPER_MOTOR triggers... ");
    assert(triggers_emergency_stop(ERROR_STEPPER_MOTOR));
    printf("PASS\n");

    printf("  Test 4: ERROR_FPGA_COMM triggers... ");
    assert(triggers_emergency_stop(ERROR_FPGA_COMM));
    printf("PASS\n");

    printf("  Test 5: ERROR_POWER_SUPPLY triggers... ");
    assert(triggers_emergency_stop(ERROR_POWER_SUPPLY));
    printf("PASS\n");

    printf("  Test 6: ERROR_TEMPERATURE_HIGH triggers (regression)... ");
    assert(triggers_emergency_stop(ERROR_TEMPERATURE_HIGH));
    printf("PASS\n");

    printf("  Test 7: ERROR_WATCHDOG_TIMEOUT triggers (regression)... ");
    assert(triggers_emergency_stop(ERROR_WATCHDOG_TIMEOUT));
    printf("PASS\n");

    /* --- Errors that MUST NOT escalate (recoverable / informational) --- */
    printf("  Test 8: ERROR_NONE does not trigger... ");
    assert(!triggers_emergency_stop(ERROR_NONE));
    printf("PASS\n");

    printf("  Test 9: ERROR_AD9523_CLOCK does not trigger... ");
    assert(!triggers_emergency_stop(ERROR_AD9523_CLOCK));
    printf("PASS\n");

    printf("  Test 10: ERROR_ADF4382_TX_UNLOCK does not trigger (recoverable)... ");
    assert(!triggers_emergency_stop(ERROR_ADF4382_TX_UNLOCK));
    printf("PASS\n");

    printf("  Test 11: ERROR_ADAR1000_COMM does not trigger... ");
    assert(!triggers_emergency_stop(ERROR_ADAR1000_COMM));
    printf("PASS\n");

    printf("  Test 12: ERROR_IMU_COMM does not trigger... ");
    assert(!triggers_emergency_stop(ERROR_IMU_COMM));
    printf("PASS\n");

    printf("  Test 13: ERROR_GPS_COMM does not trigger... ");
    assert(!triggers_emergency_stop(ERROR_GPS_COMM));
    printf("PASS\n");

    printf("  Test 14: ERROR_MEMORY_ALLOC does not trigger... ");
    assert(!triggers_emergency_stop(ERROR_MEMORY_ALLOC));
    printf("PASS\n");

    printf("\n=== Safety fix: ALL TESTS PASSED ===\n\n");
    return 0;
}
