-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\wickh\Documents\NIH\simulink_models\models\fft_filters\hdlsrc\fft_filters\fft_filters_Gains_ROM_real_block5.vhd
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: fft_filters_Gains_ROM_real_block5
-- Source Path: fft_filters/dataplane/FFT_Analysis_Synthesis_Right/Frequency_Domain_Processing/Apply_Complex_Gains/FFT_Filter_Coefficients/Filter_ROM_Choice/Complex_Gains_3_ROM/Gains_ROM_real
-- Hierarchy Level: 7
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.fft_filters_dataplane_pkg.ALL;

ENTITY fft_filters_Gains_ROM_real_block5 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_16_1                        :   IN    std_logic;
        Index                             :   IN    std_logic_vector(6 DOWNTO 0);  -- ufix7
        gain_value_real                   :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
        );
END fft_filters_Gains_ROM_real_block5;


ARCHITECTURE rtl OF fft_filters_Gains_ROM_real_block5 IS

  ATTRIBUTE multstyle : string;

  -- Constants
  CONSTANT Lookup_Table_table_data        : vector_of_signed24(0 TO 63) := 
    (to_signed(16#000000#, 24), to_signed(16#000000#, 24), to_signed(16#000000#, 24), to_signed(16#000000#, 24),
     to_signed(16#000000#, 24), to_signed(16#000000#, 24), to_signed(16#000000#, 24), to_signed(16#000000#, 24),
     to_signed(16#000000#, 24), to_signed(16#000000#, 24), to_signed(16#000000#, 24), to_signed(16#000000#, 24),
     to_signed(16#000000#, 24), to_signed(16#000000#, 24), to_signed(16#000000#, 24), to_signed(16#000000#, 24),
     to_signed(16#000000#, 24), to_signed(16#000000#, 24), to_signed(16#000000#, 24), to_signed(16#000000#, 24),
     to_signed(16#000000#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24),
     to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24),
     to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24),
     to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24),
     to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24),
     to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24),
     to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24),
     to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24),
     to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24),
     to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24),
     to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24), to_signed(16#7FFFFF#, 24));  -- sfix24 [64]

  -- Signals
  SIGNAL Index_1                          : unsigned(6 DOWNTO 0);  -- ufix7
  SIGNAL Lookup_Table_k                   : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Lookup_Table_out1                : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL Lookup_Table_out1_1              : signed(23 DOWNTO 0) := to_signed(16#000000#, 24);  -- sfix24_En23
  SIGNAL Unit_Delay_bypass_reg            : signed(23 DOWNTO 0);  -- sfix24
  SIGNAL Lookup_Table_out1_2              : signed(23 DOWNTO 0);  -- sfix24_En23

BEGIN
  Index_1 <= unsigned(Index);

  
  Lookup_Table_k <= to_unsigned(16#00#, 6) WHEN Index_1 = to_unsigned(16#00#, 7) ELSE
      to_unsigned(16#3F#, 6) WHEN Index_1 >= to_unsigned(16#3F#, 7) ELSE
      Index_1(5 DOWNTO 0);
  Lookup_Table_out1 <= Lookup_Table_table_data(to_integer(Lookup_Table_k));

  PipelineRegister_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF enb = '1' THEN
        Lookup_Table_out1_1 <= Lookup_Table_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Unit_Delay_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay_bypass_reg <= to_signed(16#000000#, 24);
    ELSIF rising_edge(clk) THEN
      IF enb_1_16_1 = '1' THEN
        Unit_Delay_bypass_reg <= Lookup_Table_out1_1;
      END IF;
    END IF;
  END PROCESS Unit_Delay_bypass_process;

  
  Lookup_Table_out1_2 <= Lookup_Table_out1_1 WHEN enb_1_16_1 = '1' ELSE
      Unit_Delay_bypass_reg;

  gain_value_real <= std_logic_vector(Lookup_Table_out1_2);

END rtl;

