/*
 * AXI XADC DMA driver.
 * Configures XADC in continuous stream and DMA in simple mode.
 * Uses DMA Client API to configure Xilinx DMA engine. 
 * Provide interface to read XADC Samples.
 * Copyright (C) 2012 Xilinx, Inc.
 * Copyright (C) 2012 Robert Armstrong
 *
 * Author: Radhey Shyam Pandey <radheys@xilinx.com>
 * 
 * Based on PL330 DMA Driver.
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

#ifndef AXI_XADC_DMA_H
#define AXI_XADC_DMA_H

#define MODULE_NAME             	"axi_xadc_dma"
#define AXI_XADC_MINOR_START            0
#define AXI_XADC_MINOR_COUNT         	1
#define AXI_XADC_CALLBACK_TIMEOUTMSEC 	10000
#define AXI_XADC_BUFF_SIZE              8192
#define AXI_XADC_NO_OF_SAMPLES          4096
#define SUCCESS                 	0
#define FAILURE                         -1
#define AXI_XADC_REG_FIFO_CNTRL         0x0
#define AXI_XADC_BUF_COUNT              1
/* IOCTL defines */
#define AXI_XADC_IOCTL_BASE		'W'
#define AXI_XADC_GET_NUM_DEVICES	_IO(AXI_XADC_IOCTL_BASE, 0)
#define AXI_XADC_GET_DEV_INFO		_IO(AXI_XADC_IOCTL_BASE, 1)
#define AXI_XADC_DMA_CONFIG		_IO(AXI_XADC_IOCTL_BASE, 2)
#define AXI_XADC_DMA_START		_IO(AXI_XADC_IOCTL_BASE, 3)
#define AXI_XADC_DMA_STOP		_IO(AXI_XADC_IOCTL_BASE, 4)

struct axi_xadc_dev {
    dev_t devno;
    struct mutex mutex;
    struct cdev cdev;
    struct class *axi_xadc_class;
    struct platform_device *pdev;
    /* XADC Hardware device constants */
    void *xadc_virtaddr;
    /* AXI FIFO Adapter constants */
    void *axififo_virtaddr;
    /* DMA stuff */
    struct dma_chan *rx_chan;
    dma_cookie_t rx_cookie;
    struct completion rx_cmp;
    unsigned long rx_tmo;
    struct scatterlist rx_sg;
    /*DMA address of buffer */
    dma_addr_t dma_dsts;
    enum dma_ctrl_flags flags;
    u8 *dsts;
};


/**@name Register offsets
 *
 * The following constants provide access to each of the registers of the
 * System Monitor/ADC device.
 * @{
 */

/*
 * XADC default values 
 */
#define XSM_DEF_DIVISOR 	2


/*
 * System Monitor/ADC Local Registers
 */
#define XSM_SRR_OFFSET		0x00  /**< Software Reset Register */
#define XSM_SR_OFFSET		0x04  /**< Status Register */
#define XSM_AOR_OFFSET		0x08  /**< Alarm Output Register */
#define XSM_CONVST_OFFSET	0x0C  /**< ADC Convert Start Register */
#define XSM_ARR_OFFSET		0x10  /**< ADC Reset Register */

/*
 * System Monitor/ADC Interrupt Registers
 */
#define XSM_GIER_OFFSET		0x5C  /**< Global Interrupt Enable */
#define XSM_IPISR_OFFSET	0x60  /**< Interrupt Status Register */
#define XSM_IPIER_OFFSET	0x68  /**< Interrupt Enable register */

/*
 * System Monitor/ADC Internal Channel Registers
 */
#define XSM_TEMP_OFFSET		 0x200 /**< On-chip Temperature Reg */
#define XSM_VCCINT_OFFSET	 0x204 /**< On-chip VCCINT Data Reg */
#define XSM_VCCAUX_OFFSET	 0x208 /**< On-chip VCCAUX Data Reg */
#define XSM_VPVN_OFFSET		 0x20C /**< ADC out of VP/VN	   */
#define XSM_VREFP_OFFSET	 0x210 /**< On-chip VREFP Data Reg */
#define XSM_VREFN_OFFSET	 0x214 /**< On-chip VREFN Data Reg */
#define XSM_VBRAM_OFFSET	 0x218 /**< On-chip VBRAM Data, 7 series/Zynq */
#define XSM_SUPPLY_CALIB_OFFSET	 0x220 /**< Supply Offset Data Reg */
#define XSM_ADC_CALIB_OFFSET	 0x224 /**< ADC Offset Data Reg */
#define XSM_GAINERR_CALIB_OFFSET 0x228 /**< Gain Error Data Reg  */
#define XSM_VCCPINT_OFFSET	 0x22C /**< PS VCCPINT Data Reg - Zynq */
#define XSM_VCCPAUX_OFFSET	 0x230 /**< PS VCCPAUX Data Reg - Zynq */
#define XSM_VCCPDRO_OFFSET	 0x234 /**< PS VCCPDRO Data Reg - Zynq */
/*
 * System Monitor/ADC External Channel Registers
 */
