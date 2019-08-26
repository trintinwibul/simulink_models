-- ------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\HA_sys8\FIRInterpolator1_block
-- Created: 2018-12-04 11:17:55
-- Generated by MATLAB 9.4 and HDL Coder 3.12
-- 
-- ------------------------------------------------------------
-- 
-- 
-- ------------------------------------------------------------
-- 
-- Module: FIRInterpolator1_block
-- Source Path: /FIRInterpolator1_block
-- 
-- ------------------------------------------------------------
-- 
-- HDL Implementation    : Fully Serial
-- Folding Factor        : 16
-- Multipliers           : 1


LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

ENTITY FIRInterpolator1_block IS
   PORT( clk                             :   IN    std_logic; 
         enb_16_1_1                      :   IN    std_logic; 
         reset                           :   IN    std_logic; 
         FIRInterpolator1_block_in       :   IN    std_logic_vector(32 DOWNTO 0); -- sfix33_En28
         FIRInterpolator1_block_out      :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
         );

END FIRInterpolator1_block;


----------------------------------------------------------------
--Module Architecture: FIRInterpolator1_block
----------------------------------------------------------------
ARCHITECTURE rtl OF FIRInterpolator1_block IS
  -- Local Functions
  -- Type Definitions
  TYPE delay_pipeline_type IS ARRAY (NATURAL range <>) OF signed(32 DOWNTO 0); -- sfix33_En28
  -- Constants
  CONSTANT coeffphase1_1                  : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase1_2                  : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase1_3                  : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase1_4                  : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase1_5                  : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase1_6                  : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase1_7                  : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase1_8                  : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase1_9                  : signed(32 DOWNTO 0) := (31 => '1',  OTHERS => '0'); -- sfix33_En31
  CONSTANT coeffphase1_10                 : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase1_11                 : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase1_12                 : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase1_13                 : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase1_14                 : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase1_15                 : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase1_16                 : signed(32 DOWNTO 0) := to_signed(0, 33); -- sfix33_En31
  CONSTANT coeffphase2_1                  : signed(32 DOWNTO 0) := to_signed(-367057, 33); -- sfix33_En31
  CONSTANT coeffphase2_2                  : signed(32 DOWNTO 0) := to_signed(2612983, 33); -- sfix33_En31
  CONSTANT coeffphase2_3                  : signed(32 DOWNTO 0) := to_signed(-9278972, 33); -- sfix33_En31
  CONSTANT coeffphase2_4                  : signed(32 DOWNTO 0) := to_signed(24561436, 33); -- sfix33_En31
  CONSTANT coeffphase2_5                  : signed(32 DOWNTO 0) := to_signed(-54977580, 33); -- sfix33_En31
  CONSTANT coeffphase2_6                  : signed(32 DOWNTO 0) := to_signed(112510743, 33); -- sfix33_En31
  CONSTANT coeffphase2_7                  : signed(32 DOWNTO 0) := to_signed(-231269353, 33); -- sfix33_En31
  CONSTANT coeffphase2_8                  : signed(32 DOWNTO 0) := to_signed(623980554, 33); -- sfix33_En31
  CONSTANT coeffphase2_9                  : signed(32 DOWNTO 0) := to_signed(1926498292, 33); -- sfix33_En31
  CONSTANT coeffphase2_10                 : signed(32 DOWNTO 0) := to_signed(-353372152, 33); -- sfix33_En31
  CONSTANT coeffphase2_11                 : signed(32 DOWNTO 0) := to_signed(159825713, 33); -- sfix33_En31
  CONSTANT coeffphase2_12                 : signed(32 DOWNTO 0) := to_signed(-79158272, 33); -- sfix33_En31
  CONSTANT coeffphase2_13                 : signed(32 DOWNTO 0) := to_signed(37331033, 33); -- sfix33_En31
  CONSTANT coeffphase2_14                 : signed(32 DOWNTO 0) := to_signed(-15505886, 33); -- sfix33_En31
  CONSTANT coeffphase2_15                 : signed(32 DOWNTO 0) := to_signed(5173182, 33); -- sfix33_En31
  CONSTANT coeffphase2_16                 : signed(32 DOWNTO 0) := to_signed(-1133184, 33); -- sfix33_En31
  CONSTANT coeffphase3_1                  : signed(32 DOWNTO 0) := to_signed(-962006, 33); -- sfix33_En31
  CONSTANT coeffphase3_2                  : signed(32 DOWNTO 0) := to_signed(5276969, 33); -- sfix33_En31
  CONSTANT coeffphase3_3                  : signed(32 DOWNTO 0) := to_signed(-17092938, 33); -- sfix33_En31
  CONSTANT coeffphase3_4                  : signed(32 DOWNTO 0) := to_signed(43016896, 33); -- sfix33_En31
  CONSTANT coeffphase3_5                  : signed(32 DOWNTO 0) := to_signed(-93504983, 33); -- sfix33_En31
  CONSTANT coeffphase3_6                  : signed(32 DOWNTO 0) := to_signed(189473302, 33); -- sfix33_En31
  CONSTANT coeffphase3_7                  : signed(32 DOWNTO 0) := to_signed(-400137009, 33); -- sfix33_En31
  CONSTANT coeffphase3_8                  : signed(32 DOWNTO 0) := to_signed(1347659956, 33); -- sfix33_En31
  CONSTANT coeffphase3_9                  : signed(32 DOWNTO 0) := to_signed(1347659956, 33); -- sfix33_En31
  CONSTANT coeffphase3_10                 : signed(32 DOWNTO 0) := to_signed(-400137009, 33); -- sfix33_En31
  CONSTANT coeffphase3_11                 : signed(32 DOWNTO 0) := to_signed(189473302, 33); -- sfix33_En31
  CONSTANT coeffphase3_12                 : signed(32 DOWNTO 0) := to_signed(-93504983, 33); -- sfix33_En31
  CONSTANT coeffphase3_13                 : signed(32 DOWNTO 0) := to_signed(43016896, 33); -- sfix33_En31
  CONSTANT coeffphase3_14                 : signed(32 DOWNTO 0) := to_signed(-17092938, 33); -- sfix33_En31
  CONSTANT coeffphase3_15                 : signed(32 DOWNTO 0) := to_signed(5276969, 33); -- sfix33_En31
  CONSTANT coeffphase3_16                 : signed(32 DOWNTO 0) := to_signed(-962006, 33); -- sfix33_En31
  CONSTANT coeffphase4_1                  : signed(32 DOWNTO 0) := to_signed(-1133184, 33); -- sfix33_En31
  CONSTANT coeffphase4_2                  : signed(32 DOWNTO 0) := to_signed(5173182, 33); -- sfix33_En31
  CONSTANT coeffphase4_3                  : signed(32 DOWNTO 0) := to_signed(-15505886, 33); -- sfix33_En31
  CONSTANT coeffphase4_4                  : signed(32 DOWNTO 0) := to_signed(37331033, 33); -- sfix33_En31
  CONSTANT coeffphase4_5                  : signed(32 DOWNTO 0) := to_signed(-79158272, 33); -- sfix33_En31
  CONSTANT coeffphase4_6                  : signed(32 DOWNTO 0) := to_signed(159825713, 33); -- sfix33_En31
  CONSTANT coeffphase4_7                  : signed(32 DOWNTO 0) := to_signed(-353372152, 33); -- sfix33_En31
  CONSTANT coeffphase4_8                  : signed(32 DOWNTO 0) := to_signed(1926498292, 33); -- sfix33_En31
  CONSTANT coeffphase4_9                  : signed(32 DOWNTO 0) := to_signed(623980554, 33); -- sfix33_En31
  CONSTANT coeffphase4_10                 : signed(32 DOWNTO 0) := to_signed(-231269353, 33); -- sfix33_En31
  CONSTANT coeffphase4_11                 : signed(32 DOWNTO 0) := to_signed(112510743, 33); -- sfix33_En31
  CONSTANT coeffphase4_12                 : signed(32 DOWNTO 0) := to_signed(-54977580, 33); -- sfix33_En31
  CONSTANT coeffphase4_13                 : signed(32 DOWNTO 0) := to_signed(24561436, 33); -- sfix33_En31
  CONSTANT coeffphase4_14                 : signed(32 DOWNTO 0) := to_signed(-9278972, 33); -- sfix33_En31
  CONSTANT coeffphase4_15                 : signed(32 DOWNTO 0) := to_signed(2612983, 33); -- sfix33_En31
  CONSTANT coeffphase4_16                 : signed(32 DOWNTO 0) := to_signed(-367057, 33); -- sfix33_En31

  CONSTANT const_zero                     : signed(65 DOWNTO 0) := to_signed(0, 66); -- sfix66_En59
  -- Signals
  SIGNAL cur_count                        : unsigned(5 DOWNTO 0); -- ufix6
  SIGNAL phase_0                          : std_logic; -- boolean
  SIGNAL phase_1                          : std_logic; -- boolean
  SIGNAL phase_16                         : std_logic; -- boolean
  SIGNAL phase_63                         : std_logic; -- boolean
  SIGNAL delay_pipeline                   : delay_pipeline_type(0 TO 15); -- sfix33_En28
  SIGNAL FIRInterpolator1_block_in_regtype : signed(32 DOWNTO 0); -- sfix33_En28
  SIGNAL inputmux                         : signed(32 DOWNTO 0); -- sfix33_En28
  SIGNAL product1                         : signed(65 DOWNTO 0); -- sfix66_En59
  SIGNAL product1_mux                     : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL phasemux                         : signed(65 DOWNTO 0); -- sfix66_En59
  SIGNAL prod_powertwo_1_9                : signed(65 DOWNTO 0); -- sfix66_En59
  SIGNAL powertwo_mux_1_9                 : signed(65 DOWNTO 0); -- sfix66_En59
  SIGNAL sumofproducts                    : signed(69 DOWNTO 0); -- sfix70_En59
  SIGNAL add_cast                         : signed(69 DOWNTO 0); -- sfix70_En59
  SIGNAL add_cast_1                       : signed(69 DOWNTO 0); -- sfix70_En59
  SIGNAL add_temp                         : signed(70 DOWNTO 0); -- sfix71_En59
  SIGNAL sumofproducts_cast               : signed(69 DOWNTO 0); -- sfix70_En59
  SIGNAL acc_sum                          : signed(69 DOWNTO 0); -- sfix70_En59
  SIGNAL accreg_in                        : signed(69 DOWNTO 0); -- sfix70_En59
  SIGNAL accreg_out                       : signed(69 DOWNTO 0); -- sfix70_En59
  SIGNAL add_cast_2                       : signed(69 DOWNTO 0); -- sfix70_En59
  SIGNAL add_cast_3                       : signed(69 DOWNTO 0); -- sfix70_En59
  SIGNAL add_temp_1                       : signed(70 DOWNTO 0); -- sfix71_En59
  SIGNAL accreg_final                     : signed(69 DOWNTO 0); -- sfix70_En59
  SIGNAL output_typeconvert               : signed(31 DOWNTO 0); -- sfix32_En28
  SIGNAL regout                           : signed(31 DOWNTO 0); -- sfix32_En28
  SIGNAL muxout                           : signed(31 DOWNTO 0); -- sfix32_En28


