-- -------------------------------------------------------------
-- 
-- File Name: /mnt/data/NIH/simulink_models/models/delay_and_sum_beamformer/hdlsrc/DSBF/DSBF_FilterTapSystolicPreAddWvlIn.vhd
-- 
-- Generated by MATLAB 9.6 and HDL Coder 3.14
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: DSBF_FilterTapSystolicPreAddWvlIn
-- Source Path: DSBF/dataplane/Avalon Data Processing/delay signals/delay signal/CIC interpolation compensator/FilterBank/subFilter/FilterTapSystolicPreAddWvlIn
-- Hierarchy Level: 7
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY DSBF_FilterTapSystolicPreAddWvlIn IS
  PORT( clk                               :   IN    std_logic;
        enb_1_2048_0                      :   IN    std_logic;
        dinReg_0_re                       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        dinPreAdd                         :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        coefIn_0                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        addin                             :   IN    std_logic_vector(48 DOWNTO 0);  -- sfix49_En43
        dinRegVld                         :   IN    std_logic;
        syncReset                         :   IN    std_logic;
        dinDly2                           :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        tapout                            :   OUT   std_logic_vector(48 DOWNTO 0)  -- sfix49_En43
        );
END DSBF_FilterTapSystolicPreAddWvlIn;


ARCHITECTURE rtl OF DSBF_FilterTapSystolicPreAddWvlIn IS

  -- Signals
  SIGNAL dinReg_0_re_signed               : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL dinPreAdd_signed                 : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL coefIn_0_signed                  : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL addin_signed                     : signed(48 DOWNTO 0);  -- sfix49_En43
  SIGNAL fTap_din1_reg1                   : signed(31 DOWNTO 0) := to_signed(0, 32);  -- sfix32
  SIGNAL fTap_din1_reg2                   : signed(31 DOWNTO 0) := to_signed(0, 32);  -- sfix32
  SIGNAL fTap_din1_reg3                   : signed(31 DOWNTO 0) := to_signed(0, 32);  -- sfix32
  SIGNAL fTap_din2_reg1                   : signed(31 DOWNTO 0) := to_signed(0, 32);  -- sfix32
  SIGNAL fTap_din2_reg2                   : signed(31 DOWNTO 0) := to_signed(0, 32);  -- sfix32
  SIGNAL fTap_addout_reg                  : signed(48 DOWNTO 0) := to_signed(0, 49);  -- sfix49
  SIGNAL fTap_coef_reg1                   : signed(15 DOWNTO 0) := to_signed(16#0000#, 16);  -- sfix16
  SIGNAL fTap_coef_reg2                   : signed(15 DOWNTO 0) := to_signed(16#0000#, 16);  -- sfix16
  SIGNAL fTap_din1_reg1_next              : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL fTap_din1_reg2_next              : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL fTap_din1_reg3_next              : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL fTap_din2_reg1_next              : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL fTap_din2_reg2_next              : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL fTap_addout_reg_next             : signed(48 DOWNTO 0);  -- sfix49_En43
  SIGNAL fTap_coef_reg1_next              : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL fTap_coef_reg2_next              : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL dinDly2_tmp                      : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL tapout_tmp                       : signed(48 DOWNTO 0);  -- sfix49_En43

BEGIN
  dinReg_0_re_signed <= signed(dinReg_0_re);

  dinPreAdd_signed <= signed(dinPreAdd);

  coefIn_0_signed <= signed(coefIn_0);

  addin_signed <= signed(addin);

  -- FilterTapSystolicPreAddWvldIn
  fTap_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        fTap_din1_reg1 <= fTap_din1_reg1_next;
        fTap_din1_reg2 <= fTap_din1_reg2_next;
        fTap_din1_reg3 <= fTap_din1_reg3_next;
        fTap_din2_reg1 <= fTap_din2_reg1_next;
        fTap_din2_reg2 <= fTap_din2_reg2_next;
        fTap_addout_reg <= fTap_addout_reg_next;
        fTap_coef_reg1 <= fTap_coef_reg1_next;
        fTap_coef_reg2 <= fTap_coef_reg2_next;
      END IF;
    END IF;
  END PROCESS fTap_process;

  fTap_output : PROCESS (addin_signed, coefIn_0_signed, dinPreAdd_signed, dinRegVld, dinReg_0_re_signed,
       fTap_addout_reg, fTap_coef_reg1, fTap_coef_reg2, fTap_din1_reg1,
       fTap_din1_reg2, fTap_din1_reg3, fTap_din2_reg1, fTap_din2_reg2)
    VARIABLE add_cast : signed(32 DOWNTO 0);
    VARIABLE add_cast_0 : signed(32 DOWNTO 0);
    VARIABLE add_temp : signed(32 DOWNTO 0);
    VARIABLE mul_temp : signed(48 DOWNTO 0);
  BEGIN
    fTap_din1_reg1_next <= fTap_din1_reg1;
    fTap_din1_reg2_next <= fTap_din1_reg2;
    fTap_din1_reg3_next <= fTap_din1_reg3;
    fTap_din2_reg1_next <= fTap_din2_reg1;
    fTap_din2_reg2_next <= fTap_din2_reg2;
    fTap_addout_reg_next <= fTap_addout_reg;
    fTap_coef_reg1_next <= fTap_coef_reg1;
    fTap_coef_reg2_next <= fTap_coef_reg2;
    IF dinRegVld = '1' THEN 
      add_cast := resize(fTap_din1_reg3, 33);
      add_cast_0 := resize(fTap_din2_reg2, 33);
      add_temp := add_cast + add_cast_0;
      mul_temp := add_temp * fTap_coef_reg2;
      fTap_addout_reg_next <= mul_temp + addin_signed;
      fTap_din1_reg3_next <= fTap_din1_reg2;
      fTap_din1_reg2_next <= fTap_din1_reg1;
      fTap_din1_reg1_next <= dinReg_0_re_signed;
      fTap_din2_reg2_next <= fTap_din2_reg1;
      fTap_din2_reg1_next <= dinPreAdd_signed;
      fTap_coef_reg2_next <= fTap_coef_reg1;
      fTap_coef_reg1_next <= coefIn_0_signed;
    END IF;
    dinDly2_tmp <= fTap_din1_reg2;
    tapout_tmp <= fTap_addout_reg;
  END PROCESS fTap_output;


  dinDly2 <= std_logic_vector(dinDly2_tmp);

  tapout <= std_logic_vector(tapout_tmp);

END rtl;