#define XSM_AUX00_OFFSET	0x240 /**< ADC out of VAUXP0/VAUXN0 */
#define XSM_AUX01_OFFSET	0x244 /**< ADC out of VAUXP1/VAUXN1 */
#define XSM_AUX02_OFFSET	0x248 /**< ADC out of VAUXP2/VAUXN2 */
#define XSM_AUX03_OFFSET	0x24C /**< ADC out of VAUXP3/VAUXN3 */
#define XSM_AUX04_OFFSET	0x250 /**< ADC out of VAUXP4/VAUXN4 */
#define XSM_AUX05_OFFSET	0x254 /**< ADC out of VAUXP5/VAUXN5 */
#define XSM_AUX06_OFFSET	0x258 /**< ADC out of VAUXP6/VAUXN6 */
#define XSM_AUX07_OFFSET	0x25C /**< ADC out of VAUXP7/VAUXN7 */
#define XSM_AUX08_OFFSET	0x260 /**< ADC out of VAUXP8/VAUXN8 */
#define XSM_AUX09_OFFSET	0x264 /**< ADC out of VAUXP9/VAUXN9 */
#define XSM_AUX10_OFFSET	0x268 /**< ADC out of VAUXP10/VAUXN10 */
#define XSM_AUX11_OFFSET	0x26C /**< ADC out of VAUXP11/VAUXN11 */
#define XSM_AUX12_OFFSET	0x270 /**< ADC out of VAUXP12/VAUXN12 */
#define XSM_AUX13_OFFSET	0x274 /**< ADC out of VAUXP13/VAUXN13 */
#define XSM_AUX14_OFFSET	0x278 /**< ADC out of VAUXP14/VAUXN14 */
#define XSM_AUX15_OFFSET	0x27C /**< ADC out of VAUXP15/VAUXN15 */

/*
 * System Monitor/ADC Registers for Maximum/Minimum data captured for the
 * on chip Temperature/VCCINT/VCCAUX data.
 */
#define XSM_MAX_TEMP_OFFSET	0x280 /**< Maximum Temperature Reg */
#define XSM_MAX_VCCINT_OFFSET	0x284 /**< Maximum VCCINT Register */
#define XSM_MAX_VCCAUX_OFFSET	0x288 /**< Maximum VCCAUX Register */
#define XSM_MAX_VBRAM_OFFSET	0x28C /**< Maximum VBRAM Reg, 7 Series/Zynq */
#define XSM_MIN_TEMP_OFFSET	0x290 /**< Minimum Temperature Reg */
#define XSM_MIN_VCCINT_OFFSET	0x294 /**< Minimum VCCINT Register */
#define XSM_MIN_VCCAUX_OFFSET	0x298 /**< Minimum VCCAUX Register */
#define XSM_MIN_VBRAM_OFFSET	0x29C /**< Maximum VBRAM Reg, 7 Series/Zynq */
#define XSM_MAX_VCCPINT_OFFSET	0x2A0 /**< Max VCCPINT Register, Zynq */
#define XSM_MAX_VCCPAUX_OFFSET	0x2A4 /**< Max VCCPAUX Register, Zynq */
#define XSM_MAX_VCCPDRO_OFFSET	0x2A8 /**< Max VCCPDRO Register, Zynq */
#define XSM_MIN_VCCPINT_OFFSET	0x2AC /**< Min VCCPINT Register, Zynq */
#define XSM_MIN_VCCPAUX_OFFSET	0x2B0 /**< Min VCCPAUX Register, Zynq */
#define XSM_MIN_VCCPDRO_OFFSET	0x2B4 /**< Min VCCPDRO Register, Zynq */

