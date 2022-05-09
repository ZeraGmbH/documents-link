-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  use work.FG_Pack.all;
  
  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT Kanal_Kurve_Manager
			 Port ( Clock_100MHz_IN : in  STD_LOGIC;
					  Phase_Count_IN : in  STD_LOGIC_VECTOR(PLL_PHASE_COUNT_SIZE-1 downto 0);
					  Kurvenauswahl_IN : in  KURVE_TYP;
					  BRAMWriteEnable_IN : in  STD_LOGIC;
					  BRAMWriteData_IN : in  STD_LOGIC_VECTOR(31 downto 0);
					  BRAMWriteAddr_IN : in  STD_LOGIC_VECTOR(19 downto 0); 
					  SPI_SCLK_IN : in  STD_LOGIC;
					  SPI_LE_OUT : out  STD_LOGIC;
					  SPI_MOSI_OUT : out  STD_LOGIC;
					  SPI_Data_OUT : out STD_LOGIC_VECTOR(16+0-1 downto 0));
          END COMPONENT;

          SIGNAL Clock_100MHz :  std_logic := '0';
          SIGNAL phase :  STD_LOGIC_VECTOR(PLL_PHASE_COUNT_SIZE-1 downto 0) := (others => '0');
			 SIGNAL sampleValue :  STD_LOGIC_VECTOR(16+0-1 downto 0) := (others => '0');
          SIGNAL SPI_SCLK :  STD_LOGIC;
			 SIGNAL SPI_LE :  STD_LOGIC;
			 SIGNAL SPI_MOSI :  STD_LOGIC;
			 SIGNAL KurveSelect : KURVE_TYP := KURVE_TYPE_A;
 BEGIN

  -- Component Instantiation
		uut: Kanal_Kurve_Manager PORT MAP(
		Clock_100MHz_IN => Clock_100MHz,
		Phase_Count_IN => phase,
		Kurvenauswahl_IN => KurveSelect,
		BRAMWriteEnable_IN => '0',
		BRAMWriteData_IN => (others => '0'),
		BRAMWriteAddr_IN => (others => '0'),
		SPI_SCLK_IN => SPI_SCLK,
		SPI_LE_OUT => SPI_LE,
		SPI_MOSI_OUT => SPI_MOSI,
		SPI_Data_OUT => sampleValue
		);

  --  Test Bench Statements
		clock: process
		begin
			wait for 5 ns;
				Clock_100MHz <= not Clock_100MHz;
		end process clock;
  
     tb : PROCESS
     BEGIN
			KurveSelect <= KURVE_TYPE_A;
			wait for 100 ns; -- wait until global set/reset completes
			phase <= x"000";
			wait for 4.88 us;
			phase <= x"001";
			wait for 4.88 us;
			phase <= x"800";
			wait for 4.88 us;
			phase <= x"FFF";
			wait for 4.88 us;
			
			
			KurveSelect <= KURVE_TYPE_B;
			phase <= x"000";
			wait for 4.88 us;
			phase <= x"001";
			wait for 4.88 us;
			phase <= x"800";
			wait for 4.88 us;
			phase <= x"FFF";
			wait for 4.88 us;
			
			
			wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
