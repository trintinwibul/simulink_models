-- -------------------------------------------------------------
-- 
-- File Name: hdlsrc\DynamicCompressionModel\Attack_Envelope.vhd
-- Created: 2019-07-24 15:04:52
-- 
-- Generated by MATLAB 9.6 and HDL Coder 3.14
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Attack_Envelope
-- Source Path: DynamicCompressionModel/recalculate/Nchan_FbankAGC_AID/Compression_1/Compression_Envelope/Attack_Envelope
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Attack_Envelope IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Curr                              :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        Desired                           :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        Enable                            :   IN    std_logic;
        Gain_out                          :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
        );
END Attack_Envelope;


ARCHITECTURE rtl OF Attack_Envelope IS

  -- Signals
  SIGNAL enb_gated                        : std_logic;
  SIGNAL Enable_out3                      : std_logic;
  SIGNAL r_att_1_out1                     : signed(63 DOWNTO 0);  -- sfix64_En60
  SIGNAL Curr_signed                      : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Desired_signed                   : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Subtract_sub_cast                : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Subtract_sub_cast_1              : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Subtract_out1                    : signed(32 DOWNTO 0);  -- sfix33_En28
  SIGNAL Product_mul_temp                 : signed(96 DOWNTO 0);  -- sfix97_En88
  SIGNAL Apply_Envelope                   : signed(63 DOWNTO 0);  -- sfix64_En60
  SIGNAL Subtract1_add_cast               : signed(64 DOWNTO 0);  -- sfix65_En60
  SIGNAL Subtract1_add_cast_1             : signed(64 DOWNTO 0);  -- sfix65_En60
  SIGNAL Subtract1_add_temp               : signed(64 DOWNTO 0);  -- sfix65_En60
  SIGNAL Subtract1_out1                   : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Subtract1_out1_bypass            : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Subtract1_out1_last_value        : signed(31 DOWNTO 0);  -- sfix32_En28

BEGIN
  -- ATTACK

  Enable_out3 <= Enable;

  enb_gated <= Enable_out3 AND enb;

  r_att_1_out1 <= signed'(X"0FFF0486C66A4280");

  Curr_signed <= signed(Curr);

  Desired_signed <= signed(Desired);

  Subtract_sub_cast <= resize(Curr_signed, 33);
  Subtract_sub_cast_1 <= resize(Desired_signed, 33);
  Subtract_out1 <= Subtract_sub_cast - Subtract_sub_cast_1;

  Product_mul_temp <= r_att_1_out1 * Subtract_out1;
  Apply_Envelope <= Product_mul_temp(91 DOWNTO 28);

  Subtract1_add_cast <= resize(Apply_Envelope, 65);
  Subtract1_add_cast_1 <= resize(Desired_signed & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 65);
  Subtract1_add_temp <= Subtract1_add_cast + Subtract1_add_cast_1;
  Subtract1_out1 <= Subtract1_add_temp(63 DOWNTO 32);

  Gain_out_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Subtract1_out1_last_value <= to_signed(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_gated = '1' THEN
        Subtract1_out1_last_value <= Subtract1_out1_bypass;
      END IF;
    END IF;
  END PROCESS Gain_out_bypass_process;


  
  Subtract1_out1_bypass <= Subtract1_out1_last_value WHEN Enable_out3 = '0' ELSE
      Subtract1_out1;

  Gain_out <= std_logic_vector(Subtract1_out1_bypass);

END rtl;

