-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  use work.FG_Pack.all;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT FG_HW
          PORT ( Clock_100MHz_IN : in  STD_LOGIC;
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
					  SPI_MOSI_OUT : out  STD_LOGIC_VECTOR(5 downto 0);
					  Phase_OUT : out STD_LOGIC_VECTOR(PLL_PHASE_COUNT_SIZE-1 downto 0);
					  Sample_OUT : out STD_LOGIC_VECTOR(16+0-1 downto 0));
          END COMPONENT;

          SIGNAL Clock_100MHz, Clock_50Hz :  std_logic := '0';
          SIGNAL RAMWriteData :  STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
          SIGNAL RAMReadData :  STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
          SIGNAL RAMAddr :  STD_LOGIC_VECTOR(19 downto 0) := (others => '0');
          signal RAM_WE, RAM_CE : STD_LOGIC := '0';
			 signal int : STD_LOGIC := '0';
			 SIGNAL SPI_SCLK :  STD_LOGIC;
			 SIGNAL SPI_LE :  STD_LOGIC_VECTOR(5 downto 0);
			 SIGNAL SPI_MOSI :  STD_LOGIC_VECTOR(5 downto 0);
			 SIGNAL Phase : STD_LOGIC_VECTOR(PLL_PHASE_COUNT_SIZE-1 downto 0) := (others => '0');
			 SIGNAL Sample : STD_LOGIC_VECTOR(16+0-1 downto 0) := (others => '0');
			 
			 constant SeqSteuerRegister : STD_LOGIC_VECTOR(31 downto 0) := X"00000021";
			 constant SeqModuloRegister : STD_LOGIC_VECTOR(31 downto 0) := X"0000000A";
			 constant SeqKanalMask : STD_LOGIC_VECTOR(31 downto 0) := X"00000001";
			 constant NullDG_K0_A : STD_LOGIC_VECTOR(31 downto 0) := X"00000002";
			 constant NullDG_K0_B : STD_LOGIC_VECTOR(31 downto 0) := X"00000004";
			 
  BEGIN

  -- Component Instantiation
          uut: FG_HW PORT MAP(
                  Clock_100MHz_IN => Clock_100MHz,
						WriteData_IN => RAMWriteData,
						WriteData_OUT => RAMReadData,
						WriteAddr_IN => RAMAddr,
						rd => '0',
						wr => RAM_WE,
						ce => RAM_CE,
						interrupt => int,
						Reference_IN => Clock_50Hz,
						SCLK_OUT => SPI_SCLK,
						SPI_LE_OUT => SPI_LE,
						SPI_MOSI_OUT => SPI_MOSI,
						Phase_OUT => Phase,
						Sample_OUT => Sample
          );


  --  Test Bench Statements
		clk_100MHz: process
		begin
			wait for 5 ns;
				Clock_100MHz <= not Clock_100MHz;
		end process clk_100MHz;
		
		clk_50Hz: process
		begin
			wait for 10 ms;
				Clock_50Hz <= not Clock_50Hz;
		end process clk_50Hz;
		
		
		tb : PROCESS
		BEGIN

			wait for 100 ns; -- wait until global set/reset completes

			RAM_WE <= '1';
			RAM_CE <= '1';
			RAMAddr <= x"01000";
			RAMWriteData <= x"00004444";
			wait for 100 ns;
			
			RAMAddr <= x"01001";
			RAMWriteData <= x"00004444";
			wait for 100 ns;
			
			RAMAddr <= x"01002";
			RAMWriteData <= x"00004444";
			wait for 100 ns;
			
			RAMAddr <= x"01003";
			RAMWriteData <= x"00004444";
			wait for 100 ns;
			
			RAMAddr <= x"01004";
			RAMWriteData <= x"00004444";
			wait for 100 ns;
			
			RAMAddr <= x"01005";
			RAMWriteData <= x"00004444";
			wait for 100 ns;
			
			RAMAddr <= x"01006";
			RAMWriteData <= x"00004444";
			wait for 100 ns;
			
			RAMAddr <= x"01007";
			RAMWriteData <= x"00004444";
			wait for 100 ns;
			
			RAMAddr <= x"01008";
			RAMWriteData <= x"00004444";
			wait for 100 ns;
			
			RAMAddr <= x"01009";
			RAMWriteData <= x"00004444";
			wait for 100 ns;
			
			RAMAddr <= x"12200";
			RAMWriteData <= NullDG_K0_A;
			wait for 100 ns;
			
			RAMAddr <= x"12201";
			RAMWriteData <= NullDG_K0_B;
			wait for 100 ns;
			
			RAMAddr <= x"10003";
			RAMWriteData <= SeqKanalMask;
			wait for 100 ns;
			
			RAMAddr <= x"10002";
			RAMWriteData <= SeqModuloRegister;
			wait for 100 ns;
			
			RAMAddr <= x"10000";
			RAMWriteData <= SeqSteuerRegister;
			wait for 100 ns;
			
			wait for 25 us;
			RAMAddr <= x"12200";
			RAMWriteData <= X"00000006";
			wait for 100 ns;
			
			RAMAddr <= x"12201";
			RAMWriteData <= X"00000008";
			wait for 100 ns;
			
			wait; -- will wait forever
		
		END PROCESS tb;
	  --  End Test Bench 
	  

  END;
