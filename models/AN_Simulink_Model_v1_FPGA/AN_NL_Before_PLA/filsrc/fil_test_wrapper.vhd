
-- ----------------------------------------------
-- File Name: fil_test_wrapper.vhd
-- Created:   10-Apr-2020 10:56:33
-- Copyright  2020 MathWorks, Inc.
-- ----------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;


ENTITY fil_test_wrapper IS 
PORT (
      clk                             : IN  std_logic;
      enb                             : IN  std_logic;
      reset                           : IN  std_logic;
      din                             : IN  std_logic_vector(7 DOWNTO 0);
      dout                            : OUT std_logic_vector(7 DOWNTO 0)
);
END fil_test_wrapper;

ARCHITECTURE rtl of fil_test_wrapper IS

COMPONENT fil_test IS 
PORT (
      datain                          : IN  std_logic_vector(7 DOWNTO 0);
      reset                           : IN  std_logic;
      clk                             : IN  std_logic;
      clk_en                          : IN  std_logic;
      dataout                         : OUT std_logic_vector(7 DOWNTO 0)
);
END COMPONENT;

  SIGNAL dut_reset                        : std_logic; -- boolean
  SIGNAL datain                           : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL datain_tmp                       : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL dataout                          : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL dataout_tmp                      : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL tmpconcat                        : std_logic_vector(7 DOWNTO 0); -- std8

BEGIN

u_fil_test: fil_test 
PORT MAP(
        datain               => datain,
        reset                => dut_reset,
        clk                  => clk,
        dataout              => dataout,
        clk_en               => enb
);

dut_reset <= reset;

datain <= datain_tmp;
datain_tmp <= din(7 DOWNTO 0);
dataout_tmp <= dataout;
dataout_tmp <= dataout;
dout <= dataout_tmp;

END;