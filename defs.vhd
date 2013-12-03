-----------------------------------------------------------------------
-- pifdefs.vhd    Bugblat pif definitions
--
-- Initial entry: 05-Jan-12 te
-- Copyright (c) 2001 to 2013  te

-- with additions and deletions111!!
--
-----------------------------------------------------------------------
library ieee;               use ieee.std_logic_1164.all;
                            use ieee.numeric_std.all;

package defs is

  -- save lots of typing
  subtype slv	is std_logic;
  subtype slv2  is std_logic_vector( 1 downto 0);
  subtype slv3  is std_logic_vector( 2 downto 0);
  subtype slv4  is std_logic_vector( 3 downto 0);
  subtype slv5  is std_logic_vector( 4 downto 0);
  subtype slv6  is std_logic_vector( 5 downto 0);
  subtype slv7  is std_logic_vector( 6 downto 0);
  subtype slv8  is std_logic_vector( 7 downto 0);
  subtype slv16 is std_logic_vector(15 downto 0);
  subtype slv32 is std_logic_vector(31 downto 0);

  -------------------------------------------------------------
 
  -------------------------------------------------------------
  -- intercept calls to conv_integer and to_integer
  function ToInteger(arg: std_logic_vector) return integer;
  function ToInteger(arg:         unsigned) return integer;
  function ToInteger(arg:           signed) return integer;

  -- convert boolean to std_logic ( t->1, f->0 )
  function to_sl(b: boolean) return std_logic;

  -- convert to std_logic vector
  function n2slv   (n,l: natural ) return std_logic_vector;

end package defs;

--=============================================================
package body defs is
  -------------------------------------------------------------
  -- put the to_integer/conv_integer resolution in one place
  function ToInteger(arg: unsigned) return integer is
    variable x: unsigned(arg'range);
    variable n: integer;
  begin
    x := arg;
    -- synthesis translate_off
    for i in x'range loop
      if x(i)/='1' then       -- resolve the 'undefined' signals
        x(i) := '0';
      end if;
    end loop;
    -- synthesis translate_on
    n := to_integer(x);
    return n;
  end;
  -------------------------------------------------------------
  function ToInteger(arg: signed) return integer is
    variable x: signed(arg'range);
    variable n: integer;
  begin
    x := arg;
    -- synthesis translate_off
    for i in x'range loop
      if x(i)/='1' then
        x(i) := '0';
      end if;
    end loop;
    -- synthesis translate_on
    n := to_integer(x);
    return n;
  end;
  -------------------------------------------------------------
  function ToInteger(arg: std_logic_vector) return integer is
    variable x: unsigned(arg'range);
    variable n: integer;
  begin
    x := unsigned(arg);
    -- synthesis translate_off
    for i in x'range loop
      if x(i)/='1' then       -- resolve the 'undefined' signals
        x(i) := '0';
      end if;
    end loop;
    -- synthesis translate_on
    n := to_integer(x);
    return n;
  end;
  -------------------------------------------------------------
  function ToInteger(arg: std_ulogic_vector) return integer is
    variable x: std_logic_vector(arg'range);
  begin
    x := std_logic_vector(arg);
    return ToInteger(x);
  end;
  -------------------------------------------------------------
  function to_sl(b: boolean) return std_logic is
    variable s: std_logic;
  begin
    if b then s :='1'; else s :='0'; end if;
    return s;
  end to_sl;
  -------------------------------------------------------------
  function n2slv ( N,L: natural ) return std_logic_vector is
    variable vec: std_logic_vector(L-1 downto 0);
    variable Nx : natural;
  begin
    Nx := N rem 2**L;
    vec := std_logic_vector(to_unsigned(Nx,L));
    return vec;
  end;

end package body defs;

-- EOF pifdefs.vhd --------------------------------------------