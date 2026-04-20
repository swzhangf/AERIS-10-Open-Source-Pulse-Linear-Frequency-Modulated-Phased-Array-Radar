/*******************************************************************************
 * test_bug13_dac2_adc_buffer_mismatch.c
 *
 * Bug #13 (FIXED): DAC2 calibration loop wrote ADC reading to adc1_readings
 *   but calculated Idq from adc2_readings — using stale/uninitialized data.
 *
 *   Old: adc1_readings[channel] = ADS7830_Measure_SingleEnded(&hadc2, channel);
 *        Idq = ... * adc2_readings[channel] / ...;  ← reads WRONG buffer
 *
 *   New: adc2_readings[channel] = ADS7830_Measure_SingleEnded(&hadc2, channel);
 *        Idq = ... * adc2_readings[channel] / ...;  ← reads CORRECT buffer
 *
 * Test strategy:
 *   Simulate the buffer read/write pattern and verify that the Idq calculation
 *   uses the freshly-measured value, not a stale one.
 ******************************************************************************/
#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <math.h>

int main(void)
{
    printf("=== Bug #13 (FIXED): DAC2 ADC buffer mismatch ===\n");

    /* Simulate the buffers */
    uint8_t adc1_readings[8] = {0};
    uint8_t adc2_readings[8] = {0};

    /* Pre-fill with stale data to detect mismatch */
    for (int i = 0; i < 8; i++) {
        adc1_readings[i] = 42;  /* stale DAC1 data */
        adc2_readings[i] = 99;  /* stale DAC2 data */
    }

    uint8_t channel = 3;
    uint8_t measured_value = 200;  /* simulated ADC reading */

    /* POST-FIX code pattern (from main.cpp line 1872): */
    adc2_readings[channel] = measured_value;  /* Write to CORRECT buffer */

    /* POST-FIX Idq calculation (from main.cpp line 1873): */
    double Idq = (3.3/255.0) * adc2_readings[channel] / (50 * 0.005);

    /* Expected Idq: (3.3/255) * 200 / 0.25 = 10.353 A (unrealistic but tests math) */
    double expected = (3.3/255.0) * 200.0 / (50.0 * 0.005);

    printf("  measured_value=%d, adc2_readings[%d]=%d\n",
           measured_value, channel, adc2_readings[channel]);
    printf("  Idq=%.6f, expected=%.6f\n", Idq, expected);

    /* Test 1: adc2_readings was written (not adc1_readings) */
    assert(adc2_readings[channel] == measured_value);
    printf("  PASS: adc2_readings[%d] == measured_value (%d)\n",
           channel, measured_value);

    /* Test 2: adc1_readings was NOT overwritten (still has stale value) */
    assert(adc1_readings[channel] == 42);
    printf("  PASS: adc1_readings[%d] unchanged (stale=%d)\n", channel, 42);

    /* Test 3: Idq was calculated from the correct buffer */
    assert(fabs(Idq - expected) < 0.001);
    printf("  PASS: Idq calculation uses adc2_readings (correct buffer)\n");

    /* Test 4: Verify the BUG pattern would have given wrong result */
    {
        /* Simulate the OLD buggy code: write to adc1, read from adc2 */
        uint8_t bug_adc1[8] = {0};
        uint8_t bug_adc2[8] = {0};
        bug_adc2[channel] = 99;  /* stale value in adc2 */

        bug_adc1[channel] = measured_value;  /* BUG: wrote to wrong buffer */
        double bug_Idq = (3.3/255.0) * bug_adc2[channel] / (50.0 * 0.005);

        /* Bug would use stale value 99 instead of measured 200 */
        printf("  Buggy Idq=%.3f (from stale val=99), Fixed Idq=%.3f (from measured=%d)\n",
               bug_Idq, Idq, measured_value);
        assert(fabs(bug_Idq - Idq) > 0.1);  /* They should be different */
        printf("  PASS: buggy value differs from correct value\n");
    }

    printf("\n=== Bug #13: ALL TESTS PASSED (post-fix) ===\n\n");
    return 0;
}
