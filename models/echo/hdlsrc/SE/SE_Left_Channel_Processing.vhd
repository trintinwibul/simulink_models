-- -------------------------------------------------------------
-- 
-- File Name: /mnt/data/NIH/simulink_models/models/echo/hdlsrc/SE/SE_Left_Channel_Processing.vhd
-- 
-- Generated by MATLAB 9.6 and HDL Coder 3.14
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: SE_Left_Channel_Processing
-- Source Path: SE/dataplane/Avalon Data Processing/Left Channel Processing
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.SE_dataplane_pkg.ALL;

ENTITY SE_Left_Channel_Processing IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Left_Data_In                      :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        Left_Bypass                       :   IN    std_logic;
        Left_Delay                        :   IN    std_logic_vector(14 DOWNTO 0);  -- ufix15
        Left_Decay                        :   IN    std_logic_vector(7 DOWNTO 0);  -- ufix8_En7
        Left_Wet_Dry_Mix                  :   IN    std_logic_vector(7 DOWNTO 0);  -- ufix8_En7
        Enable                            :   IN    std_logic;
        Left_Data_Out                     :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
        );
END SE_Left_Channel_Processing;


ARCHITECTURE rtl OF SE_Left_Channel_Processing IS

  ATTRIBUTE multstyle : string;

  -- Component Declarations
  COMPONENT SE_echo
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          input                           :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          delay                           :   IN    std_logic_vector(14 DOWNTO 0);  -- ufix15
          decay                           :   IN    std_logic_vector(7 DOWNTO 0);  -- ufix8_En7
          Enable_out6                     :   IN    std_logic;
          output                          :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
          );
  END COMPONENT;

  COMPONENT SE_mixer
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dry_signal                      :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          wet_signal                      :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          wet_dry_mix                     :   IN    std_logic_vector(7 DOWNTO 0);  -- ufix8_En7
          output                          :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : SE_echo
    USE ENTITY work.SE_echo(rtl);

  FOR ALL : SE_mixer
    USE ENTITY work.SE_mixer(rtl);

  -- Signals
  SIGNAL Enable_out6                      : std_logic;
  SIGNAL delayMatch2_reg                  : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL Enable_out6_1                    : std_logic;
  SIGNAL echo_out1                        : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL delayMatch1_reg                  : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL Left_Bypass_1                    : std_logic;
  SIGNAL mixer_out1                       : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL mixer_out1_signed                : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Left_Data_In_signed              : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL delayMatch_reg                   : vector_of_signed32(0 TO 1);  -- sfix32 [2]
  SIGNAL Left_Data_In_1                   : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Switch_out1                      : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Switch_out1_bypass               : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Switch_out1_last_value           : signed(31 DOWNTO 0);  -- sfix32_En28

BEGIN
  -- An enabled subsystem
  -- This subsystem only runs when the data valid signal is enabled (asserted)
  -- 

  u_echo : SE_echo
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              input => Left_Data_In,  -- sfix32_En28
              delay => Left_Delay,  -- ufix15
              decay => Left_Decay,  -- ufix8_En7
              Enable_out6 => Enable_out6,
              output => echo_out1  -- sfix32_En28
              );

  u_mixer : SE_mixer
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              dry_signal => Left_Data_In,  -- sfix32_En28
              wet_signal => echo_out1,  -- sfix32_En28
              wet_dry_mix => Left_Wet_Dry_Mix,  -- ufix8_En7
              output => mixer_out1  -- sfix32_En28
              );

  Enable_out6 <= Enable;

  delayMatch2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch2_reg <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        delayMatch2_reg(0) <= Enable_out6;
        delayMatch2_reg(1) <= delayMatch2_reg(0);
      END IF;
    END IF;
  END PROCESS delayMatch2_process;

  Enable_out6_1 <= delayMatch2_reg(1);

  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch1_reg <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        delayMatch1_reg(0) <= Left_Bypass;
        delayMatch1_reg(1) <= delayMatch1_reg(0);
      END IF;
    END IF;
  END PROCESS delayMatch1_process;

  Left_Bypass_1 <= delayMatch1_reg(1);

  mixer_out1_signed <= signed(mixer_out1);

  Left_Data_In_signed <= signed(Left_Data_In);

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch_reg <= (OTHERS => to_signed(0, 32));
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        delayMatch_reg(0) <= Left_Data_In_signed;
        delayMatch_reg(1) <= delayMatch_reg(0);
      END IF;
    END IF;
  END PROCESS delayMatch_process;

  Left_Data_In_1 <= delayMatch_reg(1);

  
  Switch_out1 <= mixer_out1_signed WHEN Left_Bypass_1 = '0' ELSE
      Left_Data_In_1;

  Left_Data_Out_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Switch_out1_last_value <= to_signed(0, 32);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Switch_out1_last_value <= Switch_out1_bypass;
      END IF;
    END IF;
  END PROCESS Left_Data_Out_bypass_process;


  
  Switch_out1_bypass <= Switch_out1_last_value WHEN Enable_out6_1 = '0' ELSE
      Switch_out1;

  Left_Data_Out <= std_logic_vector(Switch_out1_bypass);

END rtl;
