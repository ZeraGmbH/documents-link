--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
package FG_Pack is
use IEEE.math_real."ceil";
use IEEE.math_real."log2";


-- Constants --
constant MAIN_CLOCK_PERIOD : time := 10 ns;
	
constant Disable : std_logic := '0';
constant Enable : std_logic := '1';

constant TOTAL_SAMPLES : integer := 4096;	

constant PLL_PHASE_COUNT_SIZE : integer := integer(ceil(log2(real(TOTAL_SAMPLES)))); -- in bits & for one curve

constant KANAL_0 : integer := 0;
constant KANAL_1 : integer := 1;
constant KANAL_2 : integer := 2;
constant KANAL_3 : integer := 3;
constant KANAL_4 : integer := 4;
constant KANAL_5 : integer := 5;
constant TOTAL_KANÄLE : integer := 6;

constant KURVE_A : std_logic := '0'; --Read Me: confirm this
constant KURVE_B : std_logic := '1'; --Read Me: confirm this

constant Schalten_Bei_Nulldurchgang : std_logic := '0';
constant Schalten_Bei_Sofort : std_logic := '1';
constant Länge_Mode_Repeat : std_logic := '0';
constant Länge_Mode_Single : std_logic := '1';
constant Umschalt_Mode_A_B : std_logic := '0';
constant Umschalt_Mode_Ein_Aus : std_logic := '1';
constant Sequenzschrittdauer_Halbwelle : std_logic := '0'; --synchronous
constant Sequenzschrittdauer_FestZeit : std_logic := '1'; --asynchronous
constant Sequenzstop_KurveA : std_logic := '0';
constant Sequenzstop_KurveB : std_logic := '1';

-- User defined types --
type KURVE_TYP is range 0 to 2;
type KURVE_TYP_ALLE_KANALE is array (TOTAL_KANÄLE-1 downto 0) of KURVE_TYP;
type NULLDURCHGÄNGE_ALLE_KANALE is array (TOTAL_KANÄLE-1 downto 0, KURVE_TYP) of STD_LOGIC_VECTOR(PLL_PHASE_COUNT_SIZE-1 downto 0);

constant KURVE_TYPE_NULL : KURVE_TYP := 0;
constant KURVE_TYPE_A : KURVE_TYP := 1;
constant KURVE_TYPE_B : KURVE_TYP := 2;

constant Bit0_Freigabe					: integer := 0;
constant Bit1_Schalten_Bei				: integer := 1;
constant Bit2_Länge_Mode				: integer := 2;
constant Bit3_Umschalt_Mode			: integer := 3;
constant Bit4_Sequenzschrittdauer	: integer := 4;
constant Bit5_Sequenzstop				: integer := 5;
constant Bit6_Rampe_Status				: integer := 6;
constant Bit7_Reset_Blockade			: integer := 7;

constant CURVE_BRAM_00	: std_logic_vector(1 downto 0) := "00";
constant CURVE_BRAM_01	: std_logic_vector(1 downto 0) := "01";
constant CURVE_BRAM_10	: std_logic_vector(1 downto 0) := "10";
constant CURVE_BRAM_11	: std_logic_vector(1 downto 0) := "11";

constant RAM_ADDR_CHANNELNO_START	: integer := 13;
constant RAM_ADDR_CHANNELNO_END		: integer := 15;
constant RAM_ADDR_CURVENO				: integer := 12;
constant RAM_ADDR_BRAMNO_START		: integer := 10;
constant RAM_ADDR_BRAMNO_END			: integer := 11;
constant RAM_ADDR_SAMPLENO_START		: integer := 0;
constant RAM_ADDR_SAMPLENO_END		: integer := 9;


end FG_Pack;

package body FG_Pack is


end FG_Pack;
