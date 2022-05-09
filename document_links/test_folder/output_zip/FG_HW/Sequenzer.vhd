----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:11:05 12/08/2021 
-- Design Name: 
-- Module Name:    Sequenzer - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sequenzer is
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
end Sequenzer;

architecture Behavioral of Sequenzer is

component Sequenz_Bitstream
	Port ( CLK_IN : in  STD_LOGIC;
			  ENA_IN : in STD_LOGIC;
           ADDRA_IN : in  STD_LOGIC_VECTOR(13 downto 0);
           DOA_OUT : out  STD_LOGIC;
			  ENB_IN : in STD_LOGIC;
			  ADDRB_IN : in  STD_LOGIC_VECTOR(13 downto 0);
			  DIB_IN : in  STD_LOGIC_VECTOR(31 downto 0));
end component;

type INT_STATE is (DISABLED, RUNNING, OVER);
signal Sequencing_State : INT_STATE := DISABLED;
signal Sequence_Bit_Value : STD_LOGIC := '0';
signal Sequenz_Bit_Address : STD_LOGIC_VECTOR (13 downto 0) := (others => '0');
signal Kurvenauswahl : KURVE_TYP_ALLE_KANALE := (others => KURVE_TYPE_NULL);

begin
	
	Sequenz_Bitstream_BRAM : Sequenz_Bitstream
	port map (
		CLK_IN => Clock_100MHz_IN,
		ENA_IN => '1',
		ADDRA_IN => Sequenz_Bit_Address,
		DOA_OUT => Sequence_Bit_Value,
		ENB_IN => SequenzBRAMEna_IN,
		ADDRB_IN => SequenzBRAMAddr_IN(8 downto 0) & "00000",
		DIB_IN => SequenzBRAMData_IN);
	
	
	-- The following process handles only increments in the 'Sequenz_Bit_Number' 
	-- and sets flag 'Sequenz_Running' based on configurations in Steuer regsiter 
	process (Clock_100MHz_IN)
	variable Phase_old : STD_LOGIC_VECTOR(PLL_PHASE_COUNT_SIZE-1 downto 0) := (others=>'0');
	variable Sequenz_Running : boolean := FALSE; --must be false on initilization
	begin
		
		if (Clock_100MHz_IN'event and Clock_100MHz_IN = '1') then
		
			if (Phase_old /= PLL_Phase_IN) then
				Phase_old := PLL_Phase_IN;
				
				if (PLL_Phase_IN = NullDurchagänge_IN(KANAL_0, Kurvenauswahl(KANAL_0))) then -- Kannal beim Nulldurchgang
				--Enable/disable/change sequenz bits only at zero-crossing of Kanal0	
				
					case Sequencing_State is
				
						when DISABLED =>
							if (SteuerRegister_IN(Bit0_Freigabe) = Enable) then
								Sequenz_Bit_Address <= (others => '0');
								Sequenz_Running := TRUE;
								Sequencing_State <= RUNNING;
							end if;
						
						when RUNNING =>
							if (SteuerRegister_IN(Bit0_Freigabe) = Disable) then
								Sequenz_Bit_Address <= (others => '0');
								Sequenz_Running := FALSE;
								Sequencing_State <= DISABLED;
							else
								if (Sequenz_Bit_Address = ModuloRegister_IN) then
									if (SteuerRegister_IN(Bit2_Länge_Mode) = Länge_Mode_Repeat) then
										Sequenz_Bit_Address <= (others => '0');
									else
										Sequenz_Running := FALSE;
										Sequencing_State <= OVER;
									end if;
								else
									Sequenz_Bit_Address <= STD_LOGIC_VECTOR(unsigned(Sequenz_Bit_Address) + 1);
								end if;
							end if;
						
						when OVER =>
							if (SteuerRegister_IN(Bit0_Freigabe) = Disable) then
								Sequenz_Bit_Address <= (others => '0');
								Sequenz_Running := FALSE;
								Sequencing_State <= DISABLED;
							else
								if (SteuerRegister_IN(Bit2_Länge_Mode) = Länge_Mode_Repeat) then --length mode changed from single to repeat
									Sequenz_Bit_Address <= (others => '0');
									Sequenz_Running := TRUE;
									Sequencing_State <= RUNNING;
								end if;
							end if;
						
						when others =>
					end case;
				
				end if;		
			
			end if;
			
			for i in 0 to TOTAL_KANÄLE - 1 loop
			
				if (Phase_old = NullDurchagänge_IN(i, Kurvenauswahl(i))) then -- Kannal beim Nulldurchgang
					
					if ((Sequenz_Running = FALSE) OR (KanalMaske_IN(i) = '0')) then --sequence disabled or channel disabled
						--use default curve
						if (SteuerRegister_IN(Bit5_Sequenzstop) = KURVE_A) then
							Kurvenauswahl(i) <= KURVE_TYPE_A;
						else
							Kurvenauswahl(i) <= KURVE_TYPE_B;
						end if;
					else
						--select curve based on 'umschalt mode'
						if (SteuerRegister_IN(Bit3_Umschalt_mode) = Umschalt_Mode_A_B) then
							if (Sequence_Bit_Value = KURVE_A) then
								Kurvenauswahl(i) <= KURVE_TYPE_A;
							else
								Kurvenauswahl(i) <= KURVE_TYPE_B;
							end if;
						else --Umschalt_Mode_Ein_Aus
							if (Sequence_Bit_Value = KURVE_A) then
								Kurvenauswahl(i) <= KURVE_TYPE_A;					 
							else
								Kurvenauswahl(i) <= KURVE_TYPE_NULL; 
							end if;
						end if;
					end if;
				
				end if;
					
			end loop;
		
			
		end if;	
	end process;

Kurvenauswahl_OUT <= Kurvenauswahl;
	
end Behavioral;

