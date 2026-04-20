/*******************************************************************************
 * test_bug11_platform_spi_transmit_only.c
 *
 * Bug #11: platform_noos_stm32.c used HAL_SPI_Transmit() instead of
 *          HAL_SPI_TransmitReceive(), meaning reads returned garbage.
 *
 * Post-fix: Verify platform_spi_write_and_read() calls TransmitReceive.
 ******************************************************************************/
#include "stm32_hal_mock.h"
#include "platform_noos_stm32.h"
#include <stdio.h>
#include <assert.h>

int main(void)
{
    printf("[Bug #11] platform_spi_write_and_read uses TransmitReceive\n");

    /* ---- setup ---- */
    spy_reset();

    /* Init: get a descriptor (should be &hspi4) */
    void *desc = NULL;
    int32_t rc = platform_spi_init(&desc, 1000000, 0);
    assert(rc == 0);
    assert(desc == (void *)&hspi4);

    /* Call write_and_read */
    uint8_t buf[4] = {0xAA, 0xBB, 0xCC, 0xDD};
    rc = platform_spi_write_and_read(desc, buf, 4);
    assert(rc == 0);

    /* Verify: should see SPY_SPI_TRANSMIT_RECEIVE, NOT SPY_SPI_TRANSMIT */
    int tx_rx_count = spy_count_type(SPY_SPI_TRANSMIT_RECEIVE);
    int tx_only_count = spy_count_type(SPY_SPI_TRANSMIT);

    assert(tx_rx_count == 1 && "Expected exactly one HAL_SPI_TransmitReceive call");
    assert(tx_only_count == 0 && "Should not use HAL_SPI_Transmit (that was the bug)");

    /* Verify correct SPI handle */
    int idx = spy_find_nth(SPY_SPI_TRANSMIT_RECEIVE, 0);
    assert(idx >= 0);
    const SpyRecord *rec = spy_get(idx);
    assert(rec->extra == (void *)&hspi4);
    assert(rec->pin == 4);  /* Size = 4 */

    /* ---- null descriptor test ---- */
    spy_reset();
    rc = platform_spi_write_and_read(NULL, buf, 4);
    assert(rc == -1);

    /* ---- null desc pointer on init ---- */
    rc = platform_spi_init(NULL, 1000000, 0);
    assert(rc == -1);

    printf("[Bug #11] PASSED\n");
    return 0;
}
