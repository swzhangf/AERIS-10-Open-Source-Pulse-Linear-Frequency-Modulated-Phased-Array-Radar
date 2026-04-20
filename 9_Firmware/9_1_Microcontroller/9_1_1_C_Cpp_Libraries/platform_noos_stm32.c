/* platform_noos_stm32.c */
#include "platform_noos_stm32.h"

/* Use existing CubeMX handles */
extern SPI_HandleTypeDef hspi4;

/* SPI descriptor we pass to no-OS (just a pointer to HAL handle) */
int32_t platform_spi_init(void **desc, uint32_t max_speed_hz, uint8_t mode)
{
    /* For STM32 HAL we already configured hspi4 in CubeMX,
       so just return that pointer as the descriptor. */
    if (!desc) return -1;
    *desc = (void*)&hspi4;
    return 0;
}

/* SPI write/read - single transaction (no-OS expects raw transfer) */
int32_t platform_spi_write_and_read(void *desc, uint8_t *data, uint16_t len)
{
    SPI_HandleTypeDef *hdl = (SPI_HandleTypeDef*)desc;
    if (!hdl) return -1;
    /* ADI no-OS SPI wrappers often do full-duplex transfers */
    if (HAL_SPI_TransmitReceive(hdl, data, data, len, HAL_MAX_DELAY) != HAL_OK)
        return -1;
    return 0;
}

int32_t platform_spi_remove(void *desc)
{
    (void)desc;
    return 0;
}

/* Minimal GPIO wrapper: we will just use HAL GPIO directly */
/* For simplicity we store nothing in gpio_desc, port_pin encodes both port and pin:
   You'll map an enum (0..n) -> HAL GPIO Port/Pin in your code. */

int32_t platform_gpio_init(void *gpio_desc, uint8_t port_pin, bool is_output)
{
    (void)gpio_desc; (void)port_pin; (void)is_output;
    /* Assume CubeMX already configured the GPIO pins: nothing to do */
    return 0;
}

int32_t platform_gpio_direction_output(void *gpio_desc, uint8_t port_pin, uint8_t value)
{
    (void)gpio_desc;
    /* Implement mapping here from port_pin index to actual port/pin */
    /* Example stub: user must implement mapping function: hal_set_gpio_by_index(port_pin, value) */
    extern void hal_set_gpio_by_index(uint8_t idx, uint8_t value);
    hal_set_gpio_by_index(port_pin, value);
    return 0;
}

int32_t platform_gpio_set_value(void *gpio_desc, uint8_t port_pin, uint8_t value)
{
    extern void hal_set_gpio_by_index(uint8_t idx, uint8_t value);
    hal_set_gpio_by_index(port_pin, value);
    return 0;
}

int32_t platform_gpio_remove(void *gpio_desc) { (void)gpio_desc; return 0; }

void platform_delay_ms(uint32_t ms) { HAL_Delay(ms); }