#define XSM_FLAG_REG_OFFSET	0x2FC /**< General Status */

/*
 * System Monitor/ADC Configuration Registers
 */
#define XSM_CFR0_OFFSET		0x300 /**< Configuration Register 0 */
#define XSM_CFR1_OFFSET		0x304 /**< Configuration Register 1 */
#define XSM_CFR2_OFFSET		0x308 /**< Configuration Register 2 */

/*
 * System Monitor/ADC Sequence Registers
 */
#define XSM_SEQ00_OFFSET	0x320 /**< Seq Reg 00 Adc Channel Selection */
#define XSM_SEQ01_OFFSET	0x324 /**< Seq Reg 01 Adc Channel Selection */
#define XSM_SEQ02_OFFSET	0x328 /**< Seq Reg 02 Adc Average Enable */
#define XSM_SEQ03_OFFSET	0x32C /**< Seq Reg 03 Adc Average Enable */
#define XSM_SEQ04_OFFSET	0x330 /**< Seq Reg 04 Adc Input Mode Select */
#define XSM_SEQ05_OFFSET	0x334 /**< Seq Reg 05 Adc Input Mode Select */
#define XSM_SEQ06_OFFSET	0x338 /**< Seq Reg 06 Adc Acquisition Select */
#define XSM_SEQ07_OFFSET	0x33C /**< Seq Reg 07 Adc Acquisition Select */

/*
 * System Monitor/ADC Alarm Threshold/Limit Registers (ATR)
 */
#define XSM_ATR_TEMP_UPPER_OFFSET	0x340 /**< Temp Upper Alarm Register */
#define XSM_ATR_VCCINT_UPPER_OFFSET	0x344 /**< VCCINT Upper Alarm Reg */
#define XSM_ATR_VCCAUX_UPPER_OFFSET	0x348 /**< VCCAUX Upper Alarm Reg */
#define XSM_ATR_OT_UPPER_OFFSET		0x34C /**< Over Temp Upper Alarm Reg */
#define XSM_ATR_TEMP_LOWER_OFFSET	0x350 /**< Temp Lower Alarm Register */
#define XSM_ATR_VCCINT_LOWER_OFFSET	0x354 /**< VCCINT Lower Alarm Reg */
#define XSM_ATR_VCCAUX_LOWER_OFFSET	0x358 /**< VCCAUX Lower Alarm Reg */
#define XSM_ATR_OT_LOWER_OFFSET		0x35C /**< Over Temp Lower Alarm Reg */
#define XSM_ATR_VBRAM_UPPER_OFFSET	0x360 /**< VBBAM Upper Alarm,7 Series */
#define XSM_ATR_VCCPINT_UPPER_OFFSET	0x364 /**< VCCPINT Upper Alarm, Zynq */
#define XSM_ATR_VCCPAUX_UPPER_OFFSET	0x368 /**< VCCPAUX Upper Alarm, Zynq */
#define XSM_ATR_VCCPDRO_UPPER_OFFSET	0x36C /**< VCCPDRO Upper Alarm, Zynq */
#define XSM_ATR_VBRAM_LOWER_OFFSET	0x370 /**< VRBAM Lower Alarm, 7 Series*/
#define XSM_ATR_VCCPINT_LOWER_OFFSET	0x374 /**< VCCPINT Lower Alarm, Zynq */
#define XSM_ATR_VCCPAUX_LOWER_OFFSET	0x378 /**< VCCPAUX Lower Alarm, Zynq */
#define XSM_ATR_VCCPDRO_LOWER_OFFSET	0x37C /**< VCCPDRO Lower Alarm, Zynq */


/*@}*/

/**
 * @name System Monitor/ADC Software Reset Register (SRR) mask(s)
 * @{
 */
#define XSM_SRR_IPRST_MASK	0x0000000A   /**< Device Reset Mask */

/*@}*/

/**
 * @name System Monitor/ADC Status Register (SR) mask(s)
 * @{
 */
#define XSM_SR_JTAG_BUSY_MASK	  0x00000400 /**< JTAG is busy */
#define XSM_SR_JTAG_MODIFIED_MASK 0x00000200 /**< JTAG Write has occurred */
#define XSM_SR_JTAG_LOCKED_MASK	  0x00000100 /**< JTAG is locked */
#define XSM_SR_BUSY_MASK	  0x00000080 /**< ADC is busy in conversion */
#define XSM_SR_EOS_MASK		  0x00000040 /**< End of Sequence */
#define XSM_SR_EOC_MASK		  0x00000020 /**< End of Conversion */
#define XSM_SR_CH_MASK		  0x0000001F /**< Input ADC channel */

