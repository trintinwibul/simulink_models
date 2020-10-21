-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\conno\Documents\NIH-GitHub\simulink_models\models\fft_filters\hdlsrc\fft_filters\fft_filters_FFT_pulse_gen_block.vhd
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: fft_filters_FFT_pulse_gen_block
-- Source Path: fft_filters/dataplane/FFT_Analysis_Synthesis_Right/Analysis/FFT Frame Buffering/FFT_pulse_gen
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fft_filters_FFT_pulse_gen_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_2048_0                      :   IN    std_logic;
        counter                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        FFT_start_pulse                   :   OUT   std_logic;
        Enable_FFTs                       :   OUT   std_logic
        );
END fft_filters_FFT_pulse_gen_block;


ARCHITECTURE rtl OF fft_filters_FFT_pulse_gen_block IS

  -- Component Declarations
  COMPONENT fft_filters_FFT_Frame_Pulse_Gen_block
    PORT( counter_value                   :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          Frame_Pulse                     :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT fft_filters_Wait_for_data_to_start_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          Frame_Pulse                     :   IN    std_logic;
          FFT_Frame_Start                 :   OUT   std_logic;
          Enable_FFT_Frames               :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : fft_filters_FFT_Frame_Pulse_Gen_block
    USE ENTITY work.fft_filters_FFT_Frame_Pulse_Gen_block(rtl);

  FOR ALL : fft_filters_Wait_for_data_to_start_block
    USE ENTITY work.fft_filters_Wait_for_data_to_start_block(rtl);

  -- Signals
  SIGNAL FFT_Frame_Pulse_Gen_out1         : std_logic;
  SIGNAL Wait_for_data_to_start_out1      : std_logic;
  SIGNAL Wait_for_data_to_start_out2      : std_logic;

BEGIN
  -- Don't send out FFT frame start pulses 
  -- until circular buffer has filled.

  u_FFT_Frame_Pulse_Gen : fft_filters_FFT_Frame_Pulse_Gen_block
    PORT MAP( counter_value => counter,  -- uint8
              Frame_Pulse => FFT_Frame_Pulse_Gen_out1
              );

  u_Wait_for_data_to_start : fft_filters_Wait_for_data_to_start_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              Frame_Pulse => FFT_Frame_Pulse_Gen_out1,
              FFT_Frame_Start => Wait_for_data_to_start_out1,
              Enable_FFT_Frames => Wait_for_data_to_start_out2
              );

  FFT_start_pulse <= Wait_for_data_to_start_out1;

  Enable_FFTs <= Wait_for_data_to_start_out2;

END rtl;
