----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:31:06 12/09/2021 
-- Design Name: 
-- Module Name:    Kanal_Kurve_Manager - Behavioral 
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
use work.FG_Pack.all;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Kanal_Kurve_Manager is
    Port ( Clock_100MHz_IN : in  STD_LOGIC;
           Phase_Count_IN : in  STD_LOGIC_VECTOR(PLL_PHASE_COUNT_SIZE-1 downto 0);
			  Kurvenauswahl_IN : in  KURVE_TYP;
			  BRAMWriteEnable_IN : in  STD_LOGIC;
			  BRAMWriteData_IN : in  STD_LOGIC_VECTOR(31 downto 0);
			  BRAMWriteAddr_IN : in  STD_LOGIC_VECTOR(19 downto 0); 
           SPI_SCLK_IN : in  STD_LOGIC;
           SPI_LE_OUT : out  STD_LOGIC;
           SPI_MOSI_OUT : out  STD_LOGIC);
end Kanal_Kurve_Manager;

architecture Behavioral of Kanal_Kurve_Manager is
	
	constant BRAM_DATA_WIDTH : integer := 16; --in bits
	constant BRAM_PARITY_WIDTH : integer := 0; --in bits
	constant BRAM_SIZE : integer := 16384; --in bits
	constant BRAM_TOTAL_SAMPLES : integer := BRAM_SIZE/BRAM_DATA_WIDTH;
	constant BRAM_ADDR_WIDH : integer := integer(ceil(log2(real(BRAM_TOTAL_SAMPLES)))); -- in bits & for a single block
	
	component BRAMHandler_CurveA_B00
	Generic ( DataWidth : integer := 18);
	Port ( CLK_IN : in  STD_LOGIC;
			  ENA_IN : in STD_LOGIC;
           ADDRA_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DOA_OUT : out  STD_LOGIC_VECTOR(31 downto 0);
			  DOPA_OUT : out  STD_LOGIC_VECTOR(3 downto 0);
			  ENB_IN : in STD_LOGIC;
           ADDRB_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DIB_IN : in  STD_LOGIC_VECTOR(31 downto 0);
			  DIPB_IN : in  STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
	component BRAMHandler_CurveA_B01
	Generic ( DataWidth : integer := 18);
	Port ( CLK_IN : in  STD_LOGIC;
			  ENA_IN : in STD_LOGIC;
           ADDRA_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DOA_OUT : out  STD_LOGIC_VECTOR(31 downto 0);
			  DOPA_OUT : out  STD_LOGIC_VECTOR(3 downto 0);
			  ENB_IN : in STD_LOGIC;
           ADDRB_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DIB_IN : in  STD_LOGIC_VECTOR(31 downto 0);
			  DIPB_IN : in  STD_LOGIC_VECTOR(3 downto 0));
	end component;

	component BRAMHandler_CurveA_B10
	Generic ( DataWidth : integer := 18);
	Port ( CLK_IN : in  STD_LOGIC;
			  ENA_IN : in STD_LOGIC;
           ADDRA_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DOA_OUT : out  STD_LOGIC_VECTOR(31 downto 0);
			  DOPA_OUT : out  STD_LOGIC_VECTOR(3 downto 0);
			  ENB_IN : in STD_LOGIC;
           ADDRB_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DIB_IN : in  STD_LOGIC_VECTOR(31 downto 0);
			  DIPB_IN : in  STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
	component BRAMHandler_CurveA_B11
	Generic ( DataWidth : integer := 18);
	Port ( CLK_IN : in  STD_LOGIC;
			  ENA_IN : in STD_LOGIC;
           ADDRA_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DOA_OUT : out  STD_LOGIC_VECTOR(31 downto 0);
			  DOPA_OUT : out  STD_LOGIC_VECTOR(3 downto 0);
			  ENB_IN : in STD_LOGIC;
           ADDRB_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DIB_IN : in  STD_LOGIC_VECTOR(31 downto 0);
			  DIPB_IN : in  STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
	component BRAMHandler_CurveB_B00
	Generic ( DataWidth : integer := 18);
	Port ( CLK_IN : in  STD_LOGIC;
			  ENA_IN : in STD_LOGIC;
           ADDRA_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DOA_OUT : out  STD_LOGIC_VECTOR(31 downto 0);
			  DOPA_OUT : out  STD_LOGIC_VECTOR(3 downto 0);
			  ENB_IN : in STD_LOGIC;
           ADDRB_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DIB_IN : in  STD_LOGIC_VECTOR(31 downto 0);
			  DIPB_IN : in  STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
	component BRAMHandler_CurveB_B01
	Generic ( DataWidth : integer := 18);
	Port ( CLK_IN : in  STD_LOGIC;
			  ENA_IN : in STD_LOGIC;
           ADDRA_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DOA_OUT : out  STD_LOGIC_VECTOR(31 downto 0);
			  DOPA_OUT : out  STD_LOGIC_VECTOR(3 downto 0);
			  ENB_IN : in STD_LOGIC;
           ADDRB_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DIB_IN : in  STD_LOGIC_VECTOR(31 downto 0);
			  DIPB_IN : in  STD_LOGIC_VECTOR(3 downto 0));
	end component;

	component BRAMHandler_CurveB_B10
	Generic ( DataWidth : integer := 18);
	Port ( CLK_IN : in  STD_LOGIC;
			  ENA_IN : in STD_LOGIC;
           ADDRA_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DOA_OUT : out  STD_LOGIC_VECTOR(31 downto 0);
			  DOPA_OUT : out  STD_LOGIC_VECTOR(3 downto 0);
			  ENB_IN : in STD_LOGIC;
           ADDRB_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DIB_IN : in  STD_LOGIC_VECTOR(31 downto 0);
			  DIPB_IN : in  STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
	component BRAMHandler_CurveB_B11
	Generic ( DataWidth : integer := 18);
	Port ( CLK_IN : in  STD_LOGIC;
			  ENA_IN : in STD_LOGIC;
           ADDRA_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DOA_OUT : out  STD_LOGIC_VECTOR(31 downto 0);
			  DOPA_OUT : out  STD_LOGIC_VECTOR(3 downto 0);
			  ENB_IN : in STD_LOGIC;
           ADDRB_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DIB_IN : in  STD_LOGIC_VECTOR(31 downto 0);
			  DIPB_IN : in  STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
	component SPIMaster
	Generic ( DataWidth : integer);
	Port ( Enable_IN : in  STD_LOGIC;
			  Data_IN : in STD_LOGIC_VECTOR(DataWidth-1 downto 0);
           SCLK_IN : in  STD_LOGIC;
           SPI_LE_OUT : out  STD_LOGIC;
           SPI_MOSI_OUT : out  STD_LOGIC);
	end component;

	signal SPI_Data : STD_LOGIC_VECTOR(BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH-1 downto 0) := (others => '0');
	
	signal BRAM_ADDRA : STD_LOGIC_VECTOR(13 downto 0) := (others => '0');
	signal BRAM_ADDRB : STD_LOGIC_VECTOR(13 downto 0) := (others => '0');
	signal BRAM_CurveA_00_ENA : STD_LOGIC := '0';
	signal BRAM_CurveA_00_ENB : STD_LOGIC := '0';
	signal BRAM_CurveA_00_DOA : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal BRAM_CurveA_00_DOPA : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal BRAM_CurveA_01_ENA : STD_LOGIC := '0';
	signal BRAM_CurveA_01_ENB : STD_LOGIC := '0';
	signal BRAM_CurveA_01_DOA : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal BRAM_CurveA_01_DOPA : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal BRAM_CurveA_10_ENA : STD_LOGIC := '0';
	signal BRAM_CurveA_10_ENB : STD_LOGIC := '0';
	signal BRAM_CurveA_10_DOA : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal BRAM_CurveA_10_DOPA : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal BRAM_CurveA_11_ENA : STD_LOGIC := '0';
	signal BRAM_CurveA_11_ENB : STD_LOGIC := '0';
	signal BRAM_CurveA_11_DOA : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal BRAM_CurveA_11_DOPA : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal BRAM_CurveB_00_ENA : STD_LOGIC := '0';
	signal BRAM_CurveB_00_ENB : STD_LOGIC := '0';
	signal BRAM_CurveB_00_DOA : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal BRAM_CurveB_00_DOPA : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal BRAM_CurveB_01_ENA : STD_LOGIC := '0';
	signal BRAM_CurveB_01_ENB : STD_LOGIC := '0';
	signal BRAM_CurveB_01_DOA : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal BRAM_CurveB_01_DOPA : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal BRAM_CurveB_10_ENA : STD_LOGIC := '0';
	signal BRAM_CurveB_10_ENB : STD_LOGIC := '0';
	signal BRAM_CurveB_10_DOA : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal BRAM_CurveB_10_DOPA : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal BRAM_CurveB_11_ENA : STD_LOGIC := '0';
	signal BRAM_CurveB_11_ENB : STD_LOGIC := '0';
	signal BRAM_CurveB_11_DOA : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal BRAM_CurveB_11_DOPA : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

	signal BRAM_WriteData : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal BRAM_WriteParity : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	
	signal CurveA_Data : STD_LOGIC_VECTOR(BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH-1 downto 0) := (others => '0');
	signal CurveB_Data : STD_LOGIC_VECTOR(BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH-1 downto 0) := (others => '0');
		
begin

	DAC_0 : SPIMaster
	generic map ( DataWidth => BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH)
	port map (
		Enable_IN => '1',
		Data_IN => SPI_Data,
		SCLK_IN => SPI_SCLK_IN,
		SPI_LE_OUT => SPI_LE_OUT,
		SPI_MOSI_OUT => SPI_MOSI_OUT);
	
	BRAM_CurveA_B00 : BRAMHandler_CurveA_B00
	--generic map ( DataWidth => BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH)
	port map (
		CLK_IN => Clock_100MHz_IN,
		ENA_IN => BRAM_CurveA_00_ENA,
		ADDRA_IN => BRAM_ADDRA,
		DOA_OUT => BRAM_CurveA_00_DOA,
		DOPA_OUT => BRAM_CurveA_00_DOPA,
		ENB_IN => BRAM_CurveA_00_ENB,
      ADDRB_IN => BRAM_ADDRB,
      DIB_IN => BRAM_WriteData,
		DIPB_IN => BRAM_WriteParity);
		
	BRAM_CurveA_B01 : BRAMHandler_CurveA_B01
	--generic map ( DataWidth => BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH)
	port map (
		CLK_IN => Clock_100MHz_IN,
		ENA_IN => BRAM_CurveA_01_ENA,
		ADDRA_IN => BRAM_ADDRA,
		DOA_OUT => BRAM_CurveA_01_DOA,
		DOPA_OUT => BRAM_CurveA_01_DOPA,
		ENB_IN => BRAM_CurveA_01_ENB,
      ADDRB_IN => BRAM_ADDRB,
      DIB_IN => BRAM_WriteData,
		DIPB_IN => BRAM_WriteParity);
	
	BRAM_CurveA_B10 : BRAMHandler_CurveA_B10
	--generic map ( DataWidth => BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH)
	port map (
		CLK_IN => Clock_100MHz_IN,
		ENA_IN => BRAM_CurveA_10_ENA,
		ADDRA_IN => BRAM_ADDRA,
		DOA_OUT => BRAM_CurveA_10_DOA,
		DOPA_OUT => BRAM_CurveA_10_DOPA,
		ENB_IN => BRAM_CurveA_10_ENB,
      ADDRB_IN => BRAM_ADDRB,
      DIB_IN => BRAM_WriteData,
		DIPB_IN => BRAM_WriteParity);
		
	BRAM_CurveA_B11 : BRAMHandler_CurveA_B11
	--generic map ( DataWidth => BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH)
	port map (
		CLK_IN => Clock_100MHz_IN,
		ENA_IN => BRAM_CurveA_11_ENA,
		ADDRA_IN => BRAM_ADDRA,
		DOA_OUT => BRAM_CurveA_11_DOA,
		DOPA_OUT => BRAM_CurveA_11_DOPA,
		ENB_IN => BRAM_CurveA_11_ENB,
      ADDRB_IN => BRAM_ADDRB,
      DIB_IN => BRAM_WriteData,
		DIPB_IN => BRAM_WriteParity);
	
	BRAM_CurveB_B00 : BRAMHandler_CurveB_B00
	--generic map ( DataWidth => BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH)
	port map (
		CLK_IN => Clock_100MHz_IN,
		ENA_IN => BRAM_CurveB_00_ENA,
		ADDRA_IN => BRAM_ADDRA,
		DOA_OUT => BRAM_CurveB_00_DOA,
		DOPA_OUT => BRAM_CurveB_00_DOPA,
		ENB_IN => BRAM_CurveB_00_ENB,
      ADDRB_IN => BRAM_ADDRB,
      DIB_IN => BRAM_WriteData,
		DIPB_IN => BRAM_WriteParity);
		
	BRAM_CurveB_B01 : BRAMHandler_CurveB_B01
	--generic map ( DataWidth => BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH)
	port map (
		CLK_IN => Clock_100MHz_IN,
		ENA_IN => BRAM_CurveB_01_ENA,
		ADDRA_IN => BRAM_ADDRA,
		DOA_OUT => BRAM_CurveB_01_DOA,
		DOPA_OUT => BRAM_CurveB_01_DOPA,
		ENB_IN => BRAM_CurveB_01_ENB,
      ADDRB_IN => BRAM_ADDRB,
      DIB_IN => BRAM_WriteData,
		DIPB_IN => BRAM_WriteParity);
	
	BRAM_CurveB_B10 : BRAMHandler_CurveB_B10
	--generic map ( DataWidth => BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH)
	port map (
		CLK_IN => Clock_100MHz_IN,
		ENA_IN => BRAM_CurveB_10_ENA,
		ADDRA_IN => BRAM_ADDRA,
		DOA_OUT => BRAM_CurveB_10_DOA,
		DOPA_OUT => BRAM_CurveB_10_DOPA,
		ENB_IN => BRAM_CurveB_10_ENB,
      ADDRB_IN => BRAM_ADDRB,
      DIB_IN => BRAM_WriteData,
		DIPB_IN => BRAM_WriteParity);
		
	BRAM_CurveB_B11 : BRAMHandler_CurveB_B11
	--generic map ( DataWidth => BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH)
	port map (
		CLK_IN => Clock_100MHz_IN,
		ENA_IN => BRAM_CurveB_11_ENA,
		ADDRA_IN => BRAM_ADDRA,
		DOA_OUT => BRAM_CurveB_11_DOA,
		DOPA_OUT => BRAM_CurveB_11_DOPA,
		ENB_IN => BRAM_CurveB_11_ENB,
      ADDRB_IN => BRAM_ADDRB,
      DIB_IN => BRAM_WriteData,
		DIPB_IN => BRAM_WriteParity);
			
	
	-- One curve samples : 4096, 16-bit wide
	-- one BRAM: 16Kb,	Data width: 16-bit,	Address width: 10-bit	 
	-- One curve samples distributed in 4 BRAMs
	-- BRAM Address is always 14-bit. The relevant address bits are in MSB and others are '0'.
	BRAM_ADDRA <= Phase_Count_IN(BRAM_ADDR_WIDH-1 downto 0) & "0000";
	
	-- BRAM Data is always 32-bit. The relevant data bits are in LSB and others can be ignored.
	CurveA_Data <= BRAM_CurveA_00_DOA(BRAM_DATA_WIDTH-1 downto 0) & BRAM_CurveA_00_DOPA(BRAM_PARITY_WIDTH-1 downto 0) 
							when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_00) else
						BRAM_CurveA_01_DOA(BRAM_DATA_WIDTH-1 downto 0) & BRAM_CurveA_01_DOPA(BRAM_PARITY_WIDTH-1 downto 0) 
							when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_01) else
						BRAM_CurveA_10_DOA(BRAM_DATA_WIDTH-1 downto 0) & BRAM_CurveA_10_DOPA(BRAM_PARITY_WIDTH-1 downto 0) 
							when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_10) else
						BRAM_CurveA_11_DOA(BRAM_DATA_WIDTH-1 downto 0) & BRAM_CurveA_11_DOPA(BRAM_PARITY_WIDTH-1 downto 0) 
							when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_11) else
						(others => '0');
	BRAM_CurveA_00_ENA <= '1' when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_00) else '0';
	BRAM_CurveA_01_ENA <= '1' when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_01) else '0';
	BRAM_CurveA_10_ENA <= '1' when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_10) else '0';
	BRAM_CurveA_11_ENA <= '1' when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_11) else '0';
	
	CurveB_Data <= BRAM_CurveB_00_DOA(BRAM_DATA_WIDTH-1 downto 0) & BRAM_CurveB_00_DOPA(BRAM_PARITY_WIDTH-1 downto 0) 
							when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_00) else
						BRAM_CurveB_01_DOA(BRAM_DATA_WIDTH-1 downto 0) & BRAM_CurveB_01_DOPA(BRAM_PARITY_WIDTH-1 downto 0) 
							when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_01) else
						BRAM_CurveB_10_DOA(BRAM_DATA_WIDTH-1 downto 0) & BRAM_CurveB_10_DOPA(BRAM_PARITY_WIDTH-1 downto 0) 
							when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_10) else
						BRAM_CurveB_11_DOA(BRAM_DATA_WIDTH-1 downto 0) & BRAM_CurveB_11_DOPA(BRAM_PARITY_WIDTH-1 downto 0) 
							when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_11) else
						(others => '0');
	BRAM_CurveB_00_ENA <= '1' when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_00) else '0';
	BRAM_CurveB_01_ENA <= '1' when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_01) else '0';
	BRAM_CurveB_10_ENA <= '1' when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_10) else '0';
	BRAM_CurveB_11_ENA <= '1' when (Phase_Count_IN(BRAM_ADDR_WIDH+1 downto BRAM_ADDR_WIDH) = CURVE_BRAM_11) else '0';
	

	SPI_Data <= CurveA_Data(BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH-1 downto BRAM_PARITY_WIDTH) when (Kurvenauswahl_IN = KURVE_TYPE_A) else
					CurveB_Data(BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH-1 downto BRAM_PARITY_WIDTH) when (Kurvenauswahl_IN = KURVE_TYPE_B) else
					(others => '0');
	

	BRAM_WriteData(BRAM_DATA_WIDTH-1 downto 0) <= BRAMWriteData_IN(BRAM_DATA_WIDTH+BRAM_PARITY_WIDTH-1 downto BRAM_PARITY_WIDTH);
	BRAM_WriteParity(BRAM_PARITY_WIDTH-1 downto 0) <= BRAMWriteData_IN(BRAM_PARITY_WIDTH-1 downto 0);

	BRAM_CurveA_00_ENB <= '1' when ((BRAMWriteAddr_IN(RAM_ADDR_CURVENO) = KURVE_A) AND 
											  (BRAMWriteAddr_IN(RAM_ADDR_BRAMNO_END downto RAM_ADDR_BRAMNO_START) = CURVE_BRAM_00) AND 
											  (BRAMWriteEnable_IN = '1')) 
											   else '0';
	BRAM_CurveA_01_ENB <= '1' when ((BRAMWriteAddr_IN(RAM_ADDR_CURVENO) = KURVE_A) AND 
											  (BRAMWriteAddr_IN(RAM_ADDR_BRAMNO_END downto RAM_ADDR_BRAMNO_START) = CURVE_BRAM_01) AND 
											  (BRAMWriteEnable_IN = '1')) 
											  else '0';
	BRAM_CurveA_10_ENB <= '1' when ((BRAMWriteAddr_IN(RAM_ADDR_CURVENO) = KURVE_A) AND 
											  (BRAMWriteAddr_IN(RAM_ADDR_BRAMNO_END downto RAM_ADDR_BRAMNO_START) = CURVE_BRAM_10) AND 
											  (BRAMWriteEnable_IN = '1')) 
											  else '0';
	BRAM_CurveA_11_ENB <= '1' when ((BRAMWriteAddr_IN(RAM_ADDR_CURVENO) = KURVE_A) AND 
											  (BRAMWriteAddr_IN(RAM_ADDR_BRAMNO_END downto RAM_ADDR_BRAMNO_START) = CURVE_BRAM_11) AND 
											  (BRAMWriteEnable_IN = '1')) 
											  else '0';
	BRAM_CurveB_00_ENB <= '1' when ((BRAMWriteAddr_IN(RAM_ADDR_CURVENO) = KURVE_B) AND 
											  (BRAMWriteAddr_IN(RAM_ADDR_BRAMNO_END downto RAM_ADDR_BRAMNO_START) = CURVE_BRAM_00) AND 
											  (BRAMWriteEnable_IN = '1')) 
											  else '0';
	BRAM_CurveB_01_ENB <= '1' when ((BRAMWriteAddr_IN(RAM_ADDR_CURVENO) = KURVE_B) AND 
											  (BRAMWriteAddr_IN(RAM_ADDR_BRAMNO_END downto RAM_ADDR_BRAMNO_START) = CURVE_BRAM_01) AND 
											  (BRAMWriteEnable_IN = '1')) 
											  else '0';
	BRAM_CurveB_10_ENB <= '1' when ((BRAMWriteAddr_IN(RAM_ADDR_CURVENO) = KURVE_B) AND 
											  (BRAMWriteAddr_IN(RAM_ADDR_BRAMNO_END downto RAM_ADDR_BRAMNO_START) = CURVE_BRAM_10) AND 
											  (BRAMWriteEnable_IN = '1')) 
											  else '0';
	BRAM_CurveB_11_ENB <= '1' when ((BRAMWriteAddr_IN(RAM_ADDR_CURVENO) = KURVE_B) AND 
											  (BRAMWriteAddr_IN(RAM_ADDR_BRAMNO_END downto RAM_ADDR_BRAMNO_START) = CURVE_BRAM_11) AND 
											  (BRAMWriteEnable_IN = '1')) 
											  else '0';

	BRAM_ADDRB <= BRAMWriteAddr_IN(BRAM_ADDR_WIDH-1 downto 0) & "0000";
	
end Behavioral;

