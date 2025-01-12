-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\conno\Documents\NIH-GitHub\simulink_models\models\fft_filters\hdlsrc\fft_filters\fft_filters_FFT_Frame_Buffering.vhd
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: fft_filters_FFT_Frame_Buffering
-- Source Path: fft_filters/dataplane/FFT_Analysis_Synthesis_Left/Analysis/FFT Frame Buffering
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fft_filters_FFT_Frame_Buffering IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_16_0                        :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_2048_0                      :   IN    std_logic;
        enb_1_16_1                        :   IN    std_logic;
        enb_1_2048_1                      :   IN    std_logic;
        Sample_Data_in                    :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
        passthrough_in                    :   IN    std_logic;
        filter_select                     :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        Data_to_FFT                       :   OUT   std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
        Valid_to_FFT                      :   OUT   std_logic;
        FFT_Frame_Start_Pulse             :   OUT   std_logic;
        passthrough                       :   OUT   std_logic;
        filter_select_out                 :   OUT   std_logic_vector(1 DOWNTO 0)  -- ufix2
        );
END fft_filters_FFT_Frame_Buffering;


ARCHITECTURE rtl OF fft_filters_FFT_Frame_Buffering IS

  ATTRIBUTE multstyle : string;

  -- Component Declarations
  COMPONENT fft_filters_addr_A_offset
    PORT( counter_A                       :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          addr_A                          :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
          );
  END COMPONENT;

  COMPONENT fft_filters_FFT_pulse_gen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          counter                         :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          FFT_start_pulse                 :   OUT   std_logic;
          Enable_FFTs                     :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT fft_filters_Fast_Transition
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          enb_1_16_1                      :   IN    std_logic;
          enb_1_2048_1                    :   IN    std_logic;
          Slow_Pulse                      :   IN    std_logic;
          Slow_Enable                     :   IN    std_logic;
          Slow_Passthrough                :   IN    std_logic;
          Slow_select                     :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
          Fast_Pulse                      :   OUT   std_logic;
          Fast_Enable                     :   OUT   std_logic;
          Fast_Passthrough                :   OUT   std_logic;
          Fast_select                     :   OUT   std_logic_vector(1 DOWNTO 0)  -- ufix2
          );
  END COMPONENT;

  COMPONENT fft_filters_addr_B_gen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_16_0                      :   IN    std_logic;
          start                           :   IN    std_logic;
          enable                          :   IN    std_logic;
          addr_B                          :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          Frame_counter                   :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          FFT_Valid                       :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT fft_filters_DualRateDualPortRAM_generic
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          enb_1_16_0                      :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          din_A                           :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          addr_A                          :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          we_A                            :   IN    std_logic;
          din_B                           :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          addr_B                          :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          we_B                            :   IN    std_logic;
          doutA                           :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          doutB                           :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)  -- generic width
          );
  END COMPONENT;

  COMPONENT fft_filters_Hanning_ROM
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_16_1                      :   IN    std_logic;
          Index                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          hanning_value                   :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : fft_filters_addr_A_offset
    USE ENTITY work.fft_filters_addr_A_offset(rtl);

  FOR ALL : fft_filters_FFT_pulse_gen
    USE ENTITY work.fft_filters_FFT_pulse_gen(rtl);

  FOR ALL : fft_filters_Fast_Transition
    USE ENTITY work.fft_filters_Fast_Transition(rtl);

  FOR ALL : fft_filters_addr_B_gen
    USE ENTITY work.fft_filters_addr_B_gen(rtl);

  FOR ALL : fft_filters_DualRateDualPortRAM_generic
    USE ENTITY work.fft_filters_DualRateDualPortRAM_generic(rtl);

  FOR ALL : fft_filters_Hanning_ROM
    USE ENTITY work.fft_filters_Hanning_ROM(rtl);

  -- Signals
  SIGNAL counter_A_out1                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL addr_A_offset_out1               : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL Always_Write_A_out1              : std_logic;
  SIGNAL Never_Write_B_out1               : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL FFT_pulse_gen_out1               : std_logic;
  SIGNAL FFT_pulse_gen_out2               : std_logic;
  SIGNAL Fast_Transition_out1             : std_logic;
  SIGNAL Fast_Transition_out2             : std_logic;
  SIGNAL Fast_Transition_out3             : std_logic;
  SIGNAL Fast_Transition_out4             : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL addr_B_gen_out1                  : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL addr_B_gen_out2                  : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL addr_B_gen_out3                  : std_logic;
  SIGNAL Always_Read_B_out1               : std_logic;
  SIGNAL DPRAM_out1                       : std_logic_vector(23 DOWNTO 0);  -- ufix24
  SIGNAL DPRAM_out2                       : std_logic_vector(23 DOWNTO 0);  -- ufix24
  SIGNAL DPRAM_out2_1                     : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL DPRAM_out2_2                     : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL Hanning_ROM_out1                 : std_logic_vector(23 DOWNTO 0);  -- ufix24
  SIGNAL Hanning_ROM_out1_1               : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL Hanning_ROM_out1_2               : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL Product_out1                     : signed(47 DOWNTO 0);  -- sfix48_En46
  SIGNAL Product_out1_1                   : signed(47 DOWNTO 0);  -- sfix48_En46
  SIGNAL Data_Type_Conversion_out1        : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL FFT_bypass_reg                   : signed(23 DOWNTO 0);  -- sfix24
  SIGNAL Data_Type_Conversion_out1_1      : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL Unit_Delay_out1                  : std_logic := '0';

