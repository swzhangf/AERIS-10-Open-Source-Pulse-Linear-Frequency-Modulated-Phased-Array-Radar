/*******************************************************************************
 * test_bug10_spi_cs_not_toggled.c
 *
 * Bug #10 (FIXED): stm32_spi_write_and_read() never toggled chip select.
 * Since TX and RX ADF4382A share SPI4, every register write hit BOTH PLLs
 * simultaneously.
 *
 * Post-fix behavior:
 *   1. Manager_Init creates stm32_spi_extra structs with the correct CS
 *      port (GPIOG) and pin for each device (TX_CS_Pin, RX_CS_Pin).
 *   2. spi_param.extra points to a stm32_spi_extra with cs_port != NULL,
 *      so stm32_spi_write_and_read() will assert/deassert CS around
 *      each transfer.
 *
 * Note: The actual SPI CS toggling is in stm32_spi.c at the platform level.
 * This test verifies that the manager correctly provisions the CS metadata
 * that stm32_spi.c uses.
 ******************************************************************************/
#include "adf4382a_manager.h"
#include "stm32_spi.h"
#include <assert.h>
#include <stdio.h>

int main(void)
{
    ADF4382A_Manager mgr;
    int ret;

    printf("=== Bug #10 (FIXED): SPI CS not toggled ===\n");

    /* ---- Test A: Init succeeds ---- */
    spy_reset();
    ret = ADF4382A_Manager_Init(&mgr, SYNC_METHOD_TIMED);

    printf("  Manager_Init returned: %d (expected 0=OK)\n", ret);
    assert(ret == ADF4382A_MANAGER_OK);
    printf("  PASS: Init returned OK\n");

    /* ---- Test B: TX extra is non-NULL ---- */
    printf("  spi_tx_param.extra = %p (expected non-NULL)\n", mgr.spi_tx_param.extra);
    assert(mgr.spi_tx_param.extra != NULL);
    printf("  PASS: TX extra is non-NULL\n");

    /* ---- Test C: TX extra has correct CS port and pin ---- */
    stm32_spi_extra *tx_extra = (stm32_spi_extra *)mgr.spi_tx_param.extra;
    printf("  TX cs_port = %p (expected GPIOG = %p)\n", (void *)tx_extra->cs_port, (void *)GPIOG);
    assert(tx_extra->cs_port == GPIOG);
    printf("  PASS: TX cs_port == GPIOG\n");

    printf("  TX cs_pin = 0x%04X (expected TX_CS_Pin = 0x%04X)\n", tx_extra->cs_pin, TX_CS_Pin);
    assert(tx_extra->cs_pin == TX_CS_Pin);  /* GPIO_PIN_14 = 0x4000 */
    printf("  PASS: TX cs_pin == TX_CS_Pin (GPIO_PIN_14)\n");

    /* ---- Test D: TX extra has correct SPI handle ---- */
    printf("  TX hspi = %p (expected &hspi4 = %p)\n", (void *)tx_extra->hspi, (void *)&hspi4);
    assert(tx_extra->hspi == &hspi4);
    printf("  PASS: TX hspi == &hspi4\n");

    /* ---- Test E: RX extra is non-NULL ---- */
    printf("  spi_rx_param.extra = %p (expected non-NULL)\n", mgr.spi_rx_param.extra);
    assert(mgr.spi_rx_param.extra != NULL);
    printf("  PASS: RX extra is non-NULL\n");

    /* ---- Test F: RX extra has correct CS port and pin ---- */
    stm32_spi_extra *rx_extra = (stm32_spi_extra *)mgr.spi_rx_param.extra;
    printf("  RX cs_port = %p (expected GPIOG = %p)\n", (void *)rx_extra->cs_port, (void *)GPIOG);
    assert(rx_extra->cs_port == GPIOG);
    printf("  PASS: RX cs_port == GPIOG\n");

    printf("  RX cs_pin = 0x%04X (expected RX_CS_Pin = 0x%04X)\n", rx_extra->cs_pin, RX_CS_Pin);
    assert(rx_extra->cs_pin == RX_CS_Pin);  /* GPIO_PIN_10 = 0x0400 */
    printf("  PASS: RX cs_pin == RX_CS_Pin (GPIO_PIN_10)\n");

    /* ---- Test G: RX extra has correct SPI handle ---- */
    printf("  RX hspi = %p (expected &hspi4 = %p)\n", (void *)rx_extra->hspi, (void *)&hspi4);
    assert(rx_extra->hspi == &hspi4);
    printf("  PASS: RX hspi == &hspi4\n");

    /* ---- Test H: TX and RX extras are DIFFERENT instances ---- */
    printf("  TX extra = %p, RX extra = %p (expected different)\n",
           (void *)tx_extra, (void *)rx_extra);
    assert(tx_extra != rx_extra);
    printf("  PASS: TX and RX have separate stm32_spi_extra instances\n");

    /* ---- Test I: TX and RX have DIFFERENT CS pins ---- */
    assert(tx_extra->cs_pin != rx_extra->cs_pin);
    printf("  PASS: TX and RX CS pins differ (individual addressing)\n");

    /* Cleanup */
    ADF4382A_Manager_Deinit(&mgr);

    printf("=== Bug #10 (FIXED): ALL TESTS PASSED ===\n\n");
    return 0;
}
