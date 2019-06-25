library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library work;
use work.pace_pkg.all;
use work.sdram_pkg.all;
use work.video_controller_pkg.all;
use work.project_pkg.all;
use work.platform_pkg.all;
use work.target_pkg.all;


entity target_top is
	port (
-- Clocks
		clk50m : in std_logic;
		phi2_n : in std_logic;
		dotclk_n : in std_logic;

-- Buttons
		usart_cts : in std_logic;  -- Left button
		freeze_btn : in std_logic; -- Middle button
		reset_btn : in std_logic;  -- Right

-- PS/2, IEC, LEDs
		iec_present : in std_logic;

		ps2iec_sel : out std_logic;
		ps2iec : in unsigned(3 downto 0);

		ser_out_clk : out std_logic;
		ser_out_dat : out std_logic;
		ser_out_rclk : out std_logic;

		iec_clk_out : out std_logic;
		iec_srq_out : out std_logic;
		iec_atn_out : out std_logic;
		iec_dat_out : out std_logic;

-- SPI, Flash and SD-Card
		flash_cs : out std_logic;
		rtc_cs : out std_logic;
		mmc_cs : out std_logic;
		mmc_cd : in std_logic;
		mmc_wp : in std_logic;
		spi_clk : out std_logic;
		spi_miso : in std_logic;
		spi_mosi : out std_logic;

-- Clock port
		clock_ior : out std_logic;
		clock_iow : out std_logic;

-- C64 bus
		reset_in : in std_logic;

		ioef : in std_logic;
		romlh : in std_logic;

		dma_out : out std_logic;
		game_out : out std_logic;
		exrom_out : out std_logic;

		irq_in : in std_logic;
		irq_out : out std_logic;
		nmi_in : in std_logic;
		nmi_out : out std_logic;
		ba_in : in std_logic;
		rw_in : in std_logic;
		rw_out : out std_logic;

		sa_dir : out std_logic;
		sa_oe : out std_logic;
		sa15_out : out std_logic;
		low_a : inout unsigned(15 downto 0);

		sd_dir : out std_logic;
		sd_oe : out std_logic;
		low_d : inout unsigned(7 downto 0);

-- SDRAM
		ram_clk : out std_logic;
		ram_ldqm : out std_logic;
		ram_udqm : out std_logic;
		ram_ras : out std_logic;
		ram_cas : out std_logic;
		ram_we : out std_logic;
		ram_ba : out unsigned(1 downto 0);
		ram_a : out unsigned(12 downto 0);
		ram_d : inout unsigned(15 downto 0);

-- IR eye
		ir_data : in std_logic;

-- USB micro
		usart_clk : in std_logic;
		usart_rts : in std_logic;
		usart_rx : out std_logic;
		usart_tx : in std_logic;

-- Video output
		red : out std_logic_vector(4 downto 0);
		grn : out std_logic_vector(4 downto 0);
		blu : out std_logic_vector(4 downto 0);
		hsync_n : out std_logic;
		vsync_n : out std_logic;

-- Audio output
		sigma_l : out std_logic;
		sigma_r : out std_logic
	);  
end target_top;

architecture SYN of target_top is


  signal init       	: std_logic := '1';  
  signal sysclk	: std_logic;
  
  signal clkrst_i       : from_CLKRST_t;
  signal buttons_i      : from_BUTTONS_t;
  signal switches_i     : from_SWITCHES_t;
  signal leds_o         : to_LEDS_t;
  signal inputs_i       : from_INPUTS_t;
  signal flash_i        : from_FLASH_t;
  signal flash_o        : to_FLASH_t;
  signal sram_i			: from_SRAM_t;
  signal sram_o			: to_SRAM_t;	
  signal sdram_i        : from_SDRAM_t;
  signal sdram_o        : to_SDRAM_t;
  signal video_i        : from_VIDEO_t;
  signal video_o        : to_VIDEO_t;
  signal audio_i        : from_AUDIO_t;
  signal audio_o        : to_AUDIO_t;
  signal ser_i          : from_SERIAL_t;
  signal ser_o          : to_SERIAL_t;
  signal project_i      : from_PROJECT_IO_t;
  signal project_o      : to_PROJECT_IO_t;
  signal platform_i     : from_PLATFORM_IO_t;
  signal platform_o     : to_PLATFORM_IO_t;
  signal target_i       : from_TARGET_IO_t;
  signal target_o       : to_TARGET_IO_t;

  signal switches       : std_logic_vector(1 downto 0);
  signal buttons        : std_logic_vector(1 downto 0);