/*@}*/

/**
 * @name System Monitor/ADC Alarm Output Register (AOR) mask(s)
 * @{
 */
#define XSM_AOR_ALARM_ALL_MASK	0x000001FF /**< Mask for all Alarms */
#define XSM_AOR_ALL_MASK	0x00000100 /**< ALM7 - All Alarms  */
#define XSM_AOR_VCCPDRO_MASK	0x00000080 /**< ALM6 - VCCPDRO  Mask, Zynq */
#define XSM_AOR_VCCPAUX_MASK	0x00000040 /**< ALM5 - VCCPAUX  Mask, Zynq */
#define XSM_AOR_VCCPINT_MASK	0x00000020 /**< ALM4 - VCCPINT Mask, Zynq */
#define XSM_AOR_VBRAM_MASK	0x00000010 /**< ALM3 - VBRAM Output Mask
					     *  - 7 Series and Zynq */
#define XSM_AOR_VCCAUX_MASK	0x00000008 /**< ALM2 - VCCAUX Output Mask  */
#define XSM_AOR_VCCINT_MASK	0x00000004 /**< ALM1 - VCCINT Alarm Mask */
#define XSM_AOR_TEMP_MASK	0x00000002 /**< ALM0 - Temp sensor Alarm Mask */
#define XSM_AOR_OT_MASK		0x00000001 /**< Over Temp Alarm Output */

/*@}*/

/**
 * @name System Monitor/ADC CONVST Register (CONVST) mask(s)
 * @{
 */
#define XSM_CONVST_CONVST_MASK		0x00000001
						/**< Conversion Start Mask */
#define XSM_CONVST_TEMPUPDT_MASK	0x00000002
						/**< Temperature Update
							Enable Mask */
#define XSM_CONVST_WAITCYCLES_SHIFT	2	/**< Wait Cycles Shift */
#define XSM_CONVST_WAITCYCLES_MASK	0x0003FFFC /**< Wait Cycles Mask */
#define XSM_CONVST_WAITCYCLES_DEFAULT	0x03E8	/**< Wait Cycles
							 default value */
/*@}*/

/**
 * @name System Monitor/ADC Reset Register (ARR) mask(s)
 * @{
 */
#define XSM_ARR_RST_MASK	0x00000001 /**< ADC Reset bit mask */

/*@}*/

/**
 * @name Global Interrupt Enable Register (GIER) mask(s)
 * @{
 */
#define XSM_GIER_GIE_MASK	0x80000000 /**< Global interrupt enable */
/*@}*/

/**
 * @name System Monitor/ADC device Interrupt Status/Enable Registers
 *
 * <b> Interrupt Status Register (IPISR) </b>
 *
 * This register holds the interrupt status flags for the device.
 *
 * <b> Interrupt Enable Register (IPIER) </b>
 *
 * This register is used to enable interrupt sources for the device.
 * Writing a '1' to a bit in this register enables the corresponding Interrupt.
 * Writing a '0' to a bit in this register disables the corresponding Interrupt
 *
 * IPISR/IPIER registers have the same bit definitions and are only defined
 * once.
 * @{
 */
#define XSM_IPIXR_VBRAM_MASK	      0x00000400 /**< ALM3 - VBRAM Output Mask
						   *  - 7 Series  and Zynq */
#define XSM_IPIXR_TEMP_DEACTIVE_MASK  0x00000200 /**< Alarm 0 DEACTIVE */
#define XSM_IPIXR_OT_DEACTIVE_MASK    0x00000100 /**< Over Temp DEACTIVE */
#define XSM_IPIXR_JTAG_MODIFIED_MASK  0x00000080 /**< JTAG Modified */
#define XSM_IPIXR_JTAG_LOCKED_MASK    0x00000040 /**< JTAG Locked */
#define XSM_IPIXR_EOC_MASK	      0x00000020 /**< End Of Conversion */
#define XSM_IPIXR_EOS_MASK	      0x00000010 /**< End Of Sequence */
#define XSM_IPIXR_VCCAUX_MASK	      0x00000008 /**< Alarm 2 - VCCAUX */
#define XSM_IPIXR_VCCINT_MASK	      0x00000004 /**< Alarm 1 - VCCINT */
#define XSM_IPIXR_TEMP_MASK	      0x00000002 /**< Alarm 0 - Temp ACTIVE */
#define XSM_IPIXR_OT_MASK	      0x00000001 /**< Over Temperature ACTIVE */
#define XSM_IPIXR_ALL_MASK	      0x000003FF /**< Mask of all interrupts */

