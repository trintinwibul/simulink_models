-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\wickh\Documents\NIH\simulink_models\models\fft_filters\hdlsrc\fft_filters\fft_filters_Hanning_ROM_block2.vhd
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: fft_filters_Hanning_ROM_block2
-- Source Path: fft_filters/dataplane/FFT_Analysis_Synthesis_Right/Synthesis/Overlap_and_Add/Hanning_ROM
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.fft_filters_dataplane_pkg.ALL;

ENTITY fft_filters_Hanning_ROM_block2 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_2048_1                      :   IN    std_logic;
        Index                             :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        hanning_value                     :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En22
        );
END fft_filters_Hanning_ROM_block2;


ARCHITECTURE rtl OF fft_filters_Hanning_ROM_block2 IS

  ATTRIBUTE multstyle : string;

  -- Constants
  CONSTANT Lookup_Table_table_data        : vector_of_signed24(0 TO 127) := 
    (to_signed(16#0009B7#, 24), to_signed(16#0026D7#, 24), to_signed(16#00574D#, 24), to_signed(16#009AFC#, 24),
     to_signed(16#00F1BB#, 24), to_signed(16#015B56#, 24), to_signed(16#01D78C#, 24), to_signed(16#026612#, 24),
     to_signed(16#030691#, 24), to_signed(16#03B8A9#, 24), to_signed(16#047BEC#, 24), to_signed(16#054FE4#, 24),
     to_signed(16#063410#, 24), to_signed(16#0727E7#, 24), to_signed(16#082AD4#, 24), to_signed(16#093C39#, 24),
     to_signed(16#0A5B70#, 24), to_signed(16#0B87CC#, 24), to_signed(16#0CC096#, 24), to_signed(16#0E0510#, 24),
     to_signed(16#0F5475#, 24), to_signed(16#10ADF9#, 24), to_signed(16#1210CA#, 24), to_signed(16#137C12#, 24),
     to_signed(16#14EEF3#, 24), to_signed(16#16688C#, 24), to_signed(16#17E7F8#, 24), to_signed(16#196C4F#, 24),
     to_signed(16#1AF4A3#, 24), to_signed(16#1C8008#, 24), to_signed(16#1E0D8D#, 24), to_signed(16#1F9C40#, 24),
     to_signed(16#212B30#, 24), to_signed(16#22B96B#, 24), to_signed(16#2445FD#, 24), to_signed(16#25CFF8#, 24),
     to_signed(16#27566B#, 24), to_signed(16#28D86A#, 24), to_signed(16#2A5509#, 24), to_signed(16#2BCB63#, 24),
     to_signed(16#2D3A93#, 24), to_signed(16#2EA1BB#, 24), to_signed(16#300000#, 24), to_signed(16#31548E#, 24),
     to_signed(16#329E97#, 24), to_signed(16#33DD51#, 24), to_signed(16#350FFB#, 24), to_signed(16#3635DB#, 24),
     to_signed(16#374E3F#, 24), to_signed(16#38587C#, 24), to_signed(16#3953F0#, 24), to_signed(16#3A4004#, 24),
     to_signed(16#3B1C27#, 24), to_signed(16#3BE7D4#, 24), to_signed(16#3CA28F#, 24), to_signed(16#3D4BE8#, 24),
     to_signed(16#3DE376#, 24), to_signed(16#3E68DE#, 24), to_signed(16#3EDBCF#, 24), to_signed(16#3F3C03#, 24),
     to_signed(16#3F8941#, 24), to_signed(16#3FC358#, 24), to_signed(16#3FEA25#, 24), to_signed(16#3FFD92#, 24),
     to_signed(16#3FFD92#, 24), to_signed(16#3FEA25#, 24), to_signed(16#3FC358#, 24), to_signed(16#3F8941#, 24),
     to_signed(16#3F3C03#, 24), to_signed(16#3EDBCF#, 24), to_signed(16#3E68DE#, 24), to_signed(16#3DE376#, 24),
     to_signed(16#3D4BE8#, 24), to_signed(16#3CA28F#, 24), to_signed(16#3BE7D4#, 24), to_signed(16#3B1C27#, 24),
     to_signed(16#3A4004#, 24), to_signed(16#3953F0#, 24), to_signed(16#38587C#, 24), to_signed(16#374E3F#, 24),
     to_signed(16#3635DB#, 24), to_signed(16#350FFB#, 24), to_signed(16#33DD51#, 24), to_signed(16#329E97#, 24),
     to_signed(16#31548E#, 24), to_signed(16#300000#, 24), to_signed(16#2EA1BB#, 24), to_signed(16#2D3A93#, 24),
     to_signed(16#2BCB63#, 24), to_signed(16#2A5509#, 24), to_signed(16#28D86A#, 24), to_signed(16#27566B#, 24),
     to_signed(16#25CFF8#, 24), to_signed(16#2445FD#, 24), to_signed(16#22B96B#, 24), to_signed(16#212B30#, 24),
     to_signed(16#1F9C40#, 24), to_signed(16#1E0D8D#, 24), to_signed(16#1C8008#, 24), to_signed(16#1AF4A3#, 24),
     to_signed(16#196C4F#, 24), to_signed(16#17E7F8#, 24), to_signed(16#16688C#, 24), to_signed(16#14EEF3#, 24),
     to_signed(16#137C12#, 24), to_signed(16#1210CA#, 24), to_signed(16#10ADF9#, 24), to_signed(16#0F5475#, 24),
     to_signed(16#0E0510#, 24), to_signed(16#0CC096#, 24), to_signed(16#0B87CC#, 24), to_signed(16#0A5B70#, 24),
     to_signed(16#093C39#, 24), to_signed(16#082AD4#, 24), to_signed(16#0727E7#, 24), to_signed(16#063410#, 24),
     to_signed(16#054FE4#, 24), to_signed(16#047BEC#, 24), to_signed(16#03B8A9#, 24), to_signed(16#030691#, 24),
     to_signed(16#026612#, 24), to_signed(16#01D78C#, 24), to_signed(16#015B56#, 24), to_signed(16#00F1BB#, 24),
     to_signed(16#009AFC#, 24), to_signed(16#00574D#, 24), to_signed(16#0026D7#, 24), to_signed(16#0009B7#, 24));  -- sfix24 [128]

  -- Signals
  SIGNAL Index_1                          : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Bit_Slice_out1                   : unsigned(6 DOWNTO 0);  -- ufix7
  SIGNAL Lookup_Table_k                   : unsigned(6 DOWNTO 0);  -- ufix7
  SIGNAL Lookup_Table_out1                : signed(23 DOWNTO 0);  -- sfix24_En22
  SIGNAL Lookup_Table_out1_1              : signed(23 DOWNTO 0) := to_signed(16#000000#, 24);  -- sfix24_En22
  SIGNAL Unit_Delay_bypass_reg            : signed(23 DOWNTO 0);  -- sfix24
  SIGNAL Lookup_Table_out1_2              : signed(23 DOWNTO 0);  -- sfix24_En22

BEGIN
  Index_1 <= unsigned(Index);

  Bit_Slice_out1 <= Index_1(6 DOWNTO 0);

  
  Lookup_Table_k <= to_unsigned(16#00#, 7) WHEN Bit_Slice_out1 = to_unsigned(16#00#, 7) ELSE
      to_unsigned(16#7F#, 7) WHEN Bit_Slice_out1 = to_unsigned(16#7F#, 7) ELSE
      Bit_Slice_out1;
  Lookup_Table_out1 <= Lookup_Table_table_data(to_integer(Lookup_Table_k));

  PipelineRegister_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF enb = '1' THEN
        Lookup_Table_out1_1 <= Lookup_Table_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Unit_Delay_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay_bypass_reg <= to_signed(16#000000#, 24);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_1 = '1' THEN
        Unit_Delay_bypass_reg <= Lookup_Table_out1_1;
      END IF;
    END IF;
  END PROCESS Unit_Delay_bypass_process;

  
  Lookup_Table_out1_2 <= Lookup_Table_out1_1 WHEN enb_1_2048_1 = '1' ELSE
      Unit_Delay_bypass_reg;

  hanning_value <= std_logic_vector(Lookup_Table_out1_2);

END rtl;

