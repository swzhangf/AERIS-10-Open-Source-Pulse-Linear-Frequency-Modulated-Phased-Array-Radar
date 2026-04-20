/***************************************************************************************************/
/*
   This is an Arduino basic library for Bosch BMP180 & BMP085 barometric pressure &
   temperature sensor

   Power supply voltage:   1.8v - 3.6v
   Range:                  30,000Pa..110,000Pa at -40°C..+85°C 
   Typ. resolution:        1Pa     / 0.1°C
   Typ. accuracy:          ±100Pa* / ±1.0°C* at 0°C..+65°C
   Typ. relative accuracy: ±12Pa   / xx°C
   Duty cycle:             10% active & 90% inactive, to prevent self heating

                          *sensor is sensitive to direct light, which can affect
                           the accuracy of the measurement

   written by : enjoyneering79
   sourse code: https://github.com/enjoyneering/


   This chip uses I2C bus to communicate, specials pins are required to interface
   Board:                                    SDA                    SCL                    Level
   Uno, Mini, Pro, ATmega168, ATmega328..... A4                     A5                     5v
   Mega2560................................. 20                     21                     5v
   Due, SAM3X8E............................. 20                     21                     3.3v
   Leonardo, Micro, ATmega32U4.............. 2                      3                      5v
   Digistump, Trinket, ATtiny85............. 0/physical pin no.5    2/physical pin no.7    5v
   Blue Pill, STM32F103xxxx boards.......... PB7                    PB6                    3.3v/5v
   ESP8266 ESP-01........................... GPIO0/D5               GPIO2/D3               3.3v/5v
   NodeMCU 1.0, WeMos D1 Mini............... GPIO4/D2               GPIO5/D1               3.3v/5v
   ESP32.................................... GPIO21/D21             GPIO22/D22             3.3v

   NOTE:
   - EOC  pin is not used, shows the end of conversion
   - XCLR pin is not used, reset pin

   Frameworks & Libraries:
   ATtiny  Core          - https://github.com/SpenceKonde/ATTinyCore
   ESP32   Core          - https://github.com/espressif/arduino-esp32
   ESP8266 Core          - https://github.com/esp8266/Arduino
   STM32   Core          - https://github.com/rogerclarkmelbourne/Arduino_STM32

   GNU GPL license, all text above must be included in any redistribution,
   see link for details  - https://www.gnu.org/licenses/licenses.html
*/
/***************************************************************************************************/

#include "BMP180.h"


/**************************************************************************/
/*
    Constructor

    NOTE:
    - BMP180_ULTRALOWPOWER, pressure oversampled 1 time  & consumption 3μA
    - BMP180_STANDARD,      pressure oversampled 2 times & consumption 5μA
    - BMP180_HIGHRES,       pressure oversampled 4 times & consumption 7μA
    - BMP180_ULTRAHIGHRES,  pressure oversampled 8 times & consumption 12μA
*/
/**************************************************************************/
BMP180::BMP180(BMP180_RESOLUTION res_mode)
{
  _resolution = res_mode;
}


/**************************************************************************/
/*
    getPressure()

    Calculates compensated pressure, in Pa

    NOTE:
    - resolutin 1Pa with accuracy ±150Pa at range 30,000Pa..110,000Pa
*/
/**************************************************************************/
int32_t BMP180::getPressure(void)
{
  int32_t  UT       = 0;
  int32_t  UP       = 0;
  int32_t  B3       = 0;
  int32_t  B5       = 0;
  int32_t  B6       = 0;
  int32_t  X1       = 0;
  int32_t  X2       = 0;
  int32_t  X3       = 0;
  int32_t  pressure = 0;
  uint32_t B4       = 0;
  uint32_t B7       = 0;

  UT = readRawTemperature();                                            //read uncompensated temperature, 16-bit
  if (UT == BMP180_ERROR) return BMP180_ERROR;                          //error handler, collision on i2c bus

  UP = readRawPressure();                                               //read uncompensated pressure, 19-bit
  if (UP == BMP180_ERROR) return BMP180_ERROR;                          //error handler, collision on i2c bus

  B5 = computeB5(UT);

  /* pressure calculation */
  B6 = B5 - 4000;
  X1 = ((int32_t)_calCoeff.bmpB2 * ((B6 * B6) >> 12)) >> 11;
  X2 = ((int32_t)_calCoeff.bmpAC2 * B6) >> 11;
  X3 = X1 + X2;
  B3 = ((((int32_t)_calCoeff.bmpAC1 * 4 + X3) << _resolution) + 2) / 4;

  X1 = ((int32_t)_calCoeff.bmpAC3 * B6) >> 13;
  X2 = ((int32_t)_calCoeff.bmpB1 * ((B6 * B6) >> 12)) >> 16;
  X3 = ((X1 + X2) + 2) >> 2;
  B4 = ((uint32_t)_calCoeff.bmpAC4 * (X3 + 32768L)) >> 15;
  B7 = (UP - B3) * (50000UL >> _resolution);
  
  if (B4 == 0) return BMP180_ERROR;                                     //safety check, avoiding division by zero

  if   (B7 < 0x80000000) pressure = (B7 * 2) / B4;
  else                   pressure = (B7 / B4) * 2;

  X1 = pow((pressure >> 8), 2);
  X1 = (X1 * 3038L) >> 16;
  X2 = (-7357L * pressure) >> 16;

  return pressure = pressure + ((X1 + X2 + 3791L) >> 4);
}