-- Chameleon signals

	signal ena_1mhz : std_logic;
	signal ena_1khz : std_logic;
	
	signal phi_cnt : unsigned(7 downto 0);
	signal phi_end_1 : std_logic;

-- System state
	signal no_clock : std_logic;
	signal docking_station : std_logic;
	signal reset : std_logic;
	signal button_reset_n : std_logic;

-- LEDs
	signal led_green : std_logic := '0';
	signal led_red : std_logic := '0';
	signal ir : std_logic;

	signal ir_start : std_logic;
	signal ir_start2 : std_logic;
	signal ir_coin : std_logic;

-- C64 keyboard
	signal keys : unsigned(63 downto 0);
	signal restore_key_n : std_logic;
	signal c64_nmi_n : std_logic; -- Replaces restore_key_n in C64 mode.

-- PS/2 Keyboard
	signal ps2_keyboard_clk_in : std_logic;
	signal ps2_keyboard_dat_in : std_logic;
	signal ps2_keyboard_clk_out : std_logic;
	signal ps2_keyboard_dat_out : std_logic;

-- PS/2 Mouse
	signal ps2_mouse_clk_in: std_logic;
	signal ps2_mouse_dat_in: std_logic;
	signal ps2_mouse_clk_out: std_logic;
	signal ps2_mouse_dat_out: std_logic;

	signal joya : unsigned(5 downto 0);
	signal joyb : unsigned(5 downto 0);

	signal c64_keys : unsigned(63 downto 0);
	signal keys_valid : std_logic;
	signal c64_restore_key_n : std_logic;
	signal c64_joy1 : unsigned(5 downto 0);
	signal c64_joy2 : unsigned(5 downto 0);
	signal gp1_run : std_logic;
	signal gp1_select : std_logic;
	signal ir_d : std_logic;
	signal debug1 : std_logic_vector(31 downto 0);
	signal debug2 : std_logic_vector(31 downto 0);
	signal debug3 : std_logic_vector(31 downto 0);
	signal debug4 : std_logic_vector(31 downto 0);
	
--//********************


begin

-- -----------------------------------------------------------------------
-- Unused pins
-- -----------------------------------------------------------------------
	iec_clk_out <= '0';
	iec_atn_out <= '0';
	iec_dat_out <= '0';
	iec_srq_out <= '0';
	irq_out <= '0';
	nmi_out <= '0';
	usart_rx<='1';
	clock_ior <= '1';
	clock_iow <= '1';

	-- put these here?
	flash_cs <= '1';
	rtc_cs <= '0';
	

---- -----------------------------------------------------------------------
---- Reset
---- -----------------------------------------------------------------------
--	myReset : entity work.gen_reset
--		generic map (
--			resetCycles => reset_cycles
--		)
--		port map (
--			clk => sysclk,
--			enable => '1',
--
--			button => not reset_btn,
--			reset => reset,
--			nreset => n_reset
--		);


-- -----------------------------------------------------------------------
-- PS2IEC multiplexer
-- -----------------------------------------------------------------------
	io_ps2iec_inst : entity work.chameleon2_io_ps2iec
		port map (
			clk => sysclk,

			ps2iec_sel => ps2iec_sel,
			ps2iec => ps2iec,

			ps2_mouse_clk => ps2_mouse_clk_in,
			ps2_mouse_dat => ps2_mouse_dat_in,
			ps2_keyboard_clk => ps2_keyboard_clk_in,
			ps2_keyboard_dat => ps2_keyboard_dat_in,

			iec_clk => open, -- iec_clk_in,
			iec_srq => open, -- iec_srq_in,
			iec_atn => open, -- iec_atn_in,
			iec_dat => open  -- iec_dat_in
		);

