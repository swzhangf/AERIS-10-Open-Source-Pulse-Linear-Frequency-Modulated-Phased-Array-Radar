/* shim: redirect no_os_delay.h -> our mock */
#ifndef NO_OS_DELAY_H_SHIM
#define NO_OS_DELAY_H_SHIM
#include "stm32_hal_mock.h"
/* no_os_udelay and no_os_mdelay declared in stm32_hal_mock.h */
struct no_os_time { uint32_t s; uint32_t us; };
#endif