BEGIN

  -- Block Statements
  Counter : PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset = '1' THEN
        cur_count <= to_unsigned(63, 6);
      ELSIF enb_16_1_1 = '1' THEN
        IF cur_count >= to_unsigned(63, 6) THEN
          cur_count <= to_unsigned(0, 6);
        ELSE
          cur_count <= cur_count + to_unsigned(1, 6);
        END IF;
      END IF;
    END IF; 
  END PROCESS Counter;

  phase_0 <= '1' WHEN cur_count = to_unsigned(0, 6) AND enb_16_1_1 = '1' ELSE '0';

  phase_1 <= '1' WHEN  (((cur_count = to_unsigned(16, 6))  OR
                         (cur_count = to_unsigned(17, 6))  OR
                         (cur_count = to_unsigned(18, 6))  OR
                         (cur_count = to_unsigned(19, 6))  OR
                         (cur_count = to_unsigned(20, 6))  OR
                         (cur_count = to_unsigned(21, 6))  OR
                         (cur_count = to_unsigned(22, 6))  OR
                         (cur_count = to_unsigned(23, 6))  OR
                         (cur_count = to_unsigned(24, 6))  OR
                         (cur_count = to_unsigned(25, 6))  OR
                         (cur_count = to_unsigned(26, 6))  OR
                         (cur_count = to_unsigned(27, 6))  OR
                         (cur_count = to_unsigned(28, 6))  OR
                         (cur_count = to_unsigned(29, 6))  OR
                         (cur_count = to_unsigned(30, 6))  OR
                         (cur_count = to_unsigned(31, 6))  OR
                         (cur_count = to_unsigned(32, 6))  OR
                         (cur_count = to_unsigned(33, 6))  OR
                         (cur_count = to_unsigned(34, 6))  OR
                         (cur_count = to_unsigned(35, 6))  OR
                         (cur_count = to_unsigned(36, 6))  OR
                         (cur_count = to_unsigned(37, 6))  OR
                         (cur_count = to_unsigned(38, 6))  OR
                         (cur_count = to_unsigned(39, 6))  OR
                         (cur_count = to_unsigned(40, 6))  OR
                         (cur_count = to_unsigned(41, 6))  OR
                         (cur_count = to_unsigned(42, 6))  OR
                         (cur_count = to_unsigned(43, 6))  OR
                         (cur_count = to_unsigned(44, 6))  OR
                         (cur_count = to_unsigned(45, 6))  OR
                         (cur_count = to_unsigned(46, 6))  OR
                         (cur_count = to_unsigned(47, 6))  OR
                         (cur_count = to_unsigned(48, 6))  OR
                         (cur_count = to_unsigned(49, 6))  OR
                         (cur_count = to_unsigned(50, 6))  OR
                         (cur_count = to_unsigned(51, 6))  OR
                         (cur_count = to_unsigned(52, 6))  OR
                         (cur_count = to_unsigned(53, 6))  OR
                         (cur_count = to_unsigned(54, 6))  OR
                         (cur_count = to_unsigned(55, 6))  OR
                         (cur_count = to_unsigned(56, 6))  OR
                         (cur_count = to_unsigned(57, 6))  OR
                         (cur_count = to_unsigned(58, 6))  OR
                         (cur_count = to_unsigned(59, 6))  OR
                         (cur_count = to_unsigned(60, 6))  OR
                         (cur_count = to_unsigned(61, 6))  OR
                         (cur_count = to_unsigned(62, 6))  OR
                         (cur_count = to_unsigned(63, 6)))  AND enb_16_1_1 = '1') ELSE '0';

  phase_16 <= '1' WHEN  (((cur_count = to_unsigned(16, 6))  OR
                          (cur_count = to_unsigned(32, 6))  OR
                          (cur_count = to_unsigned(48, 6))  OR
                          (cur_count = to_unsigned(0, 6)))  AND enb_16_1_1 = '1') ELSE '0';

  phase_63 <= '1' WHEN cur_count = to_unsigned(63, 6) AND enb_16_1_1 = '1' ELSE '0';

  --   ---------------- Delay Registers ----------------

  Delay_Pipeline_process : PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset = '1' THEN
        delay_pipeline(0 TO 15) <= (OTHERS => (OTHERS => '0'));
      ELSIF phase_63 = '1' THEN
        delay_pipeline(0) <= signed(FIRInterpolator1_block_in);
        delay_pipeline(1 TO 15) <= delay_pipeline(0 TO 14);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_process;

  FIRInterpolator1_block_in_regtype <= signed(FIRInterpolator1_block_in);

  -- Mux(es) to select the input taps for multipliers 

  inputmux <= delay_pipeline(0) WHEN ( cur_count = to_unsigned(16, 6) ) ELSE
                   delay_pipeline(1) WHEN ( cur_count = to_unsigned(17, 6) ) ELSE
                   delay_pipeline(2) WHEN ( cur_count = to_unsigned(18, 6) ) ELSE
                   delay_pipeline(3) WHEN ( cur_count = to_unsigned(19, 6) ) ELSE
                   delay_pipeline(4) WHEN ( cur_count = to_unsigned(20, 6) ) ELSE
                   delay_pipeline(5) WHEN ( cur_count = to_unsigned(21, 6) ) ELSE
                   delay_pipeline(6) WHEN ( cur_count = to_unsigned(22, 6) ) ELSE
                   delay_pipeline(7) WHEN ( cur_count = to_unsigned(23, 6) ) ELSE
                   delay_pipeline(8) WHEN ( cur_count = to_unsigned(24, 6) ) ELSE
                   delay_pipeline(9) WHEN ( cur_count = to_unsigned(25, 6) ) ELSE
                   delay_pipeline(10) WHEN ( cur_count = to_unsigned(26, 6) ) ELSE
                   delay_pipeline(11) WHEN ( cur_count = to_unsigned(27, 6) ) ELSE
                   delay_pipeline(12) WHEN ( cur_count = to_unsigned(28, 6) ) ELSE
                   delay_pipeline(13) WHEN ( cur_count = to_unsigned(29, 6) ) ELSE
                   delay_pipeline(14) WHEN ( cur_count = to_unsigned(30, 6) ) ELSE
                   delay_pipeline(15) WHEN ( cur_count = to_unsigned(31, 6) ) ELSE
                   delay_pipeline(0) WHEN ( cur_count = to_unsigned(32, 6) ) ELSE
                   delay_pipeline(1) WHEN ( cur_count = to_unsigned(33, 6) ) ELSE
                   delay_pipeline(2) WHEN ( cur_count = to_unsigned(34, 6) ) ELSE
                   delay_pipeline(3) WHEN ( cur_count = to_unsigned(35, 6) ) ELSE
                   delay_pipeline(4) WHEN ( cur_count = to_unsigned(36, 6) ) ELSE
                   delay_pipeline(5) WHEN ( cur_count = to_unsigned(37, 6) ) ELSE
                   delay_pipeline(6) WHEN ( cur_count = to_unsigned(38, 6) ) ELSE
                   delay_pipeline(7) WHEN ( cur_count = to_unsigned(39, 6) ) ELSE
                   delay_pipeline(8) WHEN ( cur_count = to_unsigned(40, 6) ) ELSE
                   delay_pipeline(9) WHEN ( cur_count = to_unsigned(41, 6) ) ELSE
                   delay_pipeline(10) WHEN ( cur_count = to_unsigned(42, 6) ) ELSE
                   delay_pipeline(11) WHEN ( cur_count = to_unsigned(43, 6) ) ELSE
                   delay_pipeline(12) WHEN ( cur_count = to_unsigned(44, 6) ) ELSE
                   delay_pipeline(13) WHEN ( cur_count = to_unsigned(45, 6) ) ELSE
                   delay_pipeline(14) WHEN ( cur_count = to_unsigned(46, 6) ) ELSE
                   delay_pipeline(15) WHEN ( cur_count = to_unsigned(47, 6) ) ELSE
                   delay_pipeline(0) WHEN ( cur_count = to_unsigned(48, 6) ) ELSE
                   delay_pipeline(1) WHEN ( cur_count = to_unsigned(49, 6) ) ELSE
                   delay_pipeline(2) WHEN ( cur_count = to_unsigned(50, 6) ) ELSE
                   delay_pipeline(3) WHEN ( cur_count = to_unsigned(51, 6) ) ELSE
                   delay_pipeline(4) WHEN ( cur_count = to_unsigned(52, 6) ) ELSE
                   delay_pipeline(5) WHEN ( cur_count = to_unsigned(53, 6) ) ELSE
                   delay_pipeline(6) WHEN ( cur_count = to_unsigned(54, 6) ) ELSE
                   delay_pipeline(7) WHEN ( cur_count = to_unsigned(55, 6) ) ELSE
                   delay_pipeline(8) WHEN ( cur_count = to_unsigned(56, 6) ) ELSE
                   delay_pipeline(9) WHEN ( cur_count = to_unsigned(57, 6) ) ELSE
                   delay_pipeline(10) WHEN ( cur_count = to_unsigned(58, 6) ) ELSE
                   delay_pipeline(11) WHEN ( cur_count = to_unsigned(59, 6) ) ELSE
                   delay_pipeline(12) WHEN ( cur_count = to_unsigned(60, 6) ) ELSE
                   delay_pipeline(13) WHEN ( cur_count = to_unsigned(61, 6) ) ELSE
                   delay_pipeline(14) WHEN ( cur_count = to_unsigned(62, 6) ) ELSE
                   delay_pipeline(15);

  product1_mux <= coeffphase2_1 WHEN ( cur_count = to_unsigned(16, 6) ) ELSE
                       coeffphase2_2 WHEN ( cur_count = to_unsigned(17, 6) ) ELSE
                       coeffphase2_3 WHEN ( cur_count = to_unsigned(18, 6) ) ELSE
                       coeffphase2_4 WHEN ( cur_count = to_unsigned(19, 6) ) ELSE
                       coeffphase2_5 WHEN ( cur_count = to_unsigned(20, 6) ) ELSE
                       coeffphase2_6 WHEN ( cur_count = to_unsigned(21, 6) ) ELSE
                       coeffphase2_7 WHEN ( cur_count = to_unsigned(22, 6) ) ELSE
                       coeffphase2_8 WHEN ( cur_count = to_unsigned(23, 6) ) ELSE
                       coeffphase2_9 WHEN ( cur_count = to_unsigned(24, 6) ) ELSE
                       coeffphase2_10 WHEN ( cur_count = to_unsigned(25, 6) ) ELSE
                       coeffphase2_11 WHEN ( cur_count = to_unsigned(26, 6) ) ELSE
                       coeffphase2_12 WHEN ( cur_count = to_unsigned(27, 6) ) ELSE
                       coeffphase2_13 WHEN ( cur_count = to_unsigned(28, 6) ) ELSE
                       coeffphase2_14 WHEN ( cur_count = to_unsigned(29, 6) ) ELSE
                       coeffphase2_15 WHEN ( cur_count = to_unsigned(30, 6) ) ELSE
                       coeffphase2_16 WHEN ( cur_count = to_unsigned(31, 6) ) ELSE
                       coeffphase3_1 WHEN ( cur_count = to_unsigned(32, 6) ) ELSE
                       coeffphase3_2 WHEN ( cur_count = to_unsigned(33, 6) ) ELSE
                       coeffphase3_3 WHEN ( cur_count = to_unsigned(34, 6) ) ELSE
                       coeffphase3_4 WHEN ( cur_count = to_unsigned(35, 6) ) ELSE
                       coeffphase3_5 WHEN ( cur_count = to_unsigned(36, 6) ) ELSE
                       coeffphase3_6 WHEN ( cur_count = to_unsigned(37, 6) ) ELSE
                       coeffphase3_7 WHEN ( cur_count = to_unsigned(38, 6) ) ELSE
                       coeffphase3_8 WHEN ( cur_count = to_unsigned(39, 6) ) ELSE
                       coeffphase3_9 WHEN ( cur_count = to_unsigned(40, 6) ) ELSE
                       coeffphase3_10 WHEN ( cur_count = to_unsigned(41, 6) ) ELSE
                       coeffphase3_11 WHEN ( cur_count = to_unsigned(42, 6) ) ELSE
                       coeffphase3_12 WHEN ( cur_count = to_unsigned(43, 6) ) ELSE
                       coeffphase3_13 WHEN ( cur_count = to_unsigned(44, 6) ) ELSE
                       coeffphase3_14 WHEN ( cur_count = to_unsigned(45, 6) ) ELSE
                       coeffphase3_15 WHEN ( cur_count = to_unsigned(46, 6) ) ELSE
                       coeffphase3_16 WHEN ( cur_count = to_unsigned(47, 6) ) ELSE
                       coeffphase4_1 WHEN ( cur_count = to_unsigned(48, 6) ) ELSE
                       coeffphase4_2 WHEN ( cur_count = to_unsigned(49, 6) ) ELSE
                       coeffphase4_3 WHEN ( cur_count = to_unsigned(50, 6) ) ELSE
                       coeffphase4_4 WHEN ( cur_count = to_unsigned(51, 6) ) ELSE
                       coeffphase4_5 WHEN ( cur_count = to_unsigned(52, 6) ) ELSE
                       coeffphase4_6 WHEN ( cur_count = to_unsigned(53, 6) ) ELSE
                       coeffphase4_7 WHEN ( cur_count = to_unsigned(54, 6) ) ELSE
                       coeffphase4_8 WHEN ( cur_count = to_unsigned(55, 6) ) ELSE
                       coeffphase4_9 WHEN ( cur_count = to_unsigned(56, 6) ) ELSE
                       coeffphase4_10 WHEN ( cur_count = to_unsigned(57, 6) ) ELSE
                       coeffphase4_11 WHEN ( cur_count = to_unsigned(58, 6) ) ELSE
                       coeffphase4_12 WHEN ( cur_count = to_unsigned(59, 6) ) ELSE
                       coeffphase4_13 WHEN ( cur_count = to_unsigned(60, 6) ) ELSE
                       coeffphase4_14 WHEN ( cur_count = to_unsigned(61, 6) ) ELSE
                       coeffphase4_15 WHEN ( cur_count = to_unsigned(62, 6) ) ELSE
                       coeffphase4_16;
  product1 <= inputmux * product1_mux;

  phasemux <= product1 WHEN ( phase_1 = '1' ) ELSE
                   const_zero;

  -- Implementing products without a multiplier for coefficients with values equal to a power of 2.

  -- value of 'coeffphase1_9' is 1

  prod_powertwo_1_9 <= resize(delay_pipeline(8) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 66);

  -- Mux(es) to select the power of 2 products for the corresponding polyphase

  powertwo_mux_1_9 <= prod_powertwo_1_9 WHEN ( phase_0 = '1' ) ELSE
                           const_zero;

  -- Add the products in linear fashion

  add_cast <= resize(phasemux, 70);
  add_cast_1 <= resize(powertwo_mux_1_9, 70);
  add_temp <= resize(add_cast, 71) + resize(add_cast_1, 71);
  sumofproducts <= (69 => '0', OTHERS => '1') WHEN add_temp(70) = '0' AND add_temp(69) /= '0'
      ELSE (69 => '1', OTHERS => '0') WHEN add_temp(70) = '1' AND add_temp(69) /= '1'
      ELSE (add_temp(69 DOWNTO 0));

  -- Resize the sum of products to the accumulator type for full precision addition

  sumofproducts_cast <= sumofproducts;

  -- Accumulator register with a mux to reset it with the first addend

  add_cast_2 <= sumofproducts_cast;
  add_cast_3 <= accreg_out;
  add_temp_1 <= resize(add_cast_2, 71) + resize(add_cast_3, 71);
  acc_sum <= (69 => '0', OTHERS => '1') WHEN add_temp_1(70) = '0' AND add_temp_1(69) /= '0'
      ELSE (69 => '1', OTHERS => '0') WHEN add_temp_1(70) = '1' AND add_temp_1(69) /= '1'
      ELSE (add_temp_1(69 DOWNTO 0));

  accreg_in <= sumofproducts_cast WHEN ( phase_16 = '1' ) ELSE
                    acc_sum;

  Acc_reg_process : PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset = '1' THEN
        accreg_out <= (OTHERS => '0');
      ELSIF enb_16_1_1 = '1' THEN
        accreg_out <= accreg_in;
      END IF;
    END IF; 
  END PROCESS Acc_reg_process;

  -- Register to hold the final value of the accumulated sum

  Acc_finalreg_process : PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset = '1' THEN
        accreg_final <= (OTHERS => '0');
      ELSIF phase_16 = '1' THEN
        accreg_final <= accreg_out;
      END IF;
    END IF; 
  END PROCESS Acc_finalreg_process;

  output_typeconvert <= (31 => '0', OTHERS => '1') WHEN accreg_final(69) = '0' AND accreg_final(68 DOWNTO 62) /= "0000000"
      ELSE (31 => '1', OTHERS => '0') WHEN accreg_final(69) = '1' AND accreg_final(68 DOWNTO 62) /= "1111111"
      ELSE (accreg_final(62 DOWNTO 31));

  DataHoldRegister_process : PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset = '1' THEN
        regout <= (OTHERS => '0');
      ELSIF enb_16_1_1 = '1' THEN
        regout <= output_typeconvert;
      END IF;
    END IF; 
  END PROCESS DataHoldRegister_process;

  muxout <= output_typeconvert WHEN ( enb_16_1_1 = '1' ) ELSE
            regout;
  -- Assignment Statements
  FIRInterpolator1_block_out <= std_logic_vector(muxout);
END rtl;
