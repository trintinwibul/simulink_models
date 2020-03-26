-- -------------------------------------------------------------
-- 
-- File Name: /mnt/data/trevor/research/NIH_SBIR_R44_DC015443/simulink_models/models/delay_and_sum_beamformer/hdlsrc/DSBF/DSBF_CIC_decimation_compensator.vhd
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: DSBF_CIC_decimation_compensator
-- Source Path: DSBF/dataplane/Avalon Data Processing/delay signals/delay signal/CIC decimation compensator
-- Hierarchy Level: 4
-- 
-- Discrete FIR Filter HDL Optimized
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DSBF_dataplane_pkg.ALL;

ENTITY DSBF_CIC_decimation_compensator IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_2048_0                      :   IN    std_logic;
        dataIn                            :   IN    std_logic_vector(41 DOWNTO 0);  -- sfix42_En28
        validIn                           :   IN    std_logic;
        dataOut                           :   OUT   std_logic_vector(41 DOWNTO 0);  -- sfix42_En26
        validOut                          :   OUT   std_logic;
        ready                             :   OUT   std_logic
        );
END DSBF_CIC_decimation_compensator;


ARCHITECTURE rtl OF DSBF_CIC_decimation_compensator IS

  -- Component Declarations
  COMPONENT DSBF_FirRdyLogic_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          dataIn                          :   IN    std_logic_vector(41 DOWNTO 0);  -- sfix42_En28
          validIn                         :   IN    std_logic;
          readyS                          :   OUT   std_logic;
          din                             :   OUT   std_logic_vector(41 DOWNTO 0);  -- sfix42_En28
          dinVld                          :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT DSBF_Addressable_Delay_Line_block4
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          dataIn                          :   IN    std_logic_vector(41 DOWNTO 0);  -- sfix42_En28
          validIn                         :   IN    std_logic;
          shiftEn                         :   IN    std_logic;
          rdAddr                          :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
          delayLineEnd                    :   OUT   std_logic_vector(41 DOWNTO 0);  -- sfix42_En28
          dataOut                         :   OUT   std_logic_vector(41 DOWNTO 0)  -- sfix42_En28
          );
  END COMPONENT;

  COMPONENT DSBF_Addressable_Delay_Line_block5
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          dataIn                          :   IN    std_logic_vector(41 DOWNTO 0);  -- sfix42_En28
          validIn                         :   IN    std_logic;
          shiftEn                         :   IN    std_logic;
          rdAddr                          :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
          delayLineEnd                    :   OUT   std_logic_vector(41 DOWNTO 0);  -- sfix42_En28
          dataOut                         :   OUT   std_logic_vector(41 DOWNTO 0)  -- sfix42_En28
          );
  END COMPONENT;

  COMPONENT DSBF_Addressable_Delay_Line_block6
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          dataIn                          :   IN    std_logic_vector(41 DOWNTO 0);  -- sfix42_En28
          validIn                         :   IN    std_logic;
          shiftEn                         :   IN    std_logic;
          rdAddr                          :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
          delayLineEnd                    :   OUT   std_logic_vector(41 DOWNTO 0);  -- sfix42_En28
          dataOut                         :   OUT   std_logic_vector(41 DOWNTO 0)  -- sfix42_En28
          );
  END COMPONENT;

  COMPONENT DSBF_Addressable_Delay_Line_block7
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          dataIn                          :   IN    std_logic_vector(41 DOWNTO 0);  -- sfix42_En28
          validIn                         :   IN    std_logic;
          shiftEn                         :   IN    std_logic;
          rdAddr                          :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
          delayLineEnd                    :   OUT   std_logic_vector(41 DOWNTO 0);  -- sfix42_En28
          dataOut                         :   OUT   std_logic_vector(41 DOWNTO 0)  -- sfix42_En28
          );
  END COMPONENT;

  COMPONENT DSBF_FilterTapSystolicPreAdd_block
    PORT( clk                             :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          din_re                          :   IN    std_logic_vector(41 DOWNTO 0);  -- sfix42_En28
          preAddIn                        :   IN    std_logic_vector(41 DOWNTO 0);  -- sfix42_En28
          coeff                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          sumIn                           :   IN    std_logic_vector(58 DOWNTO 0);  -- sfix59_En43
          sumOut                          :   OUT   std_logic_vector(58 DOWNTO 0)  -- sfix59_En43
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : DSBF_FirRdyLogic_block
    USE ENTITY work.DSBF_FirRdyLogic_block(rtl);

  FOR ALL : DSBF_Addressable_Delay_Line_block4
    USE ENTITY work.DSBF_Addressable_Delay_Line_block4(rtl);

  FOR ALL : DSBF_Addressable_Delay_Line_block5
    USE ENTITY work.DSBF_Addressable_Delay_Line_block5(rtl);

  FOR ALL : DSBF_Addressable_Delay_Line_block6
    USE ENTITY work.DSBF_Addressable_Delay_Line_block6(rtl);

  FOR ALL : DSBF_Addressable_Delay_Line_block7
    USE ENTITY work.DSBF_Addressable_Delay_Line_block7(rtl);

  FOR ALL : DSBF_FilterTapSystolicPreAdd_block
    USE ENTITY work.DSBF_FilterTapSystolicPreAdd_block(rtl);

  -- Functions
  -- HDLCODER_TO_STDLOGIC 
  FUNCTION hdlcoder_to_stdlogic(arg: boolean) RETURN std_logic IS
  BEGIN
    IF arg THEN
      RETURN '1';
    ELSE
      RETURN '0';
    END IF;
  END FUNCTION;


  -- Signals
  SIGNAL readyS                           : std_logic;
  SIGNAL din                              : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL dinVld                           : std_logic;
  SIGNAL nextSharingCount                 : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL sharingCount_1                   : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL delayLineValidIn0                : std_logic;
  SIGNAL lastPhaseStrobe                  : std_logic;
  SIGNAL delayLineShiftEn0_1              : std_logic;
  SIGNAL delayLineShiftEn1_1              : std_logic;
  SIGNAL delayLineShiftEn2_1              : std_logic;
  SIGNAL delayLineShiftEn3_1              : std_logic;
  SIGNAL delayLineShiftEn4_1              : std_logic;
  SIGNAL validOutLookahead_reg            : std_logic_vector(0 TO 6);  -- ufix1 [7]
  SIGNAL validOutLookahead_1              : std_logic;
  SIGNAL rdAddr0_1                        : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL rdAddr1                          : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL rdAddr2                          : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL rdAddr3                          : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL rdAddr4                          : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL rdAddrEndNonZero                 : std_logic;
  SIGNAL finalSumValidPipe_reg            : std_logic_vector(0 TO 4);  -- ufix1 [5]
  SIGNAL accumulate                       : std_logic;
  SIGNAL accDataOut                       : signed(58 DOWNTO 0);  -- sfix59_En43
  SIGNAL delayLineEnd0                    : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL delayLineDataOut0                : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL delayLineEnd0_signed             : signed(41 DOWNTO 0);  -- sfix42_En28
  SIGNAL delayLineDataIn1_1               : signed(41 DOWNTO 0);  -- sfix42_En28
  SIGNAL delayLineEnd1                    : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL delayLineDataOut1                : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL delayLineEnd1_signed             : signed(41 DOWNTO 0);  -- sfix42_En28
  SIGNAL delayLineDataIn2_1               : signed(41 DOWNTO 0);  -- sfix42_En28
  SIGNAL delayLineEnd2                    : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL delayLineDataOut2                : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL delayLineEnd2_signed             : signed(41 DOWNTO 0);  -- sfix42_En28
  SIGNAL delayLineDataIn3_1               : signed(41 DOWNTO 0);  -- sfix42_En28
  SIGNAL delayLineEnd3                    : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL delayLineDataOut3                : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL delayLineEnd3_signed             : signed(41 DOWNTO 0);  -- sfix42_En28
  SIGNAL delayLineDataIn4_1               : signed(41 DOWNTO 0);  -- sfix42_En28
  SIGNAL delayLineEnd4                    : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL delayLineDataOut4                : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL coeffTableOut3                   : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL coeffTableReg3_reg               : vector_of_signed16(0 TO 1);  -- sfix16 [2]
  SIGNAL coeffTableReg3_1                 : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL delayLineEnd5                    : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL delayLineDataOut5                : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL coeffTableOut2                   : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL coeffTableReg2_reg               : vector_of_signed16(0 TO 1);  -- sfix16 [2]
  SIGNAL coeffTableReg2_1                 : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL delayLineEnd6                    : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL delayLineDataOut6                : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL coeffTableOut1                   : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL coeffTableReg1_reg               : vector_of_signed16(0 TO 1);  -- sfix16 [2]
  SIGNAL coeffTableReg1_1                 : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL delayLineEnd7                    : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL delayLineDataOut7                : std_logic_vector(41 DOWNTO 0);  -- ufix42
  SIGNAL coeffTableOut0                   : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL coeffTableReg0_reg               : vector_of_signed16(0 TO 1);  -- sfix16 [2]
  SIGNAL coeffTableReg0_1                 : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL sumIn                            : signed(58 DOWNTO 0);  -- sfix59_En43
  SIGNAL sumOut                           : std_logic_vector(58 DOWNTO 0);  -- ufix59
  SIGNAL sumOut_0                         : std_logic_vector(58 DOWNTO 0);  -- ufix59
  SIGNAL sumOut_1                         : std_logic_vector(58 DOWNTO 0);  -- ufix59
  SIGNAL sumOut_2                         : std_logic_vector(58 DOWNTO 0);  -- ufix59
  SIGNAL sumOut_2_signed                  : signed(58 DOWNTO 0);  -- sfix59_En43
  SIGNAL sumOutReg_1                      : signed(58 DOWNTO 0);  -- sfix59_En43
  SIGNAL accDataOut_1                     : signed(58 DOWNTO 0);  -- sfix59_En43
  SIGNAL accSwitchOut                     : signed(58 DOWNTO 0);  -- sfix59_En43
  SIGNAL accAdderOut                      : signed(58 DOWNTO 0);  -- sfix59_En43
  SIGNAL converterOut                     : signed(41 DOWNTO 0);  -- sfix42_En26
  SIGNAL dataOutRegIn                     : signed(41 DOWNTO 0);  -- sfix42_En26
  SIGNAL dout_re_1                        : signed(41 DOWNTO 0);  -- sfix42_En26
  SIGNAL vldOut_1                         : std_logic;

BEGIN
  u_firRdyLogic : DSBF_FirRdyLogic_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              dataIn => dataIn,  -- sfix42_En28
              validIn => validIn,
              readyS => readyS,
              din => din,  -- sfix42_En28
              dinVld => dinVld
              );

  u_delayLine0 : DSBF_Addressable_Delay_Line_block4
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              dataIn => din,  -- sfix42_En28
              validIn => delayLineValidIn0,
              shiftEn => delayLineShiftEn0_1,
              rdAddr => std_logic_vector(rdAddr0_1),  -- ufix3
              delayLineEnd => delayLineEnd0,  -- sfix42_En28
              dataOut => delayLineDataOut0  -- sfix42_En28
              );

  u_delayLine1 : DSBF_Addressable_Delay_Line_block4
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              dataIn => std_logic_vector(delayLineDataIn1_1),  -- sfix42_En28
              validIn => delayLineShiftEn1_1,
              shiftEn => delayLineShiftEn1_1,
              rdAddr => std_logic_vector(rdAddr1),  -- ufix3
              delayLineEnd => delayLineEnd1,  -- sfix42_En28
              dataOut => delayLineDataOut1  -- sfix42_En28
              );

  u_delayLine2 : DSBF_Addressable_Delay_Line_block4
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              dataIn => std_logic_vector(delayLineDataIn2_1),  -- sfix42_En28
              validIn => delayLineShiftEn2_1,
              shiftEn => delayLineShiftEn2_1,
              rdAddr => std_logic_vector(rdAddr2),  -- ufix3
              delayLineEnd => delayLineEnd2,  -- sfix42_En28
              dataOut => delayLineDataOut2  -- sfix42_En28
              );

  u_delayLine3 : DSBF_Addressable_Delay_Line_block5
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              dataIn => std_logic_vector(delayLineDataIn3_1),  -- sfix42_En28
              validIn => delayLineShiftEn3_1,
              shiftEn => delayLineShiftEn3_1,
              rdAddr => std_logic_vector(rdAddr3),  -- ufix3
              delayLineEnd => delayLineEnd3,  -- sfix42_En28
              dataOut => delayLineDataOut3  -- sfix42_En28
              );

  u_delayLine4 : DSBF_Addressable_Delay_Line_block6
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              dataIn => std_logic_vector(delayLineDataIn4_1),  -- sfix42_En28
              validIn => delayLineShiftEn4_1,
              shiftEn => delayLineShiftEn4_1,
              rdAddr => std_logic_vector(rdAddr4),  -- ufix3
              delayLineEnd => delayLineEnd4,  -- sfix42_En28
              dataOut => delayLineDataOut4  -- sfix42_En28
              );

  u_delayLine5 : DSBF_Addressable_Delay_Line_block7
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              dataIn => delayLineEnd4,  -- sfix42_En28
              validIn => delayLineShiftEn3_1,
              shiftEn => delayLineShiftEn3_1,
              rdAddr => std_logic_vector(rdAddr3),  -- ufix3
              delayLineEnd => delayLineEnd5,  -- sfix42_En28
              dataOut => delayLineDataOut5  -- sfix42_En28
              );

  u_delayLine6 : DSBF_Addressable_Delay_Line_block7
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              dataIn => delayLineEnd5,  -- sfix42_En28
              validIn => delayLineShiftEn2_1,
              shiftEn => delayLineShiftEn2_1,
              rdAddr => std_logic_vector(rdAddr2),  -- ufix3
              delayLineEnd => delayLineEnd6,  -- sfix42_En28
              dataOut => delayLineDataOut6  -- sfix42_En28
              );

  u_delayLine7 : DSBF_Addressable_Delay_Line_block7
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              dataIn => delayLineEnd6,  -- sfix42_En28
              validIn => delayLineShiftEn1_1,
              shiftEn => delayLineShiftEn1_1,
              rdAddr => std_logic_vector(rdAddr1),  -- ufix3
              delayLineEnd => delayLineEnd7,  -- sfix42_En28
              dataOut => delayLineDataOut7  -- sfix42_En28
              );

  u_filterTap0 : DSBF_FilterTapSystolicPreAdd_block
    PORT MAP( clk => clk,
              enb_1_2048_0 => enb_1_2048_0,
              din_re => delayLineDataOut0,  -- sfix42_En28
              preAddIn => delayLineDataOut7,  -- sfix42_En28
              coeff => std_logic_vector(coeffTableReg0_1),  -- sfix16_En15
              sumIn => std_logic_vector(sumIn),  -- sfix59_En43
              sumOut => sumOut  -- sfix59_En43
              );

  u_filterTap1 : DSBF_FilterTapSystolicPreAdd_block
    PORT MAP( clk => clk,
              enb_1_2048_0 => enb_1_2048_0,
              din_re => delayLineDataOut1,  -- sfix42_En28
              preAddIn => delayLineDataOut6,  -- sfix42_En28
              coeff => std_logic_vector(coeffTableReg1_1),  -- sfix16_En15
              sumIn => sumOut,  -- sfix59_En43
              sumOut => sumOut_0  -- sfix59_En43
              );

  u_filterTap2 : DSBF_FilterTapSystolicPreAdd_block
    PORT MAP( clk => clk,
              enb_1_2048_0 => enb_1_2048_0,
              din_re => delayLineDataOut2,  -- sfix42_En28
              preAddIn => delayLineDataOut5,  -- sfix42_En28
              coeff => std_logic_vector(coeffTableReg2_1),  -- sfix16_En15
              sumIn => sumOut_0,  -- sfix59_En43
              sumOut => sumOut_1  -- sfix59_En43
              );

  u_filterTap3 : DSBF_FilterTapSystolicPreAdd_block
    PORT MAP( clk => clk,
              enb_1_2048_0 => enb_1_2048_0,
              din_re => delayLineDataOut3,  -- sfix42_En28
              preAddIn => delayLineDataOut4,  -- sfix42_En28
              coeff => std_logic_vector(coeffTableReg3_1),  -- sfix16_En15
              sumIn => sumOut_1,  -- sfix59_En43
              sumOut => sumOut_2  -- sfix59_En43
              );

  sharingCount_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      sharingCount_1 <= to_unsigned(16#0#, 3);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        sharingCount_1 <= nextSharingCount;
      END IF;
    END IF;
  END PROCESS sharingCount_process;


  -- Input control counter combinatorial logic
  InputControl_output : PROCESS (dinVld, sharingCount_1)
  BEGIN
    delayLineValidIn0 <= hdlcoder_to_stdlogic((sharingCount_1 = to_unsigned(16#0#, 3)) AND (dinVld /= '0'));
    IF (dinVld /= '0') OR (sharingCount_1 > to_unsigned(16#0#, 3)) THEN 
      IF sharingCount_1 = to_unsigned(16#4#, 3) THEN 
        nextSharingCount <= to_unsigned(16#0#, 3);
      ELSE 
        nextSharingCount <= sharingCount_1 + to_unsigned(16#1#, 3);
      END IF;
    ELSE 
      nextSharingCount <= sharingCount_1;
    END IF;
    IF sharingCount_1 = to_unsigned(16#4#, 3) THEN 
      lastPhaseStrobe <= '1';
    ELSE 
      lastPhaseStrobe <= '0';
    END IF;
  END PROCESS InputControl_output;


  delayLineShiftEn0_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayLineShiftEn0_1 <= '0';
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        delayLineShiftEn0_1 <= lastPhaseStrobe;
      END IF;
    END IF;
  END PROCESS delayLineShiftEn0_process;


  delayLineShiftEn1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayLineShiftEn1_1 <= '0';
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        delayLineShiftEn1_1 <= delayLineShiftEn0_1;
      END IF;
    END IF;
  END PROCESS delayLineShiftEn1_process;


  delayLineShiftEn2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayLineShiftEn2_1 <= '0';
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        delayLineShiftEn2_1 <= delayLineShiftEn1_1;
      END IF;
    END IF;
  END PROCESS delayLineShiftEn2_process;


  delayLineShiftEn3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayLineShiftEn3_1 <= '0';
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        delayLineShiftEn3_1 <= delayLineShiftEn2_1;
      END IF;
    END IF;
  END PROCESS delayLineShiftEn3_process;


  delayLineShiftEn4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayLineShiftEn4_1 <= '0';
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        delayLineShiftEn4_1 <= delayLineShiftEn3_1;
      END IF;
    END IF;
  END PROCESS delayLineShiftEn4_process;


  validOutLookahead_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      validOutLookahead_reg <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        validOutLookahead_reg(0) <= delayLineShiftEn4_1;
        validOutLookahead_reg(1 TO 6) <= validOutLookahead_reg(0 TO 5);
      END IF;
    END IF;
  END PROCESS validOutLookahead_process;

  validOutLookahead_1 <= validOutLookahead_reg(6);

  rdAddr0_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rdAddr0_1 <= to_unsigned(16#0#, 3);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        rdAddr0_1 <= sharingCount_1;
      END IF;
    END IF;
  END PROCESS rdAddr0_process;


  rdAddr0_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rdAddr1 <= to_unsigned(16#0#, 3);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        rdAddr1 <= rdAddr0_1;
      END IF;
    END IF;
  END PROCESS rdAddr0_2_process;


  rdAddr1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rdAddr2 <= to_unsigned(16#0#, 3);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        rdAddr2 <= rdAddr1;
      END IF;
    END IF;
  END PROCESS rdAddr1_1_process;


  rdAddr2_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rdAddr3 <= to_unsigned(16#0#, 3);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        rdAddr3 <= rdAddr2;
      END IF;
    END IF;
  END PROCESS rdAddr2_1_process;


  rdAddr3_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rdAddr4 <= to_unsigned(16#0#, 3);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        rdAddr4 <= rdAddr3;
      END IF;
    END IF;
  END PROCESS rdAddr3_1_process;


  
  rdAddrEndNonZero <= '1' WHEN rdAddr4 /= to_unsigned(16#0#, 3) ELSE
      '0';

  finalSumValidPipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      finalSumValidPipe_reg <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        finalSumValidPipe_reg(0) <= rdAddrEndNonZero;
        finalSumValidPipe_reg(1 TO 4) <= finalSumValidPipe_reg(0 TO 3);
      END IF;
    END IF;
  END PROCESS finalSumValidPipe_process;

  accumulate <= finalSumValidPipe_reg(4);

  accDataOut <= to_signed(0, 59);

  delayLineEnd0_signed <= signed(delayLineEnd0);

  delayLineDataIn1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayLineDataIn1_1 <= to_signed(0, 42);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        delayLineDataIn1_1 <= delayLineEnd0_signed;
      END IF;
    END IF;
  END PROCESS delayLineDataIn1_process;


  delayLineEnd1_signed <= signed(delayLineEnd1);

  delayLineDataIn2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayLineDataIn2_1 <= to_signed(0, 42);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        delayLineDataIn2_1 <= delayLineEnd1_signed;
      END IF;
    END IF;
  END PROCESS delayLineDataIn2_process;


  delayLineEnd2_signed <= signed(delayLineEnd2);

  delayLineDataIn3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayLineDataIn3_1 <= to_signed(0, 42);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        delayLineDataIn3_1 <= delayLineEnd2_signed;
      END IF;
    END IF;
  END PROCESS delayLineDataIn3_process;


  delayLineEnd3_signed <= signed(delayLineEnd3);

  delayLineDataIn4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayLineDataIn4_1 <= to_signed(0, 42);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        delayLineDataIn4_1 <= delayLineEnd3_signed;
      END IF;
    END IF;
  END PROCESS delayLineDataIn4_process;


  -- Coefficient table for multiplier3
  coeffTable3_output : PROCESS (rdAddr3)
  BEGIN
    CASE rdAddr3 IS
      WHEN "000" =>
        coeffTableOut3 <= to_signed(16#0A2B#, 16);
      WHEN "001" =>
        coeffTableOut3 <= to_signed(-16#24F7#, 16);
      WHEN "010" =>
        coeffTableOut3 <= to_signed(16#5B2E#, 16);
      WHEN "011" =>
        coeffTableOut3 <= to_signed(16#0000#, 16);
      WHEN "100" =>
        coeffTableOut3 <= to_signed(16#0000#, 16);
      WHEN OTHERS => 
        coeffTableOut3 <= to_signed(16#0000#, 16);
    END CASE;
  END PROCESS coeffTable3_output;


  coeffTableReg3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      coeffTableReg3_reg <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        coeffTableReg3_reg(0) <= coeffTableOut3;
        coeffTableReg3_reg(1) <= coeffTableReg3_reg(0);
      END IF;
    END IF;
  END PROCESS coeffTableReg3_process;

  coeffTableReg3_1 <= coeffTableReg3_reg(1);

  -- Coefficient table for multiplier2
  coeffTable2_output : PROCESS (rdAddr2)
  BEGIN
    CASE rdAddr2 IS
      WHEN "000" =>
        coeffTableOut2 <= to_signed(16#0466#, 16);
      WHEN "001" =>
        coeffTableOut2 <= to_signed(-16#0851#, 16);
      WHEN "010" =>
        coeffTableOut2 <= to_signed(16#0ADF#, 16);
      WHEN "011" =>
        coeffTableOut2 <= to_signed(-16#0A20#, 16);
      WHEN "100" =>
        coeffTableOut2 <= to_signed(16#03F4#, 16);
      WHEN OTHERS => 
        coeffTableOut2 <= to_signed(16#0000#, 16);
    END CASE;
  END PROCESS coeffTable2_output;


  coeffTableReg2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      coeffTableReg2_reg <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        coeffTableReg2_reg(0) <= coeffTableOut2;
        coeffTableReg2_reg(1) <= coeffTableReg2_reg(0);
      END IF;
    END IF;
  END PROCESS coeffTableReg2_process;

  coeffTableReg2_1 <= coeffTableReg2_reg(1);

  -- Coefficient table for multiplier1
  coeffTable1_output : PROCESS (rdAddr1)
  BEGIN
    CASE rdAddr1 IS
      WHEN "000" =>
        coeffTableOut1 <= to_signed(16#01EA#, 16);
      WHEN "001" =>
        coeffTableOut1 <= to_signed(-16#02DB#, 16);
      WHEN "010" =>
        coeffTableOut1 <= to_signed(16#0307#, 16);
      WHEN "011" =>
        coeffTableOut1 <= to_signed(-16#01ED#, 16);
      WHEN "100" =>
        coeffTableOut1 <= to_signed(-16#00AA#, 16);
      WHEN OTHERS => 
        coeffTableOut1 <= to_signed(16#0000#, 16);
    END CASE;
  END PROCESS coeffTable1_output;


  coeffTableReg1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      coeffTableReg1_reg <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        coeffTableReg1_reg(0) <= coeffTableOut1;
        coeffTableReg1_reg(1) <= coeffTableReg1_reg(0);
      END IF;
    END IF;
  END PROCESS coeffTableReg1_process;

  coeffTableReg1_1 <= coeffTableReg1_reg(1);

  -- Coefficient table for multiplier0
  coeffTable0_output : PROCESS (rdAddr0_1)
  BEGIN
    CASE rdAddr0_1 IS
      WHEN "000" =>
        coeffTableOut0 <= to_signed(16#00A0#, 16);
      WHEN "001" =>
        coeffTableOut0 <= to_signed(-16#00A6#, 16);
      WHEN "010" =>
        coeffTableOut0 <= to_signed(16#0098#, 16);
      WHEN "011" =>
        coeffTableOut0 <= to_signed(-16#0020#, 16);
      WHEN "100" =>
        coeffTableOut0 <= to_signed(-16#00C7#, 16);
      WHEN OTHERS => 
        coeffTableOut0 <= to_signed(16#0000#, 16);
    END CASE;
  END PROCESS coeffTable0_output;


  coeffTableReg0_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      coeffTableReg0_reg <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        coeffTableReg0_reg(0) <= coeffTableOut0;
        coeffTableReg0_reg(1) <= coeffTableReg0_reg(0);
      END IF;
    END IF;
  END PROCESS coeffTableReg0_process;

  coeffTableReg0_1 <= coeffTableReg0_reg(1);

  sumIn <= to_signed(0, 59);

  sumOut_2_signed <= signed(sumOut_2);

  sumOutReg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      sumOutReg_1 <= to_signed(0, 59);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        sumOutReg_1 <= sumOut_2_signed;
      END IF;
    END IF;
  END PROCESS sumOutReg_process;


  
  accSwitchOut <= accDataOut WHEN accumulate = '0' ELSE
      accDataOut_1;

  accAdderOut <= accSwitchOut + sumOutReg_1;

  accDataOut_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      accDataOut_1 <= to_signed(0, 59);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        accDataOut_1 <= accAdderOut;
      END IF;
    END IF;
  END PROCESS accDataOut_2_process;


  converterOut <= accDataOut_1(58 DOWNTO 17);

  converterOutReg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dataOutRegIn <= to_signed(0, 42);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        dataOutRegIn <= converterOut;
      END IF;
    END IF;
  END PROCESS converterOutReg_process;


  dout_re_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dout_re_1 <= to_signed(0, 42);
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' AND validOutLookahead_1 = '1' THEN
        dout_re_1 <= dataOutRegIn;
      END IF;
    END IF;
  END PROCESS dout_re_process;


  dataOut <= std_logic_vector(dout_re_1);

  vldOut_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      vldOut_1 <= '0';
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        vldOut_1 <= validOutLookahead_1;
      END IF;
    END IF;
  END PROCESS vldOut_process;


  validOut <= vldOut_1;

  ready <= readyS;

END rtl;

