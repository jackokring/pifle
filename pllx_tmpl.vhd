-- VHDL module instantiation generated by SCUBA Diamond_2.2_Production (99)
-- Module  Version: 5.4
-- Tue Dec  3 23:30:27 2013

-- parameterized module component declaration
component pllx
    port (CLKI: in  std_logic; PLLCLK: in  std_logic; 
        PLLRST: in  std_logic; PLLSTB: in  std_logic; 
        PLLWE: in  std_logic; PLLDATI: in  std_logic_vector(7 downto 0); 
        PLLADDR: in  std_logic_vector(4 downto 0); CLKOP: out  std_logic; 
        LOCK: out  std_logic; PLLDATO: out  std_logic_vector(7 downto 0); 
        PLLACK: out  std_logic);
end component;

-- parameterized module component instance
__ : pllx
    port map (CLKI=>__, PLLCLK=>__, PLLRST=>__, PLLSTB=>__, PLLWE=>__, 
        PLLDATI(7 downto 0)=>__, PLLADDR(4 downto 0)=>__, CLKOP=>__, 
        LOCK=>__, PLLDATO(7 downto 0)=>__, PLLACK=>__);
