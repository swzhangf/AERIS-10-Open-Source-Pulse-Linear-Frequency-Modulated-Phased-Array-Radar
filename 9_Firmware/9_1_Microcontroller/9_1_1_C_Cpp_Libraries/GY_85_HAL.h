#ifndef __GY_85_HAL_H__
#define __GY_85_HAL_H__

#include "stm32f7xx_hal.h"   // change depending on MCU family
#include <stdbool.h>
#include <stdint.h>

#define ADXL345_ADDR     (0x53 << 1)
#define HMC5883_ADDR     (0x1E << 1)
#define ITG3200_ADDR     (0x68 << 1)

extern I2C_HandleTypeDef hi2c3;

// Struct to hold all sensor data
typedef struct {
    int16_t ax, ay, az;   // accelerometer
    float   gx, gy, gz;   // gyroscope
    int16_t mx, my, mz;   // magnetometer
} GY85_t;

// Public API
bool GY85_Init(void);
bool GY85_Update(GY85_t *imu);   // reads all sensors and stores in struct

#endif

