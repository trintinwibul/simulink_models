-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\wickh\Documents\NIH\simulink_models\models\fft_filters\hdlsrc\fft_filters\fft_filters_Apply_Complex_Gains_block.vhd
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: fft_filters_Apply_Complex_Gains_block
-- Source Path: fft_filters/dataplane/FFT_Analysis_Synthesis_Right/Frequency_Domain_Processing/Apply_Complex_Gains
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fft_filters_Apply_Complex_Gains_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_16_0                        :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_16_1                        :   IN    std_logic;
        FFT_data_re                       :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        FFT_data_im                       :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        valid_data                        :   IN    std_logic;
        frame_pulse_in                    :   IN    std_logic;
        filter_select                     :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        Processed_FFT_data_re             :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        Processed_FFT_data_im             :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        valid                             :   OUT   std_logic;
        frame_pulse_out                   :   OUT   std_logic
        );
END fft_filters_Apply_Complex_Gains_block;


ARCHITECTURE rtl OF fft_filters_Apply_Complex_Gains_block IS

  ATTRIBUTE multstyle : string;

  -- Component Declarations
  COMPONENT fft_filters_FFT_Filter_Coefficients_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_16_0                      :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_16_1                      :   IN    std_logic;
          select_rsvd                     :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
          valid                           :   IN    std_logic;
          filter_gains_re                 :   OUT   std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
          filter_gains_im                 :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : fft_filters_FFT_Filter_Coefficients_block
    USE ENTITY work.fft_filters_FFT_Filter_Coefficients_block(rtl);

  -- Signals
  SIGNAL FFT_data_re_signed               : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL FFT_data_im_signed               : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Unit_Delay1_out1_re              : signed(30 DOWNTO 0) := to_signed(16#00000000#, 31);  -- sfix31_En23
  SIGNAL Unit_Delay1_out1_im              : signed(30 DOWNTO 0) := to_signed(16#00000000#, 31);  -- sfix31_En23
  SIGNAL Unit_Delay1_out1_re_1            : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Unit_Delay1_out1_im_1            : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Product_C2ReIm_1_C2ReIm_A        : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL FFT_Filter_Coefficients_out1_re  : std_logic_vector(23 DOWNTO 0);  -- ufix24
  SIGNAL FFT_Filter_Coefficients_out1_im  : std_logic_vector(23 DOWNTO 0);  -- ufix24
  SIGNAL FFT_Filter_Coefficients_out1_re_signed : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL FFT_Filter_Coefficients_out1_im_signed : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL Product_C2ReIm_2_C2ReIm_A        : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL Product_mul_temp                 : signed(54 DOWNTO 0);  -- sfix55_En46
  SIGNAL Product_Re_AC                    : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Product_Re_AC_1                  : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Product_C2ReIm_1_C2ReIm_B        : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Product_C2ReIm_2_C2ReIm_B        : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL Product2_mul_temp                : signed(54 DOWNTO 0);  -- sfix55_En46
  SIGNAL Product_Re_BD                    : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Product_Re_BD_1                  : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL mulOutput                        : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Product1_mul_temp                : signed(54 DOWNTO 0);  -- sfix55_En46
  SIGNAL Product_Im_AD                    : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Product_Im_AD_1                  : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Product3_mul_temp                : signed(54 DOWNTO 0);  -- sfix55_En46
  SIGNAL Product_Im_BC                    : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Product_Im_BC_1                  : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL mulOutput_1                      : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Unit_Delay_out1                  : std_logic := '0';
  SIGNAL Unit_Delay2_out1                 : std_logic := '0';

BEGIN
  -- Output data type is inherited
  -- from the first input.
  -- 
  -- The frame pulse needs to be delayed 
  -- to complensate for the latency 
  -- of the Filter Coefficent block.
  -- 
  -- The valid needs to be delayed
  -- to complensate for the latency 
  -- of the Filter Coefficent block.
  -- 
  -- Data needs to be delayed
  -- to complensate for the latency 
  -- of the Filter Coefficent block.

  u_FFT_Filter_Coefficients : fft_filters_FFT_Filter_Coefficients_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_16_0 => enb_1_16_0,
              enb => enb,
              enb_1_16_1 => enb_1_16_1,
              select_rsvd => filter_select,  -- ufix2
              valid => valid_data,
              filter_gains_re => FFT_Filter_Coefficients_out1_re,  -- sfix24_En23
              filter_gains_im => FFT_Filter_Coefficients_out1_im  -- sfix24_En23
              );

  FFT_data_re_signed <= signed(FFT_data_re);

  FFT_data_im_signed <= signed(FFT_data_im);

  Unit_Delay1_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF enb_1_16_0 = '1' THEN
        Unit_Delay1_out1_re <= FFT_data_re_signed;
        Unit_Delay1_out1_im <= FFT_data_im_signed;
      END IF;
    END IF;
  END PROCESS Unit_Delay1_process;


  Unit_Delay1_out1_re_1 <= Unit_Delay1_out1_re;

  reduced_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_C2ReIm_1_C2ReIm_A <= to_signed(16#00000000#, 31);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Product_C2ReIm_1_C2ReIm_A <= Unit_Delay1_out1_re_1;
      END IF;
    END IF;
  END PROCESS reduced_process;


  FFT_Filter_Coefficients_out1_re_signed <= signed(FFT_Filter_Coefficients_out1_re);

  reduced_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_C2ReIm_2_C2ReIm_A <= to_signed(16#000000#, 24);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Product_C2ReIm_2_C2ReIm_A <= FFT_Filter_Coefficients_out1_re_signed;
      END IF;
    END IF;
  END PROCESS reduced_1_process;


  Product_mul_temp <= Product_C2ReIm_1_C2ReIm_A * Product_C2ReIm_2_C2ReIm_A;
  Product_Re_AC <= Product_mul_temp(53 DOWNTO 23);

  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_Re_AC_1 <= to_signed(16#00000000#, 31);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Product_Re_AC_1 <= Product_Re_AC;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Unit_Delay1_out1_im_1 <= Unit_Delay1_out1_im;

  reduced_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_C2ReIm_1_C2ReIm_B <= to_signed(16#00000000#, 31);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Product_C2ReIm_1_C2ReIm_B <= Unit_Delay1_out1_im_1;
      END IF;
    END IF;
  END PROCESS reduced_2_process;


  FFT_Filter_Coefficients_out1_im_signed <= signed(FFT_Filter_Coefficients_out1_im);

  reduced_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_C2ReIm_2_C2ReIm_B <= to_signed(16#000000#, 24);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Product_C2ReIm_2_C2ReIm_B <= FFT_Filter_Coefficients_out1_im_signed;
      END IF;
    END IF;
  END PROCESS reduced_3_process;


  Product2_mul_temp <= Product_C2ReIm_1_C2ReIm_B * Product_C2ReIm_2_C2ReIm_B;
  Product_Re_BD <= Product2_mul_temp(53 DOWNTO 23);

  PipelineRegister2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_Re_BD_1 <= to_signed(16#00000000#, 31);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Product_Re_BD_1 <= Product_Re_BD;
      END IF;
    END IF;
  END PROCESS PipelineRegister2_process;


  mulOutput <= Product_Re_AC_1 - Product_Re_BD_1;

  Processed_FFT_data_re <= std_logic_vector(mulOutput);

  Product1_mul_temp <= Product_C2ReIm_1_C2ReIm_A * Product_C2ReIm_2_C2ReIm_B;
  Product_Im_AD <= Product1_mul_temp(53 DOWNTO 23);

  PipelineRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_Im_AD_1 <= to_signed(16#00000000#, 31);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Product_Im_AD_1 <= Product_Im_AD;
      END IF;
    END IF;
  END PROCESS PipelineRegister1_process;


  Product3_mul_temp <= Product_C2ReIm_1_C2ReIm_B * Product_C2ReIm_2_C2ReIm_A;
  Product_Im_BC <= Product3_mul_temp(53 DOWNTO 23);

  PipelineRegister3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_Im_BC_1 <= to_signed(16#00000000#, 31);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Product_Im_BC_1 <= Product_Im_BC;
      END IF;
    END IF;
  END PROCESS PipelineRegister3_process;


  mulOutput_1 <= Product_Im_AD_1 + Product_Im_BC_1;

  Processed_FFT_data_im <= std_logic_vector(mulOutput_1);

  Unit_Delay_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF enb_1_16_0 = '1' THEN
        Unit_Delay_out1 <= valid_data;
      END IF;
    END IF;
  END PROCESS Unit_Delay_process;


  Unit_Delay2_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF enb_1_16_0 = '1' THEN
        Unit_Delay2_out1 <= frame_pulse_in;
      END IF;
    END IF;
  END PROCESS Unit_Delay2_process;


  valid <= Unit_Delay_out1;

  frame_pulse_out <= Unit_Delay2_out1;

END rtl;