/*@}*/

/**
 * @name Mask for all ADC converted data including Minimum/Maximum Measurements
 *	 and Threshold data.
 * @{
 */
#define XSM_ADCDATA_MAX_MASK	0x03FF

/*@}*/

/**
 * @name Configuration Register 0 (CFR0) mask(s)
 * @{
 */
#define XSM_CFR0_CAL_AVG_MASK	0x8000  /**< Averaging enable Mask */
#define XSM_CFR0_AVG_VALID_MASK	0x3000  /**< Averaging bit Mask */
#define XSM_CFR0_AVG1_MASK	0x0000  /**< No Averaging */
#define XSM_CFR0_AVG16_MASK	0x1000  /**< Average 16 samples */
#define XSM_CFR0_AVG64_MASK	0x2000  /**< Average 64 samples */
#define XSM_CFR0_AVG256_MASK	0x3000  /**< Average 256 samples */
#define XSM_CFR0_AVG_SHIFT	12	/**< Shift for the Averaging bits  */
#define XSM_CFR0_MUX_MASK	0x0800  /**< External Mux Mask Enable
					  *  - 7 Series and Zynq  */
#define XSM_CFR0_DU_MASK	0x0400  /**< Bipolar/Unipolar mode */
#define XSM_CFR0_EC_MASK	0x0200  /**< Event driven/Continuous mode */
#define XSM_CFR0_ACQ_MASK	0x0100  /**< Add acquisition by 6 ADCCLK  */
#define XSM_CFR0_CHANNEL_MASK	0x001F  /**< Channel number bit Mask */

/*@}*/

/**
 * @name Configuration Register 1 (CFR1) mask(s)
 * @{
 */
#define XSM_CFR1_SEQ_VALID_MASK		  0xF000 /**< Sequence bit Mask */
#define XSM_CFR1_SEQ_SAFEMODE_MASK	  0x0000 /**< Default Safe Mode */
#define XSM_CFR1_SEQ_ONEPASS_MASK	  0x1000 /**< Onepass through Seq */
#define XSM_CFR1_SEQ_CONTINPASS_MASK	  0x2000 /**< Continuous Cycling Seq */
#define XSM_CFR1_SEQ_SINGCHAN_MASK	  0x3000 /**< Single channel - No Seq */
#define XSM_CFR1_SEQ_SIMUL_SAMPLING_MASK  0x4000 /**< Simulataneous Sampling
						   *  Mask */
#define XSM_CFR1_SEQ_INDEPENDENT_MASK	  0x8000 /**< Independent Mode */
#define XSM_CFR1_SEQ_SHIFT		  12     /**< Sequence bit shift */
#define XSM_CFR1_ALM_VCCPDRO_MASK	  0x0800 /**< Alarm 6 - VCCPDRO, Zynq */
#define XSM_CFR1_ALM_VCCPAUX_MASK	  0x0400 /**< Alarm 5 - VCCPAUX, Zynq */
#define XSM_CFR1_ALM_VCCPINT_MASK	  0x0200 /**< Alarm 4 - VCCPINT, Zynq */
#define XSM_CFR1_ALM_VBRAM_MASK	  	  0x0100 /**< Alarm 3 - VBRAM Enable
						   *  7 Series and Zynq */
#define XSM_CFR1_CAL_VALID_MASK		  0x00F0 /**< Valid Calibration Mask */
#define XSM_CFR1_CAL_PS_GAIN_OFFSET_MASK  0x0080 /**< Calibration 3 -Power
							Supply Gain/Offset
							Enable */
#define XSM_CFR1_CAL_PS_OFFSET_MASK	  0x0040 /**< Calibration 2 -Power
							Supply Offset Enable */
#define XSM_CFR1_CAL_ADC_GAIN_OFFSET_MASK 0x0020 /**< Calibration 1 -ADC Gain
							Offset Enable */
#define XSM_CFR1_CAL_ADC_OFFSET_MASK	  0x0010 /**< Calibration 0 -ADC Offset
							Enable */
