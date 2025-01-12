-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\conno\Documents\NIH-GitHub\simulink_models\models\fft_filters\hdlsrc\fft_filters\fft_filters_FFT_Filter_Coefficients_block.vhd
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: fft_filters_FFT_Filter_Coefficients_block
-- Source Path: fft_filters/dataplane/FFT_Analysis_Synthesis_Right/Frequency_Domain_Processing/Apply_Complex_Gains/FFT_Filter_Coefficients
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fft_filters_FFT_Filter_Coefficients_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_16_0                        :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_16_1                        :   IN    std_logic;
        select_rsvd                       :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        valid                             :   IN    std_logic;
        filter_gains_re                   :   OUT   std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
        filter_gains_im                   :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
        );
END fft_filters_FFT_Filter_Coefficients_block;


ARCHITECTURE rtl OF fft_filters_FFT_Filter_Coefficients_block IS

  -- Component Declarations
  COMPONENT fft_filters_FFT_ROM_Indexing_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_16_0                      :   IN    std_logic;
          valid                           :   IN    std_logic;
          ROM_index                       :   OUT   std_logic_vector(6 DOWNTO 0)  -- ufix7
          );
  END COMPONENT;

  COMPONENT fft_filters_Filter_ROM_Choice_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_16_1                      :   IN    std_logic;
          select_rsvd                     :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
          Index                           :   IN    std_logic_vector(6 DOWNTO 0);  -- ufix7
          filter_gains_re                 :   OUT   std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
          filter_gains_im                 :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : fft_filters_FFT_ROM_Indexing_block
    USE ENTITY work.fft_filters_FFT_ROM_Indexing_block(rtl);

  FOR ALL : fft_filters_Filter_ROM_Choice_block
    USE ENTITY work.fft_filters_Filter_ROM_Choice_block(rtl);

  -- Signals
  SIGNAL FFT_ROM_Indexing_out1            : std_logic_vector(6 DOWNTO 0);  -- ufix7
  SIGNAL Filter_ROM_Choice_out1_re        : std_logic_vector(23 DOWNTO 0);  -- ufix24
  SIGNAL Filter_ROM_Choice_out1_im        : std_logic_vector(23 DOWNTO 0);  -- ufix24

BEGIN
  u_FFT_ROM_Indexing : fft_filters_FFT_ROM_Indexing_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_16_0 => enb_1_16_0,
              valid => valid,
              ROM_index => FFT_ROM_Indexing_out1  -- ufix7
              );

  u_Filter_ROM_Choice : fft_filters_Filter_ROM_Choice_block
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1_16_1 => enb_1_16_1,
              select_rsvd => select_rsvd,  -- ufix2
              Index => FFT_ROM_Indexing_out1,  -- ufix7
              filter_gains_re => Filter_ROM_Choice_out1_re,  -- sfix24_En23
              filter_gains_im => Filter_ROM_Choice_out1_im  -- sfix24_En23
              );

  filter_gains_re <= Filter_ROM_Choice_out1_re;

  filter_gains_im <= Filter_ROM_Choice_out1_im;

END rtl;

