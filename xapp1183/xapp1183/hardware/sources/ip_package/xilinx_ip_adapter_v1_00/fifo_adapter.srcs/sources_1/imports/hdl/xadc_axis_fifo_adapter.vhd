--
-- ************************************************************************
-- ** DISCLAIMER OF LIABILITY                                            **
-- **                                                                    **
-- ** This file contains proprietary and confidential information of     **
-- ** Xilinx, Inc. ("Xilinx"), that is distributed under a license       **
-- ** from Xilinx, and may be used, copied and/or disclosed only         **
-- ** pursuant to the terms of a valid license agreement with Xilinx.    **
-- **                                                                    **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION              **
-- ** ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER         **
-- ** EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT                **
-- ** LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,          **
-- ** MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx      **
-- ** does not warrant that functions included in the Materials will     **
-- ** meet the requirements of Licensee, or that the operation of the    **
-- ** Materials will be uninterrupted or error-free, or that defects     **
-- ** in the Materials will be corrected. Furthermore, Xilinx does       **
-- ** not warrant or make any representations regarding use, or the      **
-- ** results of the use, of the Materials in terms of correctness,      **
-- ** accuracy, reliability or otherwise.                                **
-- **                                                                    **
-- ** Xilinx products are not designed or intended to be fail-safe,      **
-- ** or for use in any application requiring fail-safe performance,     **
-- ** such as life-support or safety devices or systems, Class III       **
-- ** medical devices, nuclear facilities, applications related to       **
-- ** the deployment of airbags, or any other applications that could    **
-- ** lead to death, personal injury or severe property or               **
-- ** environmental damage (individually and collectively, "critical     **
-- ** applications"). Customer assumes the sole risk and liability       **
-- ** of any use of Xilinx products in critical applications,            **
-- ** subject only to applicable laws and regulations governing          **
-- ** limitations on product liability.                                  **
-- **                                                                    **
-- ** Copyright 2010, 2011 Xilinx, Inc.                                  **
-- ** All rights reserved.                                               **
-- **                                                                    **
-- ** This disclaimer and copyright notice must be retained as part      **
-- ** of this file at all times.                                         **
-- ************************************************************************
--

-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;

use ieee.std_logic_arith.all;

library proc_common_v3_00_a;
use proc_common_v3_00_a.proc_common_pkg.all;
use proc_common_v3_00_a.ipif_pkg.all;

library axi_lite_ipif_v1_01_a;
use axi_lite_ipif_v1_01_a.axi_lite_ipif;

entity xadc_axis_fifo_adapter is
  generic
    (
      -- ADD USER GENERICS BELOW THIS LINE ---------------
      --USER generics added here
      -- ADD USER GENERICS ABOVE THIS LINE ---------------

      -- DO NOT EDIT BELOW THIS LINE ---------------------
      -- Bus protocol parameters, do not add to or delete
      C_S_AXI_DATA_WIDTH : integer          := 32;
      C_S_AXI_ADDR_WIDTH : integer          := 32;
      C_S_AXI_MIN_SIZE   : std_logic_vector := X"000001FF";
      C_USE_WSTRB        : integer          := 0;
      C_DPHASE_TIMEOUT   : integer          := 8;
      C_BASEADDR         : std_logic_vector := X"FFFFFFFF";
      C_HIGHADDR         : std_logic_vector := X"00000000";
      C_FAMILY           : string           := "zynq";
      C_NUM_REG          : integer          := 1;
      C_NUM_MEM          : integer          := 1;
      C_SLV_AWIDTH       : integer          := 32;
      C_SLV_DWIDTH       : integer          := 32
      -- DO NOT EDIT ABOVE THIS LINE ---------------------
      );

  port (
    -- General signals
    S_AXIS_ACLK  : in std_logic;             
    M_AXIS_ACLK  : in std_logic;             
    AXIS_RESET_N : in std_logic;             


    -- AXI-Steam Slave
    S_AXIS_TREADY : out std_logic;
    S_AXIS_TDATA  : in  std_logic_vector(15 downto 0);
    S_AXIS_TID    : in  std_logic_vector(4 downto 0);
    S_AXIS_TVALID : in  std_logic;

    -- AXI-Steam Master
    M_AXIS_TREADY : in   std_logic;
    M_AXIS_TDATA  : out  std_logic_vector(15 downto 0);
    M_AXIS_TID    : out  std_logic_vector(4 downto 0);
    M_AXIS_TVALID : out  std_logic;
    M_AXIS_TLAST  : out  std_logic;

    INTR_OUT      : out  std_logic;

      -- DO NOT EDIT BELOW THIS LINE ---------------------
      -- Bus protocol ports, do not add to or delete
    S_AXI_ACLK    : in  std_logic;
    S_AXI_ARESETN : in  std_logic;
    S_AXI_AWADDR  : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_AWVALID : in  std_logic;
    S_AXI_WDATA   : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_WSTRB   : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
    S_AXI_WVALID  : in  std_logic;
    S_AXI_BREADY  : in  std_logic;
    S_AXI_ARADDR  : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_ARVALID : in  std_logic;
    S_AXI_RREADY  : in  std_logic;
    S_AXI_ARREADY : out std_logic;
    S_AXI_RDATA   : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_RRESP   : out std_logic_vector(1 downto 0);
    S_AXI_RVALID  : out std_logic;
    S_AXI_WREADY  : out std_logic;
    S_AXI_BRESP   : out std_logic_vector(1 downto 0);
    S_AXI_BVALID  : out std_logic;
    S_AXI_AWREADY : out std_logic
      -- DO NOT EDIT ABOVE THIS LINE ---------------------

);
end entity xadc_axis_fifo_adapter;

architecture rtl of xadc_axis_fifo_adapter is

  constant USER_SLV_DWIDTH : integer := C_S_AXI_DATA_WIDTH;

  constant IPIF_SLV_DWIDTH : integer := C_S_AXI_DATA_WIDTH;

  constant ZERO_ADDR_PAD     : std_logic_vector(0 to 31) := (others => '0');
  constant USER_SLV_BASEADDR : std_logic_vector          := C_BASEADDR;
  constant USER_SLV_HIGHADDR : std_logic_vector          := C_HIGHADDR;

  constant IPIF_ARD_ADDR_RANGE_ARRAY : SLV64_ARRAY_TYPE :=
    (
      ZERO_ADDR_PAD & USER_SLV_BASEADDR,  -- user logic slave space base address
      ZERO_ADDR_PAD & USER_SLV_HIGHADDR  -- user logic slave space high address
      );

  constant USER_SLV_NUM_REG : integer := 2;
  constant USER_NUM_REG     : integer := USER_SLV_NUM_REG;
  constant TOTAL_IPIF_CE    : integer := USER_NUM_REG;

  constant IPIF_ARD_NUM_CE_ARRAY : INTEGER_ARRAY_TYPE :=
    (
      0 => (USER_SLV_NUM_REG)  -- number of ce for user logic slave space
      );

  ------------------------------------------
  -- Index for CS/CE
  ------------------------------------------
  constant USER_SLV_CS_INDEX : integer := 0;
  constant USER_SLV_CE_INDEX : integer := calc_start_ce_index(IPIF_ARD_NUM_CE_ARRAY, USER_SLV_CS_INDEX);

  constant USER_CE_INDEX : integer := USER_SLV_CE_INDEX;

  -----------------------------------------------------------------------------
  -- SIGNALS
  -----------------------------------------------------------------------------
  signal rst                 : std_logic;
  signal tlast_coalesced_gen : std_logic;
  signal m_axis_tlast_gen : std_logic;
  signal fifo_full_status : std_logic;
  signal fifo_full_status_r : std_logic;
  signal fifo_status : std_logic;
  -----------------------------------------------------------------------------
  -- REGISTERS
  -----------------------------------------------------------------------------
  signal tvalid_count_r : integer range 0 to 32767:=0;
  signal tvalid_coalesce_count : integer range 0 to 32767:=4096;
  signal tvalid_coalesce_count_r : integer range 0 to 32767:=4096;
  ------------------------------------------
  -- IP Interconnect (IPIC) signal declarations
  ------------------------------------------
  signal Bus2IP_Clk    : std_logic;
  signal Bus2IP_Resetn : std_logic;
  signal Bus2IP_Addr   : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
  signal Bus2IP_RNW    : std_logic;
  signal Bus2IP_BE     : std_logic_vector(IPIF_SLV_DWIDTH/8-1 downto 0);
  signal Bus2IP_CS     : std_logic_vector((IPIF_ARD_ADDR_RANGE_ARRAY'length)/2-1 downto 0);
  signal Bus2IP_RdCE   : std_logic_vector(calc_num_ce(IPIF_ARD_NUM_CE_ARRAY)-1 downto 0);
  signal Bus2IP_WrCE   : std_logic_vector(calc_num_ce(IPIF_ARD_NUM_CE_ARRAY)-1 downto 0);
  signal Bus2IP_Data   : std_logic_vector(IPIF_SLV_DWIDTH-1 downto 0);
  signal IP2Bus_WrAck  : std_logic;
  signal IP2Bus_RdAck  : std_logic;
  signal IP2Bus_Error  : std_logic;
  signal IP2Bus_Data   : std_logic_vector(IPIF_SLV_DWIDTH-1 downto 0);

  ------------------------------------------
  -- Signals for user logic slave model s/w accessible register example
  ------------------------------------------
  signal slv_reg0          : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg1          : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg_write_sel : std_logic_vector(1 downto 0);
  signal slv_reg_read_sel  : std_logic_vector(1 downto 0);
  signal slv_ip2bus_data   : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_read_ack      : std_logic;
  signal slv_write_ack     : std_logic;
  signal valid_cycle     : std_logic;

begin  


  AXI_LITE_IPIF_I : entity axi_lite_ipif_v1_01_a.axi_lite_ipif
    generic map
    (
      C_S_AXI_DATA_WIDTH     => IPIF_SLV_DWIDTH,
      C_S_AXI_ADDR_WIDTH     => C_S_AXI_ADDR_WIDTH,
      C_S_AXI_MIN_SIZE       => C_S_AXI_MIN_SIZE,
      C_USE_WSTRB            => C_USE_WSTRB,
      C_DPHASE_TIMEOUT       => C_DPHASE_TIMEOUT,
      C_ARD_ADDR_RANGE_ARRAY => IPIF_ARD_ADDR_RANGE_ARRAY,
      C_ARD_NUM_CE_ARRAY     => IPIF_ARD_NUM_CE_ARRAY,
      C_FAMILY               => C_FAMILY
      )
    port map
    (
      S_AXI_ACLK    => S_AXI_ACLK,
      S_AXI_ARESETN => S_AXI_ARESETN,
      S_AXI_AWADDR  => S_AXI_AWADDR,
      S_AXI_AWVALID => S_AXI_AWVALID,
      S_AXI_WDATA   => S_AXI_WDATA,
      S_AXI_WSTRB   => S_AXI_WSTRB,
      S_AXI_WVALID  => S_AXI_WVALID,
      S_AXI_BREADY  => S_AXI_BREADY,
      S_AXI_ARADDR  => S_AXI_ARADDR,
      S_AXI_ARVALID => S_AXI_ARVALID,
      S_AXI_RREADY  => S_AXI_RREADY,
      S_AXI_ARREADY => S_AXI_ARREADY,
      S_AXI_RDATA   => S_AXI_RDATA,
      S_AXI_RRESP   => S_AXI_RRESP,
      S_AXI_RVALID  => S_AXI_RVALID,
      S_AXI_WREADY  => S_AXI_WREADY,
      S_AXI_BRESP   => S_AXI_BRESP,
      S_AXI_BVALID  => S_AXI_BVALID,
      S_AXI_AWREADY => S_AXI_AWREADY,
      Bus2IP_Clk    => Bus2IP_Clk,
      Bus2IP_Resetn => Bus2IP_Resetn,
      Bus2IP_Addr   => Bus2IP_Addr,
      Bus2IP_RNW    => Bus2IP_RNW,
      Bus2IP_BE     => Bus2IP_BE,
      Bus2IP_CS     => Bus2IP_CS,
      Bus2IP_RdCE   => Bus2IP_RdCE,
      Bus2IP_WrCE   => Bus2IP_WrCE,
      Bus2IP_Data   => Bus2IP_Data,
      IP2Bus_WrAck  => IP2Bus_WrAck,
      IP2Bus_RdAck  => IP2Bus_RdAck,
      IP2Bus_Error  => IP2Bus_Error,
      IP2Bus_Data   => IP2Bus_Data
      );


  --USER logic implementation added here

  ------------------------------------------
  -- Example code to read/write user logic slave model s/w accessible registers
  -- 
  -- Note:
  -- The example code presented here is to show you one way of reading/writing
  -- software accessible registers implemented in the user logic slave model.
  -- Each bit of the Bus2IP_WrCE/Bus2IP_RdCE signals is configured to correspond
  -- to one software accessible register by the top level template. For example,
  -- if you have four 32 bit software accessible registers in the user logic,
  -- you are basically operating on the following memory mapped registers:
  -- 
  --    Bus2IP_WrCE/Bus2IP_RdCE   Memory Mapped Register
  --                     "1000"   C_BASEADDR + 0x0
  --                     "0100"   C_BASEADDR + 0x4
  --                     "0010"   C_BASEADDR + 0x8
  --                     "0001"   C_BASEADDR + 0xC
  -- 
  ------------------------------------------
  slv_reg_write_sel <= Bus2IP_WrCE(1 downto 0);
  slv_reg_read_sel  <= Bus2IP_RdCE(1 downto 0);
  slv_write_ack     <= Bus2IP_WrCE(0) or Bus2IP_WrCE(1);
  slv_read_ack      <= Bus2IP_RdCE(0) or Bus2IP_RdCE(1);

  -- implement slave model software accessible register(s)
  SLAVE_REG_WRITE_PROC : process(Bus2IP_Clk) is
  begin

    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
      if Bus2IP_Resetn = '0' then
        slv_reg0 <= (others => '0');
        slv_reg1 <= (others => '0');
      else
        case slv_reg_write_sel is
          when "10" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if (Bus2IP_BE(byte_index) = '1') then
                slv_reg0(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "01" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if (Bus2IP_BE(byte_index) = '1') then
                slv_reg1(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when others => null;
        end case;
      end if;
    end if;

  end process SLAVE_REG_WRITE_PROC;

  -- implement slave model software accessible register(s) read mux
  SLAVE_REG_READ_PROC : process(slv_reg_read_sel, slv_reg0, slv_reg1) is
  begin

    case slv_reg_read_sel is
      when "10" => slv_ip2bus_data <= slv_reg0;
      when "01" => slv_ip2bus_data <= slv_reg1(31 downto 1) & fifo_status;
      when others => slv_ip2bus_data <= (others => '0');
    end case;

  end process SLAVE_REG_READ_PROC;

  ------------------------------------------
  -- Example code to drive IP to Bus signals
  ------------------------------------------
  IP2Bus_Data <= slv_ip2bus_data when slv_read_ack = '1' else
                 (others => '0');

  IP2Bus_WrAck <= slv_write_ack;
  IP2Bus_RdAck <= slv_read_ack;
  IP2Bus_Error <= '0';

  process (S_AXIS_ACLK) is
  begin  
    if rising_edge(S_AXIS_ACLK) then
      tvalid_coalesce_count_r <=  conv_integer(unsigned(slv_reg0(15 downto 0)));
      tvalid_coalesce_count   <=  tvalid_coalesce_count_r;
    end if;  
  end process;

  process (Bus2IP_Clk) is
  begin  
    if rising_edge(Bus2IP_Clk) then
      fifo_full_status_r <=  fifo_full_status;
      fifo_status        <=  fifo_full_status_r;
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- General signals
  -----------------------------------------------------------------------------
  rst <= not AXIS_RESET_N;

  m_axis_tlast_gen  <=  tlast_coalesced_gen and valid_cycle;
  S_AXIS_TREADY <=  M_AXIS_TREADY;
  M_AXIS_TVALID <= S_AXIS_TVALID ;
  M_AXIS_TID <= S_AXIS_TID;
  M_AXIS_TDATA <= S_AXIS_TDATA ;
  valid_cycle <=  S_AXIS_TVALID and M_AXIS_TREADY;
  M_AXIS_TLAST <= m_axis_tlast_gen;

  process (S_AXIS_ACLK) is
  begin  
    if rising_edge(S_AXIS_ACLK) then        -- rising clock edge
      if rst = '1' then                     -- synchronous reset (active high)
        tvalid_count_r <= 0;
      elsif m_axis_tlast_gen = '1' then
        tvalid_count_r <= 0;
      elsif valid_cycle='1' then
        tvalid_count_r <= tvalid_count_r +1;
      end if;
    end if; 
  end process;

  process (S_AXIS_ACLK) is
  begin  
    if rising_edge(S_AXIS_ACLK) then
     if( Bus2IP_Resetn = '0') then
       fifo_full_status <= '0';
     elsif(M_AXIS_TREADY='0') then
       fifo_full_status <= '1';
     end if;
    end if;
  end process;
  
  tlast_coalesced_gen  <= '1' when tvalid_count_r = tvalid_coalesce_count-1 else '0';
  
  INTR_OUT             <= tlast_coalesced_gen;

end architecture rtl;

