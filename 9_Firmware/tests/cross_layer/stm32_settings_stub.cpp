/**
 * stm32_settings_stub.cpp
 *
 * Standalone stub that wraps the real RadarSettings class.
 * Reads a binary settings packet from a file (argv[1]),
 * parses it using RadarSettings::parseFromUSB(), and prints
 * all parsed field=value pairs to stdout.
 *
 * Compile: c++ -std=c++11 -o stm32_settings_stub stm32_settings_stub.cpp \
 *          ../../9_Firmware/9_1_Microcontroller/9_1_1_C_Cpp_Libraries/RadarSettings.cpp \
 *          -I../../9_Firmware/9_1_Microcontroller/9_1_1_C_Cpp_Libraries/
 *
 * Usage:  ./stm32_settings_stub packet.bin
 *         Prints: field=value lines (one per field)
 *         Exit code: 0 if parse succeeded, 1 if failed
 */

#include "RadarSettings.h"
#include <cstdio>
#include <cstdlib>

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <packet.bin>\n", argv[0]);
        return 2;
    }

    // Read binary packet from file
    FILE* f = fopen(argv[1], "rb");
    if (!f) {
        fprintf(stderr, "ERROR: Cannot open %s\n", argv[1]);
        return 2;
    }

    fseek(f, 0, SEEK_END);
    long file_size = ftell(f);
    fseek(f, 0, SEEK_SET);

    if (file_size <= 0 || file_size > 4096) {
        fprintf(stderr, "ERROR: Invalid file size %ld\n", file_size);
        fclose(f);
        return 2;
    }

    uint8_t* buf = (uint8_t*)malloc(file_size);
    if (!buf) {
        fprintf(stderr, "ERROR: malloc failed\n");
        fclose(f);
        return 2;
    }

    size_t nread = fread(buf, 1, file_size, f);
    fclose(f);

    if ((long)nread != file_size) {
        fprintf(stderr, "ERROR: Short read (%zu of %ld)\n", nread, file_size);
        free(buf);
        return 2;
    }

    // Parse using the real RadarSettings class
    RadarSettings settings;
    bool ok = settings.parseFromUSB(buf, (uint32_t)file_size);
    free(buf);

    if (!ok) {
        printf("parse_ok=false\n");
        return 1;
    }

    // Print all fields with full precision
    // Python orchestrator will compare these against expected values
    printf("parse_ok=true\n");
    printf("system_frequency=%.17g\n", settings.getSystemFrequency());
    printf("chirp_duration_1=%.17g\n", settings.getChirpDuration1());
    printf("chirp_duration_2=%.17g\n", settings.getChirpDuration2());
    printf("chirps_per_position=%u\n", settings.getChirpsPerPosition());
    printf("freq_min=%.17g\n", settings.getFreqMin());
    printf("freq_max=%.17g\n", settings.getFreqMax());
    printf("prf1=%.17g\n", settings.getPRF1());
    printf("prf2=%.17g\n", settings.getPRF2());
    printf("max_distance=%.17g\n", settings.getMaxDistance());
    printf("map_size=%.17g\n", settings.getMapSize());

    return 0;
}