-- -----------------------------------------------------------------------
-- LED, PS2 and reset shiftregister
-- -----------------------------------------------------------------------
	io_shiftreg_inst : entity work.chameleon2_io_shiftreg
		port map (
			clk => sysclk,

			ser_out_clk => ser_out_clk,
			ser_out_dat => ser_out_dat,
			ser_out_rclk => ser_out_rclk,

			reset_c64 => reset,
			reset_iec => reset,
			ps2_mouse_clk => ps2_mouse_clk_out,
			ps2_mouse_dat => ps2_mouse_dat_out,
			ps2_keyboard_clk => ps2_keyboard_clk_out,
			ps2_keyboard_dat => ps2_keyboard_dat_out,
			led_green => led_green,
			led_red => led_red
		);

-- -----------------------------------------------------------------------
-- Chameleon IO, docking station and cartridge port
-- -----------------------------------------------------------------------
	chameleon2_io_blk : block
	begin
		chameleon2_io_inst : entity work.chameleon2_io
			generic map (
				enable_docking_station => true,
				enable_cdtv_remote => true,
				enable_c64_joykeyb => true,
				enable_c64_4player => true
			)
			port map (
				clk => sysclk,
				ena_1mhz => ena_1mhz,
				phi2_n => phi2_n,
				dotclock_n => dotclk_n,

				reset => init,

				ir_data => ir,
				ioef => ioef,
				romlh => romlh,

				dma_out => dma_out,
				game_out => game_out,
				exrom_out => exrom_out,

				ba_in => ba_in,
--				rw_in => rw_in,
				rw_out => rw_out,

				sa_dir => sa_dir,
				sa_oe => sa_oe,
				sa15_out => sa15_out,
				low_a => low_a,

				sd_dir => sd_dir,
				sd_oe => sd_oe,
				low_d => low_d,

				no_clock => no_clock,
				docking_station => docking_station,

				phi_cnt => phi_cnt,
				phi_end_1 => phi_end_1,

				joystick1 => c64_joy1,
				joystick2 => c64_joy2,
--				joystick3 => joystick3,
--				joystick4 => joystick4,
				keys => c64_keys,
				keys_valid => keys_valid,
--				restore_key_n => restore_n
				restore_key_n => open,
				debug1 => debug1,
				debug2 => debug2,
				debug3 => debug3
			);
	end block;

debug4 <= no_clock & docking_station & std_logic_vector(c64_keys(29 downto 0));
	
-- Synchronise IR signal
process (sysclk)
begin
	if rising_edge(sysclk) then
		ir_d<=ir_data;
		ir<=ir_d;
	end if;
end process;

		
-- Update keypresses only when joystick is inactive.
process(sysclk)
begin
	if rising_edge(sysclk) then
		if keys_valid='1' then
			ir_coin<=c64_keys(63);
			ir_start<=c64_keys(56) and c64_keys(38);
			ir_start2<=c64_keys(16); -- FF button on CDTV pad.
		end if;
	end if;
end process;

joya<=c64_joy1;
joyb<=c64_joy2;

	ram_clk<='0'; -- Freeze SDRAM since we can't access sd_cs

	switches<="00";
	buttons <= freeze_btn & usart_cts;


	my1Mhz : entity work.chameleon_1mhz
		generic map (
			clk_ticks_per_usec => 100
		)
		port map (
			clk => sysclk,
			ena_1mhz => ena_1mhz,
			ena_1mhz_2 => open
		);

	my1Khz : entity work.chameleon_1khz
		port map (
			clk => sysclk,
			ena_1mhz => ena_1mhz,
			ena_1khz => ena_1khz
		); 


