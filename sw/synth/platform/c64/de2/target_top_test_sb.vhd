library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.pace_pkg.all;
use work.maple_pkg.all;
use work.gamecube_pkg.all;
use work.project_pkg.all;
use work.target_pkg.all;

entity target_top is
  port
  (
		--////////////////////	Clock Input	 	////////////////////	 
		clock_27      : in std_logic;                         --	27 MHz
		clock_50      : in std_logic;                         --	50 MHz
		ext_clock     : in std_logic;                         --	External Clock
		--////////////////////	Push Button		////////////////////
		key           : in std_logic_vector(3 downto 0);      --	Pushbutton[3:0]
		--////////////////////	DPDT Switch		////////////////////
		sw            : in std_logic_vector(17 downto 0);     --	Toggle Switch[17:0]
		--////////////////////	7-SEG Dispaly	////////////////////
		hex0          : out std_logic_vector(6 downto 0);     --	Seven Segment Digit 0
		hex1          : out std_logic_vector(6 downto 0);     --	Seven Segment Digit 1
		hex2          : out std_logic_vector(6 downto 0);     --	Seven Segment Digit 2
		hex3          : out std_logic_vector(6 downto 0);     --	Seven Segment Digit 3
		hex4          : out std_logic_vector(6 downto 0);     --	Seven Segment Digit 4
		hex5          : out std_logic_vector(6 downto 0);     --	Seven Segment Digit 5
		hex6          : out std_logic_vector(6 downto 0);     --	Seven Segment Digit 6
		hex7          : out std_logic_vector(6 downto 0);     --	Seven Segment Digit 7
		--////////////////////////	LED		////////////////////////
		ledg          : out std_logic_vector(8 downto 0);     --	LED Green[8:0]
		ledr          : out std_logic_vector(17 downto 0);    --	LED Red[17:0]
		--////////////////////////	UART	////////////////////////
		uart_txd      : out std_logic;                        --	UART Transmitter
		uart_rxd      : in std_logic;                         --	UART Receiver
		--////////////////////////	IRDA	////////////////////////
		irda_txd      : out std_logic;                        --	IRDA Transmitter
		irda_rxd      : in std_logic;                         --	IRDA Receiver
		--/////////////////////	SDRAM Interface		////////////////
		dram_dq       : inout std_logic_vector(15 downto 0);  --	SDRAM Data bus 16 Bits
		dram_addr     : out std_logic_vector(11 downto 0);    --	SDRAM Address bus 12 Bits
		dram_ldqm     : out std_logic;                        --	SDRAM Low-byte Data Mask 
		dram_udqm     : out std_logic;                        --	SDRAM High-byte Data Mask
		dram_we_n     : out std_logic;                        --	SDRAM Write Enable
		dram_cas_n    : out std_logic;                        --	SDRAM Column Address Strobe
		dram_ras_n    : out std_logic;                        --	SDRAM Row Address Strobe
		dram_cs_n     : out std_logic;                        --	SDRAM Chip Select
		dram_ba_0     : out std_logic;                        --	SDRAM Bank Address 0
		dram_ba_1     : out std_logic;                        --	SDRAM Bank Address 0
		dram_clk      : out std_logic;                        --	SDRAM Clock
		dram_cke      : out std_logic;                        --	SDRAM Clock Enable
		--////////////////////	Flash Interface		////////////////
		fl_dq         : inout std_logic_vector(7 downto 0);   --	FLASH Data bus 8 Bits
		fl_addr       : out std_logic_vector(21 downto 0);    --	FLASH Address bus 22 Bits
		fl_we_n       : out std_logic;                        -- 	FLASH Write Enable
		fl_rst_n      : out std_logic;                        --	FLASH Reset
		fl_oe_n       : out std_logic;                        --	FLASH Output Enable
		fl_ce_n       : out std_logic;                        --	FLASH Chip Enable
		--////////////////////	SRAM Interface		////////////////
		sram_dq       : inout std_logic_vector(15 downto 0);  --	SRAM Data bus 16 Bits
		sram_addr     : out std_logic_vector(17 downto 0);    --	SRAM Address bus 18 Bits
		sram_ub_n     : out std_logic;                        --	SRAM High-byte Data Mask 
		sram_lb_n     : out std_logic;                        --	SRAM Low-byte Data Mask 
		sram_we_n     : out std_logic;                        --	SRAM Write Enable
		sram_ce_n     : out std_logic;                        --	SRAM Chip Enable
		sram_oe_n     : out std_logic;                        --	SRAM Output Enable
		--////////////////////	ISP1362 Interface	////////////////
		otg_data      : inout std_logic_vector(15 downto 0);  --	ISP1362 Data bus 16 Bits
		otg_addr      : out std_logic_vector(1 downto 0);     --	ISP1362 Address 2 Bits
		otg_cs_n      : out std_logic;                        --	ISP1362 Chip Select
		otg_rd_n      : out std_logic;                        --	ISP1362 Write
		otg_wr_n      : out std_logic;                        --	ISP1362 Read
		otg_rst_n     : out std_logic;                        --	ISP1362 Reset
		otg_fspeed    : out std_logic;                        --	USB Full Speed,	0 = Enable, Z = Disable
		otg_lspeed    : out std_logic;                        --	USB Low Speed, 	0 = Enable, Z = Disable
		otg_int0 			: in std_logic;                         --	ISP1362 Interrupt 0
		otg_int1 			: in std_logic;                         --	ISP1362 Interrupt 1
		otg_dreq0 		: in std_logic;                         --	ISP1362 DMA Request 0
		otg_dreq1 		: in std_logic;                         --	ISP1362 DMA Request 1
		otg_dack0_n   : out std_logic;                        --	ISP1362 DMA Acknowledge 0
		otg_dack1_n   : out std_logic;                        --	ISP1362 DMA Acknowledge 1
		--////////////////////	LCD Module 16X2		////////////////
		lcd_data      : inout std_logic_vector(7 downto 0);   --	LCD Data bus 8 bits
		lcd_on        : out std_logic;                        --	LCD Power ON/OFF
		lcd_blon      : out std_logic;                        --	LCD Back Light ON/OFF
		lcd_rw        : out std_logic;                        --	LCD Read/Write Select, 0 = Write, 1 = Read
		lcd_en        : out std_logic;                        --	LCD Enable
		lcd_rs        : out std_logic;                        --	LCD Command/Data Select, 0 = Command, 1 = Data
		--////////////////////	SD_Card Interface	////////////////
		sd_dat        : inout std_logic;                      --	SD Card Data
		sd_dat3       : inout std_logic;                      --	SD Card Data 3
		sd_cmd        : inout std_logic;                      --	SD Card Command Signal
		sd_clk        : out std_logic;                        --	SD Card Clock
		--////////////////////	USB JTAG link	////////////////////
		tdi           : in std_logic;                         -- CPLD -> FPGA (data in)
		tck           : in std_logic;                         -- CPLD -> FPGA (clk)
		tcs           : in std_logic;                         -- CPLD -> FPGA (CS)
	  tdo           : out std_logic;                        -- FPGA -> CPLD (data out)
		--////////////////////	I2C		////////////////////////////
		i2c_sdat      : inout std_logic;                      --	I2C Data
		i2c_sclk      : out std_logic;                        --	I2C Clock
		--////////////////////	PS2		////////////////////////////
		ps2_dat       : in std_logic;                         --	PS2 Data
		ps2_clk       : in std_logic;                         --	PS2 Clock
		--////////////////////	VGA		////////////////////////////
		vga_clk       : out std_logic;                        --	VGA Clock
		vga_hs        : out std_logic;                        --	VGA H_SYNC
		vga_vs        : out std_logic;                        --	VGA V_SYNC
		vga_blank     : out std_logic;                        --	VGA BLANK
		vga_sync      : out std_logic;                        --	VGA SYNC
		vga_r         : out std_logic_vector(9 downto 0);     --	VGA Red[9:0]
		vga_g         : out std_logic_vector(9 downto 0);     --	VGA Green[9:0]
		vga_b         : out std_logic_vector(9 downto 0);     --	VGA Blue[9:0]
		--////////////	Ethernet Interface	////////////////////////
		enet_data     : inout std_logic_vector(15 downto 0);  --	DM9000A DATA bus 16Bits
		enet_cmd      : out std_logic;                        --	DM9000A Command/Data Select, 0 = Command, 1 = Data
		enet_cs_n     : out std_logic;                        --	DM9000A Chip Select
		enet_wr_n     : out std_logic;                        --	DM9000A Write
		enet_rd_n     : out std_logic;                        --	DM9000A Read
		enet_rst_n    : out std_logic;                        --	DM9000A Reset
		enet_int      : in std_logic;                         --	DM9000A Interrupt
		enet_clk      : out std_logic;                        --	DM9000A Clock 25 MHz
		--////////////////	Audio CODEC		////////////////////////
		aud_adclrck   : out std_logic;                        --	Audio CODEC ADC LR Clock
		aud_adcdat    : in std_logic;                         --	Audio CODEC ADC LR Clock	Audio CODEC ADC Data
		aud_daclrck   : inout std_logic;                      --	Audio CODEC ADC LR Clock	Audio CODEC DAC LR Clock
		aud_dacdat    : out std_logic;                        --	Audio CODEC ADC LR Clock	Audio CODEC DAC Data
		aud_bclk      : inout std_logic;                      --	Audio CODEC ADC LR Clock	Audio CODEC Bit-Stream Clock
		aud_xck       : out std_logic;                        --	Audio CODEC ADC LR Clock	Audio CODEC Chip Clock
		--////////////////	TV Decoder		////////////////////////
		td_data       : in std_logic_vector(7 downto 0);      --	TV Decoder Data bus 8 bits
		td_hs         : in std_logic;                         --	TV Decoder H_SYNC
		td_vs         : in std_logic;                         --	TV Decoder V_SYNC
		td_reset      : out std_logic;                        --	TV Decoder Reset
		--////////////////////	GPIO	////////////////////////////
		gpio_0        : inout std_logic_vector(35 downto 0);  --	GPIO Connection 0
		gpio_1        : inout std_logic_vector(35 downto 0)   --	GPIO Connection 1
  );

