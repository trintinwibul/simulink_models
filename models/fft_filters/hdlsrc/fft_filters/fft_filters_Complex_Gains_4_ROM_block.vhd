-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\wickh\Documents\NIH\simulink_models\models\fft_filters\hdlsrc\fft_filters\fft_filters_Complex_Gains_4_ROM_block.vhd
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: fft_filters_Complex_Gains_4_ROM_block
-- Source Path: fft_filters/dataplane/FFT_Analysis_Synthesis_Right/Frequency_Domain_Processing/Apply_Complex_Gains/FFT_Filter_Coefficients/Filter_ROM_Choice/Complex_Gains_4_ROM
-- Hierarchy Level: 6
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fft_filters_Complex_Gains_4_ROM_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_16_1                        :   IN    std_logic;
        Index                             :   IN    std_logic_vector(6 DOWNTO 0);  -- ufix7
        gains_re                          :   OUT   std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
        gains_im                          :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
        );
END fft_filters_Complex_Gains_4_ROM_block;


ARCHITECTURE rtl OF fft_filters_Complex_Gains_4_ROM_block IS

  ATTRIBUTE multstyle : string;

  -- Component Declarations
  COMPONENT fft_filters_Gains_ROM_real_block6
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_16_1                      :   IN    std_logic;
          Index                           :   IN    std_logic_vector(6 DOWNTO 0);  -- ufix7
          gain_value_real                 :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
          );
  END COMPONENT;

  COMPONENT fft_filters_Gains_ROM_imag_block6
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_16_1                      :   IN    std_logic;
          Index                           :   IN    std_logic_vector(6 DOWNTO 0);  -- ufix7
          gain_value_imag                 :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : fft_filters_Gains_ROM_real_block6
    USE ENTITY work.fft_filters_Gains_ROM_real_block6(rtl);

  FOR ALL : fft_filters_Gains_ROM_imag_block6
    USE ENTITY work.fft_filters_Gains_ROM_imag_block6(rtl);

  -- Signals
  SIGNAL Gains_ROM_real_out1              : std_logic_vector(23 DOWNTO 0);  -- ufix24
  SIGNAL Gains_ROM_imag_out1              : std_logic_vector(23 DOWNTO 0);  -- ufix24

BEGIN
  u_Gains_ROM_real : fft_filters_Gains_ROM_real_block6
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1_16_1 => enb_1_16_1,
              Index => Index,  -- ufix7
              gain_value_real => Gains_ROM_real_out1  -- sfix24_En23
              );

  u_Gains_ROM_imag : fft_filters_Gains_ROM_imag_block6
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1_16_1 => enb_1_16_1,
              Index => Index,  -- ufix7
              gain_value_imag => Gains_ROM_imag_out1  -- sfix24_En23
              );

  gains_re <= std_logic_vector(signed(Gains_ROM_real_out1));

  gains_im <= std_logic_vector(signed(Gains_ROM_imag_out1));

END rtl;

