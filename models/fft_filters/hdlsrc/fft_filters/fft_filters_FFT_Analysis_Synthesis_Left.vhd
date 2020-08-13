-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\wickh\Documents\NIH\simulink_models\models\fft_filters\hdlsrc\fft_filters\fft_filters_FFT_Analysis_Synthesis_Left.vhd
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: fft_filters_FFT_Analysis_Synthesis_Left
-- Source Path: fft_filters/dataplane/FFT_Analysis_Synthesis_Left
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fft_filters_FFT_Analysis_Synthesis_Left IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_262144_1                    :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_2048_0                      :   IN    std_logic;
        enb_1_262144_0                    :   IN    std_logic;
        enb_1_2048_1                      :   IN    std_logic;
        enb_1_262144_4097                 :   IN    std_logic;
        signal_in                         :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
        Passthrough                       :   IN    std_logic;
        filter_select                     :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        signal_out                        :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
        );
END fft_filters_FFT_Analysis_Synthesis_Left;


ARCHITECTURE rtl OF fft_filters_FFT_Analysis_Synthesis_Left IS

  ATTRIBUTE multstyle : string;

  -- Component Declarations
  COMPONENT fft_filters_Analysis
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_262144_1                  :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          enb_1_262144_0                  :   IN    std_logic;
          enb_1_2048_1                    :   IN    std_logic;
          Signal_in                       :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
          Passthrough                     :   IN    std_logic;
          filter_select                   :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
          FFT_data_re                     :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          FFT_data_im                     :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          FFT_valid                       :   OUT   std_logic;
          FFT_frame_pulse                 :   OUT   std_logic;
          passthrough_1                   :   OUT   std_logic;
          filter_select_out               :   OUT   std_logic_vector(1 DOWNTO 0)  -- ufix2
          );
  END COMPONENT;

  COMPONENT fft_filters_Frequency_Domain_Processing
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          enb_1_2048_1                    :   IN    std_logic;
          FFT_results_re                  :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          FFT_results_im                  :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          valid_in                        :   IN    std_logic;
          frame_pulse_in                  :   IN    std_logic;
          passthrough                     :   IN    std_logic;
          filter_select                   :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
          modified_frequencies_re         :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          modified_frequencies_im         :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          valid_out                       :   OUT   std_logic;
          frame_pulse_out                 :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT fft_filters_Synthesis
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_262144_1                  :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          enb_1_262144_0                  :   IN    std_logic;
          enb_1_2048_1                    :   IN    std_logic;
          enb_1_262144_4097               :   IN    std_logic;
          modified_FFT_data_re            :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          modified_FFT_data_im            :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          FFT_valid                       :   IN    std_logic;
          FFT_frame_pulse                 :   IN    std_logic;
          synthesized_signal              :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : fft_filters_Analysis
    USE ENTITY work.fft_filters_Analysis(rtl);

  FOR ALL : fft_filters_Frequency_Domain_Processing
    USE ENTITY work.fft_filters_Frequency_Domain_Processing(rtl);

  FOR ALL : fft_filters_Synthesis
    USE ENTITY work.fft_filters_Synthesis(rtl);

  -- Signals
  SIGNAL kconst                           : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL kconst_1                         : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL Analysis_out1_re                 : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL Analysis_out1_im                 : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL Analysis_out2                    : std_logic;
  SIGNAL Analysis_out3                    : std_logic;
  SIGNAL Analysis_out4                    : std_logic;
  SIGNAL Analysis_out5                    : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL Analysis_out3_1                  : std_logic;
  SIGNAL Analysis_out4_1                  : std_logic;
  SIGNAL Analysis_out5_unsigned           : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Analysis_out5_1                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Frequency_Domain_Processing_out1_re : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL Frequency_Domain_Processing_out1_im : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL Frequency_Domain_Processing_out2 : std_logic;
  SIGNAL Frequency_Domain_Processing_out3 : std_logic;
  SIGNAL Frequency_Domain_Processing_out2_1 : std_logic;
  SIGNAL Frequency_Domain_Processing_out3_1 : std_logic;
  SIGNAL Synthesis_out1                   : std_logic_vector(23 DOWNTO 0);  -- ufix24
  SIGNAL Synthesis_out1_signed            : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL Synthesis_out1_1                 : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL Gain_mul_temp                    : signed(47 DOWNTO 0);  -- sfix48_En46
  SIGNAL Gain_out1                        : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL Gain_out1_1                      : signed(23 DOWNTO 0);  -- sfix24_En23

