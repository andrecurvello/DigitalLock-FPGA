library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
-----------------------------------------------------------------------------------
entity DigitalLock is
port (
	segment7_in0,segment7_in1,segment7_in2,segment7_in3 : in std_logic_vector(3 downto 0); --Input
	sw1 : in std_logic;
	led,led1 : buffer std_logic;  --led display
	bent,bset,b1,b2 : in std_logic;  --button in
	bo0,bo1 : buffer std_logic;  --button out
	clk : in std_logic;  --clock
--	mem0,mem1,mem2,mem3 : buffer std_logic_vector(3 downto 0); --mem
   segment7_0,segment7_1,segment7_2,segment7_3 : out std_logic_vector(6 downto 0)); --Seven Segment Display

end entity DigitalLock;
------------------------------------------------------------------------------------
architecture Behavioral of DigitalLock is
signal button : std_logic:='0';
signal mem0 : std_logic_vector(3 downto 0) := (others =>'0');
signal mem1 : std_logic_vector(3 downto 0) := (others =>'0');
signal mem2 : std_logic_vector(3 downto 0) := (others =>'0');
signal mem3 : std_logic_vector(3 downto 0) := (others =>'0');
begin
process(segment7_in0,segment7_in1,segment7_in2,segment7_in3,mem0,mem1,mem2,mem3,clk,button,bent,bset)
variable oldbent : std_logic:='1';
variable oldbset : std_logic:='1';
variable cnt : std_logic_vector(19 downto 0);
begin
if ((sw1 and b1 and b2)='1') then --Factory Reset
mem0 <= "0000";
mem1 <= "0000";
mem2 <= "0000";
mem3 <= "0000";
end if;
---------------------------------------------------------------------------------------
if (clk'event and clk='1') then
	if (bent and oldbent)='1' then
			led <= '0';
			cnt :=(others=>'0');
			oldbent := bent;
		elsif ((mem0 = segment7_in0) and (mem1 = segment7_in1) and (mem2 = segment7_in2) and (mem3 = segment7_in3)) then
			led <= '1';
			cnt:=cnt+'1';
		if ((cnt=x"F423F") and ((oldbent xor bent)='0')) then
				button <= oldbent;
		end if;
	end if;
	bo0 <=button;
end if;

	if ((bset and oldbset)='1') then
		led1 <= '0';
	elsif (led = '1') then
		led1 <= '1';
		mem0 <= segment7_in0;
		mem1 <= segment7_in1;
		mem2 <= segment7_in2;
		mem3 <= segment7_in3;
	end if;

end process;
---------------------------------------------------------------------------------------

process (segment7_in0,segment7_in1,segment7_in2,segment7_in3) --switches to 7 segment bcd display
begin

case  segment7_in0 is
when "0000"=> segment7_0 <="1000000";  ---0
when "0001"=> segment7_0 <="1001111";  ---1
when "0010"=> segment7_0 <="0100100";  ---2
when "0011"=> segment7_0 <="0000110";  ---3
when "0100"=> segment7_0 <="0001011";  ---4
when "0101"=> segment7_0 <="0010010";  ---5
when "0110"=> segment7_0 <="0010000";  ---6
when "0111"=> segment7_0 <="1000111";  ---7
when "1000"=> segment7_0 <="0000000";  ---8
when "1001"=> segment7_0 <="0000011";  ---9
when "1010"=> segment7_0 <="0000001";  ---A
when "1011"=> segment7_0 <="0011000";  ---B
when "1100"=> segment7_0 <="1110000";  ---C
when "1101"=> segment7_0 <="0001100";  ---D
when "1110"=> segment7_0 <="0110000";  ---E
when "1111"=> segment7_0 <="0110001";  ---F
when others=> segment7_0 <="0000000";  ---Null
end case;

case  segment7_in1 is
when "0000"=> segment7_1 <="1000000";  ---0
when "0001"=> segment7_1 <="1001111";  ---1
when "0010"=> segment7_1 <="0100100";  ---2
when "0011"=> segment7_1 <="0000110";  ---3
when "0100"=> segment7_1 <="0001011";  ---4
when "0101"=> segment7_1 <="0010010";  ---5
when "0110"=> segment7_1 <="0010000";  ---6
when "0111"=> segment7_1 <="1000111";  ---7
when "1000"=> segment7_1 <="0000000";  ---8
when "1001"=> segment7_1 <="0000011";  ---9
when "1010"=> segment7_1 <="0000001";  ---A
when "1011"=> segment7_1 <="0011000";  ---B
when "1100"=> segment7_1 <="1110000";  ---C
when "1101"=> segment7_1 <="0001100";  ---D
when "1110"=> segment7_1 <="0110000";  ---E
when "1111"=> segment7_1 <="0110001";  ---F
when others=> segment7_1 <="0000000";  ---Null
end case;

case  segment7_in2 is
when "0000"=> segment7_2 <="1000000";  ---0
when "0001"=> segment7_2 <="1001111";  ---1
when "0010"=> segment7_2 <="0100100";  ---2
when "0011"=> segment7_2 <="0000110";  ---3
when "0100"=> segment7_2 <="0001011";  ---4
when "0101"=> segment7_2 <="0010010";  ---5
when "0110"=> segment7_2 <="0010000";  ---6
when "0111"=> segment7_2 <="1000111";  ---7
when "1000"=> segment7_2 <="0000000";  ---8
when "1001"=> segment7_2 <="0000011";  ---9
when "1010"=> segment7_2 <="0000001";  ---A
when "1011"=> segment7_2 <="0011000";  ---B
when "1100"=> segment7_2 <="1110000";  ---C
when "1101"=> segment7_2 <="0001100";  ---D
when "1110"=> segment7_2 <="0110000";  ---E
when "1111"=> segment7_2 <="0110001";  ---F
when others=> segment7_2 <="0000000";  ---Null
end case;

case  segment7_in3 is
when "0000"=> segment7_3 <="1000000";  ---0
when "0001"=> segment7_3 <="1001111";  ---1
when "0010"=> segment7_3 <="0100100";  ---2
when "0011"=> segment7_3 <="0000110";  ---3
when "0100"=> segment7_3 <="0001011";  ---4
when "0101"=> segment7_3 <="0010010";  ---5
when "0110"=> segment7_3 <="0010000";  ---6
when "0111"=> segment7_3 <="1000111";  ---7
when "1000"=> segment7_3 <="0000000";  ---8
when "1001"=> segment7_3 <="0000011";  ---9
when "1010"=> segment7_3 <="0000001";  ---A
when "1011"=> segment7_3 <="0011000";  ---B
when "1100"=> segment7_3 <="1110000";  ---C
when "1101"=> segment7_3 <="0001100";  ---D
when "1110"=> segment7_3 <="0110000";  ---E
when "1111"=> segment7_3 <="0110001";  ---F
when others=> segment7_3 <="0000000";  ---Null
end case;

end process;
end Behavioral;