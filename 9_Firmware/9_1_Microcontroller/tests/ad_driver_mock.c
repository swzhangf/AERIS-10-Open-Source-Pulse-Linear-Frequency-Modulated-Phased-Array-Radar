/*******************************************************************************
 * ad_driver_mock.c -- Mock implementations for ADF4382 and AD9523 drivers
 ******************************************************************************/
#include "ad_driver_mock.h"
#include <stdlib.h>
#include <string.h>

/* Configurable return values */
int mock_adf4382_init_retval = 0;
int mock_adf4382_set_timed_sync_retval = 0;
int mock_ad9523_setup_retval = 0;

/* Internal device stubs (allocated on the heap by mock init) */
static struct adf4382_dev  adf4382_stub_devs[4];
static int                 adf4382_stub_idx = 0;

static struct ad9523_dev   ad9523_stub_devs[2];
static int                 ad9523_stub_idx = 0;

/* Helper to push spy record (references the extern in stm32_hal_mock) */
extern SpyRecord spy_log[];
extern int       spy_count;

static void spy_push_drv(SpyCallType type, void *extra, uint32_t val)
{
    if (spy_count < SPY_MAX_RECORDS) {
        spy_log[spy_count++] = (SpyRecord){
            .type  = type,
            .port  = NULL,
            .pin   = 0,
            .value = val,
            .extra = extra
        };
    }
}

/* ========================= ADF4382 mock =========================== */

int adf4382_init(struct adf4382_dev **device, struct adf4382_init_param *init_param)
{
    spy_push_drv(SPY_ADF4382_INIT, (void*)init_param, 0);
    if (mock_adf4382_init_retval != 0) {
        *device = NULL;
        return mock_adf4382_init_retval;
    }
    /* Return a stub device */
    int idx = adf4382_stub_idx % 4;
    memset(&adf4382_stub_devs[idx], 0, sizeof(struct adf4382_dev));
    adf4382_stub_devs[idx].freq = init_param->freq;
    adf4382_stub_devs[idx].ref_freq_hz = init_param->ref_freq_hz;
    *device = &adf4382_stub_devs[idx];
    adf4382_stub_idx++;
    return 0;
}

int adf4382_remove(struct adf4382_dev *dev)
{
    spy_push_drv(SPY_ADF4382_REMOVE, dev, 0);
    return 0;
}

int adf4382_set_out_power(struct adf4382_dev *dev, uint8_t ch, int32_t pwr)
{
    spy_push_drv(SPY_ADF4382_SET_OUT_POWER, dev, (uint32_t)((ch << 16) | (pwr & 0xFFFF)));
    return 0;
}

int adf4382_set_en_chan(struct adf4382_dev *dev, uint8_t ch, bool en)
{
    spy_push_drv(SPY_ADF4382_SET_EN_CHAN, dev, (uint32_t)((ch << 16) | en));
    return 0;
}

int adf4382_set_timed_sync_setup(struct adf4382_dev *dev, bool sync)
{
    spy_push_drv(SPY_ADF4382_SET_TIMED_SYNC, dev, (uint32_t)sync);
    return mock_adf4382_set_timed_sync_retval;
}

int adf4382_set_ezsync_setup(struct adf4382_dev *dev, bool sync)
{
    spy_push_drv(SPY_ADF4382_SET_EZSYNC, dev, (uint32_t)sync);
    return 0;
}

int adf4382_set_sw_sync(struct adf4382_dev *dev, bool sw_sync)
{
    spy_push_drv(SPY_ADF4382_SET_SW_SYNC, dev, (uint32_t)sw_sync);
    return 0;
}

int adf4382_spi_read(struct adf4382_dev *dev, uint16_t reg_addr, uint8_t *data)
{
    spy_push_drv(SPY_ADF4382_SPI_READ, dev, (uint32_t)reg_addr);
    if (data) {
        /* By default, return "locked" status for reg 0x58 */
        if (reg_addr == 0x58) {
            *data = ADF4382_LOCKED_MSK; /* locked */
        } else {
            *data = 0;
        }
    }
    return 0;
}

/* ========================= AD9523 mock ============================ */

int32_t ad9523_init(struct ad9523_init_param *init_param)
{
    spy_push_drv(SPY_AD9523_INIT, init_param, 0);
    return 0;
}

int32_t ad9523_setup(struct ad9523_dev **device, const struct ad9523_init_param *init_param)
{
    spy_push_drv(SPY_AD9523_SETUP, (void*)init_param, 0);
    if (mock_ad9523_setup_retval != 0) {
        return mock_ad9523_setup_retval;
    }
    int idx = ad9523_stub_idx % 2;
    memset(&ad9523_stub_devs[idx], 0, sizeof(struct ad9523_dev));
    *device = &ad9523_stub_devs[idx];
    ad9523_stub_idx++;
    return 0;
}

int32_t ad9523_status(struct ad9523_dev *dev)
{
    spy_push_drv(SPY_AD9523_STATUS, dev, 0);
    return 0;
}

int32_t ad9523_sync(struct ad9523_dev *dev)
{
    spy_push_drv(SPY_AD9523_SYNC, dev, 0);
    return 0;
}

int32_t ad9523_remove(struct ad9523_dev *dev)
{
    spy_push_drv(SPY_AD9523_REMOVE, dev, 0);
    return 0;
}
