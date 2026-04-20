// gps_handler.cpp
#include "gps_handler.h"
#include <cmath>
#include <cstdio>

// UART handle for communication with GUI
static UART_HandleTypeDef* gui_huart = NULL;

// GPS data buffer
static GPS_Data_t current_gps = {0};

void GPS_Init(UART_HandleTypeDef* huart)
{
    gui_huart = huart;
    memset(&current_gps, 0, sizeof(GPS_Data_t));
}

uint8_t GPS_IsDataValid(GPS_Data_t* gps_data)
{
    if (gps_data == NULL) {
        return 0;
    }

    // Check if GPS data is within valid ranges
    if (gps_data->latitude < -90.0 || gps_data->latitude > 90.0)
        return 0;
    if (gps_data->longitude < -180.0 || gps_data->longitude > 180.0)
        return 0;
    if (gps_data->altitude < -1000.0 || gps_data->altitude > 10000.0) // -1km to 10km
        return 0;
    
    return 1;
}

bool GPS_ProcessData(GPS_Data_t* gps_data)
{
    // Validate GPS data
    if (!GPS_IsDataValid(gps_data)) {
        return false;
    }
    
    // Update current GPS data
    memcpy(&current_gps, gps_data, sizeof(GPS_Data_t));
    current_gps.timestamp = HAL_GetTick();
    
    // Send to GUI
    return GPS_SendToGUI(&current_gps);
}

bool GPS_SendToGUI(GPS_Data_t* gps_data)
{
    if (gui_huart == NULL || gps_data == NULL) {
        return false;
    }
    
    // Create packet: "GPS:lat,lon,alt\r\n"
    char buffer[64];
    
    // Convert double and float to string with high precision
    int len = snprintf(buffer, sizeof(buffer), "GPS:%.8f,%.8f,%.2f\r\n",
                      gps_data->latitude,
                      gps_data->longitude,
                      gps_data->altitude);
    
    if (len <= 0 || len >= (int)sizeof(buffer)) {
        return false;
    }

    // Send via UART3 to GUI
    return HAL_UART_Transmit(gui_huart, (uint8_t*)buffer, len, 1000) == HAL_OK;
}

// Alternative binary protocol version (more efficient)
bool GPS_SendBinaryToGUI(GPS_Data_t* gps_data)
{
    if (gui_huart == NULL || gps_data == NULL) {
        return false;
    }
    
    // Binary packet structure:
    // [Header 4 bytes][Latitude 8 bytes][Longitude 8 bytes][Altitude 4 bytes][Pitch 4 bytes][CRC 2 bytes]
    
    uint8_t packet[30]; // 4 + 8 + 8 + 4 + 4 + 2 = 30 bytes
    uint16_t crc = 0;
    
    // Header: "GPSB"
    packet[0] = 'G';
    packet[1] = 'P';
    packet[2] = 'S';
    packet[3] = 'B';
    
    // Convert double latitude to bytes (big-endian)
    uint64_t lat_bits;
    memcpy(&lat_bits, &gps_data->latitude, sizeof(double));
    for(int i = 0; i < 8; i++) {
        packet[4 + i] = (lat_bits >> (56 - i*8)) & 0xFF;
    }
    
    // Convert double longitude to bytes (big-endian)
    uint64_t lon_bits;
    memcpy(&lon_bits, &gps_data->longitude, sizeof(double));
    for(int i = 0; i < 8; i++) {
        packet[12 + i] = (lon_bits >> (56 - i*8)) & 0xFF;
    }
    
    // Convert float altitude to bytes (big-endian)
    uint32_t alt_bits;
    memcpy(&alt_bits, &gps_data->altitude, sizeof(float));
    for(int i = 0; i < 4; i++) {
        packet[20 + i] = (alt_bits >> (24 - i*8)) & 0xFF;
    }
    
    // Convert float pitch to bytes (big-endian)
    uint32_t pitch_bits;
    memcpy(&pitch_bits, &gps_data->pitch, sizeof(float));
    for(int i = 0; i < 4; i++) {
        packet[24 + i] = (pitch_bits >> (24 - i*8)) & 0xFF;
    }

    // Calculate simple checksum (you can use CRC16 instead)
    for(int i = 0; i < 28; i++) {
        crc += packet[i];
    }
    
    packet[28] = (crc >> 8) & 0xFF;
    packet[29] = crc & 0xFF;
    
    // Send binary packet
    return CDC_Transmit_FS(packet, sizeof(packet)) == USBD_OK;
}
