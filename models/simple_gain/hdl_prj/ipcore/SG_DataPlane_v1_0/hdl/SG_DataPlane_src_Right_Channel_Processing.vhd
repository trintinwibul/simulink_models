-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\SG\SG_DataPlane_src_Right_Channel_Processing.vhd
-- Created: 2019-08-02 11:10:20
-- 
-- Generated by MATLAB 9.6 and HDL Coder 3.14
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: SG_DataPlane_src_Right_Channel_Processing
-- Source Path: SG/SG_DataPlane/Avalon Data Processing/Right Channel Processing
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY SG_DataPlane_src_Right_Channel_Processing IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Right_Data_In                     :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        Right_Gain                        :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        Enable                            :   IN    std_logic;
        Right_Data_Out                    :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
        );
END SG_DataPlane_src_Right_Channel_Processing;


ARCHITECTURE rtl OF SG_DataPlane_src_Right_Channel_Processing IS

  -- Signals
  SIGNAL enb_gated                        : std_logic;
  SIGNAL Enable_out3                      : std_logic;
  SIGNAL Right_Data_In_signed             : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Right_Gain_signed                : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product_out1                     : signed(63 DOWNTO 0);  -- sfix64_En56
  SIGNAL Data_Type_Conversion_out1        : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Data_Type_Conversion_out1_bypass : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Data_Type_Conversion_out1_last_value : signed(31 DOWNTO 0);  -- sfix32_En28

  ATTRIBUTE multstyle : string;

BEGIN
  -- Apply Right Gain
  -- 
  -- An enabled subsystem
  -- This subsystem only runs when the data valid signal is enabled (asserted)
  -- 

  Enable_out3 <= Enable;

  enb_gated <= Enable_out3 AND enb;

  Right_Data_In_signed <= signed(Right_Data_In);

  Right_Gain_signed <= signed(Right_Gain);

  Product_out1 <= Right_Data_In_signed * Right_Gain_signed;

  Data_Type_Conversion_out1 <= Product_out1(59 DOWNTO 28);

  Right_Data_Out_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Data_Type_Conversion_out1_last_value <= to_signed(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_gated = '1' THEN
        Data_Type_Conversion_out1_last_value <= Data_Type_Conversion_out1_bypass;
      END IF;
    END IF;
  END PROCESS Right_Data_Out_bypass_process;


  
  Data_Type_Conversion_out1_bypass <= Data_Type_Conversion_out1_last_value WHEN Enable_out3 = '0' ELSE
      Data_Type_Conversion_out1;

  Right_Data_Out <= std_logic_vector(Data_Type_Conversion_out1_bypass);

END rtl;

