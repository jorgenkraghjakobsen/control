// Control 
// Simple register bank and i2c interface 
//
// i2c interface for system configuration 
// 

`define HW_PLATFORM_CMOD_S7
`define MMCM


`include "rb_control"

import rb_control_pkg::*;

module control (
    input clk_ext_i,                // System Clock 1/2 -> direct to MCMM/PLL
    
    input reset_i, 
    input pb_0_i,                   
                                    // System communication
    inout i2c_sda_io,               // I2C client data 
    input i2c_scl_io,               // I2C client clock
    
    // Debug interface 
    output [3:0] led_o,             // LEDs MINI:[1:0] CMOD_S7:[3:0]
    output [2:0] rgb_o,             // RGB CMOD_S7 only 

);

//--------------------------------------------------------------------------------------------------------
// Register bank structs
//-------------------------------------------------------------------------------------------------------- 
rb_audio_if_if_wire_t audio_if; 
rb_amp_cfg_if_wire_t amp_cfg;
rb_sys_config_if_wire_t sys_config;
rb_modulator_if_wire_t modulator; 

//--------------------------------------------------------------------------------------------------------
// Clocking system and reset signals
//--------------------------------------------------------------------------------------------------------
wire resetb_i;
assign resetb_i = !reset_i;  

assign led_o           = 4'b1111;
assign rgb_o           = 3'b100;    
// 3'b001; Blue
// 3'b010; Red
// 3'b100; Green 

wire [5:0] rb_address;
wire [7:0] rb_data_write; 
wire [7:0] rb_data_read;
wire reg_write_en;
wire reg_en;

rb_se_audio_system rb (
    .clk(clk_sys),
    .resetb(resetb_i),
    .address(rb_address),
    .data_write_in(rb_data_write),
    .data_read_out(rb_data_read),
    //.reg_en(rb_reg_en),
    .write_en(reg_write_en), 
    .audio_if(audio_if),
    .modulator(modulator),
    .amp_cfg(amp_cfg),
    .sys_config(sys_config));

i2c_if i2c (
    .clk(clk_sys),
    .resetb(resetb_i),
    .sda(i2c_sda_io),
    .scl(i2c_scl_io),
    .address(rb_address),
    .data_write_to_reg(rb_data_write),
    .data_read_from_reg(rb_data_read),
    .reg_en(reg_en),
    .write_en(reg_write_en)
    );

endmodule