BEGIN
  -- Gain to normalize
  -- sinusoid amplitudes

  u_Analysis : fft_filters_Analysis
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_262144_1 => enb_1_262144_1,
              enb => enb,
              enb_1_2048_0 => enb_1_2048_0,
              enb_1_262144_0 => enb_1_262144_0,
              enb_1_2048_1 => enb_1_2048_1,
              Signal_in => signal_in,  -- sfix24_En23
              Passthrough => Passthrough,
              filter_select => filter_select,  -- ufix2
              FFT_data_re => Analysis_out1_re,  -- sfix31_En23
              FFT_data_im => Analysis_out1_im,  -- sfix31_En23
              FFT_valid => Analysis_out2,
              FFT_frame_pulse => Analysis_out3,
              passthrough_1 => Analysis_out4,
              filter_select_out => Analysis_out5  -- ufix2
              );

  u_Frequency_Domain_Processing : fft_filters_Frequency_Domain_Processing
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1_2048_0 => enb_1_2048_0,
              enb_1_2048_1 => enb_1_2048_1,
              FFT_results_re => Analysis_out1_re,  -- sfix31_En23
              FFT_results_im => Analysis_out1_im,  -- sfix31_En23
              valid_in => Analysis_out2,
              frame_pulse_in => Analysis_out3_1,
              passthrough => Analysis_out4_1,
              filter_select => std_logic_vector(Analysis_out5_1),  -- ufix2
              modified_frequencies_re => Frequency_Domain_Processing_out1_re,  -- sfix31_En23
              modified_frequencies_im => Frequency_Domain_Processing_out1_im,  -- sfix31_En23
              valid_out => Frequency_Domain_Processing_out2,
              frame_pulse_out => Frequency_Domain_Processing_out3
              );

  u_Synthesis : fft_filters_Synthesis
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_262144_1 => enb_1_262144_1,
              enb => enb,
              enb_1_2048_0 => enb_1_2048_0,
              enb_1_262144_0 => enb_1_262144_0,
              enb_1_2048_1 => enb_1_2048_1,
              enb_1_262144_4097 => enb_1_262144_4097,
              modified_FFT_data_re => Frequency_Domain_Processing_out1_re,  -- sfix31_En23
              modified_FFT_data_im => Frequency_Domain_Processing_out1_im,  -- sfix31_En23
              FFT_valid => Frequency_Domain_Processing_out2_1,
              FFT_frame_pulse => Frequency_Domain_Processing_out3_1,
              synthesized_signal => Synthesis_out1  -- sfix24_En23
              );

  kconst <= to_signed(16#7FFFFF#, 24);

  HwModeRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      kconst_1 <= to_signed(16#000000#, 24);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        kconst_1 <= kconst;
      END IF;
    END IF;
  END PROCESS HwModeRegister_process;


  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Analysis_out3_1 <= '0';
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        Analysis_out3_1 <= Analysis_out3;
      END IF;
    END IF;
  END PROCESS delayMatch_process;


  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Analysis_out4_1 <= '0';
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        Analysis_out4_1 <= Analysis_out4;
      END IF;
    END IF;
  END PROCESS delayMatch1_process;


  Analysis_out5_unsigned <= unsigned(Analysis_out5);

  delayMatch2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Analysis_out5_1 <= to_unsigned(16#0#, 2);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        Analysis_out5_1 <= Analysis_out5_unsigned;
      END IF;
    END IF;
  END PROCESS delayMatch2_process;


  delayMatch3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Frequency_Domain_Processing_out2_1 <= '0';
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        Frequency_Domain_Processing_out2_1 <= Frequency_Domain_Processing_out2;
      END IF;
    END IF;
  END PROCESS delayMatch3_process;


  delayMatch4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Frequency_Domain_Processing_out3_1 <= '0';
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        Frequency_Domain_Processing_out3_1 <= Frequency_Domain_Processing_out3;
      END IF;
    END IF;
  END PROCESS delayMatch4_process;


  Synthesis_out1_signed <= signed(Synthesis_out1);

  HwModeRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Synthesis_out1_1 <= to_signed(16#000000#, 24);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Synthesis_out1_1 <= Synthesis_out1_signed;
      END IF;
    END IF;
  END PROCESS HwModeRegister1_process;


  Gain_mul_temp <= kconst_1 * Synthesis_out1_1;
  Gain_out1 <= Gain_mul_temp(46 DOWNTO 23);

  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Gain_out1_1 <= to_signed(16#000000#, 24);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Gain_out1_1 <= Gain_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  signal_out <= std_logic_vector(Gain_out1_1);

END rtl;

