library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.pace_pkg.all;

package target_pkg is

	--  
	-- PACE constants which *MUST* be defined
	--
	
	constant PACE_TARGET 			: PACETargetType := PACE_TARGET_DE2_70;

	constant PACE_FPGA_VENDOR		: PACEFpgaVendor_t := PACE_FPGA_VENDOR_ALTERA;
	constant PACE_FPGA_FAMILY		: PACEFpgaFamily_t := PACE_FPGA_FAMILY_CYCLONE2;

	constant PACE_CLKIN0			: natural := 50;
	constant PACE_CLKIN1			: natural := 28;
	constant PACE_HAS_SPI			: boolean := false;

	--
	-- DE2-specific constants
	--

      
	constant DE2_LCD_LINE1			: string := "   PACE  2009   ";		-- 16 chars exactly

end;