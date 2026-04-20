/* shim: redirect no_os_util.h -> minimal defines */
#ifndef NO_OS_UTIL_H_SHIM
#define NO_OS_UTIL_H_SHIM

#include <stdint.h>

#ifndef NO_OS_BIT
#define NO_OS_BIT(x)       (1UL << (x))
#endif

#ifndef NO_OS_GENMASK
#define NO_OS_GENMASK(h, l) (((~0UL) << (l)) & (~0UL >> (31 - (h))))
#endif

static inline uint32_t no_os_field_prep(uint32_t mask, uint32_t val) {
    int shift = __builtin_ctz(mask);
    return (val << shift) & mask;
}

static inline uint32_t no_os_field_get(uint32_t mask, uint32_t val) {
    int shift = __builtin_ctz(mask);
    return (val & mask) >> shift;
}

#endif
