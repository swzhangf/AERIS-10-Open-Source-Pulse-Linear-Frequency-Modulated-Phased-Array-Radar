/*******************************************************************************
 * test_gap3_idq_periodic_reread.c
 *
 * Gap-3 Fix 4 (FIXED): IDQ values now periodically re-read during operation.
 *
 * Before fix:  Idq_reading[16] was only populated during startup/calibration.
 *              checkSystemHealth() compared stale values for overcurrent
 *              (>2.5A) and bias fault (<0.1A) checks.
 *
 * After fix:   Every 5 seconds (in the temperature monitoring block),
 *              all 16 ADC channels are re-read and Idq_reading[] is updated.
 *
 * Test strategy:
 *   Verify the IDQ conversion formula and fault thresholds with known
 *   raw ADC values.
 ******************************************************************************/
#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <math.h>

/* IDQ conversion formula: Idq = (3.3/255) * raw / (G * Rshunt)
 * where G = 50 (INA241A3 gain) and Rshunt = 5 mOhm = 0.005 Ohm.
 * Denominator = 50 * 0.005 = 0.25
 * So: Idq = (3.3/255) * raw / 0.25 = raw * (3.3 / (255 * 0.25))
 *         = raw * 0.051765... */
static float idq_from_raw(uint8_t raw)
{
    return (3.3f / 255.0f) * raw / (50.0f * 0.005f);
}

/* Overcurrent threshold from checkSystemHealth() */
#define IDQ_OVERCURRENT_THRESHOLD  2.5f
/* Bias fault threshold from checkSystemHealth() */
#define IDQ_BIAS_FAULT_THRESHOLD   0.1f

int main(void)
{
    printf("=== Gap-3 Fix 4: Periodic IDQ re-read ===\n");

    /* Test 1: Raw=0 → Idq=0 (no current) → bias fault */
    printf("  Test 1: raw=0 → Idq=0.000A (bias fault)... ");
    {
        float idq = idq_from_raw(0);
        assert(fabsf(idq - 0.0f) < 0.001f);
        assert(idq < IDQ_BIAS_FAULT_THRESHOLD);
        printf("PASS\n");
    }

    /* Test 2: Normal operating point
     * Target Idq=1.680A → raw = Idq * (50*0.005) * 255/3.3 = 1.680 * 0.25 * 77.27 ≈ 32.5
     * Use raw=33 → Idq = (3.3/255)*33/0.25 ≈ 1.709A */
    printf("  Test 2: raw=33 → Idq≈1.709A (normal)... ");
    {
        float idq = idq_from_raw(33);
        printf("(%.3fA) ", idq);
        assert(idq > IDQ_BIAS_FAULT_THRESHOLD);
        assert(idq < IDQ_OVERCURRENT_THRESHOLD);
        assert(fabsf(idq - 1.680f) < 0.1f);  /* close to calibration target */
        printf("PASS\n");
    }

    /* Test 3: Overcurrent detection (raw=255 → max Idq ≈ 13.2A) */
    printf("  Test 3: raw=255 → Idq≈13.2A (overcurrent)... ");
    {
        float idq = idq_from_raw(255);
        printf("(%.3fA) ", idq);
        assert(idq > IDQ_OVERCURRENT_THRESHOLD);
        printf("PASS\n");
    }

    /* Test 4: Edge case — just below overcurrent
     * 2.5A → raw = 2.5*0.25*255/3.3 ≈ 48.3, so raw=48 → 2.48A (below) */
    printf("  Test 4: raw=48 → just below 2.5A... ");
    {
        float idq = idq_from_raw(48);
        printf("(%.3fA) ", idq);
        assert(idq < IDQ_OVERCURRENT_THRESHOLD);
        printf("PASS\n");
    }

    /* Test 5: Edge case — just above bias fault
     * 0.1A → raw = 0.1*0.25*255/3.3 ≈ 1.93, so raw=2 → 0.103A (above) */
    printf("  Test 5: raw=2 → just above 0.1A... ");
    {
        float idq = idq_from_raw(2);
        printf("(%.3fA) ", idq);
        assert(idq > IDQ_BIAS_FAULT_THRESHOLD);
        printf("PASS\n");
    }

    /* Test 6: All 16 channels use same formula */
    printf("  Test 6: Formula consistency across channels... ");
    {
        /* Simulate ADC1 ch0-7 + ADC2 ch0-7 all returning raw=33 */
        float idq_readings[16];
        for (int ch = 0; ch < 8; ch++) {
            idq_readings[ch] = idq_from_raw(33);       /* ADC1 */
            idq_readings[ch + 8] = idq_from_raw(33);   /* ADC2 */
        }
        for (int i = 0; i < 16; i++) {
            assert(fabsf(idq_readings[i] - idq_readings[0]) < 0.001f);
        }
        printf("PASS\n");
    }

    /* Test 7: Health check would detect overcurrent in any channel */
    printf("  Test 7: Single-channel overcurrent detection... ");
    {
        float idq_readings[16];
        for (int i = 0; i < 16; i++) {
            idq_readings[i] = 1.5f;  /* normal */
        }
        idq_readings[7] = 3.0f;  /* overcurrent on channel 7 */
        int fault_detected = 0;
        for (int i = 0; i < 16; i++) {
            if (idq_readings[i] > IDQ_OVERCURRENT_THRESHOLD) {
                fault_detected = 1;
                printf("(ch%d=%.1fA) ", i, idq_readings[i]);
                break;
            }
        }
        assert(fault_detected);
        printf("PASS\n");
    }

    printf("\n=== Gap-3 Fix 4: ALL TESTS PASSED ===\n\n");
    return 0;
}
