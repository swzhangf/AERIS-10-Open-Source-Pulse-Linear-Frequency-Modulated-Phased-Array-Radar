#include "GY_85_HAL.h"

static int16_t g_offx = 0, g_offy = 0, g_offz = 0;

// ---------------- Internal Functions ---------------- //
static bool GY85_SetAccelerometer(void);
static bool GY85_ReadAccelerometer(GY85_t *imu);
static bool GY85_SetCompass(void);
static bool GY85_ReadCompass(GY85_t *imu);
static bool GY85_SetGyro(void);
static bool GY85_GyroCalibrate(void);
static bool GY85_ReadGyro(GY85_t *imu);
static bool GY85_WriteRegister(uint16_t address, uint8_t reg, uint8_t value);
static bool GY85_ReadRegisters(uint16_t address, uint8_t reg, uint8_t *buffer, uint16_t length);

// ---------------- Initialization ---------------- //
bool GY85_Init(void)
{
    if (!GY85_SetAccelerometer()) {
        return false;
    }
    if (!GY85_SetCompass()) {
        return false;
    }
    return GY85_SetGyro();
}

// ---------------- Update All Sensors ---------------- //
bool GY85_Update(GY85_t *imu)
{
    GY85_t next_sample;

    if (imu == NULL) {
        return false;
    }

    next_sample = *imu;

    if (!GY85_ReadAccelerometer(&next_sample)) {
        return false;
    }
    if (!GY85_ReadCompass(&next_sample)) {
        return false;
    }
    if (!GY85_ReadGyro(&next_sample)) {
        return false;
    }

    *imu = next_sample;
    return true;
}

// ---------------- Accelerometer ---------------- //
static bool GY85_SetAccelerometer(void)
{
    if (!GY85_WriteRegister(ADXL345_ADDR, 0x31, 0x01)) {
        return false;
    }

    return GY85_WriteRegister(ADXL345_ADDR, 0x2D, 0x08);
}

static bool GY85_ReadAccelerometer(GY85_t *imu)
{
    uint8_t buf[6];

    if (imu == NULL || !GY85_ReadRegisters(ADXL345_ADDR, 0x32, buf, sizeof(buf))) {
        return false;
    }

    imu->ax = (int16_t)((buf[1] << 8) | buf[0]);
    imu->ay = (int16_t)((buf[3] << 8) | buf[2]);
    imu->az = (int16_t)((buf[5] << 8) | buf[4]);
    return true;
}

// ---------------- Compass ---------------- //
static bool GY85_SetCompass(void)
{
    return GY85_WriteRegister(HMC5883_ADDR, 0x02, 0x00);
}

static bool GY85_ReadCompass(GY85_t *imu)
{
    uint8_t buf[6];

    if (imu == NULL || !GY85_ReadRegisters(HMC5883_ADDR, 0x03, buf, sizeof(buf))) {
        return false;
    }

    imu->mx = (int16_t)((buf[0] << 8) | buf[1]);
    imu->mz = (int16_t)((buf[2] << 8) | buf[3]);
    imu->my = (int16_t)((buf[4] << 8) | buf[5]);
    return true;
}

// ---------------- Gyroscope ---------------- //
static bool GY85_SetGyro(void)
{
    if (!GY85_WriteRegister(ITG3200_ADDR, 0x3E, 0x00)) {
        return false;
    }

    if (!GY85_WriteRegister(ITG3200_ADDR, 0x15, 0x07)) {
        return false;
    }

    if (!GY85_WriteRegister(ITG3200_ADDR, 0x16, 0x1E)) {
        return false;
    }

    if (!GY85_WriteRegister(ITG3200_ADDR, 0x17, 0x00)) {
        return false;
    }

    HAL_Delay(10);
    return GY85_GyroCalibrate();
}

static bool GY85_GyroCalibrate(void)
{
    int32_t tmpx = 0, tmpy = 0, tmpz = 0;
    GY85_t imu;

    for(uint8_t i = 0; i < 10; i++)
    {
        HAL_Delay(10);
        if (!GY85_ReadGyro(&imu)) {
            return false;
        }
        tmpx += imu.gx;
        tmpy += imu.gy;
        tmpz += imu.gz;
    }

    g_offx = tmpx / 10;
    g_offy = tmpy / 10;
    g_offz = tmpz / 10;
    return true;
}

static bool GY85_ReadGyro(GY85_t *imu)
{
    uint8_t buf[8];

    if (imu == NULL || !GY85_ReadRegisters(ITG3200_ADDR, 0x1B, buf, sizeof(buf))) {
        return false;
    }

    imu->gx = ((int16_t)((buf[2] << 8) | buf[3])) - g_offx;
    imu->gy = ((int16_t)((buf[4] << 8) | buf[5])) - g_offy;
    imu->gz = ((int16_t)((buf[6] << 8) | buf[7])) - g_offz;
    return true;
}

static bool GY85_WriteRegister(uint16_t address, uint8_t reg, uint8_t value)
{
    uint8_t data[2] = {reg, value};
    return HAL_I2C_Master_Transmit(&hi2c3, address, data, sizeof(data), HAL_MAX_DELAY) == HAL_OK;
}

static bool GY85_ReadRegisters(uint16_t address, uint8_t reg, uint8_t *buffer, uint16_t length)
{
    if (buffer == NULL) {
        return false;
    }

    if (HAL_I2C_Master_Transmit(&hi2c3, address, &reg, 1, HAL_MAX_DELAY) != HAL_OK) {
        return false;
    }

    return HAL_I2C_Master_Receive(&hi2c3, address, buffer, length, HAL_MAX_DELAY) == HAL_OK;
}