end target_top;

architecture SYN of target_top is

	component I2C_AV_Config
		port
		(
			-- 	Host Side
			iCLK					: in std_logic;
			iRST_N				: in std_logic;
			--	I2C Side
			I2C_SCLK			: out std_logic;
			I2C_SDAT			: inout std_logic
		);
	end component I2C_AV_Config;

  component I2S_LCM_Config 
    port
    (   --  Host Side
            iCLK      : in std_logic;
      iRST_N    : in std_logic;
      --    I2C Side
      I2S_SCLK  : out std_logic;
      I2S_SDAT  : out std_logic;
      I2S_SCEN  : out std_logic
    );
  end component I2S_LCM_Config;

  component SEG7_LUT is
    port (
      iDIG : in std_logic_vector(3 downto 0); 
      oSEG : out std_logic_vector(6 downto 0)
    );
  end component;

  component LCD_TEST 
    port
    (	--	Host Side
			iCLK          : in std_logic;
      iRST_N        : in std_logic;
			iLINE1				: in std_logic_vector(127 downto 0);
			iLINE2				: in std_logic_vector(127 downto 0);
			--	LCD Side
			LCD_DATA      : out std_logic_vector(7 downto 0);
      LCD_RW        : out std_logic;
      LCD_EN        : out std_logic;
      LCD_RS        : out std_logic
   	);
  end component LCD_TEST;

	alias gpio_maple 		: std_logic_vector(35 downto 0) is gpio_0;
	alias gpio_lcd 			: std_logic_vector(35 downto 0) is gpio_1;
	
	signal clk					: std_logic_vector(0 to 3);
  signal init       	: std_logic;
  signal reset      	: std_logic;
  signal button_p   	: std_logic;
	signal reset_n			: std_logic;

	signal sw_s					: std_logic_vector(17 downto 0);
	signal vga_hs_s			: std_logic;
	signal vga_vs_s			: std_logic;
	
	signal ps2clk_s			: std_logic;
	signal ps2dat_s			: std_logic;
	signal jamma				: JAMMAInputsType;
	
	signal sram_addr_s	: std_logic_vector(23 downto 0);

  signal snd_data   	: std_logic_vector(15 downto 0);
  alias aud_clk    		: std_logic is clk(2);
  signal aud_data   	: std_logic_vector(15 downto 0);

	-- maple/dreamcast controller interface
	signal maple_sense	: std_logic;
	signal maple_oe			: std_logic;
	signal mpj					: work.maple_pkg.joystate_type;

	-- gamecube controller interface
	signal gcj							: work.gamecube_pkg.joystate_type;
			
	signal video_clk_s			: std_logic;
  signal lcm_sclk   			: std_logic;
  signal lcm_sdat   			: std_logic;
  signal lcm_scen   			: std_logic;
  signal lcm_data   			: std_logic_vector(7 downto 0);
  signal lcm_grst  				: std_logic;
  signal lcm_hsync  			: std_logic;
  signal lcm_vsync  			: std_logic;
	signal lcm_dclk  				: std_logic;
	signal lcm_shdb  				: std_logic;
	signal lcm_clk					: std_logic;

	-- SB (IEC) port
	signal ext_sb_data_oe		: std_logic;
	signal ext_sb_clk_oe		: std_logic;
	signal ext_sb_atn_oe		: std_logic;
	signal ext_sb_rst_oe		: std_logic;

  signal leds_s						: std_logic_vector(7 downto 0);

  signal pwmen      			: std_logic;
  signal chaseen    			: std_logic;
	
	alias ext_sb_data_in		: std_logic is gpio_1(4);
	alias ext_sb_data_out		: std_logic is gpio_1(5);
	alias ext_sb_clk_in			: std_logic is gpio_1(2);
	alias ext_sb_clk_out		: std_logic is gpio_1(3);
	alias ext_sb_atn_in			: std_logic is gpio_1(0);
	alias ext_sb_atn_out		: std_logic is gpio_1(1);
	alias ext_sb_rst_in			: std_logic is gpio_1(6);
	alias ext_sb_rst_out		: std_logic is gpio_1(7);
	
