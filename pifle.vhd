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
    GPIO4: in slv;

	-- right bank
    ZIO4: inout slv;
    ZIO17: inout slv;
    ZIO18: inout slv;
    ZIO21: inout slv;
    ZIO22: inout slv;
    ZIO23: inout slv;
    ZIO24: inout slv;
    ZIO25: inout slv;
    ZIOA: inout slv;
    ZIOB: inout slv;

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
    XIO4: inout slv;
	
	-- reset 
	GSRn: in slv;
	
	-- spi
	SCLK: inout slv;
    MISO: inout slv;
    CE0_FSn: inout slv;
    MOSI: inout slv
);
end pifle;

architecture rtl of pifle is
  
  component efbx is
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
  end component efbx;
  
  component pllx is
	port (
        CLKI: in  std_logic; 
        PLLCLK: in  std_logic; 
        PLLRST: in  std_logic; 
        PLLSTB: in  std_logic; 
        PLLWE: in  std_logic; 
        PLLDATI: in  std_logic_vector(7 downto 0); 
        PLLADDR: in  std_logic_vector(4 downto 0); 
        CLKOP: out  std_logic; 
        LOCK: out  std_logic; 
        PLLDATO: out  std_logic_vector(7 downto 0); 
        PLLACK: out  std_logic);
	end component pllx;
	
	COMPONENT OSCH
	-- synthesis translate_off
	GENERIC (NOM_FREQ: string := "2.56");
	-- synthesis translate_on
	PORT (
	STDBY :IN
	std_logic;
	OSC :OUT std_logic;
	SEDSTDBY :OUT std_logic);
	END COMPONENT;
	attribute NOM_FREQ : string;
	attribute NOM_FREQ of OSCM : label is "2.56";


  signal  GSRnX       : std_logic;
  signal	MCLK		:slv;
  signal	XCLK		:slv;

  -- attach a pullup to the GSRn signal
  attribute pullmode  : string;
  attribute pullmode of GSRnX   : signal is "UP";   -- else floats

begin
  -- global reset
  IBgsr   : IB  port map ( I=>GSRn, O=>GSRnX );
  GSR_GSR : GSR port map ( GSR=>GSRnX );
  
  OSCM: OSCH
	-- synthesis translate_off	
	GENERIC MAP ( NOM_FREQ => "2.56" )	
	-- synthesis translate_on
	PORT MAP (
	STDBY=> '0',
	OSC=> MCLK,
	SEDSTDBY=> open
	);

  
  OSCAR: pllx port map (
        CLKI => MCLK, 
        -- PLLCLK => , 
        -- PLLRST => , 
        -- PLLSTB => , 
        -- PLLWE => , 
        -- PLLDATI => , 
        -- PLLADDR => , 
        CLKOP => XCLK --, 
        -- LOCK => , 
        -- PLLDATO => , 
        -- PLLACK => 
	);

  FEATURE: efbx port map ( 
        wb_clk_i => '0',
        wb_rst_i => '0', 
        wb_cyc_i => '0', 
        wb_stb_i => '0', 
        wb_we_i => '0', 
        wb_adr_i => "00000000", 
        wb_dat_i => "00000000", 
        -- wb_dat_o => , 
        -- wb_ack_o => , 
        i2c1_scl => SCL, 
        i2c1_sda => SDA, 
        -- i2c1_irqo => , 
        -- i2c2_scl => , 
        -- i2c2_sda => , 
        -- i2c2_irqo => , 
        spi_clk => SCLK, 
        spi_miso => MISO, 
        spi_mosi => MOSI, 
        spi_scsn => CE0_FSn, 
        -- spi_irq => , 
        tc_clki => '0', 
        tc_rstn => '1', 
        tc_ic => '0', 
        -- tc_int => , 
        -- tc_oc => , 
        pll0_bus_i => "000000000", 
        -- pll0_bus_o => , 
        pll1_bus_i => "000000000", 
        -- pll1_bus_o => , 
        ufm_sn => '1' --, 
        -- wbc_ufm_irq => , 
        -- cfg_wake => , 
        -- cfg_stdby => 
	);

--

end rtl;
