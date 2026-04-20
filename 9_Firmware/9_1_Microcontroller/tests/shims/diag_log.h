/* shim: diag_log.h -- disable DIAG macros for test builds */
#ifndef DIAG_LOG_H_SHIM
#define DIAG_LOG_H_SHIM

/* Silence all DIAG output during unit tests */
#define DIAG_DISABLE

#define DIAG(tag, fmt, ...)        ((void)0)
#define DIAG_WARN(tag, fmt, ...)   ((void)0)
#define DIAG_ERR(tag, fmt, ...)    ((void)0)
#define DIAG_REG(tag, name, val)   ((void)0)
#define DIAG_REG32(tag, name, val) ((void)0)
#define DIAG_GPIO(tag, name, port, pin) ((void)0)
#define DIAG_BOOL(tag, name, val)  ((void)0)
#define DIAG_SECTION(name)         ((void)0)
#define DIAG_ELAPSED(tag, name, t) ((void)0)

#endif
