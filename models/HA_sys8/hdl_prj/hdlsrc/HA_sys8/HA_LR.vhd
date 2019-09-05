-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\HA_sys8\HA_LR.vhd
-- Created: 2018-12-04 11:17:57
-- 
-- Generated by MATLAB 9.4 and HDL Coder 3.12
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 1.30208e-06
-- Target subsystem base rate: 1.30208e-06
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        2.08333e-05
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- HA_left_data_out              ce_out        2.08333e-05
-- HA_right_data_out             ce_out        2.08333e-05
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: HA_LR
-- Source Path: HA_sys8/HA_LR
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.HA_LR_pkg.ALL;

ENTITY HA_LR IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        HA_left_data_in                   :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        Gain_B4_left                      :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        Gain_B3_left                      :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        Gain_B2_left                      :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        Gain_B1_left                      :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        Gain_all_left                     :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        HA_right_data_in                  :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        Gain_B4_right                     :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        Gain_B3_right                     :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        Gain_B2_right                     :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        Gain_B1_right                     :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        Gain_all_right                    :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        ce_out                            :   OUT   std_logic;
        HA_left_data_out                  :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        HA_right_data_out                 :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
        );
END HA_LR;


ARCHITECTURE rtl OF HA_LR IS

  -- Component Declarations
  COMPONENT HA_LR_tc
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          enb_16_1_1                      :   OUT   std_logic;
          enb_8_4_1                       :   OUT   std_logic;
          enb                             :   OUT   std_logic;
          enb_1_1_1                       :   OUT   std_logic;
          enb_8_16_1                      :   OUT   std_logic;
          enb_1_4_0                       :   OUT   std_logic;
          enb_1_8_0                       :   OUT   std_logic;
          enb_4_32_1                      :   OUT   std_logic;
          enb_1_16_0                      :   OUT   std_logic;
          enb_1_32_0                      :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT HA_left
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_4_32_1                      :   IN    std_logic;
          enb_8_16_1                      :   IN    std_logic;
          enb_1_1_1                       :   IN    std_logic;
          enb_8_4_1                       :   IN    std_logic;
          enb_16_1_1                      :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_32_0                      :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          enb_1_8_0                       :   IN    std_logic;
          enb_1_16_0                      :   IN    std_logic;
          data_in                         :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          Gain_B4                         :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
          Gain_B3                         :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
          Gain_B2                         :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
          Gain_B1                         :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
          data_out                        :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
          );
  END COMPONENT;

  COMPONENT HA_right
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_4_32_1                      :   IN    std_logic;
          enb_8_16_1                      :   IN    std_logic;
          enb_1_1_1                       :   IN    std_logic;
          enb_8_4_1                       :   IN    std_logic;
          enb_16_1_1                      :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_32_0                      :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          enb_1_8_0                       :   IN    std_logic;
          enb_1_16_0                      :   IN    std_logic;
          data_in                         :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          Gain_B4                         :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
          Gain_B3                         :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
          Gain_B2                         :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
          Gain_B1                         :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
          data_out                        :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : HA_LR_tc
    USE ENTITY work.HA_LR_tc(rtl);

  FOR ALL : HA_left
    USE ENTITY work.HA_left(rtl);

  FOR ALL : HA_right
    USE ENTITY work.HA_right(rtl);

  -- Signals
  SIGNAL enb_4_32_1                       : std_logic;
  SIGNAL enb_8_16_1                       : std_logic;
  SIGNAL enb_1_1_1                        : std_logic;
  SIGNAL enb_8_4_1                        : std_logic;
  SIGNAL enb_16_1_1                       : std_logic;
  SIGNAL enb                              : std_logic;
  SIGNAL enb_1_32_0                       : std_logic;
  SIGNAL enb_1_4_0                        : std_logic;
  SIGNAL enb_1_8_0                        : std_logic;
  SIGNAL enb_1_16_0                       : std_logic;
  SIGNAL d5f                              : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL d5f_signed                       : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL SignumOutput                     : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL Gain_all_left_signed             : signed(31 DOWNTO 0);  -- sfix32_En16
  SIGNAL SignumOutput_1                   : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL delayMatch4_reg                  : vector_of_signed2(0 TO 185);  -- sfix2 [186]
  SIGNAL SignumOutput_2                   : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL mul_sign_mul_temp                : signed(3 DOWNTO 0);  -- sfix4
  SIGNAL mulOutput                        : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL switch_compare_1                 : std_logic;
  SIGNAL Gain_left_in0_dtc_in_abs_y       : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Gain_left_in0_dtc_in_abs_cast    : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL d5f_1                            : unsigned(31 DOWNTO 0);  -- ufix32_En28
  SIGNAL d5f_2                            : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL slicedOutput                     : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL Gain_left_in1_dtc_in_abs_y       : signed(32 DOWNTO 0);  -- sfix33_En16
  SIGNAL Gain_left_in1_dtc_in_abs_cast    : signed(32 DOWNTO 0);  -- sfix33_En16
  SIGNAL Gain_all_left_1                  : unsigned(31 DOWNTO 0);  -- ufix32_En16
  SIGNAL Gain_all_left_2                  : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL slicedOutput_1                   : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL reduced_reg                      : vector_of_unsigned14(0 TO 185);  -- ufix14 [186]
  SIGNAL slicedOutput_2                   : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL slicedOutput_3                   : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL slicedOutput_4                   : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL reduced_reg_1                    : vector_of_unsigned18(0 TO 185);  -- ufix18 [186]
  SIGNAL slicedOutput_5                   : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL mulOutput_1                      : unsigned(27 DOWNTO 0);  -- ufix28
  SIGNAL mulOutput_2                      : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL bitshiftoutput                   : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL mulOutput_3                      : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL mulOutput_4                      : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL bitshiftoutput_1                 : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL mulOutput_5                      : unsigned(64 DOWNTO 0);  -- ufix65
  SIGNAL mulOutput_6                      : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL mulOutput_7                      : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL bitshiftoutput_2                 : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL mulOutput_8                      : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL mulOutput_9                      : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL mulOutput_10                     : unsigned(64 DOWNTO 0);  -- ufix65
  SIGNAL mulOutput_11                     : unsigned(65 DOWNTO 0);  -- ufix66
  SIGNAL mulOutput_12                     : signed(65 DOWNTO 0);  -- sfix66
  SIGNAL SwitchComp_in2_uminus_in0        : signed(66 DOWNTO 0);  -- sfix67
  SIGNAL mulOutput_13                     : signed(65 DOWNTO 0);  -- sfix66
  SIGNAL mulOutput_14                     : signed(65 DOWNTO 0);  -- sfix66
  SIGNAL mulOutput_15                     : signed(63 DOWNTO 0);  -- sfix64_En44
  SIGNAL mulOutput_16                     : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL d5f_3                            : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL d5f_signed_1                     : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL SignumOutput_3                   : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL Gain_all_right_signed            : signed(31 DOWNTO 0);  -- sfix32_En16
  SIGNAL SignumOutput_4                   : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL delayMatch9_reg                  : vector_of_signed2(0 TO 185);  -- sfix2 [186]
  SIGNAL SignumOutput_5                   : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL mul_sign1_mul_temp               : signed(3 DOWNTO 0);  -- sfix4
  SIGNAL mulOutput_17                     : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL switch_compare_1_1               : std_logic;
  SIGNAL Gain_right_in0_dtc_in_abs_y      : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Gain_right_in0_dtc_in_abs_cast   : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL d5f_4                            : unsigned(31 DOWNTO 0);  -- ufix32_En28
  SIGNAL d5f_5                            : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL slicedOutput_6                   : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL Gain_right_in1_dtc_in_abs_y      : signed(32 DOWNTO 0);  -- sfix33_En16
  SIGNAL Gain_right_in1_dtc_in_abs_cast   : signed(32 DOWNTO 0);  -- sfix33_En16
  SIGNAL Gain_all_right_1                 : unsigned(31 DOWNTO 0);  -- ufix32_En16
  SIGNAL Gain_all_right_2                 : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL slicedOutput_7                   : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL reduced_reg_2                    : vector_of_unsigned14(0 TO 185);  -- ufix14 [186]
  SIGNAL slicedOutput_8                   : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL slicedOutput_9                   : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL slicedOutput_10                  : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL reduced_reg_3                    : vector_of_unsigned18(0 TO 185);  -- ufix18 [186]
  SIGNAL slicedOutput_11                  : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL mulOutput_18                     : unsigned(27 DOWNTO 0);  -- ufix28
  SIGNAL mulOutput_19                     : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL bitshiftoutput_3                 : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL mulOutput_20                     : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL mulOutput_21                     : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL bitshiftoutput_4                 : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL mulOutput_22                     : unsigned(64 DOWNTO 0);  -- ufix65
  SIGNAL mulOutput_23                     : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL mulOutput_24                     : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL bitshiftoutput_5                 : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL mulOutput_25                     : unsigned(35 DOWNTO 0);  -- ufix36
  SIGNAL mulOutput_26                     : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL mulOutput_27                     : unsigned(64 DOWNTO 0);  -- ufix65
  SIGNAL mulOutput_28                     : unsigned(65 DOWNTO 0);  -- ufix66
  SIGNAL mulOutput_29                     : signed(65 DOWNTO 0);  -- sfix66
  SIGNAL SwitchComp_in2_uminus1_in0       : signed(66 DOWNTO 0);  -- sfix67
  SIGNAL mulOutput_30                     : signed(65 DOWNTO 0);  -- sfix66
  SIGNAL mulOutput_31                     : signed(65 DOWNTO 0);  -- sfix66
  SIGNAL mulOutput_32                     : signed(63 DOWNTO 0);  -- sfix64_En44
  SIGNAL mulOutput_33                     : signed(31 DOWNTO 0);  -- sfix32_En28

  ATTRIBUTE multstyle : string;

