/*******************************************************************************
 * ad_driver_mock.h -- Mock declarations for ADF4382 and AD9523 driver APIs
 *
 * These replace the real driver implementations. The spy layer in
 * ad_driver_mock.c records all calls for test assertion.
 ******************************************************************************/
#ifndef AD_DRIVER_MOCK_H
#define AD_DRIVER_MOCK_H

#include "stm32_hal_mock.h"

#ifdef __cplusplus
extern "C" {
#endif

/* ========================= no_os SPI types ======================== */

enum no_os_spi_mode {
    NO_OS_SPI_MODE_0 = 0,
    NO_OS_SPI_MODE_1 = 1,
    NO_OS_SPI_MODE_2 = 2,
    NO_OS_SPI_MODE_3 = 3
};

enum no_os_spi_bit_order {
    NO_OS_SPI_BIT_ORDER_MSB_FIRST = 0,
    NO_OS_SPI_BIT_ORDER_LSB_FIRST = 1
};

enum no_os_spi_lanes {
    NO_OS_SPI_SINGLE = 0,
};

struct no_os_platform_spi_delays {
    uint32_t cs_delay_first;
    uint32_t cs_delay_last;
};

struct no_os_spi_desc {
    uint32_t dummy;
};

struct no_os_spi_platform_ops {
    int (*init)(void);
};

struct no_os_spi_init_param {
    uint32_t                            device_id;
    uint32_t                            max_speed_hz;
    uint16_t                            chip_select;
    enum no_os_spi_mode                 mode;
    enum no_os_spi_bit_order            bit_order;
    enum no_os_spi_lanes                lanes;
    const struct no_os_spi_platform_ops *platform_ops;
    struct no_os_platform_spi_delays    platform_delays;
    void                                *extra;
    struct no_os_spi_desc               *parent;
};

/* ========================= ADF4382 types ========================== */

enum adf4382_dev_id {
    ID_ADF4382 = 0,
    ID_ADF4382A = 1,
    ID_ADF4383 = 2,
};

struct adf4382_dev {
    struct no_os_spi_desc *spi_desc;
    bool                   spi_3wire_en;
    bool                   cmos_3v3;
    uint64_t               ref_freq_hz;
    uint64_t               freq;
    bool                   ref_doubler_en;
    uint8_t                ref_div;
    uint8_t                cp_i;
    uint16_t               bleed_word;
    uint8_t                ld_count;
    uint32_t               phase_adj;
    uint16_t               n_int;
};

struct adf4382_init_param {
    struct no_os_spi_init_param *spi_init;
    bool                         spi_3wire_en;
    bool                         cmos_3v3;
    uint64_t                     ref_freq_hz;
    uint64_t                     freq;
    bool                         ref_doubler_en;
    uint8_t                      ref_div;
    uint8_t                      cp_i;
    uint16_t                     bleed_word;
    uint8_t                      ld_count;
    uint8_t                      en_lut_gen;
    uint8_t                      en_lut_cal;
    uint8_t                      max_lpf_cap_value_uf;
    enum adf4382_dev_id          id;
};

/* Lock detect mask -- from real header */
#define ADF4382_LOCKED_MSK  (1U << 0)

/* ========================= AD9523 types =========================== */

#define AD9523_NUM_CHAN 14

struct ad9523_channel_spec {
    uint8_t  channel_num;
    uint8_t  divider_output_invert_en;
    uint8_t  sync_ignore_en;
    uint8_t  low_power_mode_en;
    uint8_t  use_alt_clock_src;
    uint8_t  output_dis;
    uint8_t  driver_mode;
    uint8_t  divider_phase;
    uint16_t channel_divider;
    int8_t   extended_name[16];
};

struct ad9523_platform_data {
    uint32_t vcxo_freq;
    uint8_t  spi3wire;
    uint8_t  refa_diff_rcv_en;
    uint8_t  refb_diff_rcv_en;
    uint8_t  zd_in_diff_en;
    uint8_t  osc_in_diff_en;
    uint8_t  refa_cmos_neg_inp_en;
    uint8_t  refb_cmos_neg_inp_en;
    uint8_t  zd_in_cmos_neg_inp_en;
    uint8_t  osc_in_cmos_neg_inp_en;
    uint16_t refa_r_div;
    uint16_t refb_r_div;
    uint16_t pll1_feedback_div;
    uint16_t pll1_charge_pump_current_nA;
    uint8_t  zero_delay_mode_internal_en;
    uint8_t  osc_in_feedback_en;
    uint8_t  pll1_bypass_en;
    uint8_t  pll1_loop_filter_rzero;
    uint8_t  ref_mode;
    uint32_t pll2_charge_pump_current_nA;
    uint8_t  pll2_ndiv_a_cnt;
    uint8_t  pll2_ndiv_b_cnt;
    uint8_t  pll2_freq_doubler_en;
    uint8_t  pll2_r2_div;
    uint8_t  pll2_vco_diff_m1;
    uint8_t  pll2_vco_diff_m2;
    uint8_t  rpole2;
    uint8_t  rzero;
    uint8_t  cpole1;
    uint8_t  rzero_bypass_en;
    int32_t  num_channels;
    struct ad9523_channel_spec *channels;
    int8_t   name[16];
};

struct ad9523_state {
    struct ad9523_platform_data *pdata;
    uint32_t vcxo_freq;
    uint32_t vco_freq;
    uint32_t vco_out_freq[3];
    uint8_t  vco_out_map[14];
};

struct ad9523_dev {
    struct no_os_spi_desc   *spi_desc;
    struct ad9523_state      ad9523_st;
    struct ad9523_platform_data *pdata;
};

struct ad9523_init_param {
    struct no_os_spi_init_param  spi_init;
    struct ad9523_platform_data *pdata;
};

/* AD9523 enums needed by test code */
enum outp_drv_mode {
    TRISTATE = 0,
    LVPECL_8mA, LVDS_4mA, LVDS_7mA,
    HSTL0_16mA, HSTL1_8mA,
    CMOS_CONF1, CMOS_CONF2, CMOS_CONF3, CMOS_CONF4,
    CMOS_CONF5, CMOS_CONF6, CMOS_CONF7, CMOS_CONF8, CMOS_CONF9
};

enum rpole2_resistor  { RPOLE2_900_OHM = 0, RPOLE2_450_OHM, RPOLE2_300_OHM, RPOLE2_225_OHM };
enum rzero_resistor   { RZERO_3250_OHM = 0, RZERO_2750_OHM, RZERO_2250_OHM, RZERO_2100_OHM,
                        RZERO_3000_OHM, RZERO_2500_OHM, RZERO_2000_OHM, RZERO_1850_OHM };
enum cpole1_capacitor { CPOLE1_0_PF = 0, CPOLE1_8_PF, CPOLE1_16_PF, CPOLE1_24_PF,
                        _CPOLE1_24_PF, CPOLE1_32_PF, CPOLE1_40_PF, CPOLE1_48_PF };

/* ========================= Mock return code control =============== */

/* Default return code for mock driver functions (0 = success) */
extern int mock_adf4382_init_retval;
extern int mock_adf4382_set_timed_sync_retval;
extern int mock_ad9523_setup_retval;

/* ========================= ADF4382 mock API ======================= */

int adf4382_init(struct adf4382_dev **device, struct adf4382_init_param *init_param);
int adf4382_remove(struct adf4382_dev *dev);
int adf4382_set_out_power(struct adf4382_dev *dev, uint8_t ch, int32_t pwr);
int adf4382_set_en_chan(struct adf4382_dev *dev, uint8_t ch, bool en);
int adf4382_set_timed_sync_setup(struct adf4382_dev *dev, bool sync);
int adf4382_set_ezsync_setup(struct adf4382_dev *dev, bool sync);
int adf4382_set_sw_sync(struct adf4382_dev *dev, bool sw_sync);
int adf4382_spi_read(struct adf4382_dev *dev, uint16_t reg_addr, uint8_t *data);

/* ========================= AD9523 mock API ======================== */

int32_t ad9523_init(struct ad9523_init_param *init_param);
int32_t ad9523_setup(struct ad9523_dev **device, const struct ad9523_init_param *init_param);
int32_t ad9523_status(struct ad9523_dev *dev);
int32_t ad9523_sync(struct ad9523_dev *dev);
int32_t ad9523_remove(struct ad9523_dev *dev);

#ifdef __cplusplus
}
#endif

#endif /* AD_DRIVER_MOCK_H */
