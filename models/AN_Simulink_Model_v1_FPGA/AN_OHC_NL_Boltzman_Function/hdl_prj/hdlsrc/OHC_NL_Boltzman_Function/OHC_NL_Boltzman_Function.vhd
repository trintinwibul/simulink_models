-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OHC_NL_Boltzman_Function\OHC_NL_Boltzman_Function.vhd
-- Created: 2020-04-15 17:34:49
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 2.08333e-05
-- Target subsystem base rate: 2.08333e-05
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
-- output                        ce_out        2.08333e-05
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: OHC_NL_Boltzman_Function
-- Source Path: OHC_NL_Boltzman_Function/OHC NL Boltzman Function
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.OHC_NL_Boltzman_Function_pkg.ALL;

ENTITY OHC_NL_Boltzman_Function IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        stimulus                          :   IN    std_logic_vector(31 DOWNTO 0);  -- single
        ce_out                            :   OUT   std_logic;
        output                            :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
        );
END OHC_NL_Boltzman_Function;


ARCHITECTURE rtl OF OHC_NL_Boltzman_Function IS

  -- Component Declarations
  COMPONENT nfp_sub_single
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          nfp_in1                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_in2                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
          );
  END COMPONENT;

  COMPONENT nfp_div_single
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          nfp_in1                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_in2                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
          );
  END COMPONENT;

  COMPONENT nfp_uminus_single
    PORT( nfp_in                          :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
          );
  END COMPONENT;

  COMPONENT nfp_exp_single
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          nfp_in                          :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
          );
  END COMPONENT;

  COMPONENT nfp_add_single
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          nfp_in1                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_in2                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
          );
  END COMPONENT;

  COMPONENT nfp_mul_single
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          nfp_in1                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_in2                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : nfp_sub_single
    USE ENTITY work.nfp_sub_single(rtl);

  FOR ALL : nfp_div_single
    USE ENTITY work.nfp_div_single(rtl);

  FOR ALL : nfp_uminus_single
    USE ENTITY work.nfp_uminus_single(rtl);

  FOR ALL : nfp_exp_single
    USE ENTITY work.nfp_exp_single(rtl);

  FOR ALL : nfp_add_single
    USE ENTITY work.nfp_add_single(rtl);

  FOR ALL : nfp_mul_single
    USE ENTITY work.nfp_mul_single(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL Constant6_out1                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Constant_out1                    : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Subtract_out1                    : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Constant1_out1                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Divide_out1                      : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Gain_out1                        : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Math_Function_out1               : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL delayMatch_reg                   : vector_of_std_logic_vector32(0 TO 10);  -- ufix32 [11]
  SIGNAL delayMatch_reg_next              : vector_of_std_logic_vector32(0 TO 10);  -- ufix32 [11]
  SIGNAL Math_Function_out1_1             : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Constant3_out1                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Subtract1_out1                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Constant4_out1                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Divide1_out1                     : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Gain1_out1                       : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Math_Function2_out1              : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Constant5_out1                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Add1_out1                        : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Product_out1                     : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Constant2_out1                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Add4_out1                        : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Divide2_out1                     : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Constant7_out1                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL out1                             : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Subtract2_out1                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL out_rsvd                         : std_logic_vector(31 DOWNTO 0);  -- ufix32

BEGIN
  -- Nonlinear Exponential Function
  -- 
  -- Nonlinear Exponential Function

  u_nfp_sub_comp : nfp_sub_single
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              nfp_in1 => stimulus,  -- single
              nfp_in2 => Constant_out1,  -- single
              nfp_out => Subtract_out1  -- single
              );

  u_nfp_div_comp : nfp_div_single
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              nfp_in1 => Subtract_out1,  -- single
              nfp_in2 => Constant1_out1,  -- single
              nfp_out => Divide_out1  -- single
              );

  u_nfp_uminus_comp : nfp_uminus_single
    PORT MAP( nfp_in => Divide_out1,  -- single
              nfp_out => Gain_out1  -- single
              );

  u_nfp_exp_comp : nfp_exp_single
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              nfp_in => Gain_out1,  -- single
              nfp_out => Math_Function_out1  -- single
              );

  u_nfp_sub_comp_1 : nfp_sub_single
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              nfp_in1 => stimulus,  -- single
              nfp_in2 => Constant3_out1,  -- single
              nfp_out => Subtract1_out1  -- single
              );

  u_nfp_div_comp_1 : nfp_div_single
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              nfp_in1 => Subtract1_out1,  -- single
              nfp_in2 => Constant4_out1,  -- single
              nfp_out => Divide1_out1  -- single
              );

  u_nfp_uminus_comp_1 : nfp_uminus_single
    PORT MAP( nfp_in => Divide1_out1,  -- single
              nfp_out => Gain1_out1  -- single
              );

  u_nfp_exp_comp_1 : nfp_exp_single
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              nfp_in => Gain1_out1,  -- single
              nfp_out => Math_Function2_out1  -- single
              );

  u_nfp_add_comp : nfp_add_single
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              nfp_in1 => Math_Function2_out1,  -- single
              nfp_in2 => Constant5_out1,  -- single
              nfp_out => Add1_out1  -- single
              );

  u_nfp_mul_comp : nfp_mul_single
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              nfp_in1 => Math_Function_out1_1,  -- single
              nfp_in2 => Add1_out1,  -- single
              nfp_out => Product_out1  -- single
              );

  u_nfp_add_comp_1 : nfp_add_single
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              nfp_in1 => Product_out1,  -- single
              nfp_in2 => Constant2_out1,  -- single
              nfp_out => Add4_out1  -- single
              );

  u_nfp_div_comp_2 : nfp_div_single
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              nfp_in1 => Constant6_out1,  -- single
              nfp_in2 => Add4_out1,  -- single
              nfp_out => Divide2_out1  -- single
              );

  u_nfp_sub_comp_2 : nfp_sub_single
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              nfp_in1 => Divide2_out1,  -- single
              nfp_in2 => Constant7_out1,  -- single
              nfp_out => out1  -- single
              );

  u_nfp_div_comp_3 : nfp_div_single
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              nfp_in1 => out1,  -- single
              nfp_in2 => Subtract2_out1,  -- single
              nfp_out => out_rsvd  -- single
              );

  Constant6_out1 <= X"3f800000";

  Constant_out1 <= X"40f2efe0";

  Constant1_out1 <= X"41400000";

  enb <= clk_enable;

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch_reg(0) <= X"00000000";
      delayMatch_reg(1) <= X"00000000";
      delayMatch_reg(2) <= X"00000000";
      delayMatch_reg(3) <= X"00000000";
      delayMatch_reg(4) <= X"00000000";
      delayMatch_reg(5) <= X"00000000";
      delayMatch_reg(6) <= X"00000000";
      delayMatch_reg(7) <= X"00000000";
      delayMatch_reg(8) <= X"00000000";
      delayMatch_reg(9) <= X"00000000";
      delayMatch_reg(10) <= X"00000000";
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch_reg(0) <= delayMatch_reg_next(0);
        delayMatch_reg(1) <= delayMatch_reg_next(1);
        delayMatch_reg(2) <= delayMatch_reg_next(2);
        delayMatch_reg(3) <= delayMatch_reg_next(3);
        delayMatch_reg(4) <= delayMatch_reg_next(4);
        delayMatch_reg(5) <= delayMatch_reg_next(5);
        delayMatch_reg(6) <= delayMatch_reg_next(6);
        delayMatch_reg(7) <= delayMatch_reg_next(7);
        delayMatch_reg(8) <= delayMatch_reg_next(8);
        delayMatch_reg(9) <= delayMatch_reg_next(9);
        delayMatch_reg(10) <= delayMatch_reg_next(10);
      END IF;
    END IF;
  END PROCESS delayMatch_process;

  Math_Function_out1_1 <= delayMatch_reg(10);
  delayMatch_reg_next(0) <= Math_Function_out1;
  delayMatch_reg_next(1) <= delayMatch_reg(0);
  delayMatch_reg_next(2) <= delayMatch_reg(1);
  delayMatch_reg_next(3) <= delayMatch_reg(2);
  delayMatch_reg_next(4) <= delayMatch_reg(3);
  delayMatch_reg_next(5) <= delayMatch_reg(4);
  delayMatch_reg_next(6) <= delayMatch_reg(5);
  delayMatch_reg_next(7) <= delayMatch_reg(6);
  delayMatch_reg_next(8) <= delayMatch_reg(7);
  delayMatch_reg_next(9) <= delayMatch_reg(8);
  delayMatch_reg_next(10) <= delayMatch_reg(9);

  Constant3_out1 <= X"40a00000";

  Constant4_out1 <= X"40a00000";

  Constant5_out1 <= X"3f800000";

  Constant2_out1 <= X"3f800000";

  Constant7_out1 <= X"3e000000";

  Subtract2_out1 <= X"3f600000";

  ce_out <= clk_enable;

  output <= out_rsvd;

END rtl;
