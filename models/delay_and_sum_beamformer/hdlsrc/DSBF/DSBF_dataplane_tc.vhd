-- -------------------------------------------------------------
-- 
-- File Name: /mnt/data/trevor/research/NIH_SBIR_R44_DC015443/simulink_models/models/delay_and_sum_beamformer/hdlsrc/DSBF/DSBF_dataplane_tc.vhd
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: DSBF_dataplane_tc
-- Source Path: dataplane_tc
-- Hierarchy Level: 1
-- 
-- Master clock enable input: clk_enable
-- 
-- enb         : identical to clk_enable
-- enb_1_1_1   : identical to clk_enable
-- enb_1_64_0  : 64x slower than clk with last phase
-- enb_1_64_1  : 64x slower than clk with phase 1
-- enb_1_2048_0: 2048x slower than clk with last phase
-- enb_1_2048_1: 2048x slower than clk with phase 1
-- enb_1_2048_5: 2048x slower than clk with phase 5
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY DSBF_dataplane_tc IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        enb                               :   OUT   std_logic;
        enb_1_1_1                         :   OUT   std_logic;
        enb_1_64_0                        :   OUT   std_logic;
        enb_1_64_1                        :   OUT   std_logic;
        enb_1_2048_0                      :   OUT   std_logic;
        enb_1_2048_1                      :   OUT   std_logic;
        enb_1_2048_5                      :   OUT   std_logic
        );
END DSBF_dataplane_tc;


ARCHITECTURE rtl OF DSBF_dataplane_tc IS

  -- Signals
  SIGNAL count64                          : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL phase_0                          : std_logic;
  SIGNAL phase_0_tmp                      : std_logic;
  SIGNAL phase_1                          : std_logic;
  SIGNAL phase_1_tmp                      : std_logic;
  SIGNAL count2048                        : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL phase_all                        : std_logic;
  SIGNAL phase_0_1                        : std_logic;
  SIGNAL phase_0_tmp_1                    : std_logic;
  SIGNAL phase_1_1                        : std_logic;
  SIGNAL phase_1_tmp_1                    : std_logic;
  SIGNAL phase_5                          : std_logic;
  SIGNAL phase_5_tmp                      : std_logic;

BEGIN
  Counter64 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      count64 <= to_unsigned(1, 6);
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        IF count64 >= to_unsigned(63, 6) THEN
          count64 <= to_unsigned(0, 6);
        ELSE
          count64 <= count64 + to_unsigned(1, 6);
        END IF;
      END IF;
    END IF; 
  END PROCESS Counter64;

  temp_process1 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phase_0 <= '0';
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        phase_0 <= phase_0_tmp;
      END IF;
    END IF; 
  END PROCESS temp_process1;

  phase_0_tmp <= '1' WHEN count64 = to_unsigned(63, 6) AND clk_enable = '1' ELSE '0';

  temp_process2 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phase_1 <= '1';
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        phase_1 <= phase_1_tmp;
      END IF;
    END IF; 
  END PROCESS temp_process2;

  phase_1_tmp <= '1' WHEN count64 = to_unsigned(0, 6) AND clk_enable = '1' ELSE '0';

  Counter2048 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      count2048 <= to_unsigned(1, 11);
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        IF count2048 >= to_unsigned(2047, 11) THEN
          count2048 <= to_unsigned(0, 11);
        ELSE
          count2048 <= count2048 + to_unsigned(1, 11);
        END IF;
      END IF;
    END IF; 
  END PROCESS Counter2048;

  phase_all <= '1' WHEN clk_enable = '1' ELSE '0';

  temp_process3 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phase_0_1 <= '0';
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        phase_0_1 <= phase_0_tmp_1;
      END IF;
    END IF; 
  END PROCESS temp_process3;

  phase_0_tmp_1 <= '1' WHEN count2048 = to_unsigned(2047, 11) AND clk_enable = '1' ELSE '0';

  temp_process4 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phase_1_1 <= '1';
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        phase_1_1 <= phase_1_tmp_1;
      END IF;
    END IF; 
  END PROCESS temp_process4;

  phase_1_tmp_1 <= '1' WHEN count2048 = to_unsigned(0, 11) AND clk_enable = '1' ELSE '0';

  temp_process5 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phase_5 <= '0';
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        phase_5 <= phase_5_tmp;
      END IF;
    END IF; 
  END PROCESS temp_process5;

  phase_5_tmp <= '1' WHEN count2048 = to_unsigned(4, 11) AND clk_enable = '1' ELSE '0';

  enb <=  phase_all AND clk_enable;

  enb_1_1_1 <=  phase_all AND clk_enable;

  enb_1_64_0 <=  phase_0 AND clk_enable;

  enb_1_64_1 <=  phase_1 AND clk_enable;

  enb_1_2048_0 <=  phase_0_1 AND clk_enable;

  enb_1_2048_1 <=  phase_1_1 AND clk_enable;

  enb_1_2048_5 <=  phase_5 AND clk_enable;


END rtl;

