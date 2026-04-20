/*******************************************************************************
 * test_bug12_pa_cal_loop_inverted.c
 *
 * Bug #12 (FIXED): PA IDQ calibration loop condition was inverted.
 *   Old: while (DAC_val > 38 && abs(Idq - 1.680) < 0.2)
 *        → loop continued ONLY when CLOSE to target, exited when far away
 *   New: while (DAC_val > 38 && abs(Idq - 1.680) > 0.2)
 *        → loop continues while FAR from target, exits when converged
 *
 * Test strategy:
 *   Simulate the loop logic with known Idq values and verify:
 *   1. Loop continues when Idq is far from 1.680A (e.g., 0.5A)
 *   2. Loop exits when Idq is within 0.2A of target (e.g., 1.60A)
 *   3. Loop exits when DAC_val reaches lower bound (38)
 ******************************************************************************/
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/* Extracted calibration loop condition (post-fix) */
static int should_continue_loop(int DAC_val, double Idq_reading)
{
    /* This matches the FIXED condition in main.cpp lines 1854/1874 */
    return (DAC_val > 38 && fabs(Idq_reading - 1.680) > 0.2);
}

int main(void)
{
    printf("=== Bug #12 (FIXED): PA calibration loop condition ===\n");

    /* Test 1: Idq far from target → loop should CONTINUE */
    printf("  Test 1: Idq=0.500A (far from 1.680A), DAC=100 → ");
    assert(should_continue_loop(100, 0.500) == 1);
    printf("CONTINUE (correct)\n");

    /* Test 2: Idq within tolerance → loop should EXIT */
    printf("  Test 2: Idq=1.600A (within 0.2A of 1.680A), DAC=80 → ");
    assert(should_continue_loop(80, 1.600) == 0);
    printf("EXIT (correct)\n");

    /* Test 3: Idq exactly at target → loop should EXIT */
    printf("  Test 3: Idq=1.680A (exactly at target), DAC=60 → ");
    assert(should_continue_loop(60, 1.680) == 0);
    printf("EXIT (correct)\n");

    /* Test 4: DAC at lower bound → loop should EXIT regardless of Idq */
    printf("  Test 4: Idq=0.200A (far), DAC=38 → ");
    assert(should_continue_loop(38, 0.200) == 0);
    printf("EXIT (DAC limit, correct)\n");

    /* Test 5: Idq just outside tolerance (0.201 from target) → CONTINUE */
    printf("  Test 5: Idq=1.479A (|diff|=0.201), DAC=50 → ");
    assert(should_continue_loop(50, 1.479) == 1);
    printf("CONTINUE (correct)\n");

    /* Test 6: Idq just inside tolerance (0.199 from target) → EXIT */
    printf("  Test 6: Idq=1.481A (|diff|=0.199), DAC=50 → ");
    assert(should_continue_loop(50, 1.481) == 0);
    printf("EXIT (correct)\n");

    /* Test 7: Simulate full loop convergence */
    printf("  Test 7: Full loop simulation... ");
    {
        int DAC_val = 126;
        int iterations = 0;
        /* Simulate decreasing DAC → increasing Idq */
        while (1) {
            DAC_val -= 4;
            iterations++;
            /* Simulate: Idq = 1.680 - (DAC_val - 50) * 0.02 */
            double Idq = 1.680 - (DAC_val - 50) * 0.02;
            if (!should_continue_loop(DAC_val, Idq)) {
                printf("converged at DAC=%d Idq=%.3fA after %d iterations",
                       DAC_val, Idq, iterations);
                /* Should converge somewhere around DAC=50-60 */
                assert(iterations < 50);  /* safety counter limit */
                assert(fabs(Idq - 1.680) <= 0.2);  /* should be in tolerance */
                break;
            }
            assert(iterations < 100);  /* prevent infinite loop in test */
        }
        printf(" → PASS\n");
    }

    printf("\n=== Bug #12: ALL TESTS PASSED (post-fix) ===\n\n");
    return 0;
}
