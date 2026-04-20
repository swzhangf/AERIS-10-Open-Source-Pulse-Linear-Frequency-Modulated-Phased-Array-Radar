// gps_handler.h
#ifndef GPS_HANDLER_H
#define GPS_HANDLER_H

#include "main.h"
#include "usb_device.h"
#include "usbd_cdc_if.h"
#include <stdbool.h>
#include <stdint.h>
#include <string.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    double latitude;
    double longitude;
    float altitude;
    float pitch;
    uint32_t timestamp;
} GPS_Data_t;

void GPS_Init(UART_HandleTypeDef* huart);
bool GPS_ProcessData(GPS_Data_t* gps_data);
bool GPS_SendToGUI(GPS_Data_t* gps_data);
bool GPS_SendBinaryToGUI(GPS_Data_t* gps_data);
uint8_t GPS_IsDataValid(GPS_Data_t* gps_data);

#ifdef __cplusplus
}
#endif

#endif /* GPS_HANDLER_H */
