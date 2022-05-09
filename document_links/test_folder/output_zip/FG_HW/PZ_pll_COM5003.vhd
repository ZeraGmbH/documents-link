----------------------------------------------------------------------------------
-- Company: ZERA
-- Engineer: Hüttemann
-- 
-- Create Date:    15:56:08 12/07/2006 
-- Design Name:    PZ_PLL.vhd
-- Module Name:    PZ_PLL - PZ_PLL_arch 
-- Project Name:    
-- Target Devices: 
-- Tool versions: 
-- Description: neue PLL für Prüfzähler, konfigurierbar  - siehe PZ_PLL.xls
-- 
-- Parameter: bit: 
--
-- Revision: 
-- Additional Comments: 
-- stand: start 31.10.12
--
-- Simmulation am 12.11.12 ...
-- mit ise-simulator! ISIM
-- todo: 
--  parameter
--		läuft nicht ohne ist, bzw soll erl. 3.12.12
--		dreh_pos ?
--		Fangebereich Frequenz 12Hz .. 200Hz im MT781 getestet
-- Einstgellungen für MT7xx
--constant 	count_to_pll_teiler_clk 	: integer := 20-1; 
--constant 	PLL_Teiler			 			: integer := 1512; 
--constant 	Bits_PLL_Teiler				: integer := 12;
--constant 	Bits_Erw_Teiler				: integer := 18;
--constant 	Bits_Teiler_T_CLK				: integer := 1-1;
--constant 	Divident							: integer := 396361728;
--constant 	T_steps_fang_bereich  		: integer := 900; 
--constant  	Phi_steps_dreh_f				: integer := 300;	
--constant		fine_phi_step			 		: integer := 24; --???
--constant		phi_steps_soll_ini			: std_logic_vector(31 downto 0) := x"00000024"; 
-- jitter bei 53 Hz ca 45us (alt mit 4046 ca. 435us)
--
-- 7+8.5.13 (im COM5003) Synchronisation geändert, es kam zu PLL-aussetzern, 
--			wenn pll aus dem tritt kam dreht sie jetzt in richtige richtung
--			max f=74Hz
-- 28.8.15 .. 31.8.15 Hüttemann
--				Versuche an PLL, PLL ist schon mal bei ca. 22Hz stehen geblieben und nur durch Bereichschalten wieder in den Tritt gekommen
--				TimeOut eingeführt, Frequenz geht bei Timeout auf F-Min

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity PZ_PLL is
	 Generic (PhaseBitCount : integer); --total number of bits expected in phase value
    Port ( clk : in  STD_LOGIC; 
			takt_in 		: in  STD_LOGIC; -- von Messplatine z.B. 50 hz eingangstakt
			parameter 	: in  STD_LOGIC_VECTOR (15 downto 0); -- ??
			phi_step_in	: in  STD_LOGIC_VECTOR (31 downto 0); -- Wert berechnet aus PZ_PLL.xls für Festfrequenz
			phi_out		: out  STD_LOGIC_VECTOR (PhaseBitCount-1 downto 0); -- aktueller Zählerstand / kann für Winkelinformation verwednet werden / Wertigkeit siehe PZ_PLL.xls
			testpin		: out  STD_LOGIC_VECTOR (31 downto 0);
			pll_clk		: out  STD_LOGIC;
			p_1ms			: in  STD_LOGIC;
			reset : in  STD_LOGIC);
end PZ_PLL;



architecture PZ_PLL_arch of PZ_PLL is
-------------------------------------------------------------------------------------------------
-- interne Signale + Constanten --
-------------------------------------------------------------------------------------------------

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Parameter bestimmt aus PZ_PLL.xls
-- 16.1.13 für COM5003 50Hz
-- am 8.5.13 kleine Fehler ausgebaut
-- 31.8.15 Parameter angepasst 31.8.15
constant 	PLL_Teiler			 			: integer := 4096; 
constant 	Bits_PLL_Teiler				: integer := 14;
constant 	Bits_Erw_Teiler				: integer := 20;
constant 	Bits_Teiler_T_CLK				: integer := 5-1;
constant 	Divident							: integer := 268435456;
constant 	T_steps_fang_bereich  		: integer := 3500; -- 20° 
constant  	Phi_steps_dreh_f				: integer := 51; -- 0.6Hz
constant		fine_phi_step			 		: integer := 2; -- 0.03Hz
constant		phi_steps_soll_ini			: std_logic_vector(35 downto 0) := x"0000010C6";
constant		phi_steps_min					: std_logic_vector(35 downto 0) := x"00000045C"; -- 13Hz
constant		phi_steps_max					: std_logic_vector(35 downto 0) := x"00000192A"; -- 75Hz

