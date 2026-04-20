/*******************************************************************************
 * test_bug8_uart_commented_out.c
 *
 * Bug #8 (FIXED): Debug helpers uart_print() and uart_println() are now
 * uncommented and available as active code.
 *
 * Post-fix test:
 *   Read the source file and verify the functions are NOT inside comment blocks.
 ******************************************************************************/
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/* Path to the source file (relative from test execution dir) */
#define SOURCE_FILE "../9_1_3_C_Cpp_Code/main.cpp"

/* Helper: read entire file into malloc'd buffer. Returns NULL on failure. */
static char *read_file(const char *path, long *out_size)
{
    FILE *f = fopen(path, "r");
    if (!f) return NULL;
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);
    char *buf = (char *)malloc(size + 1);
    if (!buf) { fclose(f); return NULL; }
    long nread = (long)fread(buf, 1, size, f);
    buf[nread] = '\0';
    fclose(f);
    if (out_size) *out_size = nread;
    return buf;
}

int main(void)
{
    printf("=== Bug #8 (FIXED): uart_print/uart_println uncommented ===\n");

    long size;
    char *src = read_file(SOURCE_FILE, &size);
    if (!src) {
        src = read_file("/Users/ganeshpanth/PLFM_RADAR/9_Firmware/9_1_Microcontroller/9_1_3_C_Cpp_Code/main.cpp", &size);
    }
    assert(src != NULL && "Could not open main.cpp");
    printf("  Read %ld bytes from main.cpp\n", size);

    /* ---- Test A: uart_print is NOT inside a block comment ---- */
    const char *uart_print_sig = "static void uart_print(const char *msg)";
    char *pos = strstr(src, uart_print_sig);
    assert(pos != NULL && "uart_print function signature not found in source");
    printf("  Found uart_print signature at offset %ld\n", (long)(pos - src));

    int inside_comment = 0;
    for (char *p = src; p < pos; p++) {
        if (p[0] == '/' && p[1] == '*') {
            inside_comment = 1;
            p++;
        } else if (p[0] == '*' && p[1] == '/') {
            inside_comment = 0;
            p++;
        }
    }
    printf("  uart_print is inside block comment: %s\n",
           inside_comment ? "YES" : "NO");
    assert(inside_comment == 0);
    printf("  PASS: uart_print is NOT commented out (FIXED)\n");

    /* ---- Test B: uart_println is NOT inside a block comment ---- */
    const char *uart_println_sig = "static void uart_println(const char *msg)";
    pos = strstr(src, uart_println_sig);
    assert(pos != NULL && "uart_println function signature not found in source");
    printf("  Found uart_println signature at offset %ld\n", (long)(pos - src));

    inside_comment = 0;
    for (char *p = src; p < pos; p++) {
        if (p[0] == '/' && p[1] == '*') {
            inside_comment = 1;
            p++;
        } else if (p[0] == '*' && p[1] == '/') {
            inside_comment = 0;
            p++;
        }
    }
    printf("  uart_println is inside block comment: %s\n",
           inside_comment ? "YES" : "NO");
    assert(inside_comment == 0);
    printf("  PASS: uart_println is NOT commented out (FIXED)\n");

    free(src);
    printf("=== Bug #8 (FIXED): ALL TESTS PASSED ===\n\n");
    return 0;
}
