#include "RadarSettings.h"
#include <cstring>

RadarSettings::RadarSettings() {
    resetToDefaults();
}

void RadarSettings::resetToDefaults() {
    system_frequency = 10.0e9;    // 10 GHz
    chirp_duration_1 = 30.0e-6;   // 30 �s
    chirp_duration_2 = 0.5e-6;    // 0.5 �s
    chirps_per_position = 32;
    freq_min = 10.0e6;           // 10 MHz
    freq_max = 30.0e6;           // 30 MHz
    prf1 = 1000.0;               // 1 kHz
    prf2 = 2000.0;               // 2 kHz
    max_distance = 50000.0;      // 50 km
    map_size = 50000.0;          // 50 km
    
    settings_valid = true;
}

bool RadarSettings::parseFromUSB(const uint8_t* data, uint32_t length) {
    // Minimum packet size: "SET" + 9 doubles + 1 uint32_t + "END" = 3 + 9*8 + 4 + 3 = 82 bytes
    if (data == nullptr || length < 82) {
        settings_valid = false;
        return false;
    }
    
    // Check for start marker "SET"
    if (memcmp(data, "SET", 3) != 0) {
        settings_valid = false;
        return false;
    }
    
    // Check for end marker "END"
    if (memcmp(data + length - 3, "END", 3) != 0) {
        settings_valid = false;
        return false;
    }
    
    uint32_t offset = 3;  // Skip "SET"
    
    // Extract all parameters in order
    system_frequency = extractDouble(data + offset);
    offset += 8;
    
    chirp_duration_1 = extractDouble(data + offset);
    offset += 8;
    
    chirp_duration_2 = extractDouble(data + offset);
    offset += 8;
    
    chirps_per_position = extractUint32(data + offset);
    offset += 4;
    
    freq_min = extractDouble(data + offset);
    offset += 8;
    
    freq_max = extractDouble(data + offset);
    offset += 8;
    
    prf1 = extractDouble(data + offset);
    offset += 8;
    
    prf2 = extractDouble(data + offset);
    offset += 8;
    
    max_distance = extractDouble(data + offset);
    offset += 8;
    
    map_size = extractDouble(data + offset);
    
    // Validate the received settings
    settings_valid = validateSettings();
    
    return settings_valid;
}

bool RadarSettings::validateSettings() {
    // Check for reasonable value ranges
    if (system_frequency < 1e9 || system_frequency > 100e9) return false;
    if (chirp_duration_1 < 1e-6 || chirp_duration_1 > 1000e-6) return false;
    if (chirp_duration_2 < 0.1e-6 || chirp_duration_2 > 10e-6) return false;
    if (chirps_per_position < 1 || chirps_per_position > 256) return false;
    if (freq_min < 1e6 || freq_min > 100e6) return false;
    if (freq_max <= freq_min || freq_max > 100e6) return false;
    if (prf1 < 100 || prf1 > 10000) return false;
    if (prf2 < 100 || prf2 > 10000) return false;
    if (max_distance < 100 || max_distance > 100000) return false;
    if (map_size < 1000 || map_size > 200000) return false;
    
    return true;
}

double RadarSettings::extractDouble(const uint8_t* data) {
    uint64_t bits = 0;
    for (int i = 0; i < 8; i++) {
        bits = (bits << 8) | data[i];
    }
    
    double value;
    memcpy(&value, &bits, sizeof(double));
    return value;
}

uint32_t RadarSettings::extractUint32(const uint8_t* data) {
    uint32_t value = 0;
    for (int i = 0; i < 4; i++) {
        value = (value << 8) | data[i];
    }
    return value;
}