-- 21.12.12 für COM5003 50Hz
-- simuliert ok, aber noch nicht optimiert!!!!
--constant 	count_to_pll_teiler_clk 	: integer := 4-1; 
--constant 	PLL_Teiler			 			: integer := 129024; 
--constant 	Bits_PLL_Teiler				: integer := 18;
--constant 	Bits_Erw_Teiler				: integer := 14;
--constant 	Bits_Teiler_T_CLK				: integer := 5-1;
--constant 	Divident							: integer := 528482304;
--constant 	T_steps_fang_bereich  		: integer := 1700; 
--constant  	Phi_steps_dreh_f				: integer := 200; --hier bin ich ???	
--constant		fine_phi_step			 		: integer := 20; --???
--constant		phi_steps_soll_ini			: std_logic_vector(31 downto 0) := x"00001F0C"; --x"00000024"; 
--constant		phi_steps_min					: std_logic_vector(31 downto 0) := x"00001DBA";
--constant		phi_steps_max					: std_logic_vector(31 downto 0) := x"00002455";

---- Einstgellungen für MT7xx
--constant 	count_to_pll_teiler_clk 	: integer := 20-1; 
--constant 	PLL_Teiler			 			: integer := 1512; 
--constant 	Bits_PLL_Teiler				: integer := 12;
--constant 	Bits_Erw_Teiler				: integer := 18;
--constant 	Bits_Teiler_T_CLK				: integer := 1-1;
--constant 	Divident							: integer := 396361728;
--constant 	T_steps_fang_bereich  		: integer := 900; 
--constant  	Phi_steps_dreh_f				: integer := 300;	
--constant		fine_phi_step			 		: integer := 24; --???
--constant		phi_steps_soll_ini			: std_logic_vector(31 downto 0) := x"00000024"; 


-- Einstgellungen für FG301
-- Funktioniert mit 20ms 18ms
--constant 	count_to_pll_teiler_clk 	: integer := 19; 
--constant 	PLL_Teiler			 			: integer := 3599; 
--constant 	Bits_PLL_Teiler				: integer := 13;
--constant 	Bits_Erw_Teiler				: integer := 16; --??
--constant 	Bits_Teiler_T_CLK				: integer := 0;
--constant 	Divident							: integer := 235929600;
--constant 	T_steps_fang_bereich  		: integer := 440; 
--constant  	Phi_steps_dreh_f				: integer := 380;	
--constant		fine_phi_step			 		: integer := 17; 
	

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 21.12.12 für COM5003 50Hz
signal	T_clk_count					: std_logic_vector (Bits_Teiler_T_CLK downto 0);
signal	pll_teiler_clk_count		: std_logic_vector (4 downto 0):=(others => '0');
--signal	en_P_clk						: std_logic;
signal	en_T_clk						: std_logic;
signal 	count_filter				: std_logic_vector(3 downto 0):="0000";
signal	takt_in_i,takt_in_i2,takt_in_i0,takt_in_i01		: std_logic; 
signal   start_state_0,start_state_1,start_state_2,start_state_3,start_state_4			: std_logic; -- states
signal	run_div,run_div_i 		: std_logic;
signal 	T_counter					: std_logic_vector(35 downto 0):=(others => '0');
signal	T_SOLL						: std_logic_vector(35 downto 0):=(others => '0');
signal	Phi_steps_soll				: std_logic_vector(35 downto 0):= phi_steps_soll_ini;
signal	Gesamt_Counter				: std_logic_vector(35 downto 0):=(others => '0');
signal	Phi_steps					: std_logic_vector(35 downto 0):= phi_steps_soll_ini;
signal	Phi_steps_i					: std_logic_vector(35 downto 0):= phi_steps_soll_ini;
signal	takt_ist,takt_ist_i 		: std_logic:='0';
signal	takt_ist_p			 		: std_logic;
signal	Phase_count,Phase_count_i : std_logic_vector(17 downto 0):=(others => '0'); -- Zähler für Phasenlage in en_T_clk
signal	Phase_pos			 		: std_logic;
signal	Phase_count_run,Phase_count_run_i	 		: std_logic;
signal	tmp_stat4,tmp_stat4_i	: std_logic;
signal	pll_gefangen,pll_gefangen_i		 		: std_logic;
signal	pll_neu_gefangen	 		: std_logic;
signal	dreh_pos	 					: std_logic:='0';
signal	pll_clk_i	 				: std_logic;
signal	timeout_phase_count		: std_logic;
signal	eingangsfiltercount		: std_logic_vector(3 downto 0):=(others => '0'); 
signal	startfiltercount			: std_logic;
signal	TimeOutCounter			 	: std_logic_vector(7 downto 0):=(others => '0'); 
signal	TimeOut			: std_logic:='0';





