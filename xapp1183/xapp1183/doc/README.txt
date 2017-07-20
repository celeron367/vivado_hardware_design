*************************************************************************
   ____  ____ 
  /   /\/   / 
 /___/  \  /   
 \   \   \/    © Copyright 2013 Xilinx, Inc. All rights reserved.
  \   \        This file contains confidential and proprietary 
  /   /        information of Xilinx, Inc. and is protected under U.S. 
 /___/   /\    and international copyright and other intellectual 
 \   \  /  \   property laws. 
  \___\/\___\ 
 
*************************************************************************

Vendor: Xilinx 
Current readme.txt Version: 1.0 
Date Last Modified:  18NOV2013
Date Created: 18NOV2013

Associated Filename: xapp1183.zip
Associated Document: XAPP1183, - Using the Zynq-7000 Processing System (PS) to Xilinx Analog to Digital Converter (XADC) AXI Interface to Implement Analog Data Acquisition Functionality

Supported Device(s): Zynq-7000 AP SOC based zc702 kit 
   
*************************************************************************

Disclaimer: 

      This disclaimer is not a license and does not grant any rights to 
      the materials distributed herewith. Except as otherwise provided in 
      a valid license issued to you by Xilinx, and to the maximum extent 
      permitted by applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE 
      "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL 
      WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, 
      INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, 
      NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and 
      (2) Xilinx shall not be liable (whether in contract or tort, 
      including negligence, or under any other theory of liability) for 
      any loss or damage of any kind or nature related to, arising under 
      or in connection with these materials, including for any direct, or 
      any indirect, special, incidental, or consequential loss or damage 
      (including loss of data, profits, goodwill, or any type of loss or 
      damage suffered as a result of any action brought by a third party) 
      even if such damage or loss was reasonably foreseeable or Xilinx 
      had been advised of the possibility of the same.

Critical Applications:

      Xilinx products are not designed or intended to be fail-safe, or 
      for use in any application requiring fail-safe performance, such as 
      life-support or safety devices or systems, Class III medical 
      devices, nuclear facilities, applications related to the deployment 
      of airbags, or any other applications that could lead to death, 
      personal injury, or severe property or environmental damage 
      (individually and collectively, "Critical Applications"). Customer 
      assumes the sole risk and liability of any use of Xilinx products 
      in Critical Applications, subject only to applicable laws and 
      regulations governing limitations on product liability.

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS 
FILE AT ALL TIMES.

*************************************************************************

This readme file contains these sections:

1. REVISION HISTORY
2. OVERVIEW
3. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS
4. DESIGN FILE HIERARCHY
5. INSTALLATION AND OPERATING INSTRUCTIONS
6. OTHER INFORMATION (OPTIONAL)
7. SUPPORT


1. REVISION HISTORY 

            Readme  
Date        Version      Revision Description
=========================================================================
18NOV2013   1.0          Initial Xilinx release.
=========================================================================


2. OVERVIEW

This readme describes how to use the files that come with XAPP1183 

The Zynq-7000 family is based on the Xilinx All Programmable SoC (AP SoC) architecture.
These products integrate a feature-rich dual-core ARM Cortex-A9 MPCore based
processing system. The PS and Xilinx programmable logic (PL) are in a single device. The
ARM Cortex-A9 MPCore CPUs are the core of the PS, which also includes on-chip memory,
external memory interfaces, and a rich set of I/O peripherals.
The XADC is an integrated 12-bit, 17 channel, 1 Ms/s ADC. The Zynq-7000 PS communicates
with the XADC using an AXI interface when the XADC is instantiated in the PL. The XADC is a
hard block available in all Zynq-7000 AP SoCs.
The LogiCORE XADC wizard IP provides an AXI4-Lite compatible interface and an optional
AXI4-Stream interface. The AXI4-Lite interface is used to configure the XADC, and the
AXI4-Stream interface is used for data communication. The AXI4-Stream interface includes
options for interfacing the XADC data interface to other signal processing IP. This application
note demonstrates using the AXI4-Lite interface to control the XADC configuration parameters,
and using the AXI4-Stream interface to capture samples of the input analog data.
This application note provides a hardware design in the PL that establishes the datapath
between the XADC and the PS using the general-purpose (GP) port interface. An AXI DMA is
used to interface to the XADC AXI4-Stream interface, and the DMA stores the XADC samples
in the PS DDR3. The Cortex-A9 processor is used to configure the XADC for user-specific
configuration parameters.
A LabView based GUI interface is provided to configure the XADC and display the collected
samples. The samples are analyzed in the GUI to plot the linearity of the samples and various
performance characteristics of the XADC, including signal-to-noise ratio (SNR), total harmonic
distortion (THD), signal-to-noise and distortion (SINAD), and effective number of bits (ENOB).
The LabView GUI interfaces to the XADC with the UART interface.

3. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS

Software:
  -- Vivado Design Suite, version 2013.2
  -- ZC702 board uses CP210x USB to UART Bridge to provide COM port
     connection to the board. This configuration is highly recommended because
     the UART outputs information to hyper terminal right after power up.
     To use this feature, hyper terminal, Minicom, teraterm or equivalent
     terminal software on the host machine is required. 
  -- For additional information on software installation, refer to UG798 (v14.5)
  -- Host machine OS (Linux / Windows) with USB and Ethernet port support
        - Also see UG798 for details installation requirement.
  -- LabView RTE 2011 and AMS101 Evaluator GUI
  

Hardware:
  -- ZC702 evaluation board setup in the default configuration as documented
     in the Default Switch and Jumper Setting of UG850.
  -- AC power adapter (12VDC)
  -- USB Type A Male to USB Mini-B Male cable if using USB-to-UART
     bridge
  -- SD memory card reader for transferring files onto the SD card.
     (not included in the package)
  -- Host Machine with USB and ethernet port
  -- Ethernet cable with RJ45 connector.


4. DESIGN FILE HIERARCHY

The directory structure underneath this top-level folder is described
below:

|-- doc/
|   |-- README.txt                  #  This file
|
|
|---ready_to_test/
|   |   |-- BOOT.bin                # Zynq Boot Image, which is created from
|   |   |                             FSBL and u-boot
|   |   |-- devicetree.dtb          # Linux device tree binary, loaded into
|   |   |                             memory by u-boot (default is 1080p resolution)
|   |   |-- init.sh                 # Script to set up environment, sourced at the
|   |   |                             end of the boot process
|   |   |-- uramdisk.image.gz       # Ramdisk image, loaded into memory by u-boot
|   |   |-- uImage                  # Linux kernel image, loaded into memory by
|   |   |                             u-boot
|   |   |-- axi_xadc_app            # AXI XADC Data Acquisition app binary 
|   |   |-- axi_xadc_dma.ko         # Pre-compiled Kernel module
|                               
|-- hardware
|   |-- sources                     # 
|   |-- vivado                      #
|
|-- software
|   |
|   |-- devicetree
|   |   |-- zynq-zc702-xadc-dma.dts # devicetree with AXI XADC and DMA nodes
|   |   
|   |-- app                         # AXI XADC user application project
|   |
|   |-- driver                      # kernel module for DMA,XADC configuration
|   |
|   |-- workspace                   # SDK workspace for importing and build

5. INSTALLATION AND OPERATING INSTRUCTIONS 

ZC702 Initial Setup:
--------------------

-- All jumpers and switches should be in default setting except SW16.
   Mode switch SW16 should be set to boot from SD card.
   Use the following switch settings:
   SW16.1: OFF
   SW16.2: OFF
   SW16.3: ON
   SW16.4: ON
   SW16.5: OFF
-- connect the AC power adapter
-- If USB-to-UART bridge is used, connect USB Mini-B side of USB-to-
   Mini-B cable to the on-board mini USB connector (J17). Connect USB side to
   the control PC.
-- Connect an external sinusoidal source to the AMS101 Evaluator card
-- Connect the AMS101 Evaluator card to the ZC702 board's XADC Header
-- Open the AMS101 Evaluator GUI, select COM port and click on Connect.
-- Select Unipolar mode in the AMS101 Evaluator GUI design
-- Click on Collect Data button to connect samples from XADC
-- The Frequency Domain shows the spectrum of the collected samples
-- Select 4 Term B-Harris window in the Frequency Domain tab

6. OTHER INFORMATION (OPTIONAL) 

Refer to the wiki.xilinx.com for build instructions of the design
Refer to 7 Series AMS Targeted Reference Design User Guide (UG960) for Information
on board setup 

7. SUPPORT

To obtain technical support for this reference design, go to 
www.xilinx.com/support to locate answers to known issues in the Xilinx
Answers Database or to create a WebCase.  
