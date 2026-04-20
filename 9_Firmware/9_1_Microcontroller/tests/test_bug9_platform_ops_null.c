/*******************************************************************************
 * test_bug9_platform_ops_null.c
 *
 * Bug #9 (FIXED): Both TX and RX SPI init params had platform_ops = NULL.
 * adf4382_init() calls no_os_spi_init() which checks
 *   if (!param->platform_ops) return -EINVAL;
 * so SPI init always silently failed.
 *
 * Post-fix behavior:
 *   1. Manager_Init sets platform_ops = &stm32_spi_ops for both TX and RX.
 *   2. platform_ops is non-NULL and points to the STM32 SPI platform ops.
 ******************************************************************************/
#include "adf4382a_manager.h"
#include "stm32_spi.h"
#include <assert.h>
#include <stdio.h>

int main(void)
{
    ADF4382A_Manager mgr;
    int ret;

    printf("=== Bug #9 (FIXED): platform_ops was NULL ===\n");

    /* ---- Test A: Init succeeds ---- */
    spy_reset();
    ret = ADF4382A_Manager_Init(&mgr, SYNC_METHOD_TIMED);

    printf("  Manager_Init returned: %d (expected 0=OK)\n", ret);
    assert(ret == ADF4382A_MANAGER_OK);
    printf("  PASS: Init returned OK\n");

    /* ---- Test B: TX platform_ops is non-NULL ---- */
    printf("  spi_tx_param.platform_ops = %p (expected non-NULL)\n",
           (void *)mgr.spi_tx_param.platform_ops);
    assert(mgr.spi_tx_param.platform_ops != NULL);
    printf("  PASS: TX platform_ops is non-NULL\n");

    /* ---- Test C: RX platform_ops is non-NULL ---- */
    printf("  spi_rx_param.platform_ops = %p (expected non-NULL)\n",
           (void *)mgr.spi_rx_param.platform_ops);
    assert(mgr.spi_rx_param.platform_ops != NULL);
    printf("  PASS: RX platform_ops is non-NULL\n");

    /* ---- Test D: Both point to stm32_spi_ops ---- */
    printf("  &stm32_spi_ops = %p\n", (void *)&stm32_spi_ops);
    assert(mgr.spi_tx_param.platform_ops == &stm32_spi_ops);
    printf("  PASS: TX platform_ops == &stm32_spi_ops\n");

    assert(mgr.spi_rx_param.platform_ops == &stm32_spi_ops);
    printf("  PASS: RX platform_ops == &stm32_spi_ops\n");

    /* Cleanup */
    ADF4382A_Manager_Deinit(&mgr);

    printf("=== Bug #9 (FIXED): ALL TESTS PASSED ===\n\n");
    return 0;
}
