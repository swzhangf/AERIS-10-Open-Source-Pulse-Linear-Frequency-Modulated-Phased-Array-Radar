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

#ifndef BMP180_h
#define BMP180_h
  
#include "stm32f7xx_hal.h"
#include <cmath>

extern I2C_HandleTypeDef hi2c3;

/* resolutions */
typedef enum : uint8_t
{
  BMP180_ULTRALOWPOWER = 0x00, //low power             mode, oss0
  BMP180_STANDARD      = 0x01, //standard              mode, oss1
  BMP180_HIGHRES       = 0x02, //high resolution       mode, oss2
  BMP180_ULTRAHIGHRES  = 0x03  //ultra high resolution mode, oss3
}
BMP180_RESOLUTION;


/* calibration registers */
typedef enum : uint8_t
{
  BMP180_CAL_AC1_REG =                0xAA,  //ac1 pressure    computation
  BMP180_CAL_AC2_REG =                0xAC,  //ac2 pressure    computation
  BMP180_CAL_AC3_REG =                0xAE,  //ac3 pressure    computation
  BMP180_CAL_AC4_REG =                0xB0,  //ac4 pressure    computation
  BMP180_CAL_AC5_REG =                0xB2,  //ac5 temperature computation
  BMP180_CAL_AC6_REG =                0xB4,  //ac6 temperature computation
  BMP180_CAL_B1_REG  =                0xB6,  //b1  pressure    computation
  BMP180_CAL_B2_REG  =                0xB8,  //b2  pressure    computation
  BMP180_CAL_MB_REG  =                0xBA,  //mb
  BMP180_CAL_MC_REG  =                0xBC,  //mc  temperature computation
  BMP180_CAL_MD_REG  =                0xBE   //md  temperature computation
}
BMP180_CAL_REG;

#define BMP180_GET_ID_REG             0xD0   //device id register
#define BMP180_GET_VERSION_REG        0xD1   //device version register

#define BMP180_SOFT_RESET_REG         0xE0   //soft reset register
#define BMP180_SOFT_RESET_CTRL        0xB6   //soft reset control

#define BMP180_START_MEASURMENT_REG   0xF4   //start measurment  register
#define BMP180_READ_ADC_MSB_REG       0xF6   //read adc msb  register
#define BMP180_READ_ADC_LSB_REG       0xF7   //read adc lsb  register
#define BMP180_READ_ADC_XLSB_REG      0xF8   //read adc xlsb register

/* BMP180_START_MEASURMENT_REG controls */
#define BMP180_GET_TEMPERATURE_CTRL   0x2E   //get temperature control
#define BMP180_GET_PRESSURE_OSS0_CTRL 0x34   //get pressure oversampling 1 time/oss0 control
#define BMP180_GET_PRESSURE_OSS1_CTRL 0x74   //get pressure oversampling 2 time/oss1 control
#define BMP180_GET_PRESSURE_OSS2_CTRL 0xB4   //get pressure oversampling 4 time/oss2 control
#define BMP180_GET_PRESSURE_OSS3_CTRL 0xF4   //get pressure oversampling 8 time/oss3 control

/* misc */
#define BMP180_CHIP_ID                0x55   //id number

#define BMP180_ERROR                  255    //returns 255, if communication error is occurred

#define BMP180_ADDRESS (0x77 << 1) // HAL requires 7-bit address shifted left by 1 bit

#define I2C_TIMEOUT 100

/* to store calibration coefficients */
typedef struct
{
  int16_t  bmpAC1 = 0;
  int16_t  bmpAC2 = 0;
  int16_t  bmpAC3 = 0;
  uint16_t bmpAC4 = 0;
  uint16_t bmpAC5 = 0;
  uint16_t bmpAC6 = 0;

  int16_t  bmpB1  = 0;
  int16_t  bmpB2  = 0;

  int16_t  bmpMB  = 0;
  int16_t  bmpMC  = 0;
  int16_t  bmpMD  = 0;
}
BMP180_CAL_COEFF;


class BMP180
{
 public:
  BMP180(BMP180_RESOLUTION = BMP180_ULTRAHIGHRES);          //BMP180_ULTRAHIGHRES, by default
  int32_t getPressure(void);                               //in Pa
  float   getTemperature(void);                            //in °C
  int32_t getSeaLevelPressure(int16_t trueAltitude = 115); //in Pa, by default true altitude id 115 meters
  void    softReset(void);
  uint8_t readFirmwareVersion(void);
  uint8_t readDeviceID(void);


 private:
  BMP180_CAL_COEFF _calCoeff;

  uint8_t  _resolution;

  bool     readCalibrationCoefficients(void);
  uint16_t readRawTemperature(void);
  uint32_t readRawPressure(void);
  int32_t  computeB5(int32_t UT);
  uint8_t  read8(uint8_t reg);
  uint16_t read16(uint8_t reg);
  bool     write8(uint8_t reg, uint8_t control);
};

#endif
