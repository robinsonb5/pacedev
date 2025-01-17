-- This file was generated with hex2rom written by Daniel Wallner

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity prom_10_1 is
	port(
		Clk	: in std_logic;
		A	: in std_logic_vector(4 downto 0);
		D	: out std_logic_vector(7 downto 0)
	);
end prom_10_1;

architecture rtl of prom_10_1 is
	signal A_r : std_logic_vector(4 downto 0);
begin
	process (Clk)
	begin
		if Clk'event and Clk = '1' then
			A_r <= A;
		end if;
	end process;
	process (A_r)
	begin
		case to_integer(unsigned(A_r)) is
		when 000000 => D <= "00000000";	-- 0x0000
		when 000001 => D <= "10010100";	-- 0x0001
		when 000002 => D <= "10000011";	-- 0x0002
		when 000003 => D <= "10100111";	-- 0x0003
		when 000004 => D <= "00000000";	-- 0x0004
		when 000005 => D <= "11110011";	-- 0x0005
		when 000006 => D <= "11111100";	-- 0x0006
		when 000007 => D <= "11110100";	-- 0x0007
		when 000008 => D <= "00000000";	-- 0x0008
		when 000009 => D <= "11010101";	-- 0x0009
		when 000010 => D <= "11100011";	-- 0x000A
		when 000011 => D <= "00101000";	-- 0x000B
		when 000012 => D <= "00000000";	-- 0x000C
		when 000013 => D <= "01100111";	-- 0x000D
		when 000014 => D <= "11010011";	-- 0x000E
		when 000015 => D <= "00010101";	-- 0x000F
		when 000016 => D <= "00000000";	-- 0x0010
		when 000017 => D <= "00111111";	-- 0x0011
		when 000018 => D <= "11001111";	-- 0x0012
		when 000019 => D <= "01111111";	-- 0x0013
		when 000020 => D <= "00000000";	-- 0x0014
		when 000021 => D <= "11110111";	-- 0x0015
		when 000022 => D <= "11111010";	-- 0x0016
		when 000023 => D <= "11111000";	-- 0x0017
		when 000024 => D <= "00000000";	-- 0x0018
		when 000025 => D <= "11110001";	-- 0x0019
		when 000026 => D <= "11111000";	-- 0x001A
		when 000027 => D <= "11111010";	-- 0x001B
		when 000028 => D <= "00000000";	-- 0x001C
		when 000029 => D <= "11111000";	-- 0x001D
		when 000030 => D <= "11110011";	-- 0x001E
		when 000031 => D <= "11110010";	-- 0x001F
		when others => D <= "--------";
		end case;
	end process;
end;