begin

	-- FPGA STARTUP
	-- should extend power-on reset if registers init to '0'
	process (clock_50)
		variable count : std_logic_vector (11 downto 0) := (others => '0');
	begin
		if rising_edge(clock_50) then
			if count = X"FFF" then
				init <= '0';
			else
				count := count + 1;
				init <= '1';
			end if;
		end if;
	end process;

  -- reset logic
  button_p <= not key(0);
  reset <= init or button_p;
	reset_n <= not reset;
	
	-- invert switch inputs
	sw_s <= not sw;

  -- Light red leds for corresponding switch
  --ledr <= sw;
	
	-- PS/2 inout signal drivers
	ps2clk_s <= ps2_clk;
	ps2dat_s <= ps2_dat;

  sram_ub_n <= '1';
  sram_lb_n <= '0'; -- enable low byte only

  -- turn off LEDs
  hex0 <= (others => '1');
  hex1 <= (others => '1');
  hex2 <= (others => '1');
  hex3 <= (others => '1');
  hex4 <= (others => '1');
  hex5 <= (others => '1');
  --hex6 <= (others => '1');
  --hex7 <= (others => '1');
  ledg(8) <= '0';
  --ledr(17 downto 8) <= (others => '0');

	-- no IrDA
	irda_txd <= 'Z';
	
  -- disable DRAM
	dram_addr <= (others => 'Z');
  dram_we_n <= '1';
  dram_cs_n <= '1';
  dram_clk <= '0';
  dram_cke <= '0';

  -- disable flash
  fl_dq <= (others => 'Z');
  fl_addr <= (others => 'Z');
  fl_we_n <= '1';
  fl_rst_n <= '0';
  fl_oe_n <= '1';
  fl_ce_n <= '1';

	sram_addr <= sram_addr_s(sram_addr'range);
	
  -- disable USB
  otg_data <= (others => 'Z');
  otg_addr <= (others => 'Z');
  otg_cs_n <= '1';
  otg_rd_n <= '1';
  otg_wr_n <= '1';
  otg_rst_n <= '1';

	BLK_LCD_TEST : block
		signal iline1 : std_logic_vector(127 downto 0);
		signal iline2 : std_logic_vector(127 downto 0);
	begin

		GEN_LINES : for i in 0 to 15 generate
			iline1(i*8+7 downto i*8) <= conv_std_logic_vector(character'pos(DE2_LCD_LINE1(i+1)),8);
			iline2(i*8+7 downto i*8) <= conv_std_logic_vector(character'pos(DE2_LCD_LINE2(i+1)),8);
		end generate GEN_LINES;

	  -- LCD
	  lcd_on <= '1';
	  lcd_blon <= '1';
	  lcdt: LCD_TEST 
	    port map
	    (	--	Host Side
				iCLK      => clock_50,
	      iRST_N    => reset_n,
				iLINE1		=> iline1,
				iLINE2		=> iline2,
				--	LCD Side
				LCD_DATA  => lcd_data,
	      LCD_RW    => lcd_rw,
	      LCD_EN    => lcd_en,
	      LCD_RS    => lcd_rs
	   	);

	end block BLK_LCD_TEST;

  -- disable SD card
  sd_clk <= '0';
  sd_dat <= 'Z';
  sd_dat3 <= 'Z';
  sd_cmd <= 'Z';

  -- disable JTAG
  tdo <= 'Z';
  
  -- VGA signals
	vga_clk <= video_clk_s;
  vga_blank <= '1'; -- no blanking
	vga_hs <= vga_hs_s;
	vga_vs <= vga_vs_s;
  vga_sync <= vga_hs_s and vga_vs_s;
	
  -- disable ethernet
  enet_data <= (others => 'Z');
  enet_cs_n <= '1';
  enet_wr_n <= '1';
  enet_rd_n <= '1';
  enet_rst_n <= '0';
  enet_clk <= '0';

	BLK_1541_DISPLAY : block
	
		signal ds : std_logic_vector(3 downto 0);
	
	begin
		-- how device number is generated internally
		ds <= C64_1541_DEVICE_SELECT xor ("00" & sw(17 downto 16));
		
  	-- Display 1541 Device Number
	  seg7_0: SEG7_LUT port map (iDIG => X"0", oSEG => hex7);
	  seg7_1: SEG7_LUT port map (iDIG => ds, oSEG => hex6);
		-- Display 1541 ACTIVITY LED
		ledr(17) <= leds_s(0);
		
	end block BLK_1541_DISPLAY;
		
  -- Audio
  audif_inst : work.audio_if
    generic map (
      REF_CLK       => 18432000,  -- Set REF clk frequency here
      SAMPLE_RATE   => 48000,     -- 48000 samples/sec
      DATA_WIDTH    => 16,			  --	16		Bits
      CHANNEL_NUM   => 2  			  --	Dual Channel
    )
    port map
    (
  		-- Inputs
      clk           => aud_clk,
      reset         => reset,
      datal         => aud_data,
      datar         => aud_data,
  
      -- Outputs
      aud_xck       => aud_xck,
      aud_adclrck   => aud_adclrck,
      aud_daclrck   => aud_daclrck,
      aud_bclk      => aud_bclk,
      aud_dacdat    => aud_dacdat,
      next_sample   => open
    );

  -- Unmeta sound data
  process(aud_clk, reset)
    variable data0 : std_logic_vector(snd_data'range);
    variable data1 : std_logic_vector(snd_data'range);
    variable data2 : std_logic_vector(snd_data'range);
  begin
    aud_data <= data2;
    if reset = '1' then
      data0 := (others => '0');
      data1 := (others => '0');
      data2 := (others => '0');
    elsif rising_edge(aud_clk) then
      data2 := data1;
      data1 := data0;
      data0 := snd_data;
    end if;
  end process;

  -- *MUST* be high to use 27MHz clock as input
  td_reset <= '1';

  -- GPIO
  gpio_0 <= (others => 'Z');
  --gpio_1 <= (others => 'Z');
    
  -- LCM signals
  gpio_lcd(19) <= lcm_data(7);
  gpio_lcd(18) <= lcm_data(6);
  gpio_lcd(21) <= lcm_data(5);
  gpio_lcd(20) <= lcm_data(4);
  gpio_lcd(23) <= lcm_data(3);
  gpio_lcd(22) <= lcm_data(2);
  gpio_lcd(25) <= lcm_data(1);
  gpio_lcd(24) <= lcm_data(0);
  gpio_lcd(30) <=	lcm_grst;
  gpio_lcd(26) <= lcm_vsync;
  gpio_lcd(35) <= lcm_hsync;
	gpio_lcd(29) <= lcm_dclk;
	gpio_lcd(31) <= lcm_shdb;
  gpio_lcd(28) <=	lcm_sclk;
  gpio_lcd(33) <=	lcm_scen;
  gpio_lcd(34) <= lcm_sdat;

	GEN_PLL : if PACE_HAS_PLL generate
	
    pll_50_inst : entity work.pll
      generic map
      (
        -- INCLK0
        INCLK0_INPUT_FREQUENCY  => 20000,
  
        -- CLK0
        CLK0_DIVIDE_BY          => PACE_CLK0_DIVIDE_BY,
        CLK0_MULTIPLY_BY        => PACE_CLK0_MULTIPLY_BY,
    
        -- CLK1
        CLK1_DIVIDE_BY          => PACE_CLK1_DIVIDE_BY,
        CLK1_MULTIPLY_BY        => PACE_CLK1_MULTIPLY_BY
      )
      port map
      (
        inclk0  => clock_50,
        c0      => clk(0),
        c1      => clk(1)
      );

	end generate GEN_PLL;
	
	GEN_NO_PLL : if not PACE_HAS_PLL generate

		-- feed input clocks into PACE core
		clk(0) <= clock_50;
		clk(1) <= clock_27;
			
	end generate GEN_NO_PLL;
    
  pll_27_inst : entity work.pll
    generic map
    (
      -- INCLK0
      INCLK0_INPUT_FREQUENCY  => 37037,

      -- CLK0 - 18M432Hz for audio
      CLK0_DIVIDE_BY          => 22,
      CLK0_MULTIPLY_BY        => 15,
  
      -- CLK1 - not used
      CLK1_DIVIDE_BY          => 1,
      CLK1_MULTIPLY_BY        => 1
    )
    port map
    (
      inclk0  => clock_27,
      c0      => clk(2),
      c1      => clk(3)
    );
  
  lcmc: I2S_LCM_Config
    port map
    (   --  Host Side
      iCLK => clock_50,
      iRST_N => reset_n, --lcm_grst_n,
      --    I2C Side
      I2S_SCLK => lcm_sclk,
      I2S_SDAT => lcm_sdat,
      I2S_SCEN => lcm_scen
    );

	lcm_clk <= video_clk_s;
	lcm_grst <= reset_n;
  lcm_dclk	<=	not lcm_clk;
  lcm_shdb	<=	'1';
	lcm_hsync <= vga_hs_s;
	lcm_vsync <= vga_vs_s;
	
	-- hook up the serial bus
	ext_sb_data_out <= '0' when ext_sb_data_oe = '1' else 'Z';
	ext_sb_clk_out <= '0' when ext_sb_clk_oe = '1' else 'Z';
	ext_sb_atn_out <= '0' when ext_sb_atn_oe = '1' else 'Z';
	ext_sb_rst_out <= '0' when ext_sb_rst_oe = '1' else 'Z';

  -- route switches to output
  ext_sb_data_oe <= not sw(0);
  ext_sb_clk_oe <= not sw(1);
  ext_sb_atn_oe <= not sw(2);
  ext_sb_rst_oe <= not sw(3);
	
	ledr(0) <= not ext_sb_data_in;
	ledr(1) <= not ext_sb_clk_in;
	ledr(2) <= not ext_sb_atn_in;
	ledr(3) <= not ext_sb_rst_in;
	
	av_init : I2C_AV_Config
		port map
		(
			--	Host Side
			iCLK							=> clock_50,
			iRST_N						=> reset_n,
			
			--	I2C Side
			I2C_SCLK					=> I2C_SCLK,
			I2C_SDAT					=> I2C_SDAT
		);

	assert (not (DE2_JAMMA_IS_MAPLE and DE2_JAMMA_IS_GAMECUBE))
		report "Cannot choose both MAPLE and GAMECUBE interfaces"
		severity error;
	
	GEN_MAPLE : if DE2_JAMMA_IS_MAPLE generate
	
		-- Dreamcast MapleBus joystick interface
		MAPLE_JOY : entity work.maple_joy
			port map
			(
				clk				=> clock_50,
				reset			=> reset,
				sense			=> maple_sense,
				oe				=> maple_oe,
				a					=> gpio_maple(14),
				b					=> gpio_maple(13),
				joystate	=> mpj
			);
		gpio_maple(12) <= maple_oe;
		gpio_maple(11) <= not maple_oe;
		maple_sense <= gpio_maple(17); -- and sw(0);

		-- map maple bus to jamma inputs
		-- - same mappings as default mappings for MAMED (DCMAME)
		jamma.coin(1) 				<= mpj.lv(7);		-- MSB of right analogue trigger (0-255)
		jamma.p(1).start 			<= mpj.start;
		jamma.p(1).up 				<= mpj.d_up;
		jamma.p(1).down 			<= mpj.d_down;
		jamma.p(1).left	 			<= mpj.d_left;
		jamma.p(1).right 			<= mpj.d_right;
		jamma.p(1).button(1) 	<= mpj.a;
		jamma.p(1).button(2) 	<= mpj.x;
		jamma.p(1).button(3) 	<= mpj.b;
		jamma.p(1).button(4) 	<= mpj.y;
		jamma.p(1).button(5)	<= '1';

	end generate GEN_MAPLE;

	GEN_GAMECUBE : if DE2_JAMMA_IS_GAMECUBE generate
	
		GC_JOY: entity work.gamecube_joy
			generic map( MHZ => 50 )
  		port map
		  (
  			clk 				=> clock_50,
				reset 			=> reset,
				--oe 					=> gc_oe,
				d 					=> gpio_0(25),
				joystate 		=> gcj
			);

		-- map gamecube controller to jamma inputs
		jamma.coin(1) <= not gcj.l;
		jamma.p(1).start <= not gcj.start;
		jamma.p(1).up <= not gcj.d_up;
		jamma.p(1).down <= not gcj.d_down;
		jamma.p(1).left <= not gcj.d_left;
		jamma.p(1).right <= not gcj.d_right;
		jamma.p(1).button(1) <= not gcj.a;
		jamma.p(1).button(2) <= not gcj.b;
		jamma.p(1).button(3) <= not gcj.x;
		jamma.p(1).button(4) <= not gcj.y;
		jamma.p(1).button(5)	<= not gcj.z;

	end generate GEN_GAMECUBE;
	
	-- not currently wired to any inputs
	jamma.coin(2) <= '1';
	jamma.p(2).start <= '1';
	jamma.service <= '1';
	jamma.tilt <= '1';
	jamma.test <= '1';
		
	-- show JAMMA inputs on LED bank
	ledr(11) <= not jamma.coin(1);
	ledr(10) <= not jamma.coin(2);
	ledr(9) <= not jamma.p(1).start;
	ledr(8) <= not jamma.p(1).up;
	ledr(7) <= not jamma.p(1).down;
	ledr(6) <= not jamma.p(1).left;
	ledr(5) <= not jamma.p(1).right;
	ledr(4) <= not jamma.p(1).button(1);
	--ledr(3) <= not jamma.p(1).button(2);
	--ledr(2) <= not jamma.p(1).button(3);
	--ledr(1) <= not jamma.p(1).button(4);
	--ledr(0) <= not jamma.p(1).button(5);
		
  pchaser: work.pwm_chaser 
	  generic map(nleds  => 8, nbits => 8, period => 4, hold_time => 12)
    port map (clk => clock_50, clk_en => chaseen, pwm_en => pwmen, reset => reset, fade => X"0F", ledout => ledg(7 downto 0));

  -- Generate pwmen pulse every 1024 clocks, chase pulse every 512k clocks
  process(clock_50, reset)
    variable pcount     : std_logic_vector(9 downto 0);
    variable pwmen_r    : std_logic;
    variable ccount     : std_logic_vector(18 downto 0);
    variable chaseen_r  : std_logic;
  begin
    pwmen <= pwmen_r;
    chaseen <= chaseen_r;
    if reset = '1' then
      pcount := (others => '0');
      ccount := (others => '0');
    elsif rising_edge(clock_50) then
      pwmen_r := '0';
      if pcount = std_logic_vector(conv_unsigned(0, pcount'length)) then
        pwmen_r := '1';
      end if;
      chaseen_r := '0';
      if ccount = std_logic_vector(conv_unsigned(0, ccount'length)) then
        chaseen_r := '1';
      end if;
      pcount := pcount + 1;
      ccount := ccount + 1;
    end if;
  end process;

end SYN;

