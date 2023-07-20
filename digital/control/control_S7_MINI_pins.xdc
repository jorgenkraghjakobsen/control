## Pin map for SonicEdge Gen2 Development board 
## Adapted to SonicEdge Development platforms 2022

## Pin map adapted to S7 MINI Fpga board 

## All pin names refect SE NTlab hardwere schematic V2 

# MesaLAB S7 Mini FPGA schematics projetct copy 

# Pinout file for Black Mesa Labs' Spartan7 M2 Board
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_ext_i_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_ext_i_IBUF]
# Config PROM. Note spi_sck handled by STARTUPE2 hard IP
#set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports {spi_mosi}]
#set_property -dict {PACKAGE_PIN B12 IOSTANDARD LVCMOS33} [get_ports {spi_miso}]
#set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCMOS33} [get_ports {spi_cs_l}]
# set_property -dict {PACKAGE_PIN A8 IOSTANDARD LVCMOS33} [get_ports {spi_sck}]

# S7 Mini Board
set_property -dict {PACKAGE_PIN A10 IOSTANDARD LVCMOS33}  [get_ports {resetb_i}]
set_property -dict {PACKAGE_PIN L5 IOSTANDARD LVCMOS33}   [get_ports {clk_ext_i}]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5.00} [get_ports { clk_ext_i }];

## USB UART
## Note: Port names are from the perspoctive of the FPGA.
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33 } [get_ports { i2c_scl_io }]; # FTDI 2'nd USB channel for I2C system communication   [GND,FTDI_0,5V,FTDI_1,FTDI_2,FTDI_3]   
set_property -dict {PACKAGE_PIN A12 IOSTANDARD LVCMOS33 } [get_ports { i2c_sda_io }]; # [GND,FTDI_0,5V,FTDI_1,FTDI_2,FTDI_3]   
#set_property DRIVE 4 [get_ports i2c_*];
set_property PULLUP TRUE [get_ports i2c_sda_io]
set_property PULLUP TRUE [get_ports i2c_scl_io]

#set_property PACKAGE_PIN A5  [get_ports {ftdi[2]}]
#set_property PACKAGE_PIN B5  [get_ports {ftdi[3]}]
#set_property PACKAGE_PIN D3  [get_ports {j1_l}]
#set_property PACKAGE_PIN A4  [get_ports {j2_l}]
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33}  [get_ports {led_o[0]}]
set_property -dict {PACKAGE_PIN C14 IOSTANDARD LVCMOS33}  [get_ports {led_o[1]}]

# S7 Mini 32 DIP I/O and 64 50mil I/O (shared)
#set_property PACKAGE_PIN A2 [get_ports {port_a[0]}]    # nc  
#set_property PACKAGE_PIN B3 [get_ports {port_a[4]}]	# nc		
#set_property PACKAGE_PIN C4 [get_ports {port_a[1]}]  	# ADC_SCLK   	O	3  Current sense ADC 
#set_property PACKAGE_PIN C5 [get_ports {port_a[5]}]	# ADC_SYNQn  	O	3
#set_property PACKAGE_PIN D4 [get_ports {port_a[2]}]	# ADC_MOSI	  	O	3
#set_property PACKAGE_PIN E4 [get_ports {port_a[6]}]    # ADC_MISO		I 	3 
#set_property PACKAGE_PIN A3 [get_ports {port_a[3]}]    # nc
#set_property PACKAGE_PIN C3 [get_ports {port_a[7]}]    # nc 

#set_property PACKAGE_PIN B2 [get_ports {port_b[0]}]    # nc 
#set_property PACKAGE_PIN B1 [get_ports {port_b[4]}] 	# nc
set_property -dict {PACKAGE_PIN C1 IOSTANDARD LVCMOS33 } [get_ports {cmut_sck_o}]; 	## CMUT_SCK		O 	3 strap low
set_property -dict {PACKAGE_PIN D1 IOSTANDARD LVCMOS33 } [get_ports {cmut_sc_b_o}];	## nCMUT_CS		O	3 strap high	
set_property -dict {PACKAGE_PIN D2 IOSTANDARD LVCMOS33 } [get_ports {cmut_sdi_o}];	## CMUT_SDI		O 	3 strap low
#set_property PACKAGE_PIN E2 [get_ports {port_b[6]}]    # nc
set_property -dict {PACKAGE_PIN F1 IOSTANDARD LVCMOS33 } [get_ports {cmut_le_o}];	## nCMUT_LE		O 	3 strap low
set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS33 } [get_ports {cmut_mc_o}];	## CMUT_MC		O	3 map to register

#set_property PACKAGE_PIN F3 [get_ports {port_c[0]}]    # nc 
set_property -dict {PACKAGE_PIN F2 IOSTANDARD LVCMOS33 } [get_ports {cmut_o[1]}];		## nCMUT1_C		O	3     
set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVCMOS33 } [get_ports {cmut_o[0]}];		## nCMUT1_D		O	3     
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33 } [get_ports {cmut_en_o}];	## CMUT1_EN		O	3     
set_property -dict {PACKAGE_PIN H3 IOSTANDARD LVCMOS33 } [get_ports {cmut_o[3]}];	## nCMUT1_A		O	3     
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33 } [get_ports {cmut_o[2]}];	## nCMUT1_B		O	3     
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33 } [get_ports {cmut_o[5]}];	## nCMUT2_C		O	3     
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33 } [get_ports {cmut_o[4]}];	## nCMUT2_D		O	3     

