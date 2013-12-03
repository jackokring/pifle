-- pifle main project file

library IEEE;       use IEEE.std_logic_1164.all;
library work;       use work.defs.all;
library machxo2;    use machxo2.components.all;

entity pifle is
   port (
   -- top bank
    LEDR: out slv;
    LEDG: out slv;
    SDA: inout slv;
    SCL: inout slv;
    PiCLK: in slv;

	-- right bank
    R0: ;
    R1: ;
    R2: ;
    R3: ;
    R4: ;
    R5: ;
    R6: ;
    R7: ;
    R8: ;
    R9: ;

	-- bottom bank
    B0: out slv;
    B1: out slv;
    B2: out slv;
    B3: out slv;
    B4: out slv;
    B5: out slv;
    B6: out slv;

	-- left bank
    CE1: in slv;
    XCE1: out slv;
    XCE0: out slv;
    GPIO25: inout slv;
    XIO25: inout slv;
    GPIO24: inout slv;
    XIO24: inout slv;
    GPIO23: inout slv;
    XIO23: inout slv;
    GPIO22: inout slv;
    GPIO27: inout slv;
    XIO22: inout slv;
    XIO27: inout slv;
    GPIO18: inout slv;
    XIO18: inout slv;
    GPIO17: inout slv;
    XIO17: inout slv;
    GPIO15: inout slv;
    XIO15: inout slv;
    GPIO14: inout slv;
    XIO14: inout slv;
    XCLK: out slv
);
end pifle;

architecture rtl of pifle is
  
  component efb is
    port (
        wb_clk_i: in  std_logic; 
        wb_rst_i: in  std_logic; 
        wb_cyc_i: in  std_logic; 
        wb_stb_i: in  std_logic; 
        wb_we_i: in  std_logic; 
        wb_adr_i: in  std_logic_vector(7 downto 0); 
        wb_dat_i: in  std_logic_vector(7 downto 0); 
        wb_dat_o: out  std_logic_vector(7 downto 0); 
        wb_ack_o: out  std_logic; 
        i2c1_scl: inout  std_logic; 
        i2c1_sda: inout  std_logic; 
        i2c1_irqo: out  std_logic; 
        i2c2_scl: inout  std_logic; 
        i2c2_sda: inout  std_logic; 
        i2c2_irqo: out  std_logic; 
        spi_clk: inout  std_logic; 
        spi_miso: inout  std_logic; 
        spi_mosi: inout  std_logic; 
        spi_scsn: in  std_logic; 
        spi_irq: out  std_logic; 
        tc_clki: in  std_logic; 
        tc_rstn: in  std_logic; 
        tc_ic: in  std_logic; 
        tc_int: out  std_logic; 
        tc_oc: out  std_logic; 
        pll0_bus_i: in  std_logic_vector(8 downto 0); 
        pll0_bus_o: out  std_logic_vector(16 downto 0); 
        pll1_bus_i: in  std_logic_vector(8 downto 0); 
        pll1_bus_o: out  std_logic_vector(16 downto 0); 
        ufm_sn: in  std_logic; 
        wbc_ufm_irq: out  std_logic; 
        cfg_wake: out  std_logic; 
        cfg_stdby: out  std_logic);
  end component efb;

  signal  GSRnX       : std_logic;

  -- attach a pullup to the GSRn signal
  attribute pullmode  : string;
  attribute pullmode of GSRnX   : signal is "UP";   -- else floats

begin
  -- global reset
  IBgsr   : IB  port map ( I=>GSRn, O=>GSRnX );
  GSR_GSR : GSR port map ( GSR=>GSRnX );

  FEATURE: efb port map ( 
        wb_clk_i => ,
        wb_rst_i => , 
        wb_cyc_i => , 
        wb_stb_i => , 
        wb_we_i => , 
        wb_adr_i => , 
        wb_dat_i => , 
        wb_dat_o => , 
        wb_ack_o => , 
        i2c1_scl => , 
        i2c1_sda => , 
        i2c1_irqo => , 
        i2c2_scl => , 
        i2c2_sda => , 
        i2c2_irqo => , 
        spi_clk => , 
        spi_miso => , 
        spi_mosi => , 
        spi_scsn => , 
        spi_irq => , 
        tc_clki => , 
        tc_rstn => , 
        tc_ic => , 
        tc_int => , 
        tc_oc => , 
        pll0_bus_i => , 
        pll0_bus_o => , 
        pll1_bus_i => , 
        pll1_bus_o => , 
        ufm_sn => , 
        wbc_ufm_irq => , 
        cfg_wake => , 
        cfg_stdby => 
);

--

end rtl;
