/*******************************************************************************
 * test_bug2_ad9523_double_setup.c
 *
 * Bug #2 (FIXED): configure_ad9523() now calls ad9523_setup() only ONCE,
 * after AD9523_RESET_RELEASE(). The first call (before reset) was removed.
 *
 * Post-fix test:
 *   1. Replay the fixed configure_ad9523() call sequence.
 *   2. Verify ad9523_setup() is called exactly ONCE.
 *   3. Verify the reset-release GPIO write occurs BEFORE the setup call.
 ******************************************************************************/
#include "stm32_hal_mock.h"
#include "ad_driver_mock.h"
#include <assert.h>
#include <stdio.h>

/* Pin defines from main.h shim */
#define AD9523_RESET_Pin        GPIO_PIN_6
#define AD9523_RESET_GPIO_Port  GPIOF
#define AD9523_REF_SEL_Pin      GPIO_PIN_4
#define AD9523_REF_SEL_GPIO_Port GPIOF

/* Macro from main.cpp */
#define AD9523_RESET_RELEASE() HAL_GPIO_WritePin(AD9523_RESET_GPIO_Port, AD9523_RESET_Pin, GPIO_PIN_SET)
#define AD9523_REF_SEL(x)     HAL_GPIO_WritePin(AD9523_REF_SEL_GPIO_Port, AD9523_REF_SEL_Pin, (x) ? GPIO_PIN_SET : GPIO_PIN_RESET)

/*
 * Extracted from main.cpp — FIXED version (single setup call after reset).
 */
static int configure_ad9523_extracted(void)
{
    struct ad9523_dev *dev = NULL;
    struct ad9523_platform_data pdata;
    struct ad9523_init_param init_param;
    int32_t ret;

    memset(&pdata, 0, sizeof(pdata));
    pdata.vcxo_freq = 100000000;
    pdata.num_channels = 0;
    pdata.channels = NULL;

    memset(&init_param, 0, sizeof(init_param));
    init_param.pdata = &pdata;

    /* Step 1: ad9523_init (fills defaults) */
    ad9523_init(&init_param);

    /* Step 2: Release reset FIRST (Bug #2 fix: removed pre-reset setup call) */
    AD9523_RESET_RELEASE();
    HAL_Delay(5);

    /* Step 3: Select REFB */
    AD9523_REF_SEL(true);

    /* Step 4: Single ad9523_setup() — post-reset, real config */
    ret = ad9523_setup(&dev, &init_param);
    if (ret != 0) return -1;

    /* Step 5: status + sync */
    ad9523_status(dev);
    ad9523_sync(dev);

    return 0;
}

int main(void)
{
    printf("=== Bug #2 (FIXED): AD9523 single setup call ===\n");

    spy_reset();
    int ret = configure_ad9523_extracted();
    assert(ret == 0);

    /* ---- Test A: ad9523_setup was called exactly ONCE ---- */
    int setup_count = spy_count_type(SPY_AD9523_SETUP);
    printf("  SPY_AD9523_SETUP records: %d (expected 1)\n", setup_count);
    assert(setup_count == 1);
    printf("  PASS: ad9523_setup() called exactly once\n");

    /* ---- Test B: Reset release occurs BEFORE the setup call ---- */
    int setup_idx = spy_find_nth(SPY_AD9523_SETUP, 0);

    /* Find the GPIO write for GPIOF, AD9523_RESET_Pin, SET */
    int reset_gpio_idx = -1;
    for (int i = 0; i < setup_idx; i++) {
        const SpyRecord *r = spy_get(i);
        if (r && r->type == SPY_GPIO_WRITE &&
            r->port == GPIOF &&
            r->pin == AD9523_RESET_Pin &&
            r->value == GPIO_PIN_SET) {
            reset_gpio_idx = i;
            break;
        }
    }

    printf("  Reset release at spy index %d, setup at %d\n",
           reset_gpio_idx, setup_idx);
    assert(reset_gpio_idx >= 0);
    assert(reset_gpio_idx < setup_idx);
    printf("  PASS: Reset released BEFORE setup call (correct order)\n");

    printf("=== Bug #2 (FIXED): ALL TESTS PASSED ===\n\n");
    return 0;
}
