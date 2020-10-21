-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\conno\Documents\NIH-GitHub\simulink_models\models\delay_and_sum_beamformer\hdlsrc\DSBF\DSBF_compute_delays.vhd
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: DSBF_compute_delays
-- Source Path: DSBF/dataplane/compute_delays
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.DSBF_dataplane_pkg.ALL;

ENTITY DSBF_compute_delays IS
  PORT( sin_azimuth                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        cos_elevation                     :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        sin_elevation                     :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        delays                            :   OUT   vector_of_std_logic_vector12(0 TO 15)  -- sfix12_En6 [16]
        );
END DSBF_compute_delays;


ARCHITECTURE rtl OF DSBF_compute_delays IS

  ATTRIBUTE multstyle : string;

  -- Constants
  CONSTANT zElementIdx                    : vector_of_signed5(0 TO 3) := 
    (to_signed(16#00#, 5), to_signed(16#02#, 5), to_signed(16#04#, 5), to_signed(16#06#, 5));  -- sfix5 [4]
  CONSTANT nc                             : vector_of_signed23(0 TO 3) := 
    (to_signed(-16#000999#, 23), to_signed(-16#000333#, 23), to_signed(16#000333#, 23),
     to_signed(16#000999#, 23));  -- sfix23 [4]

  -- Signals
  SIGNAL sin_azimuth_signed               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL cos_elevation_signed             : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL sin_elevation_signed             : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL delays_tmp                       : vector_of_signed12(0 TO 15);  -- sfix12_En6 [16]

BEGIN
  sin_azimuth_signed <= signed(sin_azimuth);

  cos_elevation_signed <= signed(cos_elevation);

  sin_elevation_signed <= signed(sin_elevation);

  compute_delays_output : PROCESS (cos_elevation_signed, sin_azimuth_signed, sin_elevation_signed)
    VARIABLE idx : unsigned(4 DOWNTO 0);
    VARIABLE z : signed(4 DOWNTO 0);
    VARIABLE y : signed(4 DOWNTO 0);
    VARIABLE add_temp : vector_of_unsigned6(0 TO 3);
    VARIABLE sub_cast : vector_of_signed32(0 TO 3);
    VARIABLE add_cast : vector_of_signed6(0 TO 3);
    VARIABLE add_temp_0 : vector_of_signed6(0 TO 3);
    VARIABLE sub_cast_0 : vector_of_signed32(0 TO 3);
    VARIABLE mul_temp : vector_of_signed39(0 TO 3);
    VARIABLE mul_temp_0 : vector_of_signed55(0 TO 3);
    VARIABLE add_cast_0 : vector_of_signed56(0 TO 3);
    VARIABLE add_cast_1 : vector_of_signed6(0 TO 3);
    VARIABLE add_temp_1 : vector_of_signed6(0 TO 3);
    VARIABLE sub_cast_1 : vector_of_signed32(0 TO 3);
    VARIABLE mul_temp_1 : vector_of_signed39(0 TO 3);
    VARIABLE add_cast_2 : vector_of_signed56(0 TO 3);
    VARIABLE add_temp_2 : vector_of_signed56(0 TO 3);
    VARIABLE mul_temp_2 : vector_of_signed72(0 TO 3);
  BEGIN
    z := to_signed(16#00#, 5);
    y := to_signed(16#00#, 5);
    -- meters
    -- meters/second

    FOR t_0 IN 0 TO 15 LOOP
      delays_tmp(t_0) <= to_signed(16#000#, 12);
    END LOOP;

    idx := to_unsigned(16#00#, 5);

    FOR z_0 IN 0 TO 3 LOOP
      z := zElementIdx(z_0);

      FOR y_0 IN 0 TO 3 LOOP
        y := zElementIdx(y_0);
        add_temp(y_0) := resize(idx, 6) + to_unsigned(16#01#, 6);
        IF add_temp(y_0)(5) /= '0' THEN 
          idx := "11111";
        ELSE 
          idx := add_temp(y_0)(4 DOWNTO 0);
        END IF;
        sub_cast(y_0) := signed(resize(idx, 32));
        add_cast(y_0) := resize(y, 6);
        add_temp_0(y_0) := add_cast(y_0) + to_signed(16#02#, 6);
        sub_cast_0(y_0) := resize(add_temp_0(y_0)(5 DOWNTO 1), 32);
        mul_temp(y_0) := nc(to_integer(sub_cast_0(y_0) - 1)) * sin_azimuth_signed;
        mul_temp_0(y_0) := mul_temp(y_0) * cos_elevation_signed;
        add_cast_0(y_0) := resize(mul_temp_0(y_0), 56);
        add_cast_1(y_0) := resize(z, 6);
        add_temp_1(y_0) := add_cast_1(y_0) + to_signed(16#02#, 6);
        sub_cast_1(y_0) := resize(add_temp_1(y_0)(5 DOWNTO 1), 32);
        mul_temp_1(y_0) := nc(to_integer(sub_cast_1(y_0) - 1)) * sin_elevation_signed;
        add_cast_2(y_0) := resize(mul_temp_1(y_0) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 56);
        add_temp_2(y_0) := add_cast_0(y_0) + add_cast_2(y_0);
        mul_temp_2(y_0) := to_signed(-16#0046#, 16) * add_temp_2(y_0);
        IF ((mul_temp_2(y_0)(71) = '0') AND (mul_temp_2(y_0)(70 DOWNTO 48) /= "00000000000000000000000")) OR ((mul_temp_2(y_0)(71) = '0') AND (mul_temp_2(y_0)(48 DOWNTO 37) = "011111111111")) THEN 
          delays_tmp(to_integer(sub_cast(y_0) - 1)) <= "011111111111";
        ELSIF (mul_temp_2(y_0)(71) = '1') AND (mul_temp_2(y_0)(70 DOWNTO 48) /= "11111111111111111111111") THEN 
          delays_tmp(to_integer(sub_cast(y_0) - 1)) <= "100000000000";
        ELSE 
          delays_tmp(to_integer(sub_cast(y_0) - 1)) <= mul_temp_2(y_0)(48 DOWNTO 37) + ('0' & mul_temp_2(y_0)(36));
        END IF;
      END LOOP;

    END LOOP;

  END PROCESS compute_delays_output;


  outputgen: FOR k IN 0 TO 15 GENERATE
    delays(k) <= std_logic_vector(delays_tmp(k));
  END GENERATE;

END rtl;
