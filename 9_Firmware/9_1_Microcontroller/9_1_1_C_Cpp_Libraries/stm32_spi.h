#ifndef _STM32_SPI_H_
#define _STM32_SPI_H_

#include "no_os_spi.h"
#include "stm32f7xx_hal.h"

/**
 * @struct stm32_spi_extra
 * @brief Platform-specific SPI data for STM32.
 *
 * When software chip-select is needed (e.g. multiple devices sharing one SPI
 * bus with GPIO-managed CS), set cs_port to the GPIO port and cs_pin to the
 * GPIO pin mask.  stm32_spi_write_and_read() will assert CS LOW before the
 * transfer and deassert CS HIGH after.
 *
 * If cs_port is NULL (legacy usage where the caller passes a bare
 * SPI_HandleTypeDef* as the extra pointer), CS management is skipped.
 */
typedef struct {
    SPI_HandleTypeDef *hspi;       /**< HAL SPI handle */
    GPIO_TypeDef      *cs_port;    /**< GPIO port for software CS (NULL = no SW CS) */
    uint16_t           cs_pin;     /**< GPIO pin mask for software CS */
} stm32_spi_extra;

extern const struct no_os_spi_platform_ops stm32_spi_ops;

#endif /* _STM32_SPI_H_ */
