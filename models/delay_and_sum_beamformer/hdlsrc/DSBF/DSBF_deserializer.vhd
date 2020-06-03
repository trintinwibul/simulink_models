-- -------------------------------------------------------------
-- 
-- File Name: /mnt/data/NIH/simulink_models/models/delay_and_sum_beamformer/hdlsrc/DSBF/DSBF_deserializer.vhd
-- 
-- Generated by MATLAB 9.6 and HDL Coder 3.14
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: DSBF_deserializer
-- Source Path: DSBF/dataplane/Avalon Data Processing/deserializer
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DSBF_dataplane_pkg.ALL;

ENTITY DSBF_deserializer IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        data_in                           :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        valid_in                          :   IN    std_logic;
        channel_in                        :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
        valid_out                         :   OUT   std_logic;
        data_out                          :   OUT   vector_of_std_logic_vector32(0 TO 15)  -- sfix32_En28 [16]
        );
END DSBF_deserializer;


ARCHITECTURE rtl OF DSBF_deserializer IS

  ATTRIBUTE multstyle : string;

  -- Signals
  SIGNAL data_in_signed                   : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL channel_in_unsigned              : unsigned(3 DOWNTO 0);  -- ufix4
  SIGNAL data_out_tmp                     : vector_of_signed32(0 TO 15);  -- sfix32_En28 [16]
  SIGNAL data_out_temp                    : vector_of_signed32(0 TO 15);  -- sfix32 [16]
  SIGNAL data_out_reg                     : vector_of_signed32(0 TO 15);  -- sfix32 [16]
  SIGNAL data_out_temp_next               : vector_of_signed32(0 TO 15);  -- sfix32_En28 [16]
  SIGNAL data_out_reg_next                : vector_of_signed32(0 TO 15);  -- sfix32_En28 [16]

BEGIN
  data_in_signed <= signed(data_in);

  channel_in_unsigned <= unsigned(channel_in);

  deserializer_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_out_temp <= (OTHERS => to_signed(0, 32));
      data_out_reg <= (OTHERS => to_signed(0, 32));
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        data_out_temp <= data_out_temp_next;
        data_out_reg <= data_out_reg_next;
      END IF;
    END IF;
  END PROCESS deserializer_process;

  deserializer_output : PROCESS (channel_in_unsigned, data_in_signed, data_out_reg, data_out_temp, valid_in)
    VARIABLE data_out_temp_temp : vector_of_signed32(0 TO 15);
    VARIABLE add_temp : unsigned(4 DOWNTO 0);
    VARIABLE sub_cast : signed(31 DOWNTO 0);
  BEGIN
    --MATLAB Function 'dataplane/Avalon Data Processing/deserializer': '<S12>:1'
    --'<S12>:1:13'
    valid_out <= '0';
    --'<S12>:1:14'
    data_out_temp_temp := data_out_temp;
    data_out_reg_next <= data_out_reg;
    data_out_tmp <= data_out_reg;
    IF valid_in = '1' THEN 
      --'<S12>:1:17'
      --'<S12>:1:18'
      add_temp := resize(channel_in_unsigned, 5) + to_unsigned(16#01#, 5);
      sub_cast := signed(resize(add_temp, 32));
      data_out_temp_temp(to_integer(sub_cast - 1)) := data_in_signed;
      IF channel_in_unsigned = to_unsigned(16#F#, 4) THEN 
        --'<S12>:1:19'
        --'<S12>:1:20'
        valid_out <= '1';
        --'<S12>:1:21'
        data_out_reg_next <= data_out_temp_temp;
      END IF;
    END IF;
    data_out_temp_next <= data_out_temp_temp;
  END PROCESS deserializer_output;


  outputgen: FOR k IN 0 TO 15 GENERATE
    data_out(k) <= std_logic_vector(data_out_tmp(k));
  END GENERATE;

END rtl;
