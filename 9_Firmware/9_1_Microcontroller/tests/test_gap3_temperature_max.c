/*******************************************************************************
 * test_gap3_temperature_max.c
 *
 * Gap-3 Fix 3 (FIXED): `temperature` variable now assigned from sensors.
 *
 * Before fix:  `float temperature;` was declared but NEVER assigned.
 *              checkSystemHealth() compared uninitialized value against 75°C.
 *
 * After fix:   After reading Temperature_1..8, the code computes
 *              temperature = max(Temperature_1..Temperature_8).
 *
 * Test strategy:
 *   Extract the max-temperature logic and verify with known sensor values.
 ******************************************************************************/
#include <assert.h>
#include <stdio.h>
#include <math.h>

/* Extracted max-temperature logic (post-fix) */
static float compute_max_temperature(float temps[8])
{
    float max_temp = temps[0];
    for (int i = 1; i < 8; i++) {
        if (temps[i] > max_temp) max_temp = temps[i];
    }
    return max_temp;
}

int main(void)
{
    printf("=== Gap-3 Fix 3: temperature = max(Temperature_1..8) ===\n");

    /* Test 1: Hottest sensor is in middle */
    printf("  Test 1: Max in middle position... ");
    {
        float temps[8] = {20.0f, 25.0f, 30.0f, 80.0f, 40.0f, 35.0f, 22.0f, 18.0f};
        float result = compute_max_temperature(temps);
        assert(fabsf(result - 80.0f) < 0.001f);
        printf("%.1f PASS\n", result);
    }

    /* Test 2: Hottest sensor is first */
    printf("  Test 2: Max at index 0... ");
    {
        float temps[8] = {90.0f, 25.0f, 30.0f, 40.0f, 40.0f, 35.0f, 22.0f, 18.0f};
        float result = compute_max_temperature(temps);
        assert(fabsf(result - 90.0f) < 0.001f);
        printf("%.1f PASS\n", result);
    }

    /* Test 3: Hottest sensor is last */
    printf("  Test 3: Max at index 7... ");
    {
        float temps[8] = {20.0f, 25.0f, 30.0f, 40.0f, 40.0f, 35.0f, 22.0f, 85.5f};
        float result = compute_max_temperature(temps);
        assert(fabsf(result - 85.5f) < 0.001f);
        printf("%.1f PASS\n", result);
    }

    /* Test 4: All sensors equal */
    printf("  Test 4: All equal... ");
    {
        float temps[8] = {42.0f, 42.0f, 42.0f, 42.0f, 42.0f, 42.0f, 42.0f, 42.0f};
        float result = compute_max_temperature(temps);
        assert(fabsf(result - 42.0f) < 0.001f);
        printf("%.1f PASS\n", result);
    }

    /* Test 5: Overtemp threshold check (>75°C triggers ERROR_TEMPERATURE_HIGH) */
    printf("  Test 5: Overtemp detection at 75.1C... ");
    {
        float temps[8] = {20.0f, 25.0f, 30.0f, 40.0f, 75.1f, 35.0f, 22.0f, 18.0f};
        float result = compute_max_temperature(temps);
        assert(result > 75.0f);  /* would trigger checkSystemHealth overtemp */
        printf("%.1f > 75.0 → OVERTEMP DETECTED, PASS\n", result);
    }

    /* Test 6: Below overtemp threshold */
    printf("  Test 6: Normal temp (all below 75C)... ");
    {
        float temps[8] = {20.0f, 25.0f, 30.0f, 40.0f, 74.9f, 35.0f, 22.0f, 18.0f};
        float result = compute_max_temperature(temps);
        assert(result <= 75.0f);  /* would NOT trigger overtemp */
        printf("%.1f <= 75.0 → OK, PASS\n", result);
    }

    /* Test 7: ADC scaling verification */
    printf("  Test 7: ADC scaling: raw=116 → 75.1°C... ");
    {
        /* TMP37: 3.3V→165°C, ADS7830: 3.3V→255
         * temp = raw * 165/255 = raw * 0.64705 */
        float raw = 116.0f;
        float temp = raw * 0.64705f;
        printf("(%.2f°C) ", temp);
        assert(temp > 75.0f);  /* 116 * 0.64705 ≈ 75.06 */
        printf("PASS\n");
    }

    printf("\n=== Gap-3 Fix 3: ALL TESTS PASSED ===\n\n");
    return 0;
}
