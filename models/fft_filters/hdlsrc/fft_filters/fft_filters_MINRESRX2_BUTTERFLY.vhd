-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\wickh\Documents\NIH\simulink_models\models\fft_filters\hdlsrc\fft_filters\fft_filters_MINRESRX2_BUTTERFLY.vhd
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: fft_filters_MINRESRX2_BUTTERFLY
-- Source Path: fft_filters/dataplane/FFT_Analysis_Synthesis_Left/Analysis/FFT/MINRESRX2_BUTTERFLY
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.fft_filters_dataplane_pkg.ALL;

ENTITY fft_filters_MINRESRX2_BUTTERFLY IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_2048_0                      :   IN    std_logic;
        btfIn1_re                         :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        btfIn1_im                         :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        btfIn2_re                         :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        btfIn2_im                         :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        btfIn_vld                         :   IN    std_logic;
        twdl_re                           :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En29
        twdl_im                           :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En29
        syncReset                         :   IN    std_logic;
        btfOut1_re                        :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        btfOut1_im                        :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        btfOut2_re                        :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        btfOut2_im                        :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        btfOut_vld                        :   OUT   std_logic
        );
END fft_filters_MINRESRX2_BUTTERFLY;


ARCHITECTURE rtl OF fft_filters_MINRESRX2_BUTTERFLY IS

  -- Component Declarations
  COMPONENT fft_filters_Complex4Multiply
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          btfIn2_re                       :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfIn2_im                       :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          din2Dly_vld                     :   IN    std_logic;
          twdl_re                         :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En29
          twdl_im                         :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En29
          syncReset                       :   IN    std_logic;
          dinXTwdl_re                     :   OUT   std_logic_vector(62 DOWNTO 0);  -- sfix63_En52
          dinXTwdl_im                     :   OUT   std_logic_vector(62 DOWNTO 0);  -- sfix63_En52
          dinXTwdl_vld                    :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : fft_filters_Complex4Multiply
    USE ENTITY work.fft_filters_Complex4Multiply(rtl);

  -- Signals
  SIGNAL btfIn2_re_signed                 : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL btfIn2_im_signed                 : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL intdelay_reg                     : vector_of_signed31(0 TO 1);  -- sfix31 [2]
  SIGNAL din2Dly_re                       : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL intdelay_reg_1                   : vector_of_signed31(0 TO 1);  -- sfix31 [2]
  SIGNAL din2Dly_im                       : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL dinXTwdl_re                      : std_logic_vector(62 DOWNTO 0);  -- ufix63
  SIGNAL dinXTwdl_im                      : std_logic_vector(62 DOWNTO 0);  -- ufix63
  SIGNAL dinXTwdl_vld                     : std_logic;
  SIGNAL dinXTwdl_re_signed               : signed(62 DOWNTO 0);  -- sfix63_En52
  SIGNAL dinXTwdl_im_signed               : signed(62 DOWNTO 0);  -- sfix63_En52
  SIGNAL btfIn1_re_signed                 : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL intdelay_reg_2                   : vector_of_signed31(0 TO 7);  -- sfix31 [8]
  SIGNAL din1Dly_re                       : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL btfIn1_im_signed                 : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL intdelay_reg_3                   : vector_of_signed31(0 TO 7);  -- sfix31 [8]
  SIGNAL din1Dly_im                       : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL intdelay_reg_4                   : std_logic_vector(0 TO 7);  -- ufix1 [8]
  SIGNAL din1Dly_vld                      : std_logic;
  SIGNAL minResRX2FFTButterfly_add1_re    : signed(63 DOWNTO 0);  -- sfix64
  SIGNAL minResRX2FFTButterfly_add1_im    : signed(63 DOWNTO 0);  -- sfix64
  SIGNAL minResRX2FFTButterfly_sub1_re    : signed(63 DOWNTO 0);  -- sfix64
  SIGNAL minResRX2FFTButterfly_sub1_im    : signed(63 DOWNTO 0);  -- sfix64
  SIGNAL minResRX2FFTButterfly_vld_reg    : std_logic;
  SIGNAL minResRX2FFTButterfly_add1_cast_re : signed(63 DOWNTO 0);  -- sfix64
  SIGNAL minResRX2FFTButterfly_add1_cast_im : signed(63 DOWNTO 0);  -- sfix64
  SIGNAL minResRX2FFTButterfly_sub1_cast_re : signed(63 DOWNTO 0);  -- sfix64
  SIGNAL minResRX2FFTButterfly_sub1_cast_im : signed(63 DOWNTO 0);  -- sfix64
  SIGNAL minResRX2FFTButterfly_add1_re_next : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_add1_im_next : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_sub1_re_next : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_sub1_im_next : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_add1_cast_re_next : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_add1_cast_im_next : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_sub1_cast_re_next : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_sub1_cast_im_next : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_add_cast   : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_add_cast_1 : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_add_cast_2 : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_add_cast_3 : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_sub_cast   : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_sub_cast_1 : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_sub_cast_2 : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL minResRX2FFTButterfly_sub_cast_3 : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL btfOut1FP_re                     : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL btfOut1FP_im                     : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL btfOut2FP_re                     : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL btfOut2FP_im                     : signed(63 DOWNTO 0);  -- sfix64_En52
  SIGNAL btfOut1_re_tmp                   : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL btfOut1_im_tmp                   : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL btfOut2_re_tmp                   : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL btfOut2_im_tmp                   : signed(30 DOWNTO 0);  -- sfix31_En23

