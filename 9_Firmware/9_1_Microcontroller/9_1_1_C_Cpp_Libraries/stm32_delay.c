#include "stm32f7xx_hal.h"
#include "no_os_delay.h"

/*  microsecond delay using DWT cycle counter */
void no_os_udelay(uint32_t usec)
{
    uint32_t start = DWT->CYCCNT;
    uint32_t cycles = (HAL_RCC_GetHCLKFreq() / 1000000U) * usec;
    while ((DWT->CYCCNT - start) < cycles);
}

/*  millisecond delay wrapper  */
void no_os_mdelay(uint32_t msec)
{
    HAL_Delay(msec);
}

