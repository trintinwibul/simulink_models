-- -------------------------------------------------------------
-- 
-- File Name: /mnt/data/trevor/research/NIH_SBIR_R44_DC015443/simulink_models/models/delay_and_sum_beamformer/hdlsrc/DSBF/DSBF_Sample_and_Hold1.vhd
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: DSBF_Sample_and_Hold1
-- Source Path: DSBF/dataplane/Avalon Data Processing/convert to sampling rate/Sample and Hold1
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DSBF_dataplane_pkg.ALL;

ENTITY DSBF_Sample_and_Hold1 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        In_rsvd                           :   IN    vector_of_std_logic_vector13(0 TO 15);  -- sfix13_En7 [16]
        Trigger                           :   IN    std_logic;
        alpha                             :   OUT   vector_of_std_logic_vector13(0 TO 15)  -- sfix13_En7 [16]
        );
END DSBF_Sample_and_Hold1;


ARCHITECTURE rtl OF DSBF_Sample_and_Hold1 IS

  -- Signals
  SIGNAL enb_gated                        : std_logic;
  SIGNAL Trigger_delayed                  : std_logic;
  SIGNAL Trigger_emulated                 : std_logic;
  SIGNAL In_signed                        : vector_of_signed13(0 TO 15);  -- sfix13_En7 [16]
  SIGNAL In_bypass                        : vector_of_signed13(0 TO 15);  -- sfix13_En7 [16]
  SIGNAL In_last_value                    : vector_of_signed13(0 TO 15);  -- sfix13_En7 [16]

BEGIN

  Trigger_delay_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Trigger_delayed <= '1';
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Trigger_delayed <= Trigger;
      END IF;
    END IF;
  END PROCESS Trigger_delay_process;

  Trigger_emulated <= NOT Trigger_delayed AND Trigger;

  enb_gated <= Trigger_emulated AND enb;

  outputgen1: FOR k IN 0 TO 15 GENERATE
    In_signed(k) <= signed(In_rsvd(k));
  END GENERATE;

  alpha_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      In_last_value <= (OTHERS => to_signed(16#0000#, 13));
    ELSIF rising_edge(clk) THEN
      IF enb_gated = '1' THEN
        In_last_value <= In_bypass;
      END IF;
    END IF;
  END PROCESS alpha_bypass_process;


  
  In_bypass <= In_last_value WHEN Trigger_emulated = '0' ELSE
      In_signed;

  outputgen: FOR k IN 0 TO 15 GENERATE
    alpha(k) <= std_logic_vector(In_bypass(k));
  END GENERATE;

END rtl;