#define XSM_CFR1_CAL_DISABLE_MASK	  0x0000 /**< No Calibration */
#define XSM_CFR1_ALM_ALL_MASK		  0x0F0F /**< Mask for all alarms */
#define XSM_CFR1_ALM_VCCAUX_MASK	  0x0008 /**< Alarm 2 - VCCAUX Enable */
#define XSM_CFR1_ALM_VCCINT_MASK	  0x0004 /**< Alarm 1 - VCCINT Enable */
#define XSM_CFR1_ALM_TEMP_MASK		  0x0002 /**< Alarm 0 - Temperature */
#define XSM_CFR1_OT_MASK		  0x0001 /**< Over Temperature Enable */

/*@}*/

/**
 * @name Configuration Register 2 (CFR2) mask(s)
 * @{
 */
#define XSM_CFR2_CD_VALID_MASK	0xFF00  /**<Clock Divisor bit Mask   */
#define XSM_CFR2_CD_SHIFT	8	/**<Num of shift on division */
#define XSM_CFR2_CD_MIN		8	/**<Minimum value of divisor */
#define XSM_CFR2_CD_MAX		255	/**<Maximum value of divisor */

#define XSM_CFR2_PD_MASK	0x0030	/**<Power Down Mask */
#define XSM_CFR2_PD_XADC_MASK	0x0030	/**<Power Down XADC Mask */
#define XSM_CFR2_PD_ADC1_MASK	0x0020	/**<Power Down XADC Mask */
#define XSM_CFR2_PD_SHIFT	4	/**<Power Down Shift */

/*@}*/

/**
 * @name Sequence Register (SEQ) Bit Definitions
 * @{
 */
#define XSM_SEQ_CH_CALIB	0x00000001 /**< ADC Calibration Channel */
#define XSM_SEQ_CH_VCCPINT	0x00000020 /**< VCCPINT, Zynq Only */
#define XSM_SEQ_CH_VCCPAUX	0x00000040 /**< VCCPAUX, Zynq Only */
#define XSM_SEQ_CH_VCCPDRO	0x00000080 /**< VCCPDRO, Zynq Only */
#define XSM_SEQ_CH_TEMP		0x00000100 /**< On Chip Temperature Channel */
#define XSM_SEQ_CH_VCCINT	0x00000200 /**< VCCINT Channel */
#define XSM_SEQ_CH_VCCAUX	0x00000400 /**< VCCAUX Channel */
#define XSM_SEQ_CH_VPVN		0x00000800 /**< VP/VN analog inputs Channel */
#define XSM_SEQ_CH_VREFP	0x00001000 /**< VREFP Channel */
#define XSM_SEQ_CH_VREFN	0x00002000 /**< VREFN Channel */
#define XSM_SEQ_CH_VBRAM	0x00004000 /**< VBRAM Channel, 7 series/Zynq */
#define XSM_SEQ_CH_AUX00	0x00010000 /**< 1st Aux Channel */
#define XSM_SEQ_CH_AUX01	0x00020000 /**< 2nd Aux Channel */
#define XSM_SEQ_CH_AUX02	0x00040000 /**< 3rd Aux Channel */
#define XSM_SEQ_CH_AUX03	0x00080000 /**< 4th Aux Channel */
#define XSM_SEQ_CH_AUX04	0x00100000 /**< 5th Aux Channel */
#define XSM_SEQ_CH_AUX05	0x00200000 /**< 6th Aux Channel */
#define XSM_SEQ_CH_AUX06	0x00400000 /**< 7th Aux Channel */
#define XSM_SEQ_CH_AUX07	0x00800000 /**< 8th Aux Channel */
#define XSM_SEQ_CH_AUX08	0x01000000 /**< 9th Aux Channel */
#define XSM_SEQ_CH_AUX09	0x02000000 /**< 10th Aux Channel */
#define XSM_SEQ_CH_AUX10	0x04000000 /**< 11th Aux Channel */
#define XSM_SEQ_CH_AUX11	0x08000000 /**< 12th Aux Channel */
#define XSM_SEQ_CH_AUX12	0x10000000 /**< 13th Aux Channel */
#define XSM_SEQ_CH_AUX13	0x20000000 /**< 14th Aux Channel */
#define XSM_SEQ_CH_AUX14	0x40000000 /**< 15th Aux Channel */
#define XSM_SEQ_CH_AUX15	0x80000000 /**< 16th Aux Channel */