-------------------------------------------------------------------------------------------------
-- Componenten --
-------------------------------------------------------------------------------------------------
COMPONENT PZ_div
Generic (
			Divident	: integer
	);
PORT(
	testp: out  STD_LOGIC_VECTOR (15 downto 0);
	divisor : IN std_logic_vector(35 downto 0);
	clk : IN std_logic;
	start : IN std_logic;
	reset : IN std_logic;          
	run : OUT std_logic;
	ergebnis : OUT std_logic_vector(35 downto 0)
	);
END COMPONENT;


begin--archtecture ---
-------------------------------------------------------------------------------------------------
-- Begin Prozesse und Module einbinden--
-------------------------------------------------------------------------------------------------



-----------------------------------------------------
-- Erzeugung Takte
-----------------------------------------------------
-- Eingang: clk, T_clk_count, pll_teiler_clk_count
-- Ausgang: en_T_clk, en_p_clk
-- Test: 
--   Sim ok 12.11.12
-----------------------------------------------------
--process(clk,reset)
--begin  
--	if reset = '1' then
--			pll_teiler_clk_count <= (others => '0');
--		
--	elsif ( rising_edge(CLK)) then 
--		if pll_teiler_clk_count = count_to_pll_teiler_clk then
--			pll_teiler_clk_count <= (others => '0');
--			en_p_clk <= '1';
--		else
--			pll_teiler_clk_count <= pll_teiler_clk_count + 1;
--			en_p_clk <= '0';
--		end if;	
--	end if;
--end process;

process(clk,reset)
begin  
	if reset = '1' then
			T_clk_count <= (others => '0');
	elsif ( rising_edge(CLK)) then 
		T_clk_count <= T_clk_count + 1;
		if T_clk_count = 0 then
				en_T_clk <= '1';
		else
			en_T_clk <= '0';
		end if;
	end if;
end process;
-----------------------------------------------------
	
testpin(0) <= '0';
testpin(1) <= takt_in_i;
testpin(2) <= takt_ist;
testpin(3) <= phase_pos;
testpin(4) <= run_div;
testpin(5) <= pll_gefangen;
testpin(6) <= Phase_count_run;
testpin(7) <= dreh_pos;

testpin(8)  <=  start_state_0;
testpin(9)  <=  start_state_1;
testpin(10) <=  start_state_2;
testpin(11) <=  start_state_3;
testpin(12) <=  start_state_4;
testpin(13) <= '0';
testpin(14) <= '0';
testpin(15) <= '0';

-----------------------------------------------------
-- Eingangsfilter
-----------------------------------------------------
-- Eingang: takt_in
-- Ausgang: start_state_0
-- Test:
-- Sim am 12.11.12 hh
-- 6.5.13 Problem: PLL ist schon mal aus dem Tritt gekommen
-- 	Test:  ??
-----------------------------------------------------
process(clk)
begin  
	if rising_edge(CLK) then 
		if startfiltercount = '1' and p_1ms= '1' then 
			eingangsfiltercount <= eingangsfiltercount + 1;
		end if;	
		
		takt_in_i0 <= takt_in;
		
		if takt_in_i0 ='0' then 
			startfiltercount <= '1';
		else
			takt_in_i <= '1';
			eingangsfiltercount <= (others => '0');
			startfiltercount <= '0';
		end if;
		if eingangsfiltercount = 2 then 
			takt_in_i <= '0';
		end if;
		takt_in_i2 	<= takt_in_i;
		start_state_1    <= not(takt_in_i2) and takt_in_i; -- steigende flanke
	end if;
