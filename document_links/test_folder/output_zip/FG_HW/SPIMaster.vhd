----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:01:06 11/05/2021 
-- Design Name: 
-- Module Name:    SPIMaster - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SPIMaster is
	 Generic ( DataWidth : integer);
    Port ( Enable_IN : in  STD_LOGIC;
			  Data_IN : in STD_LOGIC_VECTOR(DataWidth-1 downto 0);
           SCLK_IN : in  STD_LOGIC;
           SPI_LE_OUT : out  STD_LOGIC;
           SPI_MOSI_OUT : out  STD_LOGIC);
end SPIMaster;

architecture Behavioral of SPIMaster is

type INT_STATE is (IDLE, DATA_TX, DELAY_FOR_LE_H2L, DELAY_FOR_LE_L2H);

signal SPI_Master_State : INT_STATE := IDLE;

begin

	--State machine for SPI master data transmission
	process (SCLK_IN)
	variable MOSI_Buffer : STD_LOGIC_VECTOR (DataWidth-1 downto 0) := (others => '0');
	variable bit_to_Transfer : integer range 0 to DataWidth := DataWidth;
	begin
		if (SCLK_IN'event and SCLK_IN = '0') then
		
			case SPI_Master_State is
			
				when IDLE =>
					if (Enable_IN = '1') then
						MOSI_Buffer := Data_IN;
						bit_to_Transfer := 16;
						SPI_Master_State <= DATA_TX;
						SPI_MOSI_OUT <= '1'; 
						SPI_LE_OUT <= '1'; 
					end if;	
				
				when DATA_TX =>
					if (bit_to_Transfer > 0) then
						bit_to_Transfer := bit_to_Transfer - 1;
						SPI_MOSI_OUT <= MOSI_Buffer(bit_to_Transfer);
					else
						--SPI_Master_State <= DELAY_FOR_LE_H2L;
						SPI_LE_OUT <= '0';
						SPI_MOSI_OUT <= '1';
						SPI_Master_State <= DELAY_FOR_LE_L2H;
					end if;
					
				when DELAY_FOR_LE_H2L =>
					SPI_LE_OUT <= '0';
					SPI_Master_State <= DELAY_FOR_LE_L2H;
					
				when DELAY_FOR_LE_L2H =>
					SPI_LE_OUT <= '1';
					SPI_MOSI_OUT <= '1';
					SPI_Master_State <= IDLE;
				
				when others =>	
			end case;	
		
		end if;
	end process;

end Behavioral;