/**************************************************************************/
/*
    getTemperature()

    Calculates compensated temperature, in °C

    NOTE:
    - resolution 0.1°C with accuracy ±1.0°C at range 0°C..+65°C
*/
/**************************************************************************/
float BMP180::getTemperature(void)
{
  int16_t rawTemperature = readRawTemperature();

  if (rawTemperature == BMP180_ERROR) return BMP180_ERROR;                                       //error handler, collision on i2c bus
                                      return (float)((computeB5(rawTemperature) + 8) >> 4) / 10;
}

/**************************************************************************/
/*
    getSeaLevelPressure()

    Converts current pressure to sea level pressure at specific true
    altitude, in Pa

    NOTE:
    - true altitude is the actual elevation above sea level, to find out
      your current true altitude do search with google earth or gps
    - see level pressure is commonly used in weather reports & forecasts
      to compensate current true altitude
    - for example, we know that a sunny day happens if the current sea
      level pressure is 250Pa above the average sea level pressure of
      101325 Pa, so by converting the current pressure to sea level &
      comparing it with an average sea level pressure we can instantly
      predict the weather conditions
*/
/**************************************************************************/
int32_t BMP180::getSeaLevelPressure(int16_t trueAltitude)
{
  int32_t pressure = getPressure();

  if (pressure == BMP180_ERROR) return BMP180_ERROR;
                                return (pressure / pow(1.0 - (float)trueAltitude / 44330, 5.255));
}

/**************************************************************************/
/*
    softReset()

    Soft reset

    NOTE:
    - performs the same sequence as power on reset
*/
/**************************************************************************/
void BMP180::softReset(void)
{
  write8(BMP180_SOFT_RESET_REG, BMP180_SOFT_RESET_CTRL);
}

/**************************************************************************/
/*
    readFirmwareVersion()

    Reads ML & AL Version

    NOTE:
    - ML version is LSB, 4-bit..0-bit
    - AL version is MSB, 7-bit..5-bit
*/
/**************************************************************************/
uint8_t BMP180::readFirmwareVersion(void)
{
  return read8(BMP180_GET_VERSION_REG);
}

/**************************************************************************/
/*
    readDeviceID()

    Reads chip ID
*/
/**************************************************************************/
uint8_t BMP180::readDeviceID(void)
{
  if (read8(BMP180_GET_ID_REG) == BMP180_CHIP_ID) return 180;
                                                  return false;
}

/**************************************************************************/
/*
    readCalibrationCoefficients()

    Reads factory calibration coefficients from E2PROM

    NOTE:
    - every sensor module has individual calibration coefficients
    - before first temperature & pressure calculation master have to read
      calibration coefficients from 176-bit E2PROM
*/
/**************************************************************************/
bool BMP180::readCalibrationCoefficients()
{
  int32_t value = 0;

  for (uint8_t reg = BMP180_CAL_AC1_REG; reg <= BMP180_CAL_MD_REG; reg++)
  {
    value = read16(reg);

    if (value == BMP180_ERROR) return false; //error handler, collision on i2c bus

    switch (reg)
    {
      case BMP180_CAL_AC1_REG:               //used for pressure computation
        _calCoeff.bmpAC1 = value;
        break;

      case BMP180_CAL_AC2_REG:               //used for pressure computation
        _calCoeff.bmpAC2 = value;
        break;

      case BMP180_CAL_AC3_REG:               //used for pressure computation
        _calCoeff.bmpAC3 = value;
        break;

      case BMP180_CAL_AC4_REG:               //used for pressure computation
        _calCoeff.bmpAC4 = value;
        break;

      case BMP180_CAL_AC5_REG:               //used for temperature computation
        _calCoeff.bmpAC5 = value;
        break;

      case BMP180_CAL_AC6_REG:               //used for temperature computation
        _calCoeff.bmpAC6 = value;
        break;

      case BMP180_CAL_B1_REG:                //used for pressure computation
        _calCoeff.bmpB1 = value;
        break;

      case BMP180_CAL_B2_REG:                //used for pressure computation
        _calCoeff.bmpB2 = value;
        break;

      case BMP180_CAL_MB_REG:                //???
        _calCoeff.bmpMB = value;
        break;

      case BMP180_CAL_MC_REG:                //used for temperature computation
        _calCoeff.bmpMC = value;
        break;

      case BMP180_CAL_MD_REG:                //used for temperature computation
        _calCoeff.bmpMD = value;
        break;
    }
  }

  return true;
}