end process;
-----------------------------------------------------
	
-----------------------------------------------------
-- TimoutCounter
-----------------------------------------------------
-- Eingang: start_state_1
-- Ausgang: TimeOut
-- Test:
-- Sim 
-- 28.8.15 Problem: PLL wird auf Festfrequenz gesetzt wenn kein Eingangssignal da ist
-----------------------------------------------------
process(clk)
begin  
	if rising_edge(CLK) then 
		if start_state_1 = '1' then
			TimeOutCounter <= (others => '0');
		elsif p_1ms = '1' then
			if TimeOutCounter < 200 then -- entspricht 0.2sec
					TimeOut <= '0';
					TimeOutCounter <= TimeOutCounter + 1; 
			else		
				TimeOut <= '1';
			end if;
		end if;
	end if;
end process;
-----------------------------------------------------
	
	
-----------------------------------------------------
-- Periodendauer messung
-----------------------------------------------------
-- Eingang: start_state_1
-- Startzeit: start_state_1
-- Ausgang: T_SOLL 
-- Fertig: start_state_2
-- Test: 
--		sim am 12.11.12 ok
-----------------------------------------------------
process(clk)
begin  
	if rising_edge(CLK) then 
		if start_state_1 = '1' then 
			T_SOLL <= T_counter;
			T_counter <= (others => '0');
		elsif en_T_clk = '1' then
			T_counter <= T_counter + 1;
		end if;
		start_state_2 <= start_state_1;
	end if;	
end process;
-----------------------------------------------------

-----------------------------------------------------
-- Division --> Phi_step_soll
-----------------------------------------------------
-- Eingang: T_SOLL
-- Startzeit: start_state_2
-- Ausgang: Phi_steps_soll
-- Fertig: start_state_3
-- Test:
--   sim 12.11.12 ok
-----------------------------------------------------
u_div: PZ_div 
generic map (
		Divident => Divident )
PORT MAP(
	   testp => open,
		divisor => T_SOLL,
		clk => clk,
		start => start_state_2,
		run => run_div,
		reset => reset,
		ergebnis => Phi_steps_soll
	);

process(clk)
begin  
	if rising_edge(CLK) then 
		run_div_i <= run_div;
	end if;
end process;
start_state_3 <= not(run_div) and run_div_i; -- negativ Flanke
-----------------------------------------------------



-----------------------------------------------------
-- PLL-Zähler
-----------------------------------------------------
-- Eingang: PLL_Teiler
-- Ausgang: takt_ist, pll_clk
-- Test:
--		sim 12.11.12 
-----------------------------------------------------
process(clk)
begin
	if rising_edge(CLK) then 
			if Gesamt_Counter(35 downto (Bits_Erw_Teiler+1)) = PLL_Teiler then
				Gesamt_Counter(35 downto (Bits_Erw_Teiler+1)) <= (others => '0');
				--if takt_ist = '0' then
				--	takt_ist <= '1';
				--else
				--	takt_ist <= '0'; 
				--end if;
			else	
				Gesamt_Counter <= Gesamt_Counter + Phi_steps;
	--		Gesamt_Counter <= Gesamt_Counter + phi_steps_soll_ini;
				
			end if;		
			
			if Gesamt_Counter(35 downto Bits_Erw_Teiler) < PLL_Teiler then
				takt_ist <= '1'; 
			else
				takt_ist <= '0';
			end if;
		end if;		
end process;



