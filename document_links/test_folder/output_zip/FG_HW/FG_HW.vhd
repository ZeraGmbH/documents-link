----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:45:01 11/05/2021 
-- Design Name: 
-- Module Name:    Main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use work.FG_Pack.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FG_HW is
    Port ( Clock_100MHz_IN : in  STD_LOGIC;
			  WriteData_IN : in  STD_LOGIC_VECTOR(31 downto 0);
			  WriteData_OUT : out  STD_LOGIC_VECTOR(31 downto 0);
			  WriteAddr_IN : in  STD_LOGIC_VECTOR(19 downto 0); 
			  rd : in  STD_LOGIC;
			  wr : in  STD_LOGIC;
			  ce	: in  std_logic;			-- chip enable
			  interrupt : out std_logic;
			  
			  Reference_IN : in STD_LOGIC;
           SCLK_OUT : out  STD_LOGIC;
           SPI_LE_OUT : out  STD_LOGIC_VECTOR(5 downto 0);
           SPI_MOSI_OUT : out  STD_LOGIC_VECTOR(5 downto 0));
end FG_HW;

architecture Behavioral of FG_HW is
	
	constant PULSE_1MS_PERIOD : integer := 100000;
	constant SCLK_PERIOD : time := 100 ns;
	constant SCLK_Clock_Cycle_Count : integer := SCLK_PERIOD/MAIN_CLOCK_PERIOD;

	component PZ_PLL
	Generic (PhaseBitCount : integer);
	Port ( clk : in  STD_LOGIC; 
				takt_in 		: in  STD_LOGIC; -- von Messplatine z.B. 50 hz eingangstakt
				parameter 	: in  STD_LOGIC_VECTOR (15 downto 0); -- ??
				phi_step_in	: in  STD_LOGIC_VECTOR (31 downto 0); -- Wert berechnet aus PZ_PLL.xls für Festfrequenz
				phi_out		: out  STD_LOGIC_VECTOR (PhaseBitCount-1 downto 0); -- aktueller Zählerstand / kann für Winkelinformation verwednet werden / Wertigkeit siehe PZ_PLL.xls
				testpin		: out  STD_LOGIC_VECTOR (31 downto 0);
				pll_clk		: out  STD_LOGIC;
				p_1ms			: in  STD_LOGIC;
				reset : in  STD_LOGIC);
	end component;
	
	component Sequenzer
    Port ( Clock_100MHz_IN : in  STD_LOGIC;
			  PLL_Phase_IN : in  STD_LOGIC_VECTOR(PLL_PHASE_COUNT_SIZE-1 downto 0);
			  NullDurchagänge_IN : in  NULLDURCHGÄNGE_ALLE_KANALE;
			  SequenzBRAMData_IN : in  STD_LOGIC_VECTOR (31 downto 0);
			  SequenzBRAMAddr_IN : in  STD_LOGIC_VECTOR (19 downto 0);
			  SequenzBRAMEna_IN : in  STD_LOGIC;
			  SteuerRegister_IN : in  STD_LOGIC_VECTOR (15 downto 0);
			  ModuloRegister_IN : in  STD_LOGIC_VECTOR (13 downto 0);
			  KanalMaske_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           Kurvenauswahl_OUT : out KURVE_TYP_ALLE_KANALE);
	end component;
	
	component Kanal_Kurve_Manager
	Port ( Clock_100MHz_IN : in  STD_LOGIC;
           Phase_Count_IN : in  STD_LOGIC_VECTOR(PLL_PHASE_COUNT_SIZE-1 downto 0);
			  Kurvenauswahl_IN : in  KURVE_TYP;
			  BRAMWriteEnable_IN : in  STD_LOGIC;
			  BRAMWriteData_IN : in  STD_LOGIC_VECTOR(31 downto 0);
			  BRAMWriteAddr_IN : in  STD_LOGIC_VECTOR(19 downto 0); 
           SPI_SCLK_IN : in  STD_LOGIC;
           SPI_LE_OUT : out  STD_LOGIC;
           SPI_MOSI_OUT : out  STD_LOGIC);
	end component;
	
	signal SPI_SCLK : STD_LOGIC := '0';
	
	signal PLL_parameter : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
	signal PLL_phi_step_in : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal PLL_phi_out : STD_LOGIC_VECTOR(PLL_PHASE_COUNT_SIZE-1 downto 0) := (others => '0');
	signal PLL_testpin : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
	signal PLL_Clock : STD_LOGIC := '0';
	signal PLL_1ms : STD_LOGIC := '0';

	signal NullDurchagänge : NULLDURCHGÄNGE_ALLE_KANALE := (others => (others => (others => '0')));
	
	signal ModuloRegister : STD_LOGIC_VECTOR (13 downto 0) := (others => '0');
	signal KanalMaske : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
	signal SequenzSteuerRegister : STD_LOGIC_VECTOR (15 downto 0) := (others => '0'); 
	signal Kurvenauswahl : KURVE_TYP_ALLE_KANALE := (others => KURVE_TYPE_NULL);
	signal SequenceBRAMWriteEna : STD_LOGIC := '0';
	
	signal KanalWriteEnable : STD_LOGIC_VECTOR (TOTAL_KANÄLE-1 downto 0) := (others => '0'); 
	
