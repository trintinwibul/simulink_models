-- -------------------------------------------------------------
-- 
-- File Name: /home/cb54103/Documents/fpga-open-speech-tools/simulink_models/models/Dynamic_Compression_Model/hdlsrc/sm_DynamicCompression/sm_DynamicCompression_Data_Type_Conversion_Inherited_B_block1.vhd
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: sm_DynamicCompression_Data_Type_Conversion_Inherited_B_block1
-- Source Path: sm_DynamicCompression/dataplane/Avalon Data Processing/Left Channel Processing/recalculate/Nchan_FbankAGC_AID/Static_pFIR2/B_k_Memory_Block/Data 
-- Type Conversion Inherited 
-- Hierarchy Level: 7
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY sm_DynamicCompression_Data_Type_Conversion_Inherited_B_block1 IS
  PORT( u                                 :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        y                                 :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
        );
END sm_DynamicCompression_Data_Type_Conversion_Inherited_B_block1;


ARCHITECTURE rtl OF sm_DynamicCompression_Data_Type_Conversion_Inherited_B_block1 IS

BEGIN

  y <= u;

END rtl;

