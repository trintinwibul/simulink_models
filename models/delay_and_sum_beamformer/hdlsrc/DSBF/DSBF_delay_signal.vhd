-- -------------------------------------------------------------
-- 
-- File Name: /mnt/data/trevor/research/NIH_SBIR_R44_DC015443/simulink_models/models/delay_and_sum_beamformer/hdlsrc/DSBF/DSBF_delay_signal.vhd
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: DSBF_delay_signal
-- Source Path: DSBF/dataplane/Avalon Data Processing/delay signals/delay signal
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DSBF_dataplane_pkg.ALL;

ENTITY DSBF_delay_signal IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_64_1                        :   IN    std_logic;
        enb_1_2048_0                      :   IN    std_logic;
        enb_1_64_0                        :   IN    std_logic;
        data_in                           :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        delay                             :   IN    std_logic_vector(12 DOWNTO 0);  -- sfix13_En7
        data_out                          :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
        );
END DSBF_delay_signal;


ARCHITECTURE rtl OF DSBF_delay_signal IS

  ATTRIBUTE multstyle : string;

  -- Component Declarations
  COMPONENT DSBF_MATLAB_Function
    PORT( delay                           :   IN    std_logic_vector(12 DOWNTO 0);  -- sfix13_En7
          integer_delay                   :   OUT   std_logic_vector(5 DOWNTO 0);  -- sfix6
          fractional_delay                :   OUT   std_logic_vector(6 DOWNTO 0)  -- sfix7
          );
  END COMPONENT;

  COMPONENT DSBF_read_address_generator
    PORT( write_addr                      :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
          delay                           :   IN    std_logic_vector(5 DOWNTO 0);  -- sfix6
          read_addr                       :   OUT   std_logic_vector(5 DOWNTO 0)  -- ufix6
          );
  END COMPONENT;

  COMPONENT DSBF_SimpleDualPortRAM_generic_block
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          wr_din                          :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          wr_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          wr_en                           :   IN    std_logic;
          rd_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          rd_dout                         :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)  -- generic width
          );
  END COMPONENT;

  COMPONENT DSBF_FIR_Interpolation
    PORT( clk                             :   IN    std_logic;
          enb_1_64_1                      :   IN    std_logic;
          reset                           :   IN    std_logic;
          DSBF_FIR_Interpolation_in       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          DSBF_FIR_Interpolation_out      :   OUT   std_logic_vector(68 DOWNTO 0)  -- sfix69_En58
          );
  END COMPONENT;

  COMPONENT DSBF_read_address_generator1
    PORT( write_addr                      :   IN    std_logic_vector(6 DOWNTO 0);  -- ufix7
          delay                           :   IN    std_logic_vector(6 DOWNTO 0);  -- sfix7
          read_addr                       :   OUT   std_logic_vector(6 DOWNTO 0)  -- ufix7
          );
  END COMPONENT;

  COMPONENT DSBF_SimpleDualPortRAM_generic
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          enb_1_64_0                      :   IN    std_logic;
          wr_din                          :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          wr_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          wr_en                           :   IN    std_logic;
          rd_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          rd_dout                         :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)  -- generic width
          );
  END COMPONENT;

  COMPONENT DSBF_FIR_Decimation
    PORT( clk                             :   IN    std_logic;
          enb_1_64_1                      :   IN    std_logic;
          reset                           :   IN    std_logic;
          DSBF_FIR_Decimation_in          :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          DSBF_FIR_Decimation_out         :   OUT   std_logic_vector(68 DOWNTO 0)  -- sfix69_En63
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : DSBF_MATLAB_Function
    USE ENTITY work.DSBF_MATLAB_Function(rtl);

  FOR ALL : DSBF_read_address_generator
    USE ENTITY work.DSBF_read_address_generator(rtl);

  FOR ALL : DSBF_SimpleDualPortRAM_generic_block
    USE ENTITY work.DSBF_SimpleDualPortRAM_generic_block(rtl);

  FOR ALL : DSBF_FIR_Interpolation
    USE ENTITY work.DSBF_FIR_Interpolation(rtl);

  FOR ALL : DSBF_read_address_generator1
    USE ENTITY work.DSBF_read_address_generator1(rtl);

  FOR ALL : DSBF_SimpleDualPortRAM_generic
    USE ENTITY work.DSBF_SimpleDualPortRAM_generic(rtl);

  FOR ALL : DSBF_FIR_Decimation
    USE ENTITY work.DSBF_FIR_Decimation(rtl);

  -- Signals
  SIGNAL write_address_generator_out1     : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL reduced_reg                      : vector_of_unsigned6(0 TO 1);  -- ufix6 [2]
  SIGNAL write_address_generator_out1_1   : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Constant2_out1                   : std_logic;
  SIGNAL integer_delay                    : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL fractional_delay                 : std_logic_vector(6 DOWNTO 0);  -- ufix7
  SIGNAL read_address_generator_out1      : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL Simple_Dual_Port_RAM_out1        : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL FIR_Interpolation_out1           : std_logic_vector(68 DOWNTO 0);  -- ufix69
  SIGNAL FIR_Interpolation_out1_signed    : signed(68 DOWNTO 0);  -- sfix69_En58
  SIGNAL Data_Type_Conversion_out1        : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL write_address_generator1_out1    : unsigned(6 DOWNTO 0);  -- ufix7
  SIGNAL reduced_reg_1                    : vector_of_unsigned7(0 TO 63);  -- ufix7 [64]
  SIGNAL write_address_generator1_out1_1  : unsigned(6 DOWNTO 0);  -- ufix7
  SIGNAL fractional_delay_signed          : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL Constant1_out1                   : std_logic;
  SIGNAL Rate_Transition_out1             : signed(6 DOWNTO 0);  -- sfix7
  SIGNAL read_address_generator1_out1     : std_logic_vector(6 DOWNTO 0);  -- ufix7
  SIGNAL Simple_Dual_Port_RAM1_out1       : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL FIR_Decimation_out1              : std_logic_vector(68 DOWNTO 0);  -- ufix69
  SIGNAL FIR_Decimation_out1_signed       : signed(68 DOWNTO 0);  -- sfix69_En63
  SIGNAL Data_Type_Conversion1_out1       : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Rate_Transition1_out1            : signed(31 DOWNTO 0);  -- sfix32_En28

BEGIN
  -- Integer delay
  -- 
  -- fractional delay (upsampled)

  u_MATLAB_Function : DSBF_MATLAB_Function
    PORT MAP( delay => delay,  -- sfix13_En7
              integer_delay => integer_delay,  -- sfix6
              fractional_delay => fractional_delay  -- sfix7
              );

  u_read_address_generator : DSBF_read_address_generator
    PORT MAP( write_addr => std_logic_vector(write_address_generator_out1_1),  -- ufix6
              delay => integer_delay,  -- sfix6
              read_addr => read_address_generator_out1  -- ufix6
              );

  u_Simple_Dual_Port_RAM : DSBF_SimpleDualPortRAM_generic_block
    GENERIC MAP( AddrWidth => 6,
                 DataWidth => 32
                 )
    PORT MAP( clk => clk,
              enb_1_2048_0 => enb_1_2048_0,
              wr_din => data_in,
              wr_addr => std_logic_vector(write_address_generator_out1_1),
              wr_en => Constant2_out1,
              rd_addr => read_address_generator_out1,
              rd_dout => Simple_Dual_Port_RAM_out1
              );

  u_DSBF_FIR_Interpolation : DSBF_FIR_Interpolation
    PORT MAP( clk => clk,
              enb_1_64_1 => enb_1_64_1,
              reset => reset,
              DSBF_FIR_Interpolation_in => Simple_Dual_Port_RAM_out1,  -- sfix32_En28
              DSBF_FIR_Interpolation_out => FIR_Interpolation_out1  -- sfix69_En58
              );

  -- 
  u_read_address_generator1 : DSBF_read_address_generator1
    PORT MAP( write_addr => std_logic_vector(write_address_generator1_out1_1),  -- ufix7
              delay => std_logic_vector(Rate_Transition_out1),  -- sfix7
              read_addr => read_address_generator1_out1  -- ufix7
              );

  u_Simple_Dual_Port_RAM1 : DSBF_SimpleDualPortRAM_generic
    GENERIC MAP( AddrWidth => 7,
                 DataWidth => 32
                 )
    PORT MAP( clk => clk,
              enb_1_64_0 => enb_1_64_0,
              wr_din => std_logic_vector(Data_Type_Conversion_out1),
              wr_addr => std_logic_vector(write_address_generator1_out1_1),
              wr_en => Constant1_out1,
              rd_addr => read_address_generator1_out1,
              rd_dout => Simple_Dual_Port_RAM1_out1
              );

  u_DSBF_FIR_Decimation : DSBF_FIR_Decimation
    PORT MAP( clk => clk,
              enb_1_64_1 => enb_1_64_1,
              reset => reset,
              DSBF_FIR_Decimation_in => Simple_Dual_Port_RAM1_out1,  -- sfix32_En28
              DSBF_FIR_Decimation_out => FIR_Decimation_out1  -- sfix69_En63
              );

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 63
  -- 
  write_address_generator_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      write_address_generator_out1 <= to_unsigned(16#00#, 6);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        write_address_generator_out1 <= write_address_generator_out1 + to_unsigned(16#01#, 6);
      END IF;
    END IF;
  END PROCESS write_address_generator_process;


  reduced_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      reduced_reg <= (OTHERS => to_unsigned(16#00#, 6));
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        reduced_reg(0) <= write_address_generator_out1;
        reduced_reg(1) <= reduced_reg(0);
      END IF;
    END IF;
  END PROCESS reduced_process;

  write_address_generator_out1_1 <= reduced_reg(1);

  Constant2_out1 <= '1';

  FIR_Interpolation_out1_signed <= signed(FIR_Interpolation_out1);

  Data_Type_Conversion_out1 <= FIR_Interpolation_out1_signed(61 DOWNTO 30);

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 127
  -- 
  write_address_generator1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      write_address_generator1_out1 <= to_unsigned(16#00#, 7);
    ELSIF rising_edge(clk) THEN
      IF enb_1_64_0 = '1' THEN
        write_address_generator1_out1 <= write_address_generator1_out1 + to_unsigned(16#01#, 7);
      END IF;
    END IF;
  END PROCESS write_address_generator1_process;


  reduced_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      reduced_reg_1 <= (OTHERS => to_unsigned(16#00#, 7));
    ELSIF rising_edge(clk) THEN
      IF enb_1_64_0 = '1' THEN
        reduced_reg_1(0) <= write_address_generator1_out1;
        reduced_reg_1(1 TO 63) <= reduced_reg_1(0 TO 62);
      END IF;
    END IF;
  END PROCESS reduced_1_process;

  write_address_generator1_out1_1 <= reduced_reg_1(63);

  fractional_delay_signed <= signed(fractional_delay);

  Constant1_out1 <= '1';

  Rate_Transition_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Rate_Transition_out1 <= to_signed(16#00#, 7);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        Rate_Transition_out1 <= fractional_delay_signed;
      END IF;
    END IF;
  END PROCESS Rate_Transition_process;


  FIR_Decimation_out1_signed <= signed(FIR_Decimation_out1);

  Data_Type_Conversion1_out1 <= FIR_Decimation_out1_signed(66 DOWNTO 35);

  Rate_Transition1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Rate_Transition1_out1 <= to_signed(0, 32);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        Rate_Transition1_out1 <= Data_Type_Conversion1_out1;
      END IF;
    END IF;
  END PROCESS Rate_Transition1_process;


  data_out <= std_logic_vector(Rate_Transition1_out1);



END rtl;

