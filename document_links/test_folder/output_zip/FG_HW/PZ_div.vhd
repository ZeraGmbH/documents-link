----------------------------------------------------------------------------------
-- Company: ZERA
-- Engineer: Hüttemann
-- 
-- Create Date:    11:26:16 05/11/2007 
-- Design Name:    div.vhd
-- Module Name:    div - div_arch 
-- Project Name:   PLL 
-- Target Devices: 
-- Tool versions: 
-- Description: Division durch zählen
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
-- 24.3.2010 design anpassungen, keine funktionsänderungen
-- 16.1.2013 auf 36bit aufgebort!! hh

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PZ_div is
Generic (
			Divident	: integer
	);
    Port ( testp: out  STD_LOGIC_VECTOR (15 downto 0);
			  divisor : in  STD_LOGIC_VECTOR (35 downto 0);
           clk : in  STD_LOGIC;
           start : in  STD_LOGIC;
           run : out  STD_LOGIC;
           reset : in  STD_LOGIC;
           ergebnis : out  STD_LOGIC_VECTOR (35 downto 0)
			  );
end PZ_div;

architecture PZ_div_arch of PZ_div is
-------------------------------------------------------------------------------------------------
-- interne Signale + Constanten --
-------------------------------------------------------------------------------------------------
--constant 	divident	: integer := 235926000; -- = 7200 * 65535 / 2

signal		count	:  std_logic_vector (35 downto 0):=x"000000000";
signal		step	:  std_logic_vector (35 downto 0):=x"000000000";
signal		countb	:  std_logic_vector (35 downto 0) :=x"000000000";
signal		ergebnis_i	:  std_logic_vector (35 downto 0) :=x"000000000";
signal		run_i	: std_logic;


-------------------------------------------------------------------------------------------------
-- Componenten --
-------------------------------------------------------------------------------------------------

begin--archtecture ---
-------------------------------------------------------------------------------------------------
-- Begin Prozesse und Module einbinden--
-------------------------------------------------------------------------------------------------

process(clk)
begin  
	if ( rising_edge(CLK) ) then 
		if start = '1' then
			run_i <= '1';
			step 	<= divisor;
		end if;	
		if run_i = '1' then
			count <= count + step;
			countb <= countb + 1;
		end if;	
		if count > divident and run_i = '1' then
			run_i <= '0';
			ergebnis_i <= countb;
			count <= (others =>'0');
			countb <= (others =>'0');
		end if;	
	end if;
end process;
run 			<= run_i;
ergebnis 	<= ergebnis_i;


end PZ_div_arch;
-------------------------------------------------------------------------------------------------
-- Ende --
-------------------------------------------------------------------------------------------------


