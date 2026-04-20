#include "ADS7830.h"
#include "diag_log.h"
#include <string.h>

/**
  * @brief  Initialize the ADS7830 ADC
  * @param  hadc: pointer to an ADS7830_HandleTypeDef structure
  * @param  hi2c: pointer to an I2C_HandleTypeDef structure
  * @param  i2c_addr: I2C address of the ADC
  * @param  sdmode: Single-ended or differential mode
  * @param  pdmode: Power-down mode
  * @retval bool: true if successful, false otherwise
  */
bool ADS7830_Init(ADS7830_HandleTypeDef *hadc, I2C_HandleTypeDef *hi2c, uint8_t i2c_addr, 
                  ADS7830_SDMode_t sdmode, ADS7830_PDMode_t pdmode) {
    
    DIAG("PA", "ADS7830_Init: addr=0x%02X (shifted=0x%02X), sdmode=%u, pdmode=%u",
         i2c_addr, i2c_addr << 1, (unsigned)sdmode, (unsigned)pdmode);
    
    if (hadc == NULL || hi2c == NULL) {
        DIAG_ERR("PA", "ADS7830_Init: NULL handle(s)");
        return false;
    }
    
    hadc->hi2c = hi2c;
    hadc->i2c_addr = i2c_addr << 1; // HAL requires 7-bit address shifted left
    hadc->sdmode = sdmode;
    hadc->pdmode = pdmode;
    hadc->conversion_delay = ADS7830_CONVERSIONDELAY;
    hadc->last_conversion_result = 0;
    
    /* Test communication by reading from a channel */
    uint8_t test_read = ADS7830_Measure_SingleEnded(hadc, 0);
    bool ok = (test_read != 0xFF);
    DIAG("PA", "ADS7830_Init: test read ch0 = 0x%02X => %s", test_read, ok ? "OK" : "FAILED (0xFF)");
    return ok;
}

/**
  * @brief  Set Single-Ended/Differential mode
  * @param  hadc: pointer to an ADS7830_HandleTypeDef structure
  * @param  sdmode: Single-ended or differential mode
  * @retval bool: true if successful, false otherwise
  */
bool ADS7830_SetSDMode(ADS7830_HandleTypeDef *hadc, ADS7830_SDMode_t sdmode) {
    if (hadc == NULL) {
        return false;
    }
    
    hadc->sdmode = sdmode;
    return true;
}

/**
  * @brief  Set Power-Down mode
  * @param  hadc: pointer to an ADS7830_HandleTypeDef structure
  * @param  pdmode: Power-down mode
  * @retval bool: true if successful, false otherwise
  */
bool ADS7830_SetPDMode(ADS7830_HandleTypeDef *hadc, ADS7830_PDMode_t pdmode) {
    if (hadc == NULL) {
        return false;
    }
    
    hadc->pdmode = pdmode;
    return true;
}

/**
  * @brief  Measure single-ended voltage on specified channel
  * @param  hadc: pointer to an ADS7830_HandleTypeDef structure
  * @param  channel: ADC channel (0-7)
  * @retval uint8_t: 8-bit conversion result (0-255), 0xFF on error
  */
uint8_t ADS7830_Measure_SingleEnded(ADS7830_HandleTypeDef *hadc, uint8_t channel) {
    if (hadc == NULL || channel > 7) {
        return 0xFF;
    }
    
    uint8_t config = 0;
    
    // Set Single-Ended/Differential Inputs
    config |= hadc->sdmode;
    
    // Set Power-Down Selection
    config |= hadc->pdmode;

    // Set single-ended input channel
    switch (channel) {
        case (0):
            config |= ADS7830_REG_COMMAND_CH_SINGLE_0;
            break;
        case (1):
            config |= ADS7830_REG_COMMAND_CH_SINGLE_1;
            break;
        case (2):
            config |= ADS7830_REG_COMMAND_CH_SINGLE_2;
            break;
        case (3):
            config |= ADS7830_REG_COMMAND_CH_SINGLE_3;
            break;
        case (4):
            config |= ADS7830_REG_COMMAND_CH_SINGLE_4;
            break;
        case (5):
            config |= ADS7830_REG_COMMAND_CH_SINGLE_5;
            break;
        case (6):
            config |= ADS7830_REG_COMMAND_CH_SINGLE_6;
            break;
        case (7):
            config |= ADS7830_REG_COMMAND_CH_SINGLE_7;
            break;
        default:
            return 0xFF;
    }

    // Write config register to the ADC
    HAL_StatusTypeDef status = HAL_I2C_Master_Transmit(hadc->hi2c, hadc->i2c_addr, &config, 1, HAL_MAX_DELAY);
    if (status != HAL_OK) {
        DIAG_ERR("PA", "ADS7830 I2C transmit FAILED: addr=0x%02X ch=%u HAL=%d", hadc->i2c_addr, channel, (int)status);
        return 0xFF;
    }

    // Wait for the conversion to complete
    HAL_Delay(hadc->conversion_delay);

    // Read the conversion results
    uint8_t result = 0;
    status = HAL_I2C_Master_Receive(hadc->hi2c, hadc->i2c_addr, &result, 1, HAL_MAX_DELAY);
    if (status != HAL_OK) {
        DIAG_ERR("PA", "ADS7830 I2C receive FAILED: addr=0x%02X ch=%u HAL=%d", hadc->i2c_addr, channel, (int)status);
        return 0xFF;
    }
    
    hadc->last_conversion_result = result;
    return result;
}

