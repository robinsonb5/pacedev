library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.pace_pkg.all;
use work.target_pkg.all;
use work.video_controller_pkg.all;

package project_pkg is

	--  
	-- PACE constants which *MUST* be defined
	--
	
  -- Reference clock is 24MHz
	constant PACE_HAS_PLL										  : boolean := true;
  --constant PACE_HAS_SRAM                    : boolean := true;
  constant PACE_HAS_SDRAM                   : boolean := false;
  constant PACE_HAS_SERIAL                  : boolean := false;
  
	constant PACE_JAMMA	                      : PACEJamma_t := PACE_JAMMA_NONE;

  constant PACE_VIDEO_CONTROLLER_TYPE       : PACEVideoController_t := PACE_VIDEO_VGA_800x600_60Hz;
  constant PACE_CLK0_DIVIDE_BY        		  : natural := 5;
  constant PACE_CLK0_MULTIPLY_BY      		  : natural := 3;   -- 50Mhz => 30MHz
  constant PACE_CLK1_DIVIDE_BY        		  : natural := 5;
  constant PACE_CLK1_MULTIPLY_BY      		  : natural := 4;  	-- 50MHz => 40MHz
	constant PACE_VIDEO_H_SCALE         		  : integer := 2;
	constant PACE_VIDEO_V_SCALE         		  : integer := 2;
  constant PACE_VIDEO_H_SYNC_POLARITY       : std_logic := '1';
  constant PACE_VIDEO_V_SYNC_POLARITY       : std_logic := '1';

  constant PACE_VIDEO_BORDER_RGB            : RGB_t := RGB_GREEN;

  constant PACE_HAS_OSD                     : boolean := false;
  constant PACE_OSD_XPOS                    : natural := 0;
  constant PACE_OSD_YPOS                    : natural := 0;

	-- Moon Patrol-specific constants
			
	constant M52_USE_INTERNAL_WRAM            : boolean := true;

  -- derived
  constant ROCKY_EMULATE_SRAM               : boolean := not M52_USE_INTERNAL_WRAM;
  constant ROCKY_EMULATE_FLASH              : boolean := false;
  
  constant PACE_HAS_FLASH                   : boolean := ROCKY_EMULATE_FLASH;
  constant PACE_HAS_SRAM                    : boolean := ROCKY_EMULATE_SRAM;

  type from_PROJECT_IO_t is record
    not_used  : std_logic;
  end record;

  type to_PROJECT_IO_t is record
    not_used  : std_logic;
  end record;

end;