BEGIN
  -- The valid needs to be delayed
  -- to complensate for the latency 
  -- of the DPRAM and the 
  -- Hanning_ROM
  -- 
  -- When a FFT frame pulse
  -- is received, create addresses for
  -- Port B to stream a data frame
  -- to the FFT engine.
  -- 
  -- Apply a Hanning Window
  -- before computing FFT.  This
  -- is done by looking up the
  -- appropiate Hanning value
  -- and applied to the data as the
  -- data is streamed to the
  -- FFT engine.
  -- 
  -- Frame pulses don't start
  -- until there is enough data
  -- in the circular buffer.
  -- 
  -- The size of Dual Port RAM is specified by the variable DPRAM1_size 
  -- and is typically twice the FFT size.  Ports A and B are running at different clock rates.
  -- 
  -- Circular Buffer 
  -- Port A Address Generator
  -- 
  -- Port A of Dual Port RAM
  -- 
  -- Data is written to circular buffer at input sample rate.
  -- Write is always enabled.  Port A is never read so output is ignored.
  -- 
  -- Transition to
  -- Fast Clock
  -- for FFT Processing 
  -- 
  -- 
  -- 
  -- 
  -- 
  -- 
  -- 
  -- 
  -- 
  -- 
  -- 
  -- 
  -- 
  -- 
  -- 
  -- 
  -- Port B of Dual Port RAM
  -- 
  -- Data is read from the circular buffer at a higher clock rate.
  -- Read is always enabled.  Port B never writes so input data to port B
  -- is ignored (specified as zero).

  u_addr_A_offset : fft_filters_addr_A_offset
    PORT MAP( counter_A => std_logic_vector(counter_A_out1),  -- uint8
              addr_A => addr_A_offset_out1  -- uint8
              );

  u_FFT_pulse_gen : fft_filters_FFT_pulse_gen
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              counter => std_logic_vector(counter_A_out1),  -- uint8
              FFT_start_pulse => FFT_pulse_gen_out1,
              Enable_FFTs => FFT_pulse_gen_out2
              );

  u_Fast_Transition : fft_filters_Fast_Transition
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              enb_1_16_1 => enb_1_16_1,
              enb_1_2048_1 => enb_1_2048_1,
              Slow_Pulse => FFT_pulse_gen_out1,
              Slow_Enable => FFT_pulse_gen_out2,
              Slow_Passthrough => passthrough_in,
              Slow_select => filter_select,  -- ufix2
              Fast_Pulse => Fast_Transition_out1,
              Fast_Enable => Fast_Transition_out2,
              Fast_Passthrough => Fast_Transition_out3,
              Fast_select => Fast_Transition_out4  -- ufix2
              );

  u_addr_B_gen : fft_filters_addr_B_gen
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_16_0 => enb_1_16_0,
              start => Fast_Transition_out1,
              enable => Fast_Transition_out2,
              addr_B => addr_B_gen_out1,  -- uint8
              Frame_counter => addr_B_gen_out2,  -- uint8
              FFT_Valid => addr_B_gen_out3
              );

  u_DPRAM : fft_filters_DualRateDualPortRAM_generic
    GENERIC MAP( AddrWidth => 8,
                 DataWidth => 24
                 )
    PORT MAP( clk => clk,
              enb_1_16_0 => enb_1_16_0,
              enb_1_2048_0 => enb_1_2048_0,
              din_A => Sample_Data_in,
              addr_A => addr_A_offset_out1,
              we_A => Always_Write_A_out1,
              din_B => std_logic_vector(Never_Write_B_out1),
              addr_B => addr_B_gen_out1,
              we_B => Always_Read_B_out1,
              doutA => DPRAM_out1,
              doutB => DPRAM_out2
              );

  u_Hanning_ROM : fft_filters_Hanning_ROM
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1_16_1 => enb_1_16_1,
              Index => addr_B_gen_out2,  -- uint8
              hanning_value => Hanning_ROM_out1  -- sfix24_En23
              );

  -- Free running, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  counter_A_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      counter_A_out1 <= to_unsigned(16#00#, 8);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        counter_A_out1 <= counter_A_out1 + to_unsigned(16#01#, 8);
      END IF;
    END IF;
  END PROCESS counter_A_process;


  Always_Write_A_out1 <= '1';

  Never_Write_B_out1 <= to_signed(16#000000#, 24);

  Always_Read_B_out1 <= '0';

  DPRAM_out2_1 <= signed(DPRAM_out2);

  HwModeRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      DPRAM_out2_2 <= to_signed(16#000000#, 24);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        DPRAM_out2_2 <= DPRAM_out2_1;
      END IF;
    END IF;
  END PROCESS HwModeRegister_process;


  Hanning_ROM_out1_1 <= signed(Hanning_ROM_out1);

  HwModeRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Hanning_ROM_out1_2 <= to_signed(16#000000#, 24);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Hanning_ROM_out1_2 <= Hanning_ROM_out1_1;
      END IF;
    END IF;
  END PROCESS HwModeRegister1_process;


  Product_out1 <= DPRAM_out2_2 * Hanning_ROM_out1_2;

  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_out1_1 <= to_signed(0, 48);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        Product_out1_1 <= Product_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Data_Type_Conversion_out1 <= Product_out1_1(46 DOWNTO 23);

  FFT_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      FFT_bypass_reg <= to_signed(16#000000#, 24);
    ELSIF rising_edge(clk) THEN
      IF enb_1_16_1 = '1' THEN
        FFT_bypass_reg <= Data_Type_Conversion_out1;
      END IF;
    END IF;
  END PROCESS FFT_bypass_process;

  
  Data_Type_Conversion_out1_1 <= Data_Type_Conversion_out1 WHEN enb_1_16_1 = '1' ELSE
      FFT_bypass_reg;

  Data_to_FFT <= std_logic_vector(Data_Type_Conversion_out1_1);

  Unit_Delay_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF enb_1_16_0 = '1' THEN
        Unit_Delay_out1 <= addr_B_gen_out3;
      END IF;
    END IF;
  END PROCESS Unit_Delay_process;


  Valid_to_FFT <= Unit_Delay_out1;

  FFT_Frame_Start_Pulse <= Fast_Transition_out1;

  passthrough <= Fast_Transition_out3;

  filter_select_out <= Fast_Transition_out4;

END rtl;