/**
  * @brief  Measure differential voltage between specified channel pairs
  * @param  hadc: pointer to an ADS7830_HandleTypeDef structure
  * @param  channel: Channel pair (01, 10, 23, 32, 45, 54, 67, 76)
  * @retval int8_t: 8-bit signed conversion result (-128 to 127), 0x80 on error
  */
int8_t ADS7830_Measure_Differential(ADS7830_HandleTypeDef *hadc, uint8_t channel) {
    if (hadc == NULL) {
        return (int8_t)0x80;
    }
    
    uint8_t config = 0;
    
    // Set Single-Ended/Differential Inputs
    config |= hadc->sdmode;
    
    // Set Power-Down Selection
    config |= hadc->pdmode;
    
    // Set Differential input channel
    switch (channel) {
        case (01):
            config |= ADS7830_REG_COMMAND_CH_DIFF_0_1;  // CH0 = P, CH1 = N
            break;
        case (10):
            config |= ADS7830_REG_COMMAND_CH_DIFF_1_0;  // CH1 = P, CH0 = N
            break;
        case (23):
            config |= ADS7830_REG_COMMAND_CH_DIFF_2_3;  // CH2 = P, CH3 = N
            break;
        case (32):
            config |= ADS7830_REG_COMMAND_CH_DIFF_3_2;  // CH3 = P, CH2 = N
            break;
        case (45):
            config |= ADS7830_REG_COMMAND_CH_DIFF_4_5;  // CH4 = P, CH5 = N
            break;
        case (54):
            config |= ADS7830_REG_COMMAND_CH_DIFF_5_4;  // CH5 = P, CH4 = N
            break;
        case (67):
            config |= ADS7830_REG_COMMAND_CH_DIFF_6_7;  // CH6 = P, CH7 = N
            break;
        case (76):
            config |= ADS7830_REG_COMMAND_CH_DIFF_7_6;  // CH7 = P, CH6 = N
            break;
        default:
            return (int8_t)0x80;
    }

    // Write config register to the ADC
    HAL_StatusTypeDef status = HAL_I2C_Master_Transmit(hadc->hi2c, hadc->i2c_addr, &config, 1, HAL_MAX_DELAY);
    if (status != HAL_OK) {
        DIAG_ERR("PA", "ADS7830 diff I2C transmit FAILED: addr=0x%02X ch=%u HAL=%d", hadc->i2c_addr, channel, (int)status);
        return (int8_t)0x80;
    }

    // Wait for the conversion to complete
    HAL_Delay(hadc->conversion_delay);

    // Read the conversion results
    uint8_t raw_adc = 0;
    status = HAL_I2C_Master_Receive(hadc->hi2c, hadc->i2c_addr, &raw_adc, 1, HAL_MAX_DELAY);
    if (status != HAL_OK) {
        DIAG_ERR("PA", "ADS7830 diff I2C receive FAILED: addr=0x%02X ch=%u HAL=%d", hadc->i2c_addr, channel, (int)status);
        return (int8_t)0x80;
    }
    
    // Convert to signed 8-bit value
    int8_t result = (int8_t)raw_adc;
    hadc->last_conversion_result = raw_adc;
    return result;
}

/**
  * @brief  Get the last conversion result
  * @param  hadc: pointer to an ADS7830_HandleTypeDef structure
  * @retval uint8_t: Last conversion result
  */
uint8_t ADS7830_GetLastConversionResult(ADS7830_HandleTypeDef *hadc) {
    if (hadc == NULL) {
        return 0;
    }
    return hadc->last_conversion_result;
}