begin

	Pulse_1ms : process(Clock_100MHz_IN)
	variable pulse_Counter : integer range 0 to 100000:= 0;
	begin
		if (Clock_100MHz_IN'event and Clock_100MHz_IN = '1') then
			pulse_Counter := pulse_Counter + 1;
			if (pulse_Counter = PULSE_1MS_PERIOD) then
				pulse_Counter := 0;
				PLL_1ms <= '1';
			else
				PLL_1ms <= '0';
			end if;
		end if;
	end process;
	
	PLL_1 : PZ_PLL
	generic map (
		PhaseBitCount => PLL_PHASE_COUNT_SIZE
	)
	port map (
		clk => Clock_100MHz_IN,
		takt_in => Reference_IN,
		parameter => PLL_parameter,
		phi_step_in => PLL_phi_step_in,
		phi_out => PLL_phi_out,
		testpin => PLL_testpin,
		pll_clk => PLL_Clock,
		p_1ms => PLL_1ms,
		reset => '0'
	);
	
	--SCLK generation: This process creates SCLK of half frequency of 'ClockReference'
	process (Clock_100MHz_IN)
	variable counter_SCLK : integer range 0 to 10:= 0;
	begin
		if (Clock_100MHz_IN'event and Clock_100MHz_IN = '1') then
			counter_SCLK := counter_SCLK + 1;
			if (counter_SCLK >= SCLK_Clock_Cycle_Count/2) then
				counter_SCLK := 0;
				SPI_SCLK <= not SPI_SCLK; 
			end if;
		end if;
	end process;
	SCLK_OUT <= SPI_SCLK;
	
	
	Sequenzer_0 : Sequenzer
	port map (
		Clock_100MHz_IN => Clock_100MHz_IN,
		PLL_Phase_IN => PLL_phi_out,
		NullDurchagänge_IN => NullDurchagänge,
		SequenzBRAMData_IN => WriteData_IN,
		SequenzBRAMAddr_IN => WriteAddr_IN,
		SequenzBRAMEna_IN => SequenceBRAMWriteEna,
		SteuerRegister_IN => SequenzSteuerRegister,
		ModuloRegister_IN => ModuloRegister,
		KanalMaske_IN => KanalMaske,
		Kurvenauswahl_OUT => Kurvenauswahl
	);
	
	gen_Kanal:
	for i in 0 to TOTAL_KANÄLE-1 generate
		Kanali : Kanal_Kurve_Manager
		port map (
			Clock_100MHz_IN => Clock_100MHz_IN,
			Phase_Count_IN => PLL_phi_out,
			Kurvenauswahl_IN => Kurvenauswahl(i),
			BRAMWriteEnable_IN => KanalWriteEnable(i),
			BRAMWriteData_IN => WriteData_IN,
			BRAMWriteAddr_IN => WriteAddr_IN,
			SPI_SCLK_IN => SPI_SCLK,
			SPI_LE_OUT => SPI_LE_OUT(i),
			SPI_MOSI_OUT => SPI_MOSI_OUT(i)
		);
	end generate gen_Kanal;
	
	process(Clock_100MHz_IN, ce, wr, rd)
	begin
		if rising_edge(Clock_100MHz_IN) then
			if ce = '1' then
				if wr = '1' then
				
					case WriteAddr_IN(19 downto 16) is
						
						when x"0" =>
							SequenceBRAMWriteEna <= '0';
							case WriteAddr_IN(RAM_ADDR_CHANNELNO_END downto RAM_ADDR_CHANNELNO_START) is
								when "000" => KanalWriteEnable <= (KANAL_0 => '1', others => '0'); --0x00000 to 0x01FFF, channel 0 curve A & B
								when "001" => KanalWriteEnable <= (KANAL_1 => '1', others => '0'); --0x02000 to 0x03FFF, channel 1 curve A & B
								when "010" => KanalWriteEnable <= (KANAL_2 => '1', others => '0'); --0x04000 to 0x05FFF, channel 2 curve A & B
								when "011" => KanalWriteEnable <= (KANAL_3 => '1', others => '0'); --0x06000 to 0x07FFF, channel 3 curve A & B
								when "100" => KanalWriteEnable <= (KANAL_4 => '1', others => '0'); --0x08000 to 0x09FFF, channel 4 curve A & B
								when "101" => KanalWriteEnable <= (KANAL_5 => '1', others => '0'); --0x0A000 to 0x0BFFF, channel 5 curve A & B
								when others => KanalWriteEnable <= (others => '0');
							end case;
						
						when x"1" =>
							KanalWriteEnable <= (others => '0');
							SequenceBRAMWriteEna <= '0';	
							case WriteAddr_IN(15 downto 0) is
								when x"0000" => SequenzSteuerRegister <= WriteData_IN(15 downto 0); --0x10000
								when x"0002" => ModuloRegister <= WriteData_IN(13 downto 0); --0x10002
								when x"0003" => KanalMaske <= WriteData_IN(15 downto 0); --0x10003
								when x"2200" => 
									NullDurchagänge(KANAL_0, KURVE_TYPE_A) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x12200
									NullDurchagänge(KANAL_0, KURVE_TYPE_NULL) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --same used for KURVE_TYPE_NULL
								when x"2201" => NullDurchagänge(KANAL_0, KURVE_TYPE_B) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x12201
								when x"2202" => 
									NullDurchagänge(KANAL_1, KURVE_TYPE_A) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x12202
									NullDurchagänge(KANAL_1, KURVE_TYPE_NULL) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x12202
								when x"2203" => NullDurchagänge(KANAL_1, KURVE_TYPE_B) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x12203
								when x"2204" => 
									NullDurchagänge(KANAL_2, KURVE_TYPE_A) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x12204
									NullDurchagänge(KANAL_2, KURVE_TYPE_NULL) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x12204
								when x"2205" => NullDurchagänge(KANAL_2, KURVE_TYPE_B) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x12205
								when x"2206" => 
									NullDurchagänge(KANAL_3, KURVE_TYPE_A) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x12206
									NullDurchagänge(KANAL_3, KURVE_TYPE_NULL) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x12206
								when x"2207" => NullDurchagänge(KANAL_3, KURVE_TYPE_B) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x12207
								when x"2208" => 
									NullDurchagänge(KANAL_4, KURVE_TYPE_A) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x12208
									NullDurchagänge(KANAL_4, KURVE_TYPE_NULL) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x12208
								when x"2209" => NullDurchagänge(KANAL_4, KURVE_TYPE_B) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x12209
								when x"220a" => 
									NullDurchagänge(KANAL_5, KURVE_TYPE_A) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x1220A
									NullDurchagänge(KANAL_5, KURVE_TYPE_NULL) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x1220A
								when x"220b" => NullDurchagänge(KANAL_5, KURVE_TYPE_B) <= WriteData_IN(PLL_PHASE_COUNT_SIZE-1 downto 0); --0x1220B
								when others =>
							end case;
							
							case WriteAddr_IN(15 downto 8) is
								when x"20" | x"21" => SequenceBRAMWriteEna <= '1'; --0x12000 to 0x121FF			
								when others => SequenceBRAMWriteEna <= '0';
							end case;
							
						when others =>
							KanalWriteEnable <= (others => '0');
							SequenceBRAMWriteEna <= '0';
							
					end case;
				
				end if;
			end if;
		end if;
	end process;
	
	
	
end Behavioral;