#define XSM_SEQ00_CH_VALID_MASK	0x7FE1 /**< Mask for the valid channels */
#define XSM_SEQ01_CH_VALID_MASK	0xFFFF /**< Mask for the valid channels */

#define XSM_SEQ02_CH_VALID_MASK	0x7FE0 /**< Mask for the valid channels */
#define XSM_SEQ03_CH_VALID_MASK	0xFFFF /**< Mask for the valid channels */

#define XSM_SEQ04_CH_VALID_MASK	0x0800 /**< Mask for the valid channels */
#define XSM_SEQ05_CH_VALID_MASK	0xFFFF /**< Mask for the valid channels */

#define XSM_SEQ06_CH_VALID_MASK	0x0800 /**< Mask for the valid channels */
#define XSM_SEQ07_CH_VALID_MASK	0xFFFF /**< Mask for the valid channels */

#define XSM_SEQ_CH_AUX_SHIFT	16 /**< Shift for the Aux Channel */

/*@}*/

/**
 * @name OT Upper Alarm Threshold Register Bit Definitions
 * @{
 */

#define XSM_ATR_OT_UPPER_ENB_MASK	0x000F /**< Mask for OT enable */
#define XSM_ATR_OT_UPPER_VAL_MASK	0xFFF0 /**< Mask for OT value */
#define XSM_ATR_OT_UPPER_VAL_SHIFT	4      /**< Shift for OT value */
#define XSM_ATR_OT_UPPER_ENB_VAL	0x0003 /**< Value for OT enable */
#define XSM_ATR_OT_UPPER_VAL_MAX	0x0FFF /**< Max OT value */


/**
 * @name Indexes for the different channels.
 * @{
 */
#define XSM_CH_TEMP		0x0  /**< On Chip Temperature */
#define XSM_CH_VCCINT		0x1  /**< VCCINT */
#define XSM_CH_VCCAUX		0x2  /**< VCCAUX */
#define XSM_CH_VPVN		0x3  /**< VP/VN Dedicated analog inputs */
#define XSM_CH_VREFP		0x4  /**< VREFP */
#define XSM_CH_VREFN		0x5  /**< VREFN */
#define XSM_CH_VBRAM		0x6  /**< VBRAM - 7 Series and Zynq */
#define XSM_CH_SUPPLY_CALIB	0x07 /**< Supply Calib Data Reg */
#define XSM_CH_ADC_CALIB	0x08 /**< ADC Offset Channel Reg */
#define XSM_CH_GAINERR_CALIB 	0x09 /**< Gain Error Channel Reg  */
#define XSM_CH_VCCPINT		0x0D /**< On-chip PS VCCPINT Channel, Zynq */
#define XSM_CH_VCCPAUX		0x0E /**< On-chip PS VCCPAUX Channel, Zynq */
#define XSM_CH_VCCPDRO		0x0F /**< On-chip PS VCCPDRO Channel, Zynq */
#define XSM_CH_AUX_MIN		16   /**< Channel number for 1st Aux Channel */
#define XSM_CH_AUX_MAX		31   /**< Channel number for Last Aux channel */

/*@}*/


/**
 * @name Indexes for reading the Calibration Coefficient Data.
 * @{
 */
#define XSM_CALIB_SUPPLY_OFFSET_COEFF 0 /**< Supply Offset Calib Coefficient */
#define XSM_CALIB_ADC_OFFSET_COEFF    1 /**< ADC Offset Calib Coefficient */
#define XSM_CALIB_GAIN_ERROR_COEFF    2 /**< Gain Error Calib Coefficient*/

/*@}*/


/**
 * @name Indexes for reading the Minimum/Maximum Measurement Data.
 * @{
 */
