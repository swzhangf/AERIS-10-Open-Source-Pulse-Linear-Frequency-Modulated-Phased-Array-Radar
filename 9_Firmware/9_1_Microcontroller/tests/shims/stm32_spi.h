/* shim: stm32_spi.h -- provides stm32_spi_extra type and stm32_spi_ops mock
 *
 * The real stm32_spi.h includes stm32f7xx_hal.h which we can't use in tests.
 * This shim provides the stm32_spi_extra struct and a mock stm32_spi_ops
 * extern so that adf4382a_manager.c compiles against test infrastructure.
 */
#ifndef STM32_SPI_H_SHIM
#define STM32_SPI_H_SHIM

#include "stm32_hal_mock.h"
#include "ad_driver_mock.h"

/**
 * @struct stm32_spi_extra
 * @brief Platform-specific SPI data for STM32 (test mock version).
 */
typedef struct {
    SPI_HandleTypeDef *hspi;       /**< HAL SPI handle */
    GPIO_TypeDef      *cs_port;    /**< GPIO port for software CS (NULL = no SW CS) */
    uint16_t           cs_pin;     /**< GPIO pin mask for software CS */
} stm32_spi_extra;

/* Mock stm32_spi_ops -- declared in stm32_hal_mock.c */
extern const struct no_os_spi_platform_ops stm32_spi_ops;

#endif /* STM32_SPI_H_SHIM */
