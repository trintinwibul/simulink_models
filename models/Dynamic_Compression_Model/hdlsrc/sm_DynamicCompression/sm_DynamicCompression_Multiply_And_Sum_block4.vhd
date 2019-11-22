-- -------------------------------------------------------------
-- 
-- File Name: /home/cb54103/Documents/fpga-open-speech-tools/simulink_models/models/Dynamic_Compression_Model/hdlsrc/sm_DynamicCompression/sm_DynamicCompression_Multiply_And_Sum_block4.vhd
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: sm_DynamicCompression_Multiply_And_Sum_block4
-- Source Path: sm_DynamicCompression/dataplane/Avalon Data Processing/Left Channel Processing/recalculate/Static_pFIR/Multiply_And_Sum
-- Hierarchy Level: 5
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.sm_DynamicCompression_dataplane_pkg.ALL;

ENTITY sm_DynamicCompression_Multiply_And_Sum_block4 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        x_n_i                             :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        End_of_sample_calc                :   IN    std_logic;
        b_i                               :   IN    std_logic_vector(63 DOWNTO 0);  -- sfix64_En32
        Filtered_Output                   :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        Output_Valid                      :   OUT   std_logic
        );
END sm_DynamicCompression_Multiply_And_Sum_block4;


ARCHITECTURE rtl OF sm_DynamicCompression_Multiply_And_Sum_block4 IS

  ATTRIBUTE multstyle : string;

  -- Signals
  SIGNAL Bitwise_Operator_out1            : std_logic;
  SIGNAL delayMatch1_reg                  : std_logic_vector(0 TO 2049);  -- ufix1 [2050]
  SIGNAL Bitwise_Operator_out1_1          : std_logic;
  SIGNAL Constant_out1                    : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL x_n_i_signed                     : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL b_i_signed                       : signed(63 DOWNTO 0);  -- sfix64_En32
  SIGNAL delayMatch_reg                   : vector_of_signed64(0 TO 2049);  -- sfix64 [2050]
  SIGNAL b_i_1                            : signed(63 DOWNTO 0);  -- sfix64_En32
  SIGNAL mulOutput                        : signed(95 DOWNTO 0);  -- sfix96_En60
  SIGNAL Sum_memory_out1                  : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Multiply_Add_add_add_cast        : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Multiply_Add_out1                : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Reset_Switch_out1                : signed(31 DOWNTO 0);  -- sfix32_En28

  ATTRIBUTE multstyle OF mulOutput : SIGNAL IS "dsp";

BEGIN
  -- Try to use this at some point?
  -- 
  -- End_of_sample_calc triggers this subsystem to give the FIR output for this sample.
  -- Also, it resets the sum memory back to 0.

  Bitwise_Operator_out1 <=  NOT End_of_sample_calc;

  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch1_reg <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        delayMatch1_reg(0) <= Bitwise_Operator_out1;
        delayMatch1_reg(1 TO 2049) <= delayMatch1_reg(0 TO 2048);
      END IF;
    END IF;
  END PROCESS delayMatch1_process;

  Bitwise_Operator_out1_1 <= delayMatch1_reg(2049);

  Constant_out1 <= to_signed(0, 32);

  x_n_i_signed <= signed(x_n_i);

  b_i_signed <= signed(b_i);

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch_reg <= (OTHERS => to_signed(0, 64));
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        delayMatch_reg(0) <= b_i_signed;
        delayMatch_reg(1 TO 2049) <= delayMatch_reg(0 TO 2048);
      END IF;
    END IF;
  END PROCESS delayMatch_process;

  b_i_1 <= delayMatch_reg(2049);

  mulOutput <= x_n_i_signed * b_i_1;

  -- 
  Multiply_Add_add_add_cast <= mulOutput(63 DOWNTO 32);
  Multiply_Add_out1 <= Sum_memory_out1 + Multiply_Add_add_add_cast;

  
  Reset_Switch_out1 <= Constant_out1 WHEN Bitwise_Operator_out1_1 = '0' ELSE
      Multiply_Add_out1;

  Sum_memory_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Sum_memory_out1 <= to_signed(0, 32);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Sum_memory_out1 <= Reset_Switch_out1;
      END IF;
    END IF;
  END PROCESS Sum_memory_process;


  Filtered_Output <= std_logic_vector(Sum_memory_out1);

  Output_Valid <= End_of_sample_calc;

END rtl;