#define XSM_MAX_TEMP		0  /**< Maximum Temperature Data */
#define XSM_MAX_VCCINT		1  /**< Maximum VCCINT Data */
#define XSM_MAX_VCCAUX		2  /**< Maximum VCCAUX Data */
#define XSM_MAX_VCCBRAM		3  /**< Maximum VCCBRAM Data, 7 Series/Zynq */
#define XSM_MIN_TEMP		4  /**< Minimum Temperature Data */
#define XSM_MIN_VCCINT		5  /**< Minimum VCCINT Data */
#define XSM_MIN_VCCAUX		6  /**< Minimum VCCAUX Data */
#define XSM_MIN_VCCBRAM		7  /**< Minimum VCCBRAM Data, 7 Series/Zynq */
#define XSM_MAX_VCCPINT		8  /**< Maximum VCCPINT Register , Zynq */
#define XSM_MAX_VCCPAUX		9  /**< Maximum VCCPAUX Register , Zynq */
#define XSM_MAX_VCCPDRO		0xA /**< Maximum VCCPDRO Register , Zynq */
#define XSM_MIN_VCCPINT		0xC /**< Minimum VCCPINT Register , Zynq */
#define XSM_MIN_VCCPAUX		0xD /**< Minimum VCCPAUX Register , Zynq */
#define XSM_MIN_VCCPDRO		0xE /**< Minimum VCCPDRO Register , Zynq */


/*@}*/


/**
 * @name Alarm Threshold(Limit) Register (ATR) indexes.
 * @{
 */
#define XSM_ATR_TEMP_UPPER	 0   /**< High user Temperature */
#define XSM_ATR_VCCINT_UPPER	 1   /**< VCCINT high voltage limit register */
#define XSM_ATR_VCCAUX_UPPER	 2   /**< VCCAUX high voltage limit register */
#define XSM_ATR_OT_UPPER	 3   /**< Lower Over Temperature limit */
#define XSM_ATR_TEMP_LOWER	 4   /**< Low user Temperature */
#define XSM_ATR_VCCINT_LOWER	 5   /**< VCCINT low voltage limit register */
#define XSM_ATR_VCCAUX_LOWER	 6   /**< VCCAUX low voltage limit register */
#define XSM_ATR_OT_LOWER	 7   /**< Lower Over Temperature limit */
#define XSM_ATR_VBRAM_UPPER	 8   /**< VBRAM high voltage limit register */
#define XSM_ATR_VCCPINT_UPPER 	 9   /**< VCCPINT Upper Alarm Reg, Zynq */
#define XSM_ATR_VCCPAUX_UPPER 	 0xA /**< VCCPAUX Upper Alarm Reg, Zynq */
#define XSM_ATR_VCCPDRO_UPPER 	 0xB /**< VCCPDRO Upper Alarm Reg, Zynq */
#define XSM_ATR_VBRAM_LOWER	 0xC /**< VRBAM Lower Alarm, 7 Series and Zynq*/
#define XSM_ATR_VCCPINT_LOWER 	 0xD /**< VCCPINT Lower Alarm Reg , Zynq */
#define XSM_ATR_VCCPAUX_LOWER 	 0xE /**< VCCPAUX Lower Alarm Reg , Zynq */
#define XSM_ATR_VCCPDRO_LOWER 	 0xF /**< VCCPDRO Lower Alarm Reg , Zynq */

/*@}*/


/**
 * @name Averaging to be done for the channels.
 * @{
 */
#define XSM_AVG_0_SAMPLES	0 /**< No Averaging */
#define XSM_AVG_16_SAMPLES	1 /**< Average 16 samples */
#define XSM_AVG_64_SAMPLES	2 /**< Average 64 samples */
#define XSM_AVG_256_SAMPLES	3 /**< Average 256 samples */

/*@}*/


/**
 * @name Channel Sequencer Modes of operation.
 * @{
 */
#define XSM_SEQ_MODE_SAFE	 0 /**< Default Safe Mode */
#define XSM_SEQ_MODE_ONEPASS	 1 /**< Onepass through Sequencer */
#define XSM_SEQ_MODE_CONTINPASS	 2 /**< Continuous Cycling Seqquencer */
#define XSM_SEQ_MODE_SINGCHAN	 3 /**< Single channel - No Sequencing */
#define XSM_SEQ_MODE_SIMUL	 4 /**< Simultaneous Cycling Sequencer,
				     *  7 Series and Zynq XADC only */
#define XSM_SEQ_MODE_INDEPENDENT 8 /**< Independent ADC Sequencer,
				     *  7 Series and Zynq XADC only */

/*@}*/

/* For backwards compatabilty */
#define XSM_CH_CALIBRATION	XSM_CH_ADC_CALIB
#define XSM_ATR_BRAM_UPPER	XSM_ATR_VBRAM_UPPER
#define XSM_ATR_BRAM_LOWER	XSM_ATR_VBRAM_LOWER


#endif
