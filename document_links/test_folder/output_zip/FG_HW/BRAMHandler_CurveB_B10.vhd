----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:07:53 11/05/2021 
-- Design Name: 
-- Module Name:    BRAMHandler - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity BRAMHandler_CurveB_B10 is
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
end BRAMHandler_CurveB_B10;

architecture Behavioral of BRAMHandler_CurveB_B10 is

	signal REGCEA: STD_LOGIC := '0';
	signal RSTA: STD_LOGIC := '0';
	signal WEA : STD_LOGIC_VECTOR(3 downto 0)  := (others => '0');
	signal DIA : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal DIPA : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

	signal DOB : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal DOPB : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	signal REGCEB: STD_LOGIC := '0';
	signal RSTB: STD_LOGIC := '0';
	signal WEB : STD_LOGIC_VECTOR(3 downto 0) := (others => '1');
	
begin

	-- RAMB16BWER: 16k-bit Data and 2k-bit Parity Configurable Synchronous Dual Port Block RAM with Optional Output Registers
   --             Spartan-6
   -- Xilinx HDL Language Template, version 14.7

   RAMB16BWER_inst10 : RAMB16BWER
   generic map (
      -- DATA_WIDTH_A/DATA_WIDTH_B: 0, 1, 2, 4, 9, 18, or 36
      DATA_WIDTH_A => DataWidth,
      DATA_WIDTH_B => DataWidth,
      -- DOA_REG/DOB_REG: Optional output register (0 or 1)
      DOA_REG => 0,
      DOB_REG => 0,
      -- EN_RSTRAM_A/EN_RSTRAM_B: Enable/disable RST
      EN_RSTRAM_A => TRUE,
      EN_RSTRAM_B => TRUE,
     	-- INITP_00 to INITP_07: Initial memory contents.
		INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
		INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",

		-- INIT_00 to INIT_3F: Initial memory contents.
		INIT_00 => X"FE7BFE94FEADFEC6FEDFFEF9FF12FF2BFF44FF5DFF76FF8FFFA9FFC2FFDBFFF4",
		INIT_01 => X"FCE9FD02FD1BFD34FD4DFD67FD80FD99FDB2FDCBFDE4FDFDFE16FE30FE49FE62",
		INIT_02 => X"FB58FB71FB8AFBA3FBBCFBD5FBEEFC07FC20FC39FC52FC6BFC85FC9EFCB7FCD0",
		INIT_03 => X"F9C7F9E0F9F9FA12FA2BFA44FA5DFA76FA8FFAA8FAC1FADAFAF3FB0CFB25FB3E",
		INIT_04 => X"F837F850F869F882F89BF8B4F8CDF8E6F8FFF918F931F94AF963F97CF995F9AE",
		INIT_05 => X"F6A8F6C1F6DAF6F3F70CF725F73EF757F770F788F7A1F7BAF7D3F7ECF805F81E",
		INIT_06 => X"F51BF534F54DF566F57EF597F5B0F5C9F5E2F5FBF613F62CF645F65EF677F690",
		INIT_07 => X"F390F3A9F3C1F3DAF3F3F40BF424F43DF455F46EF487F4A0F4B8F4D1F4EAF503",
		INIT_08 => X"F206F21FF237F250F269F281F29AF2B2F2CBF2E3F2FCF315F32DF346F35FF377",
		INIT_09 => X"F07FF097F0B0F0C8F0E1F0F9F111F12AF142F15BF173F18CF1A4F1BDF1D5F1EE",
		INIT_0A => X"EEFAEF12EF2BEF43EF5BEF73EF8CEFA4EFBCEFD5EFEDF005F01EF036F04EF067",
		INIT_0B => X"ED78ED90EDA8EDC0EDD8EDF0EE08EE20EE38EE51EE69EE81EE99EEB1EECAEEE2",
		INIT_0C => X"EBF8EC10EC28EC40EC58EC70EC88ECA0ECB8ECD0ECE8ED00ED18ED30ED48ED60",
		INIT_0D => X"EA7CEA93EAABEAC3EADBEAF2EB0AEB22EB3AEB51EB69EB81EB99EBB1EBC8EBE0",
		INIT_0E => X"E903E91AE932E949E961E978E990E9A7E9BFE9D6E9EEEA06EA1DEA35EA4CEA64",
		INIT_0F => X"E78DE7A4E7BCE7D3E7EAE801E819E830E847E85FE876E88EE8A5E8BCE8D4E8EB",
		INIT_10 => X"E61BE632E649E660E677E68FE6A6E6BDE6D4E6EBE702E719E730E748E75FE776",
		INIT_11 => X"E4AEE4C4E4DBE4F2E509E51FE536E54DE564E57BE592E5A9E5C0E5D7E5EDE604",
		INIT_12 => X"E344E35BE371E388E39EE3B5E3CBE3E2E3F8E40FE426E43CE453E46AE480E497",
		INIT_13 => X"E1DFE1F5E20BE222E238E24EE264E27BE291E2A7E2BEE2D4E2EAE301E317E32E",
		INIT_14 => X"E07EE094E0AAE0C0E0D6E0ECE102E118E12EE144E15AE170E186E19DE1B3E1C9",
		INIT_15 => X"DF23DF38DF4EDF64DF79DF8FDFA5DFBADFD0DFE6DFFCE011E027E03DE053E069",
		INIT_16 => X"DDCCDDE2DDF7DE0CDE21DE37DE4CDE62DE77DE8CDEA2DEB7DECDDEE2DEF8DF0D",
		INIT_17 => X"DC7BDC90DCA5DCBADCCFDCE4DCF9DD0EDD23DD38DD4DDD62DD78DD8DDDA2DDB7",
		INIT_18 => X"DB2FDB44DB58DB6DDB82DB96DBABDBC0DBD4DBE9DBFEDC13DC28DC3CDC51DC66",
		INIT_19 => X"D9E9D9FDDA12DA26DA3ADA4EDA63DA77DA8CDAA0DAB4DAC9DADDDAF2DB06DB1B",
		INIT_1A => X"D8A9D8BDD8D1D8E5D8F8D90CD920D934D948D95CD970D984D999D9ADD9C1D9D5",
		INIT_1B => X"D76FD782D796D7A9D7BDD7D0D7E4D7F8D80BD81FD832D846D85AD86ED881D895",
		INIT_1C => X"D63BD64ED661D674D687D69AD6AED6C1D6D4D6E7D6FBD70ED721D735D748D75B",
		INIT_1D => X"D50DD520D533D546D558D56BD57ED591D5A3D5B6D5C9D5DCD5EFD602D615D628",
		INIT_1E => X"D3E7D3F9D40BD41DD430D442D454D467D479D48CD49ED4B1D4C3D4D6D4E8D4FB",
		INIT_1F => X"D2C7D2D8D2EAD2FCD30ED320D332D344D356D368D37AD38CD39ED3B0D3C2D3D4",
		INIT_20 => X"D1AED1BFD1D0D1E2D1F3D205D216D228D239D24BD25CD26ED280D291D2A3D2B5",
		INIT_21 => X"D09CD0ADD0BED0CFD0DFD0F1D102D113D124D135D146D157D168D17AD18BD19C",
		INIT_22 => X"CF91CFA2CFB2CFC3CFD3CFE4CFF4D005D015D026D037D048D058D069D07AD08B",
		INIT_23 => X"CE8ECE9ECEAECEBECECECEDECEEECEFECF0FCF1FCF2FCF3FCF50CF60CF70CF81",
		INIT_24 => X"CD93CDA2CDB2CDC1CDD1CDE0CDF0CE00CE0FCE1FCE2FCE3FCE4ECE5ECE6ECE7E",
		INIT_25 => X"CC9FCCAECCBDCCCCCCDBCCEACCF9CD08CD18CD27CD36CD46CD55CD64CD74CD83",
		INIT_26 => X"CBB3CBC2CBD0CBDFCBEDCBFCCC0BCC19CC28CC37CC45CC54CC63CC72CC81CC90",
		INIT_27 => X"CACFCADDCAEBCAF9CB07CB16CB24CB32CB40CB4ECB5DCB6BCB79CB88CB96CBA5",
		INIT_28 => X"C9F4CA01CA0FCA1CCA2ACA38CA45CA53CA61CA6ECA7CCA8ACA98CAA6CAB3CAC1",
		INIT_29 => X"C921C92EC93BC948C955C962C96FC97CC989C996C9A4C9B1C9BEC9CCC9D9C9E6",
		INIT_2A => X"C856C862C86FC87BC888C894C8A1C8AEC8BAC8C7C8D4C8E0C8EDC8FAC907C914",
		INIT_2B => X"C794C7A0C7ACC7B8C7C4C7D0C7DCC7E8C7F4C800C80CC818C825C831C83DC84A",
		INIT_2C => X"C6DAC6E6C6F1C6FDC708C713C71FC72BC736C742C74DC759C765C770C77CC788",
		INIT_2D => X"C62AC635C63FC64AC655C660C66BC676C681C68CC697C6A2C6ADC6B9C6C4C6CF",
		INIT_2E => X"C582C58CC597C5A1C5ABC5B6C5C0C5CAC5D5C5DFC5EAC5F5C5FFC60AC614C61F",
		INIT_2F => X"C4E4C4EDC4F7C501C50AC514C51EC528C532C53CC546C550C55AC564C56EC578",
		INIT_30 => X"C44EC457C460C469C473C47CC485C48EC498C4A1C4AAC4B4C4BDC4C7C4D0C4DA",
		INIT_31 => X"C3C2C3CAC3D3C3DBC3E4C3EDC3F5C3FEC407C410C418C421C42AC433C43CC445",
		INIT_32 => X"C33FC347C34FC357C35FC367C36FC377C37FC387C390C398C3A0C3A8C3B1C3B9",
		INIT_33 => X"C2C5C2CCC2D4C2DBC2E3C2EAC2F2C2F9C301C308C310C318C31FC327C32FC337",
		INIT_34 => X"C255C25CC262C269C270C277C27EC285C28CC293C29AC2A1C2A8C2AFC2B7C2BE",
		INIT_35 => X"C1EEC1F4C1FBC201C207C20DC214C21AC220C227C22DC234C23AC241C248C24E",
		INIT_36 => X"C191C197C19CC1A2C1A8C1ADC1B3C1B9C1BEC1C4C1CAC1D0C1D6C1DCC1E2C1E8",
		INIT_37 => X"C13EC143C148C14DC152C157C15CC161C166C16BC171C176C17BC181C186C18C",
		INIT_38 => X"C0F4C0F8C0FDC101C105C10AC10EC113C118C11CC121C126C12AC12FC134C139",
		INIT_39 => X"C0B4C0B8C0BBC0BFC0C3C0C7C0CBC0CFC0D3C0D7C0DBC0DFC0E3C0E7C0EBC0F0",
		INIT_3A => X"C07EC081C084C087C08AC08DC091C094C097C09BC09EC0A2C0A5C0A9C0ADC0B0",
		INIT_3B => X"C051C054C056C059C05BC05EC061C063C066C069C06CC06FC071C074C077C07A",
		INIT_3C => X"C02EC030C032C034C036C038C03AC03CC03EC041C043C045C047C04AC04CC04F",
		INIT_3D => X"C016C017C018C019C01BC01CC01EC01FC021C022C024C026C027C029C02BC02D",
		INIT_3E => X"C007C007C008C009C009C00AC00BC00CC00DC00EC00FC010C011C012C013C014",
		INIT_3F => X"C002C002C002C002C002C002C002C003C003C003C004C004C004C005C005C006",

      -- INIT_A/INIT_B: Initial values on output port
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      -- INIT_FILE: Optional file used to specify initial RAM contents
      INIT_FILE => "NONE",
      -- RSTTYPE: "SYNC" or "ASYNC" 
      RSTTYPE => "SYNC",
      -- RST_PRIORITY_A/RST_PRIORITY_B: "CE" or "SR" 
      RST_PRIORITY_A => "CE",
      RST_PRIORITY_B => "CE",
      -- SIM_COLLISION_CHECK: Collision check enable "ALL", "WARNING_ONLY", "GENERATE_X_ONLY" or "NONE" 
      SIM_COLLISION_CHECK => "ALL",
      -- SIM_DEVICE: Must be set to "SPARTAN6" for proper simulation behavior
      SIM_DEVICE => "SPARTAN6",
      -- SRVAL_A/SRVAL_B: Set/Reset value for RAM output
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      -- WRITE_MODE_A/WRITE_MODE_B: "WRITE_FIRST", "READ_FIRST", or "NO_CHANGE" 
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST" 
   )
   port map (
      -- Port A Data: 32-bit (each) output: Port A data
      DOA => DOA_OUT,       -- 32-bit output: A port data output
      DOPA => DOPA_OUT,     -- 4-bit output: A port parity output
      -- Port B Data: 32-bit (each) output: Port B data
      DOB => DOB,       -- 32-bit output: B port data output
      DOPB => DOPB,     -- 4-bit output: B port parity output
      -- Port A Address/Control Signals: 14-bit (each) input: Port A address and control signals
      ADDRA => ADDRA_IN,   -- 14-bit input: A port address input
      CLKA => CLK_IN,     -- 1-bit input: A port clock input
      ENA => ENA_IN,       -- 1-bit input: A port enable input
      REGCEA => REGCEA, -- 1-bit input: A port register clock enable input
      RSTA => RSTA,     -- 1-bit input: A port register set/reset input
      WEA => WEA,       -- 4-bit input: Port A byte-wide write enable input
      -- Port A Data: 32-bit (each) input: Port A data
      DIA => DIA,       -- 32-bit input: A port data input
      DIPA => DIPA,     -- 4-bit input: A port parity input
      -- Port B Address/Control Signals: 14-bit (each) input: Port B address and control signals
      ADDRB => ADDRB_IN,   -- 14-bit input: B port address input
      CLKB => CLK_IN,     -- 1-bit input: B port clock input
      ENB => ENB_IN,       -- 1-bit input: B port enable input
      REGCEB => REGCEB, -- 1-bit input: B port register clock enable input
      RSTB => RSTB,     -- 1-bit input: B port register set/reset input
      WEB => WEB,       -- 4-bit input: Port B byte-wide write enable input
      -- Port B Data: 32-bit (each) input: Port B data
      DIB => DIB_IN,       -- 32-bit input: B port data input
      DIPB => DIPB_IN      -- 4-bit input: B port parity input
   );

   -- End of RAMB16BWER_inst instantiation
end Behavioral;