-- relevant phase count starts from 'Bits_Erw_Teiler+1'
-- example: for 12-bit phase value, phi_out(32 downto 21) d.h. phi_out(32 downto (Bits_Erw_Teiler+1)) is to be used.
phi_out <= Gesamt_Counter((PhaseBitCount - 1) + (Bits_Erw_Teiler + 1) downto (Bits_Erw_Teiler+1));
pll_clk_i <= Gesamt_Counter(Bits_Erw_Teiler);
pll_clk <= pll_clk_i;
-----------------------------------------------------

-----------------------------------------------------
-- Messung Phasenlage 
-----------------------------------------------------
-- Eingang: start_state_1, en_T_clk, takt_in_i, takt_ist
-- Ausgang: phase_pos, T_phase, Phase_count, start_state_4
-- Test:
--
-- 
-----------------------------------------------------
process(clk)
begin
	if rising_edge(CLK) then 
		takt_ist_i <= takt_ist;
		if start_state_1 = '1' then 		-- Zeitpunkt ist pos Flanke von takt_in_i
			Phase_pos <= takt_ist;	
			timeout_phase_count <= '0';
		end if;
		
		if (takt_ist ='1' and takt_in_i='1') or (takt_ist ='0' and takt_in_i='0') then -- 
			Phase_count_run <= '0';
		elsif start_state_1='1' or takt_ist_p='1' then
			Phase_count_run <= '1';
			Phase_count <= (others => '0');
		end if;
		if Phase_count_run = '1' and en_t_clk ='1' then
				Phase_count <= Phase_count + 1;
		end if;
		Phase_count_run_i <= Phase_count_run;
	end if;
end process;
takt_ist_p <= takt_ist and not(takt_ist_i); -- steigende Flanke


process(clk)
begin
	if rising_edge(CLK) then 
		if start_state_2 = '1' then
			tmp_stat4 <= '0';
		elsif run_div = '0' and phase_count_run = '0' then
			tmp_stat4 <= '1';
		end if;
		tmp_stat4_i <= tmp_stat4;
	end if;
end process;
start_state_4 <= not(tmp_stat4_i) and tmp_stat4; -- steigende Flanke
--start_state_4    <= not(takt_in_i) and takt_in_i2; -- fallende flanke

-----------------------------------------------------



-----------------------------------------------------
-- Check Status + neue Werte anwenden
-----------------------------------------------------
-- Eingang: phase_count
-- Startzeitpunkt: start_state_4
-- Ausgang: neuer Phi_steps
-- Test: 
-- 	sim:  OK 1.12.12
-----------------------------------------------------
process(clk)
begin
	if rising_edge(CLK) then 
		if  start_state_4 = '1' then
			if phase_count < T_steps_fang_bereich then
				pll_gefangen <= '1';
				if pll_gefangen_i = '0' then		-- pll_neugefangen
					pll_neu_gefangen <= '1';
					Phi_steps_i <= Phi_steps_soll;
				else
					if phase_pos = '1' then 
						Phi_steps_i <= Phi_steps_soll -  fine_phi_step;
					else
						Phi_steps_i <= Phi_steps_soll +  fine_phi_step;
					end if;
				end if;
			else
				pll_gefangen <= '0';
				if pll_gefangen_i = '1' then 		-- pll_neu_nicht gefangen
--					if Phase_count > Phase_count_i and phase_pos ='1' then
					if phase_pos ='1' then
						dreh_pos <= '0';
					else
						dreh_pos <= '1';
					end if;	
				else
					if dreh_pos = '1' then 					
						Phi_steps_i <= Phi_steps_soll + Phi_steps_dreh_f;
					else
						Phi_steps_i <= Phi_steps_soll - Phi_steps_dreh_f;
					end if;	
				end if;
				Phase_count_i <= Phase_count;
			end if;
		end if;
		pll_gefangen_i <=pll_gefangen;
		
	-- Grenzen prüfen
		if ((phi_steps_i < phi_steps_min) or TimeOut = '1')  then
			phi_steps <= phi_steps_min;
		else
			if phi_steps_i > phi_steps_max then
				phi_steps <= phi_steps_max;
			else
				phi_steps <= phi_steps_i;
			end if;
		end if;	
	end if;
end process;
				



-----------------------------------------------------
	

end PZ_PLL_arch;
-------------------------------------------------------------------------------------------------
-- Ende --
-------------------------------------------------------------------------------------------------