BEGIN
  u_MUL4 : fft_filters_Complex4Multiply
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              btfIn2_re => std_logic_vector(din2Dly_re),  -- sfix31_En23
              btfIn2_im => std_logic_vector(din2Dly_im),  -- sfix31_En23
              din2Dly_vld => btfIn_vld,
              twdl_re => twdl_re,  -- sfix31_En29
              twdl_im => twdl_im,  -- sfix31_En29
              syncReset => syncReset,
              dinXTwdl_re => dinXTwdl_re,  -- sfix63_En52
              dinXTwdl_im => dinXTwdl_im,  -- sfix63_En52
              dinXTwdl_vld => dinXTwdl_vld
              );

  btfIn2_re_signed <= signed(btfIn2_re);

  btfIn2_im_signed <= signed(btfIn2_im);

  intdelay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg <= (OTHERS => to_signed(16#00000000#, 31));
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        intdelay_reg(0) <= btfIn2_re_signed;
        intdelay_reg(1) <= intdelay_reg(0);
      END IF;
    END IF;
  END PROCESS intdelay_process;

  din2Dly_re <= intdelay_reg(1);

  intdelay_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg_1 <= (OTHERS => to_signed(16#00000000#, 31));
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        intdelay_reg_1(0) <= btfIn2_im_signed;
        intdelay_reg_1(1) <= intdelay_reg_1(0);
      END IF;
    END IF;
  END PROCESS intdelay_1_process;

  din2Dly_im <= intdelay_reg_1(1);

  dinXTwdl_re_signed <= signed(dinXTwdl_re);

  dinXTwdl_im_signed <= signed(dinXTwdl_im);

  btfIn1_re_signed <= signed(btfIn1_re);

  intdelay_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg_2 <= (OTHERS => to_signed(16#00000000#, 31));
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        intdelay_reg_2(0) <= btfIn1_re_signed;
        intdelay_reg_2(1 TO 7) <= intdelay_reg_2(0 TO 6);
      END IF;
    END IF;
  END PROCESS intdelay_2_process;

  din1Dly_re <= intdelay_reg_2(7);

  btfIn1_im_signed <= signed(btfIn1_im);

  intdelay_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg_3 <= (OTHERS => to_signed(16#00000000#, 31));
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        intdelay_reg_3(0) <= btfIn1_im_signed;
        intdelay_reg_3(1 TO 7) <= intdelay_reg_3(0 TO 6);
      END IF;
    END IF;
  END PROCESS intdelay_3_process;

  din1Dly_im <= intdelay_reg_3(7);

  intdelay_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg_4 <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        intdelay_reg_4(0) <= btfIn_vld;
        intdelay_reg_4(1 TO 7) <= intdelay_reg_4(0 TO 6);
      END IF;
    END IF;
  END PROCESS intdelay_4_process;

  din1Dly_vld <= intdelay_reg_4(7);

  -- minResRX2FFTButterfly
  minResRX2FFTButterfly_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      minResRX2FFTButterfly_add1_re <= to_signed(0, 64);
      minResRX2FFTButterfly_add1_im <= to_signed(0, 64);
      minResRX2FFTButterfly_sub1_re <= to_signed(0, 64);
      minResRX2FFTButterfly_sub1_im <= to_signed(0, 64);
      minResRX2FFTButterfly_add1_cast_re <= to_signed(0, 64);
      minResRX2FFTButterfly_add1_cast_im <= to_signed(0, 64);
      minResRX2FFTButterfly_sub1_cast_re <= to_signed(0, 64);
      minResRX2FFTButterfly_sub1_cast_im <= to_signed(0, 64);
      minResRX2FFTButterfly_vld_reg <= '0';
      btfOut_vld <= '0';
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        minResRX2FFTButterfly_add1_re <= minResRX2FFTButterfly_add1_re_next;
        minResRX2FFTButterfly_add1_im <= minResRX2FFTButterfly_add1_im_next;
        minResRX2FFTButterfly_sub1_re <= minResRX2FFTButterfly_sub1_re_next;
        minResRX2FFTButterfly_sub1_im <= minResRX2FFTButterfly_sub1_im_next;
        minResRX2FFTButterfly_add1_cast_re <= minResRX2FFTButterfly_add1_cast_re_next;
        minResRX2FFTButterfly_add1_cast_im <= minResRX2FFTButterfly_add1_cast_im_next;
        minResRX2FFTButterfly_sub1_cast_re <= minResRX2FFTButterfly_sub1_cast_re_next;
        minResRX2FFTButterfly_sub1_cast_im <= minResRX2FFTButterfly_sub1_cast_im_next;
        btfOut_vld <= minResRX2FFTButterfly_vld_reg;
        minResRX2FFTButterfly_vld_reg <= din1Dly_vld;
      END IF;
    END IF;
  END PROCESS minResRX2FFTButterfly_process;

  minResRX2FFTButterfly_add1_cast_re_next <= minResRX2FFTButterfly_add1_re;
  minResRX2FFTButterfly_add1_cast_im_next <= minResRX2FFTButterfly_add1_im;
  minResRX2FFTButterfly_sub1_cast_re_next <= minResRX2FFTButterfly_sub1_re;
  minResRX2FFTButterfly_sub1_cast_im_next <= minResRX2FFTButterfly_sub1_im;
  minResRX2FFTButterfly_add_cast <= resize(din1Dly_re & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 64);
  minResRX2FFTButterfly_add_cast_1 <= resize(dinXTwdl_re_signed, 64);
  minResRX2FFTButterfly_add1_re_next <= minResRX2FFTButterfly_add_cast + minResRX2FFTButterfly_add_cast_1;
  minResRX2FFTButterfly_add_cast_2 <= resize(din1Dly_im & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 64);
  minResRX2FFTButterfly_add_cast_3 <= resize(dinXTwdl_im_signed, 64);
  minResRX2FFTButterfly_add1_im_next <= minResRX2FFTButterfly_add_cast_2 + minResRX2FFTButterfly_add_cast_3;
  minResRX2FFTButterfly_sub_cast <= resize(din1Dly_re & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 64);
  minResRX2FFTButterfly_sub_cast_1 <= resize(dinXTwdl_re_signed, 64);
  minResRX2FFTButterfly_sub1_re_next <= minResRX2FFTButterfly_sub_cast - minResRX2FFTButterfly_sub_cast_1;
  minResRX2FFTButterfly_sub_cast_2 <= resize(din1Dly_im & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 64);
  minResRX2FFTButterfly_sub_cast_3 <= resize(dinXTwdl_im_signed, 64);
  minResRX2FFTButterfly_sub1_im_next <= minResRX2FFTButterfly_sub_cast_2 - minResRX2FFTButterfly_sub_cast_3;
  btfOut1FP_re <= minResRX2FFTButterfly_add1_cast_re;
  btfOut1FP_im <= minResRX2FFTButterfly_add1_cast_im;
  btfOut2FP_re <= minResRX2FFTButterfly_sub1_cast_re;
  btfOut2FP_im <= minResRX2FFTButterfly_sub1_cast_im;

  btfOut1_re_tmp <= btfOut1FP_re(59 DOWNTO 29);

  btfOut1_re <= std_logic_vector(btfOut1_re_tmp);

  btfOut1_im_tmp <= btfOut1FP_im(59 DOWNTO 29);

  btfOut1_im <= std_logic_vector(btfOut1_im_tmp);

  btfOut2_re_tmp <= btfOut2FP_re(59 DOWNTO 29);

  btfOut2_re <= std_logic_vector(btfOut2_re_tmp);

  btfOut2_im_tmp <= btfOut2FP_im(59 DOWNTO 29);

  btfOut2_im <= std_logic_vector(btfOut2_im_tmp);

END rtl;

