## Generated SDC file "pengo.sdc"

## Copyright (C) 2018  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

## DATE    "Wed Jun 26 08:24:40 2019"

##
## DEVICE  "10CL025YU256C8G"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk50m} -period 20.000 -waveform { 0.000 0.500 } [get_ports { clk50m }]
create_clock -name {altera_reserved_tck} -period 1.000 -waveform { 0.000 0.500 } [get_ports {altera_reserved_tck}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 1 -master_clock {clk50m} [get_pins {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 4 -divide_by 5 -master_clock {clk50m} [get_pins {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}] 
create_generated_clock -name {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]} -source [get_pins {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 2 -master_clock {clk50m} [get_pins {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.110  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {altera_reserved_tck}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.110  
set_clock_uncertainty -rise_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {altera_reserved_tck}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.110  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {altera_reserved_tck}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.110  
set_clock_uncertainty -fall_from [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {altera_reserved_tck}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -hold 0.110  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -hold 0.110  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -hold 0.110  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {\BLK_CLOCKING:GEN_PLL:pll_50_inst|altpll_component|auto_generated|pll1|clk[2]}] -hold 0.110  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