/**************************************************************************/
/*
    readRawTemperature()

    Reads raw/uncompensated temperature value, 16-bit
*/
/**************************************************************************/
uint16_t BMP180::readRawTemperature(void)
{
  /* send temperature measurement command */
  if (write8(BMP180_START_MEASURMENT_REG, BMP180_GET_TEMPERATURE_CTRL) != true) return BMP180_ERROR; //error handler, collision on i2c bus

  /* set measurement delay */
   HAL_Delay(5);

  /* read result */
  return read16(BMP180_READ_ADC_MSB_REG);                                                            //reads msb + lsb
}

/**************************************************************************/
/*
    readRawPressure()

    Reads raw/uncompensated pressure value, 19-bits
*/
/**************************************************************************/
uint32_t BMP180::readRawPressure(void)
{
  uint8_t  regControl  = 0;
  uint32_t rawPressure = 0;

  /* convert resolution to register control */
  switch (_resolution)
  {
    case BMP180_ULTRALOWPOWER:                    //oss0
      regControl = BMP180_GET_PRESSURE_OSS0_CTRL;
      break;

    case BMP180_STANDARD:                         //oss1
      regControl = BMP180_GET_PRESSURE_OSS1_CTRL;
      break;

    case BMP180_HIGHRES:                          //oss2
      regControl = BMP180_GET_PRESSURE_OSS2_CTRL;
      break;

    case BMP180_ULTRAHIGHRES:                     //oss3
      regControl = BMP180_GET_PRESSURE_OSS3_CTRL;
      break;
  }

  /* send pressure measurement command */
  if (write8(BMP180_START_MEASURMENT_REG, regControl) != true) return BMP180_ERROR; //error handler, collision on i2c bus

  /* set measurement delay */
  switch (_resolution)
  {
    case BMP180_ULTRALOWPOWER:
       HAL_Delay(5);
      break;

    case BMP180_STANDARD:
       HAL_Delay(8);
      break;

    case BMP180_HIGHRES:
       HAL_Delay(14);
      break;

    case BMP180_ULTRAHIGHRES:
       HAL_Delay(26);
      break;
  }

  /* read result msb + lsb */
  rawPressure = read16(BMP180_READ_ADC_MSB_REG);        //16-bits
  if (rawPressure == BMP180_ERROR) return BMP180_ERROR; //error handler, collision on i2c bus

  /* read result xlsb */
  rawPressure <<= 8;
  rawPressure |= read8(BMP180_READ_ADC_XLSB_REG);       //19-bits

  rawPressure >>= (8 - _resolution);

  return rawPressure;
}

/**************************************************************************/
/*
    computeB5()

    Computes B5 value

    NOTE:
    - to compensate raw/uncompensated temperature
    - also used for compensated pressure calculation
*/
/**************************************************************************/
int32_t BMP180::computeB5(int32_t UT)
{
  int32_t X1 = ((UT - (int32_t)_calCoeff.bmpAC6) * (int32_t)_calCoeff.bmpAC5) >> 15;
  int32_t X2 = ((int32_t)_calCoeff.bmpMC << 11) / (X1 + (int32_t)_calCoeff.bmpMD);

  return X1 + X2;
}

/**************************************************************************/
/*
    read8()

    Reads 8-bit value over I2C
*/
/**************************************************************************/
uint8_t BMP180::read8(uint8_t reg)
{
  uint8_t data = 0;
  HAL_StatusTypeDef status;
  
  // Write register address
  status = HAL_I2C_Master_Transmit(&hi2c3, BMP180_ADDRESS, &reg, 1, I2C_TIMEOUT);
  if (status != HAL_OK) return BMP180_ERROR;
  
  // Read data from register
  status = HAL_I2C_Master_Receive(&hi2c3, BMP180_ADDRESS, &data, 1, I2C_TIMEOUT);
  if (status != HAL_OK) return BMP180_ERROR;
  
  return data;
}

/**************************************************************************/
/*
    read16()

    Reads 16-bits value over I2C
*/
/**************************************************************************/

uint16_t BMP180::read16(uint8_t reg)
{
  uint8_t data[2] = {0, 0};
  uint16_t value = 0;
  HAL_StatusTypeDef status;
  
  // Write register address
  status = HAL_I2C_Master_Transmit(&hi2c3, BMP180_ADDRESS, &reg, 1, I2C_TIMEOUT);
  if (status != HAL_OK) return BMP180_ERROR;
  
  // Read 2 bytes from register
  status = HAL_I2C_Master_Receive(&hi2c3, BMP180_ADDRESS, data, 2, I2C_TIMEOUT);
  if (status != HAL_OK) return BMP180_ERROR;
  
  // Combine bytes (MSB first)
  value = (data[0] << 8) | data[1];
  
  return value;
}


/**************************************************************************/
/*
    write8()

    Writes 8-bits value over I2C
*/
/**************************************************************************/

bool BMP180::write8(uint8_t reg, uint8_t control)
{
  uint8_t data[2] = {reg, control};
  HAL_StatusTypeDef status;
  
  // Write register address and data
  status = HAL_I2C_Master_Transmit(&hi2c3, BMP180_ADDRESS, data, 2, I2C_TIMEOUT);
  
  return (status == HAL_OK);
}