#set_property PACKAGE_PIN K3 [get_ports {port_d[0]}]    # nc 
#set_property PACKAGE_PIN K4 [get_ports {port_d[4]}]    # nc 
#set_property PACKAGE_PIN L2 [get_ports {port_d[1]}]	# R121			I	4
set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS33 } [get_ports {cmut_set_o}];	# CMUT_SET		O 	3  strap low
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33 } [get_ports {cmut_o[7]}];	# nCMUT2_A 	O	3
set_property -dict {PACKAGE_PIN M3 IOSTANDARD LVCMOS33 } [get_ports {cmut_o[6]}];	# nCMUT2_B 	O	3
#set_property PACKAGE_PIN M4 [get_ports {port_d[3]}]		## PWM_CLK		O	4
#set_property PACKAGE_PIN M5 [get_ports {port_d[7]}]

#set_property PACKAGE_PIN E11 [get_ports {port_h[0]}]    ## nc
#set_property PACKAGE_PIN C12 [get_ports {port_h[4]}]    ## R_AMP_SCLK   O   2,4
#set_property PACKAGE_PIN C10 [get_ports {port_h[1]}]    ## R_AMP_MISO   I   2,4
#set_property PACKAGE_PIN D10 [get_ports {port_h[5]}]    ## R_AMP_MOSI   O   2,4
#set_property PACKAGE_PIN D12 [get_ports {port_h[2]}]    ## MCU_SYNQN    I   2 
#set_property PACKAGE_PIN D13 [get_ports {port_h[6]}]    ## nc 
#set_property PACKAGE_PIN E13 [get_ports {port_h[3]}]    ## nc
#set_property PACKAGE_PIN F13 [get_ports {port_h[7]}]    ## nc

#set_property PACKAGE_PIN F14 [get_ports {port_g[0]}]    ## R_CMP_nSYNC  O   2
#set_property PACKAGE_PIN G14 [get_ports {port_g[4]}]    ## R_AMP_nSYNC  O   4 
#set_property PACKAGE_PIN E12 [get_ports {port_g[1]}]    ## nc 
#set_property PACKAGE_PIN F12 [get_ports {port_g[5]}]    ## MCU_MISO     O   2   
#set_property PACKAGE_PIN F11 [get_ports {port_g[2]}]    ## MCU_MOSI     I   2  
#set_property PACKAGE_PIN G11 [get_ports {port_g[6]}]    ## MCO_SCLK     I   2
set_property -dict {PACKAGE_PIN H12 IOSTANDARD LVCMOS33 } [get_ports {debug_o[1]}];    # I2S_SCLK     I    
set_property -dict {PACKAGE_PIN H11 IOSTANDARD LVCMOS33 } [get_ports {debug_o[0]}];    # I2S_MCLK     I   

set_property -dict {PACKAGE_PIN H13 IOSTANDARD LVCMOS33 } [get_ports {spdif_rx_i}];    # I2S_SDATA    I 
set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33 } [get_ports {debug_o[2]}];    # I2S_LRCK     I
#set_property PACKAGE_PIN J13 [get_ports {port_f[1]}]    ## nc
#set_property PACKAGE_PIN J14 [get_ports {port_f[5]}]    ## nc
#set_property PACKAGE_PIN L12 [get_ports {port_f[2]}]    ## FEEDBACK     O   3
#set_property PACKAGE_PIN L13 [get_ports {port_f[6]}]    ## CP_COMP      I   2
#set_property PACKAGE_PIN L14 [get_ports {port_f[3]}]    ## PWM_OUT      I   4 
 #set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports {i2s_usb_bck_i}]  # FUNC1_BCK     O   4

#set_property PACKAGE_PIN J12 [get_ports {port_e[0]}]    ## nc
#set_property PACKAGE_PIN J11 [get_ports {port_e[4]}]    ## nc
#set_property PACKAGE_PIN M14 [get_ports {port_e[1]}]    ## nc
 #set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports {i2s_usb_sclk_i}]  # FUNC2_SCLK   O   4 
 #set_property -dict {PACKAGE_PIN K12 IOSTANDARD LVCMOS33 } [get_ports {i2s_usb_ws_i}]    # FUNC0_LRCLK  O   4  
 #set_property -dict {PACKAGE_PIN K11 IOSTANDARD LVCMOS33 } [get_ports {i2s_usb_din_o}]   # FUNC3_DIN    O   4  
 #set_property -dict {PACKAGE_PIN M12 IOSTANDARD LVCMOS33 } [get_ports {i2s_usb_dout_i}]  # DOUT         I   4
#set_property PACKAGE_PIN M11 [get_ports {port_e[7]}]


#set_property PACKAGE_PIN P2   [get_ports {hr_cs_l}]
#set_property PACKAGE_PIN P3   [get_ports {hr_rst_l}]
#set_property PACKAGE_PIN N1   [get_ports {hr_ck}]
#set_property PACKAGE_PIN P4   [get_ports {hr_rwds}]
#set_property PACKAGE_PIN N4   [get_ports {hr_dq[2]}]
#set_property PACKAGE_PIN P12  [get_ports {hr_dq[1]}]
#set_property PACKAGE_PIN P11  [get_ports {hr_dq[0]}]
#set_property PACKAGE_PIN P10  [get_ports {hr_dq[3]}]
#set_property PACKAGE_PIN P5   [get_ports {hr_dq[4]}]
#set_property PACKAGE_PIN P13  [get_ports {hr_dq[7]}]
#set_property PACKAGE_PIN N11  [get_ports {hr_dq[6]}]
#set_property PACKAGE_PIN N10  [get_ports {hr_dq[5]}]

# HR Banks mA Ranges     HP Banks mA Ranges
# LVCMOS33 4,8,12,16
# LVCMOS25 4,8,12,16     
# LVCMOS18 4,8,12,16,24  2,4,6,8,12,16
# LVCMOS15 4,8,12,16     2,4,6,8,12,16
# LVCMOS12 4,8,12        2,4,6,8