BEGIN
  u_HA_LR_tc : HA_LR_tc
    PORT MAP( clk => clk,
              reset => reset,
              clk_enable => clk_enable,
              enb_16_1_1 => enb_16_1_1,
              enb_8_4_1 => enb_8_4_1,
              enb => enb,
              enb_1_1_1 => enb_1_1_1,
              enb_8_16_1 => enb_8_16_1,
              enb_1_4_0 => enb_1_4_0,
              enb_1_8_0 => enb_1_8_0,
              enb_4_32_1 => enb_4_32_1,
              enb_1_16_0 => enb_1_16_0,
              enb_1_32_0 => enb_1_32_0
              );

  u_HA_left : HA_left
    PORT MAP( clk => clk,
              reset => reset,
              enb_4_32_1 => enb_4_32_1,
              enb_8_16_1 => enb_8_16_1,
              enb_1_1_1 => enb_1_1_1,
              enb_8_4_1 => enb_8_4_1,
              enb_16_1_1 => enb_16_1_1,
              enb => enb,
              enb_1_32_0 => enb_1_32_0,
              enb_1_4_0 => enb_1_4_0,
              enb_1_8_0 => enb_1_8_0,
              enb_1_16_0 => enb_1_16_0,
              data_in => HA_left_data_in,  -- sfix32_En28
              Gain_B4 => Gain_B4_left,  -- sfix32_En16
              Gain_B3 => Gain_B3_left,  -- sfix32_En16
              Gain_B2 => Gain_B2_left,  -- sfix32_En16
              Gain_B1 => Gain_B1_left,  -- sfix32_En16
              data_out => d5f  -- sfix32_En28
              );

  u_HA_right : HA_right
    PORT MAP( clk => clk,
              reset => reset,
              enb_4_32_1 => enb_4_32_1,
              enb_8_16_1 => enb_8_16_1,
              enb_1_1_1 => enb_1_1_1,
              enb_8_4_1 => enb_8_4_1,
              enb_16_1_1 => enb_16_1_1,
              enb => enb,
              enb_1_32_0 => enb_1_32_0,
              enb_1_4_0 => enb_1_4_0,
              enb_1_8_0 => enb_1_8_0,
              enb_1_16_0 => enb_1_16_0,
              data_in => HA_right_data_in,  -- sfix32_En28
              Gain_B4 => Gain_B4_right,  -- sfix32_En16
              Gain_B3 => Gain_B3_right,  -- sfix32_En16
              Gain_B2 => Gain_B2_right,  -- sfix32_En16
              Gain_B1 => Gain_B1_right,  -- sfix32_En16
              data_out => d5f_3  -- sfix32_En28
              );

  d5f_signed <= signed(d5f);

  
  SignumOutput <= to_signed(16#1#, 2) WHEN d5f_signed > to_signed(0, 32) ELSE
      to_signed(-16#1#, 2) WHEN d5f_signed < to_signed(0, 32) ELSE
      to_signed(16#0#, 2);

  Gain_all_left_signed <= signed(Gain_all_left);

  
  SignumOutput_1 <= to_signed(16#1#, 2) WHEN Gain_all_left_signed > to_signed(0, 32) ELSE
      to_signed(-16#1#, 2) WHEN Gain_all_left_signed < to_signed(0, 32) ELSE
      to_signed(16#0#, 2);

  delayMatch4_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        delayMatch4_reg <= (OTHERS => to_signed(16#0#, 2));
      ELSIF enb = '1' THEN
        delayMatch4_reg(0) <= SignumOutput_1;
        delayMatch4_reg(1 TO 185) <= delayMatch4_reg(0 TO 184);
      END IF;
    END IF;
  END PROCESS delayMatch4_process;

  SignumOutput_2 <= delayMatch4_reg(185);

  mul_sign_mul_temp <= SignumOutput * SignumOutput_2;
  mulOutput <= mul_sign_mul_temp(1 DOWNTO 0);

  
  switch_compare_1 <= '1' WHEN mulOutput > to_signed(16#0#, 2) ELSE
      '0';

  Gain_left_in0_dtc_in_abs_cast <= resize(d5f_signed, 33);
  
  Gain_left_in0_dtc_in_abs_y <=  - (Gain_left_in0_dtc_in_abs_cast) WHEN d5f_signed < to_signed(0, 32) ELSE
      resize(d5f_signed, 33);
  d5f_1 <= unsigned(Gain_left_in0_dtc_in_abs_y(31 DOWNTO 0));

  d5f_2 <= resize(d5f_1, 36);

  slicedOutput <= d5f_2(31 DOWNTO 18);

  Gain_left_in1_dtc_in_abs_cast <= resize(Gain_all_left_signed, 33);
  
  Gain_left_in1_dtc_in_abs_y <=  - (Gain_left_in1_dtc_in_abs_cast) WHEN Gain_all_left_signed < to_signed(0, 32) ELSE
      resize(Gain_all_left_signed, 33);
  Gain_all_left_1 <= unsigned(Gain_left_in1_dtc_in_abs_y(31 DOWNTO 0));

  Gain_all_left_2 <= resize(Gain_all_left_1, 36);

  slicedOutput_1 <= Gain_all_left_2(31 DOWNTO 18);

  reduced_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        reduced_reg <= (OTHERS => to_unsigned(16#0000#, 14));
      ELSIF enb = '1' THEN
        reduced_reg(0) <= slicedOutput_1;
        reduced_reg(1 TO 185) <= reduced_reg(0 TO 184);
      END IF;
    END IF;
  END PROCESS reduced_process;

  slicedOutput_2 <= reduced_reg(185);

  slicedOutput_3 <= d5f_2(17 DOWNTO 0);

  slicedOutput_4 <= Gain_all_left_2(17 DOWNTO 0);

  reduced_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        reduced_reg_1 <= (OTHERS => to_unsigned(16#00000#, 18));
      ELSIF enb = '1' THEN
        reduced_reg_1(0) <= slicedOutput_4;
        reduced_reg_1(1 TO 185) <= reduced_reg_1(0 TO 184);
      END IF;
    END IF;
  END PROCESS reduced_1_process;

  slicedOutput_5 <= reduced_reg_1(185);

  mulOutput_1 <= slicedOutput * slicedOutput_2;

  mulOutput_2 <= resize(mulOutput_1, 64);

  bitshiftoutput <= mulOutput_2 sll 36;

  mulOutput_3 <= slicedOutput_3 * slicedOutput_2;

  mulOutput_4 <= resize(mulOutput_3, 64);

  bitshiftoutput_1 <= mulOutput_4 sll 18;

  mulOutput_5 <= resize(bitshiftoutput, 65) + resize(bitshiftoutput_1, 65);

  mulOutput_6 <= slicedOutput * slicedOutput_5;

  mulOutput_7 <= resize(mulOutput_6, 64);

  bitshiftoutput_2 <= mulOutput_7 sll 18;

  mulOutput_8 <= slicedOutput_3 * slicedOutput_5;

  mulOutput_9 <= resize(mulOutput_8, 64);

  mulOutput_10 <= resize(bitshiftoutput_2, 65) + resize(mulOutput_9, 65);

  mulOutput_11 <= resize(mulOutput_5, 66) + resize(mulOutput_10, 66);

  mulOutput_12 <= signed(mulOutput_11);

  SwitchComp_in2_uminus_in0 <=  - (resize(mulOutput_12, 67));
  mulOutput_13 <= SwitchComp_in2_uminus_in0(65 DOWNTO 0);

  
  mulOutput_14 <= mulOutput_13 WHEN switch_compare_1 = '0' ELSE
      mulOutput_12;

  mulOutput_15 <= mulOutput_14(63 DOWNTO 0);

  
  mulOutput_16 <= X"7FFFFFFF" WHEN (mulOutput_15(63) = '0') AND (mulOutput_15(62 DOWNTO 47) /= X"0000") ELSE
      X"80000000" WHEN (mulOutput_15(63) = '1') AND (mulOutput_15(62 DOWNTO 47) /= X"FFFF") ELSE
      mulOutput_15(47 DOWNTO 16);

  HA_left_data_out <= std_logic_vector(mulOutput_16);

  d5f_signed_1 <= signed(d5f_3);

  
  SignumOutput_3 <= to_signed(16#1#, 2) WHEN d5f_signed_1 > to_signed(0, 32) ELSE
      to_signed(-16#1#, 2) WHEN d5f_signed_1 < to_signed(0, 32) ELSE
      to_signed(16#0#, 2);

  Gain_all_right_signed <= signed(Gain_all_right);

  
  SignumOutput_4 <= to_signed(16#1#, 2) WHEN Gain_all_right_signed > to_signed(0, 32) ELSE
      to_signed(-16#1#, 2) WHEN Gain_all_right_signed < to_signed(0, 32) ELSE
      to_signed(16#0#, 2);

  delayMatch9_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        delayMatch9_reg <= (OTHERS => to_signed(16#0#, 2));
      ELSIF enb = '1' THEN
        delayMatch9_reg(0) <= SignumOutput_4;
        delayMatch9_reg(1 TO 185) <= delayMatch9_reg(0 TO 184);
      END IF;
    END IF;
  END PROCESS delayMatch9_process;

  SignumOutput_5 <= delayMatch9_reg(185);

  mul_sign1_mul_temp <= SignumOutput_3 * SignumOutput_5;
  mulOutput_17 <= mul_sign1_mul_temp(1 DOWNTO 0);

  
  switch_compare_1_1 <= '1' WHEN mulOutput_17 > to_signed(16#0#, 2) ELSE
      '0';

  Gain_right_in0_dtc_in_abs_cast <= resize(d5f_signed_1, 33);
  
  Gain_right_in0_dtc_in_abs_y <=  - (Gain_right_in0_dtc_in_abs_cast) WHEN d5f_signed_1 < to_signed(0, 32) ELSE
      resize(d5f_signed_1, 33);
  d5f_4 <= unsigned(Gain_right_in0_dtc_in_abs_y(31 DOWNTO 0));

  d5f_5 <= resize(d5f_4, 36);

  slicedOutput_6 <= d5f_5(31 DOWNTO 18);

  Gain_right_in1_dtc_in_abs_cast <= resize(Gain_all_right_signed, 33);
  
  Gain_right_in1_dtc_in_abs_y <=  - (Gain_right_in1_dtc_in_abs_cast) WHEN Gain_all_right_signed < to_signed(0, 32) ELSE
      resize(Gain_all_right_signed, 33);
  Gain_all_right_1 <= unsigned(Gain_right_in1_dtc_in_abs_y(31 DOWNTO 0));

  Gain_all_right_2 <= resize(Gain_all_right_1, 36);

  slicedOutput_7 <= Gain_all_right_2(31 DOWNTO 18);

  reduced_2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        reduced_reg_2 <= (OTHERS => to_unsigned(16#0000#, 14));
      ELSIF enb = '1' THEN
        reduced_reg_2(0) <= slicedOutput_7;
        reduced_reg_2(1 TO 185) <= reduced_reg_2(0 TO 184);
      END IF;
    END IF;
  END PROCESS reduced_2_process;

  slicedOutput_8 <= reduced_reg_2(185);

  slicedOutput_9 <= d5f_5(17 DOWNTO 0);

  slicedOutput_10 <= Gain_all_right_2(17 DOWNTO 0);

  reduced_3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        reduced_reg_3 <= (OTHERS => to_unsigned(16#00000#, 18));
      ELSIF enb = '1' THEN
        reduced_reg_3(0) <= slicedOutput_10;
        reduced_reg_3(1 TO 185) <= reduced_reg_3(0 TO 184);
      END IF;
    END IF;
  END PROCESS reduced_3_process;

  slicedOutput_11 <= reduced_reg_3(185);

  mulOutput_18 <= slicedOutput_6 * slicedOutput_8;

  mulOutput_19 <= resize(mulOutput_18, 64);

  bitshiftoutput_3 <= mulOutput_19 sll 36;

  mulOutput_20 <= slicedOutput_9 * slicedOutput_8;

  mulOutput_21 <= resize(mulOutput_20, 64);

  bitshiftoutput_4 <= mulOutput_21 sll 18;

  mulOutput_22 <= resize(bitshiftoutput_3, 65) + resize(bitshiftoutput_4, 65);

  mulOutput_23 <= slicedOutput_6 * slicedOutput_11;

  mulOutput_24 <= resize(mulOutput_23, 64);

  bitshiftoutput_5 <= mulOutput_24 sll 18;

  mulOutput_25 <= slicedOutput_9 * slicedOutput_11;

  mulOutput_26 <= resize(mulOutput_25, 64);

  mulOutput_27 <= resize(bitshiftoutput_5, 65) + resize(mulOutput_26, 65);

  mulOutput_28 <= resize(mulOutput_22, 66) + resize(mulOutput_27, 66);

  mulOutput_29 <= signed(mulOutput_28);

  SwitchComp_in2_uminus1_in0 <=  - (resize(mulOutput_29, 67));
  mulOutput_30 <= SwitchComp_in2_uminus1_in0(65 DOWNTO 0);

  
  mulOutput_31 <= mulOutput_30 WHEN switch_compare_1_1 = '0' ELSE
      mulOutput_29;

  mulOutput_32 <= mulOutput_31(63 DOWNTO 0);

  
  mulOutput_33 <= X"7FFFFFFF" WHEN (mulOutput_32(63) = '0') AND (mulOutput_32(62 DOWNTO 47) /= X"0000") ELSE
      X"80000000" WHEN (mulOutput_32(63) = '1') AND (mulOutput_32(62 DOWNTO 47) /= X"FFFF") ELSE
      mulOutput_32(47 DOWNTO 16);

  HA_right_data_out <= std_logic_vector(mulOutput_33);

  ce_out <= enb_1_1_1;

END rtl;
