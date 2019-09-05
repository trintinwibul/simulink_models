-- -------------------------------------------------------------
-- 
-- File Name: hdlsrc\DynamicCompressionModel\Addr_Organizer.vhd
-- Created: 2019-07-24 15:04:52
-- 
-- Generated by MATLAB 9.6 and HDL Coder 3.14
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Addr_Organizer
-- Source Path: DynamicCompressionModel/recalculate/Nchan_FbankAGC_AID/Addr_Organizer
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Addr_Organizer IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Reset_Count                       :   IN    std_logic;
        Valid_in                          :   IN    std_logic;
        Addr                              :   OUT   std_logic_vector(8 DOWNTO 0);  -- ufix9
        Sel                               :   OUT   std_logic_vector(2 DOWNTO 0)  -- ufix3
        );
END Addr_Organizer;


ARCHITECTURE rtl OF Addr_Organizer IS

  -- Signals
  SIGNAL Counter_up_to_320_out1           : unsigned(11 DOWNTO 0);  -- ufix12
  SIGNAL Bit_Slice_out1                   : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL top3Bits                         : unsigned(2 DOWNTO 0);  -- ufix3

BEGIN
  -- Addr line contains the local address bits: 0-63
  -- 
  -- Select Line is 000 to 101, if 110 writing is complete

  -- Count limited, Unsigned Counter
  --  initial value   = 2560
  --  step value      = 1
  --  count to value  = 2561
  Counter_up_to_320_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Counter_up_to_320_out1 <= to_unsigned(16#A00#, 12);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF Reset_Count = '1' THEN 
          Counter_up_to_320_out1 <= to_unsigned(16#A00#, 12);
        ELSIF Valid_in = '1' THEN 
          IF Counter_up_to_320_out1 >= to_unsigned(16#A01#, 12) THEN 
            Counter_up_to_320_out1 <= to_unsigned(16#A00#, 12);
          ELSE 
            Counter_up_to_320_out1 <= Counter_up_to_320_out1 + to_unsigned(16#001#, 12);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS Counter_up_to_320_process;


  Bit_Slice_out1 <= Counter_up_to_320_out1(8 DOWNTO 0);

  Addr <= std_logic_vector(Bit_Slice_out1);

  top3Bits <= Counter_up_to_320_out1(11 DOWNTO 9);

  Sel <= std_logic_vector(top3Bits);

END rtl;