-- CDTV IR decoder
--
--myIr : entity work.chameleon_cdtv_remote
--	port map (
--		clk => sysclk,
--		ena_1mhz => ena_1mhz,
--		ir => ir,
--
----		trigger : out std_logic;
----
----		key_1 : out std_logic;
----		key_2 : out std_logic;
----		key_3 : out std_logic;
----		key_4 : out std_logic;
----		key_5 : out std_logic;
----		key_6 : out std_logic;
----		key_7 : out std_logic;
----		key_8 : out std_logic;
----		key_9 : out std_logic;
----		key_0 : out std_logic;
----		key_escape : out std_logic;
----		key_enter : out std_logic;
----		key_genlock : out std_logic;
----		key_cdtv : out std_logic;
--		key_power => ir_coin,
----		key_rew : out std_logic;
--		key_play => ir_start,
----		key_ff : out std_logic;
----		key_stop : out std_logic;
----		key_vol_up : out std_logic;
----		key_vol_dn : out std_logic;
--		joystick_a => ir_joya,
--		joystick_b => ir_joyb
----		debug_code : out unsigned(11 downto 0)
--	);

		

  BLK_CLOCKING : block
  begin
    clkrst_i.clk_ref <= clk50m;
  
    GEN_PLL : if PACE_HAS_PLL generate
    
      pll_50_inst : entity work.pllclk_ez -- entity work.pllclk_ez  --entity work.pll
        port map
        (
          inclk0  => clk50m,
			 c0		=> clkrst_i.clk(0),  -- system clock
          c1      => clkrst_i.clk(1),  -- video clock
 			 c2		=> sysclk	-- aux clock
        );

    end generate GEN_PLL;
    
    GEN_NO_PLL : if not PACE_HAS_PLL generate
   
      -- feed input clocks into PACE core
      clkrst_i.clk(0) <= clk50m;
      clkrst_i.clk(1) <= clk50m;
        
    end generate GEN_NO_PLL;
      
  end block BLK_CLOCKING;
	
  -- FPGA STARTUP
	-- should extend power-on reset if registers init to '0'
	process (sysclk)
		variable count : std_logic_vector (15 downto 0) := (others => '0');
	begin
		if rising_edge(sysclk) then
			if count = X"FFFF" then
				init <= '0';
			else
				count := count + 1;
				init <= '1';
			end if;
			if reset_btn='0' then
				count:=X"0000";
			end if;
		end if;
	end process;

  clkrst_i.arst <= init;
  clkrst_i.arst_n <= not clkrst_i.arst;

  GEN_RESETS : for i in 0 to 3 generate

    process (clkrst_i.clk(i), clkrst_i.arst)
      variable rst_r : std_logic_vector(2 downto 0) := (others => '0');
    begin
      if clkrst_i.arst = '1' then
        rst_r := (others => '1');
      elsif rising_edge(clkrst_i.clk(i)) then
        rst_r := rst_r(rst_r'left-1 downto 0) & '0';
      end if;
      clkrst_i.rst(i) <= rst_r(rst_r'left);
    end process;

  end generate GEN_RESETS;

      -- inputs

       switches_i(0) <= switches(0);
       switches_i(1) <= switches(1);

       GEN_NO_JAMMA : if PACE_JAMMA = PACE_JAMMA_NONE generate
		inputs_i.jamma_n.coin(1) <= buttons(0) and ir_coin;
		inputs_i.jamma_n.p(1).start <= buttons(1) and ir_start;
		inputs_i.jamma_n.p(1).up <= joya(0);
		inputs_i.jamma_n.p(1).down <= joya(1);
		inputs_i.jamma_n.p(1).left <= joya(2);
		inputs_i.jamma_n.p(1).right <= joya(3);
		inputs_i.jamma_n.p(1).button(1) <= joya(4);
		inputs_i.jamma_n.p(1).button(2) <= joya(5);
		inputs_i.jamma_n.p(1).button(3) <= '1';
		inputs_i.jamma_n.p(1).button(4) <= '1';
		inputs_i.jamma_n.p(1).button(5) <= '1';
		inputs_i.jamma_n.p(2).start <= ir_start2;
		inputs_i.jamma_n.p(2).up <= joyb(0);
		inputs_i.jamma_n.p(2).down <= joyb(1);
		inputs_i.jamma_n.p(2).left <= joyb(2);
		inputs_i.jamma_n.p(2).right <= joyb(3);
		inputs_i.jamma_n.p(2).button(1) <= joyb(4);
		inputs_i.jamma_n.p(2).button(2) <= joyb(5);
		inputs_i.jamma_n.p(2).button(3) <= '1';
		inputs_i.jamma_n.p(2).button(4) <= '1';
		inputs_i.jamma_n.p(2).button(5) <= '1';
        end generate GEN_NO_JAMMA;
  
	-- not currently wired to any inputs
	inputs_i.jamma_n.coin_cnt <= (others => '1');
	inputs_i.jamma_n.coin(2) <= '1';
--	inputs_i.jamma_n.p(2).start <= '1';
--	inputs_i.jamma_n.p(2).up <= '1';
--	inputs_i.jamma_n.p(2).down <= '1';
--	inputs_i.jamma_n.p(2).left <= '1';
--	inputs_i.jamma_n.p(2).right <= '1';
--	inputs_i.jamma_n.p(2).button <= (others => '1');
	inputs_i.jamma_n.service <= '1';
	inputs_i.jamma_n.tilt <= '1';
	inputs_i.jamma_n.test <= '1';
		
  BLK_VIDEO : block
  begin

    video_i.clk <= clkrst_i.clk(1);	-- by convention
    video_i.clk_ena <= '1';
    video_i.reset <= clkrst_i.rst(1);
    
    red <= video_o.rgb.r(video_o.rgb.r'left downto video_o.rgb.r'left-4);
    grn <= video_o.rgb.g(video_o.rgb.g'left downto video_o.rgb.g'left-4);
    blu <= video_o.rgb.b(video_o.rgb.b'left downto video_o.rgb.b'left-4);
    hsync_n <= video_o.hsync;
    vsync_n <= video_o.vsync;
 
  end block BLK_VIDEO;

  BLK_AUDIO : block
  begin
  
    dacl : entity work.sigma_delta_dac
      port map (
        clk     => sysclk,
        din     => audio_o.ldata(15 downto 8),
        dout    => sigma_l
      );        

    dacr : entity work.sigma_delta_dac
      port map (
        clk     => sysclk,
        din     => audio_o.rdata(15 downto 8),
        dout    => sigma_r
      );        

  end block BLK_AUDIO;
 
 pace_inst : entity work.pace                                            
   port map
   (
     -- clocks and resets
     clkrst_i					=> clkrst_i,

     -- misc inputs and outputs
     buttons_i         => buttons_i,
     switches_i        => switches_i,
     leds_o            => open,
     
     -- controller inputs
     inputs_i          => inputs_i,

     	-- external ROM/RAM
     flash_i           => flash_i,
     flash_o           => flash_o,
     sram_i        		=> sram_i,
     sram_o        		=> sram_o,
     sdram_i           => sdram_i,
     sdram_o           => sdram_o,
  
      -- VGA video
      video_i           => video_i,
      video_o           => video_o,
      
      -- sound
      audio_i           => audio_i,
      audio_o           => audio_o,

      -- SPI (flash)
      spi_i.din         => '0',
      spi_o             => open,
  
      -- serial
      ser_i             => ser_i,
      ser_o             => ser_o,
      
      -- custom i/o
      project_i         => project_i,
      project_o         => project_o,
      platform_i        => platform_i,
      platform_o        => platform_o,
      target_i          => target_i,
      target_o          => target_o
    );
end SYN;
