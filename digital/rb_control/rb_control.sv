// Register bank 
// Auto generated code from control version 1 
// Written by Jørgen Kragh Jakobsen, All right reserved 
//-----------------------------------------------------------------------------
//`include "rb_control_struct.sv"
import control_pkg::*;

module rb_control
#(parameter ADR_BITS = 6
 )
(
	input  logic				clk,
	input  logic				resetb,
	input  logic [ADR_BITS-1:0]		address,
	input  logic [7:0]			data_write_in,
	output logic [7:0] 			data_read_out,
	input  logic 				reg_en,
	input  logic 				write_en,
//---------------------------------------------
	inout rb_audio_if_if_wire_t             audio_if,
	inout rb_clk_sys_if_wire_t              clk_sys,
	inout rb_modulator_if_wire_t            modulator,
	inout rb_debug_if_wire_t                debug,
	inout rb_amp_cfg_if_wire_t              amp_cfg,
	inout rb_sys_config_if_wire_t           sys_config 
);
//------------------------------------------------Write to registers and reset-
// Create registers

    // --- Section: audio_if  Offset: 0x0000  Size: 8
reg [2:0]  reg__audio_if__input_sel;                             //3:SIGGEN, 2:SPDIF, 1:I2S1(ADC), 0:I2S0
reg        reg__audio_if__signalgenerator_enable;                //Enable signal generator
reg [7:0]  reg__audio_if__Version;                               //Indicates the HDL version flashed to FPGA

    // --- Section: clk_sys  Offset: 0x0008  Size: 8
reg [3:0]  reg__clk_sys__debug_mux;                              //Select internal signal to debug bus
reg        reg__clk_sys__debug_enable;                           //Disable debug bus output

    // --- Section: modulator  Offset: 0x0010  Size: 16
reg        reg__modulator__cmut_enable;                          //Enable CMUT driver
reg        reg__modulator__cmut_reg_en;                          //Drive from register
reg        reg__modulator__cmut_mc;                              //CMUT MC high or low driver strength
reg        reg__modulator__sr_locked_to_shut_cnt;                //Derive sr down factor form shut cnt
reg [7:0]  reg__modulator__cmut_reg;                             //CMUT overwrite register
reg [7:0]  reg__modulator__cmut_mask;                            //cmut mask register
reg        reg__modulator__mod_enable;                           //modulator enable used for fixed modulation
reg        reg__modulator__div4_enable;                          //Set 1:4 mode - Default 1:5
reg        reg__modulator__mod_fixed_track;                      //track fixed modulation + 1
reg        reg__modulator__sine_sdmod;                           //Source modulator signal 0: counter ratio, 1: sigmadelta sine
reg [3:0]  reg__modulator__fixed_delta;                          //Fixed delta (Added to mod_cnt)
reg [7:0]  reg__modulator__mod_cnt;                              //fixed carry counter
reg [7:0]  reg__modulator__shut_cnt;                             //shutter counter
reg [7:0]  reg__modulator__mix_length;                           //mixer sample length
reg [7:0]  reg__modulator__phase_delay;                          //Phase delay modulator
reg        reg__modulator__mixer_audio_const;                    //Const input to mixer
reg [7:0]  reg__modulator__mixer_const_input_high;               //Mixer const input high
reg [7:0]  reg__modulator__mixer_const_input_low;                //Mixer const input low
reg [7:0]  reg__modulator__phase_inc;                            //Modulator sine phase increment value, 256 added in block
reg [7:0]  reg__modulator__phase_inc_frac;                       //Modulator sine phase increment fraction 
reg [7:0]  reg__modulator__bpsd_a;                               //a coeffiecent bp centerfreq
reg [7:0]  reg__modulator__down_samp_factor;                     //Down sample rate for rate converter

    // --- Section: debug  Offset: 0x0020  Size: 8
reg        reg__debug__dummy;                                    //dummy signal

    // --- Section: amp_cfg  Offset: 0x0030  Size: 16
reg        reg__amp_cfg__config_trig;                            //Send config when high 
reg [7:0]  reg__amp_cfg__bootmem0;                               //Bootmem0: Adr Master Volume
reg [7:0]  reg__amp_cfg__bootmem1;                               //Bootmem1: value
reg [7:0]  reg__amp_cfg__bootmem2;                               //Bootmem2: Mode config
reg [7:0]  reg__amp_cfg__bootmem3;                               //Bootmem3: DSP enable, I2S std format
reg [7:0]  reg__amp_cfg__bootmem4;                               //Bootmem4: end of program
reg [7:0]  reg__amp_cfg__bootmem5;                               //Bootmem5: end of program
reg [7:0]  reg__amp_cfg__bootmem6;                               //Bootmem6: end of program
reg [7:0]  reg__amp_cfg__bootmem7;                               //Bootmem7: end of program

    // --- Section: sys_config  Offset: 0x0028  Size: 8
reg        reg__sys_config__we;                                  //Sin table write 
reg        reg__sys_config__clk_xo_12mhz;                        //select external 12Mhz crystal for pll ref
reg        reg__sys_config__mod_fixed;                           //Force fixed delta modultaion
reg        reg__sys_config__output_flip;                         //flip modulator / shutter driver
reg [7:0]  reg__sys_config__din;                                 //Write input value 
reg [3:0]  reg__sys_config__db_sel0;                             //Debug[0]
reg [3:0]  reg__sys_config__db_sel1;                             //Debug[1]
reg [3:0]  reg__sys_config__db_sel2;                             //Debug[2]
reg [3:0]  reg__sys_config__db_sel3;                             //Debug[3]
reg [3:0]  reg__sys_config__db_sel4;                             //Debug[4]
reg        reg__sys_config__audio_generator;                     //Enable Audio Generator
reg [1:0]  reg__sys_config__audio_input_select;                  //Audio input select (0:ADC,1:USB,2:SPDIF,3:ExtI2S)
reg [1:0]  reg__sys_config__audio_input_sel_mode;                //Audio input LED mode (0:off, 1: solid, 2: flash, 3: slow flash)

always_ff @(posedge clk)
begin
  if (resetb == 0)
  begin

    // --- Section: audio_if  Offset: 0x0000  Size: 8
    reg__audio_if__input_sel                              <=  3'b00000001;   //3:SIGGEN, 2:SPDIF, 1:I2S1(ADC), 0:I2S0
    reg__audio_if__signalgenerator_enable                 <=  1'b00000000;   //Enable signal generator
    reg__audio_if__Version                                <=  8'b10011010010;   //Indicates the HDL version flashed to FPGA

    // --- Section: clk_sys  Offset: 0x0008  Size: 8
    reg__clk_sys__debug_mux                               <=  4'b00000010;   //Select internal signal to debug bus
    reg__clk_sys__debug_enable                            <=  1'b00000001;   //Disable debug bus output

    // --- Section: modulator  Offset: 0x0010  Size: 16
    reg__modulator__cmut_enable                           <=  1'b00000000;   //Enable CMUT driver
    reg__modulator__cmut_reg_en                           <=  1'b00000000;   //Drive from register
    reg__modulator__cmut_mc                               <=  1'b00000000;   //CMUT MC high or low driver strength
    reg__modulator__sr_locked_to_shut_cnt                 <=  1'b00000001;   //Derive sr down factor form shut cnt
    reg__modulator__cmut_reg                              <=  8'b00000000;   //CMUT overwrite register
    reg__modulator__cmut_mask                             <=  8'b00000011;   //cmut mask register
    reg__modulator__mod_enable                            <=  1'b00000000;   //modulator enable used for fixed modulation
    reg__modulator__div4_enable                           <=  1'b00000000;   //Set 1:4 mode - Default 1:5
    reg__modulator__mod_fixed_track                       <=  1'b00000000;   //track fixed modulation + 1
    reg__modulator__sine_sdmod                            <=  1'b00000001;   //Source modulator signal 0: counter ratio, 1: sigmadelta sine
    reg__modulator__fixed_delta                           <=  4'b00000000;   //Fixed delta (Added to mod_cnt)
    reg__modulator__mod_cnt                               <=  8'b11011101;   //fixed carry counter
    reg__modulator__shut_cnt                              <=  8'b01101101;   //shutter counter
    reg__modulator__mix_length                            <=  8'b00011101;   //mixer sample length
    reg__modulator__phase_delay                           <=  8'b00001100;   //Phase delay modulator
    reg__modulator__mixer_audio_const                     <=  1'b00000000;   //Const input to mixer
    reg__modulator__mixer_const_input_high                <=  8'b00000000;   //Mixer const input high
    reg__modulator__mixer_const_input_low                 <=  8'b00000000;   //Mixer const input low
    reg__modulator__phase_inc                             <=  8'b00001111;   //Modulator sine phase increment value, 256 added in block
    reg__modulator__phase_inc_frac                        <=  8'b00000000;   //Modulator sine phase increment fraction 
    reg__modulator__bpsd_a                                <=  8'b00000001;   //a coeffiecent bp centerfreq
    reg__modulator__down_samp_factor                      <=  8'b01101110;   //Down sample rate for rate converter

    // --- Section: debug  Offset: 0x0020  Size: 8
    reg__debug__dummy                                     <=  1'b00000000;   //dummy signal

    // --- Section: amp_cfg  Offset: 0x0030  Size: 16
    reg__amp_cfg__config_trig                             <=  1'b00000000;   //Send config when high 
    reg__amp_cfg__bootmem0                                <=  8'b01000000;   //Bootmem0: Adr Master Volume
    reg__amp_cfg__bootmem1                                <=  8'b01000000;   //Bootmem1: value
    reg__amp_cfg__bootmem2                                <=  8'b00110101;   //Bootmem2: Mode config
    reg__amp_cfg__bootmem3                                <=  8'b00001000;   //Bootmem3: DSP enable, I2S std format
    reg__amp_cfg__bootmem4                                <=  8'b11111111;   //Bootmem4: end of program
    reg__amp_cfg__bootmem5                                <=  8'b11111111;   //Bootmem5: end of program
    reg__amp_cfg__bootmem6                                <=  8'b11111111;   //Bootmem6: end of program
    reg__amp_cfg__bootmem7                                <=  8'b11111111;   //Bootmem7: end of program

    // --- Section: sys_config  Offset: 0x0028  Size: 8
    reg__sys_config__we                                   <=  1'b00000000;   //Sin table write 
    reg__sys_config__clk_xo_12mhz                         <=  1'b00000000;   //select external 12Mhz crystal for pll ref
    reg__sys_config__mod_fixed                            <=  1'b00000000;   //Force fixed delta modultaion
    reg__sys_config__output_flip                          <=  1'b00000000;   //flip modulator / shutter driver
    reg__sys_config__din                                  <=  8'b00000000;   //Write input value 
    reg__sys_config__db_sel0                              <=  4'b00000000;   //Debug[0]
    reg__sys_config__db_sel1                              <=  4'b00000000;   //Debug[1]
    reg__sys_config__db_sel2                              <=  4'b00000000;   //Debug[2]
    reg__sys_config__db_sel3                              <=  4'b00000000;   //Debug[3]
    reg__sys_config__db_sel4                              <=  4'b00000000;   //Debug[4]
    reg__sys_config__audio_generator                      <=  1'b00000000;   //Enable Audio Generator
    reg__sys_config__audio_input_select                   <=  2'b00000001;   //Audio input select (0:ADC,1:USB,2:SPDIF,3:ExtI2S)
    reg__sys_config__audio_input_sel_mode                 <=  2'b00000001;   //Audio input LED mode (0:off, 1: solid, 2: flash, 3: slow flash)
  end
  else
  begin
    if (write_en)
    begin
      case (address)
        001 : begin 
              reg__audio_if__input_sel                          <=   data_write_in[2:0];  // 3:SIGGEN, 2:SPDIF, 1:I2S1(ADC), 0:I2S0
              reg__audio_if__signalgenerator_enable             <=   data_write_in[3:3];  // Enable signal generator
              end
        002 : reg__audio_if__Version                            <=   data_write_in[7:0];  // Indicates the HDL version flashed to FPGA
 
        014 : begin 
              reg__clk_sys__debug_mux                           <=   data_write_in[3:0];  // Select internal signal to debug bus
              reg__clk_sys__debug_enable                        <=   data_write_in[4:4];  // Disable debug bus output
              end
        016 : begin 
              reg__modulator__cmut_enable                       <=   data_write_in[0:0];  // Enable CMUT driver
              reg__modulator__cmut_reg_en                       <=   data_write_in[1:1];  // Drive from register
              reg__modulator__cmut_mc                           <=   data_write_in[2:2];  // CMUT MC high or low driver strength
              reg__modulator__sr_locked_to_shut_cnt             <=   data_write_in[3:3];  // Derive sr down factor form shut cnt
              end
        017 : reg__modulator__cmut_reg                          <=   data_write_in[7:0];  // CMUT overwrite register
 
        018 : reg__modulator__cmut_mask                         <=   data_write_in[7:0];  // cmut mask register
 
        019 : begin 
              reg__modulator__mod_enable                        <=   data_write_in[0:0];  // modulator enable used for fixed modulation
              reg__modulator__div4_enable                       <=   data_write_in[1:1];  // Set 1:4 mode - Default 1:5
              reg__modulator__mod_fixed_track                   <=   data_write_in[2:2];  // track fixed modulation + 1
              reg__modulator__sine_sdmod                        <=   data_write_in[3:3];  // Source modulator signal 0: counter ratio, 1: sigmadelta sine
              reg__modulator__fixed_delta                       <=   data_write_in[7:4];  // Fixed delta (Added to mod_cnt)
              end
        020 : reg__modulator__mod_cnt                           <=   data_write_in[7:0];  // fixed carry counter
 
        021 : reg__modulator__shut_cnt                          <=   data_write_in[7:0];  // shutter counter
 
        022 : reg__modulator__mix_length                        <=   data_write_in[7:0];  // mixer sample length
 
        023 : reg__modulator__phase_delay                       <=   data_write_in[7:0];  // Phase delay modulator
 
        024 : reg__modulator__mixer_audio_const                 <=   data_write_in[0:0];  // Const input to mixer
 
        025 : reg__modulator__mixer_const_input_high            <=   data_write_in[7:0];  // Mixer const input high
 
        026 : reg__modulator__mixer_const_input_low             <=   data_write_in[7:0];  // Mixer const input low
 
        027 : reg__modulator__phase_inc                         <=   data_write_in[7:0];  // Modulator sine phase increment value, 256 added in block
 
        028 : reg__modulator__phase_inc_frac                    <=   data_write_in[7:0];  // Modulator sine phase increment fraction 
 
        029 : reg__modulator__bpsd_a                            <=   data_write_in[7:0];  // a coeffiecent bp centerfreq
 
        030 : reg__modulator__down_samp_factor                  <=   data_write_in[7:0];  // Down sample rate for rate converter
 
        032 : reg__debug__dummy                                 <=   data_write_in[0:0];  // dummy signal
 
        040 : begin 
              reg__sys_config__we                               <=   data_write_in[0:0];  // Sin table write 
              reg__sys_config__clk_xo_12mhz                     <=   data_write_in[1:1];  // select external 12Mhz crystal for pll ref
              reg__sys_config__mod_fixed                        <=   data_write_in[2:2];  // Force fixed delta modultaion
              reg__sys_config__output_flip                      <=   data_write_in[3:3];  // flip modulator / shutter driver
              end
        041 : reg__sys_config__din                              <=   data_write_in[7:0];  // Write input value 
 
        042 : begin 
              reg__sys_config__db_sel0                          <=   data_write_in[3:0];  // Debug[0]
              reg__sys_config__db_sel1                          <=   data_write_in[7:4];  // Debug[1]
              end
        043 : begin 
              reg__sys_config__db_sel2                          <=   data_write_in[3:0];  // Debug[2]
              reg__sys_config__db_sel3                          <=   data_write_in[7:4];  // Debug[3]
              end
        044 : reg__sys_config__db_sel4                          <=   data_write_in[3:0];  // Debug[4]
 
        045 : reg__sys_config__audio_generator                  <=   data_write_in[0:0];  // Enable Audio Generator
 
        046 : begin 
              reg__sys_config__audio_input_select               <=   data_write_in[1:0];  // Audio input select (0:ADC,1:USB,2:SPDIF,3:ExtI2S)
              reg__sys_config__audio_input_sel_mode             <=   data_write_in[3:2];  // Audio input LED mode (0:off, 1: solid, 2: flash, 3: slow flash)
              end
        048 : reg__amp_cfg__config_trig                         <=   data_write_in[0:0];  // Send config when high 
 
        056 : reg__amp_cfg__bootmem0                            <=   data_write_in[7:0];  // Bootmem0: Adr Master Volume
 
        057 : reg__amp_cfg__bootmem1                            <=   data_write_in[7:0];  // Bootmem1: value
 
        058 : reg__amp_cfg__bootmem2                            <=   data_write_in[7:0];  // Bootmem2: Mode config
 
        059 : reg__amp_cfg__bootmem3                            <=   data_write_in[7:0];  // Bootmem3: DSP enable, I2S std format
 
        060 : reg__amp_cfg__bootmem4                            <=   data_write_in[7:0];  // Bootmem4: end of program
 
        061 : reg__amp_cfg__bootmem5                            <=   data_write_in[7:0];  // Bootmem5: end of program
 
        062 : reg__amp_cfg__bootmem6                            <=   data_write_in[7:0];  // Bootmem6: end of program
 
        063 : reg__amp_cfg__bootmem7                            <=   data_write_in[7:0];  // Bootmem7: end of program
 
      endcase 
    end
  end
end
//---------------------------------------------
always @(posedge clk )
begin
  if (resetb == 0)
    data_read_out <= 8'b00000000;
  else
  begin
    data_read_out <= 8'b00000000;
    case (address)
        000 : data_read_out[7:0]  <=  audio_if.status;                          // Status from input audio interface [nc,PLL,SPDIF,I2S,RATE[3:0]]
 
        001 : begin 
              data_read_out[2:0]  <=  reg__audio_if__input_sel;                 // 3:SIGGEN, 2:SPDIF, 1:I2S1(ADC), 0:I2S0
              data_read_out[3:3]  <=  reg__audio_if__signalgenerator_enable;    // Enable signal generator
              end
        002 : data_read_out[7:0]  <=  reg__audio_if__Version;                   // Indicates the HDL version flashed to FPGA
 
        005 : data_read_out[7:0]  <=  audio_if.symbolShort;                     // clk pr symbol short
 
        006 : data_read_out[7:0]  <=  audio_if.symbolMid;                       // clk pr symbol mid
 
        007 : data_read_out[7:0]  <=  audio_if.symbolLong;                      // clk pr symbol long
 
        008 : data_read_out[7:0]  <=  clk_sys.status;                           // Status from clock system
 
        014 : begin 
              data_read_out[3:0]  <=  reg__clk_sys__debug_mux;                  // Select internal signal to debug bus
              data_read_out[4:4]  <=  reg__clk_sys__debug_enable;               // Disable debug bus output
              end
        016 : begin 
              data_read_out[0:0]  <=  reg__modulator__cmut_enable;              // Enable CMUT driver
              data_read_out[1:1]  <=  reg__modulator__cmut_reg_en;              // Drive from register
              data_read_out[2:2]  <=  reg__modulator__cmut_mc;                  // CMUT MC high or low driver strength
              data_read_out[3:3]  <=  reg__modulator__sr_locked_to_shut_cnt;    // Derive sr down factor form shut cnt
              end
        017 : data_read_out[7:0]  <=  reg__modulator__cmut_reg;                 // CMUT overwrite register
 
        018 : data_read_out[7:0]  <=  reg__modulator__cmut_mask;                // cmut mask register
 
        019 : begin 
              data_read_out[0:0]  <=  reg__modulator__mod_enable;               // modulator enable used for fixed modulation
              data_read_out[1:1]  <=  reg__modulator__div4_enable;              // Set 1:4 mode - Default 1:5
              data_read_out[2:2]  <=  reg__modulator__mod_fixed_track;          // track fixed modulation + 1
              data_read_out[3:3]  <=  reg__modulator__sine_sdmod;               // Source modulator signal 0: counter ratio, 1: sigmadelta sine
              data_read_out[7:4]  <=  reg__modulator__fixed_delta;              // Fixed delta (Added to mod_cnt)
              end
        020 : data_read_out[7:0]  <=  reg__modulator__mod_cnt;                  // fixed carry counter
 
        021 : data_read_out[7:0]  <=  reg__modulator__shut_cnt;                 // shutter counter
 
        022 : data_read_out[7:0]  <=  reg__modulator__mix_length;               // mixer sample length
 
        023 : data_read_out[7:0]  <=  reg__modulator__phase_delay;              // Phase delay modulator
 
        024 : data_read_out[0:0]  <=  reg__modulator__mixer_audio_const;        // Const input to mixer
 
        025 : data_read_out[7:0]  <=  reg__modulator__mixer_const_input_high;   // Mixer const input high
 
        026 : data_read_out[7:0]  <=  reg__modulator__mixer_const_input_low;    // Mixer const input low
 
        027 : data_read_out[7:0]  <=  reg__modulator__phase_inc;                // Modulator sine phase increment value, 256 added in block
 
        028 : data_read_out[7:0]  <=  reg__modulator__phase_inc_frac;           // Modulator sine phase increment fraction 
 
        029 : data_read_out[7:0]  <=  reg__modulator__bpsd_a;                   // a coeffiecent bp centerfreq
 
        030 : data_read_out[7:0]  <=  reg__modulator__down_samp_factor;         // Down sample rate for rate converter
 
        032 : data_read_out[0:0]  <=  reg__debug__dummy;                        // dummy signal
 
        040 : begin 
              data_read_out[0:0]  <=  reg__sys_config__we;                      // Sin table write 
              data_read_out[1:1]  <=  reg__sys_config__clk_xo_12mhz;            // select external 12Mhz crystal for pll ref
              data_read_out[2:2]  <=  reg__sys_config__mod_fixed;               // Force fixed delta modultaion
              data_read_out[3:3]  <=  reg__sys_config__output_flip;             // flip modulator / shutter driver
              end
        041 : data_read_out[7:0]  <=  reg__sys_config__din;                     // Write input value 
 
        042 : begin 
              data_read_out[3:0]  <=  reg__sys_config__db_sel0;                 // Debug[0]
              data_read_out[7:4]  <=  reg__sys_config__db_sel1;                 // Debug[1]
              end
        043 : begin 
              data_read_out[3:0]  <=  reg__sys_config__db_sel2;                 // Debug[2]
              data_read_out[7:4]  <=  reg__sys_config__db_sel3;                 // Debug[3]
              end
        044 : data_read_out[3:0]  <=  reg__sys_config__db_sel4;                 // Debug[4]
 
        045 : data_read_out[0:0]  <=  reg__sys_config__audio_generator;         // Enable Audio Generator
 
        046 : begin 
              data_read_out[1:0]  <=  reg__sys_config__audio_input_select;      // Audio input select (0:ADC,1:USB,2:SPDIF,3:ExtI2S)
              data_read_out[3:2]  <=  reg__sys_config__audio_input_sel_mode;    // Audio input LED mode (0:off, 1: solid, 2: flash, 3: slow flash)
              end
        047 : data_read_out[5:0]  <=  sys_config.fifo_fill_level;               // Rate converter FIFO fill level
 
        048 : data_read_out[0:0]  <=  reg__amp_cfg__config_trig;                // Send config when high 
 
        056 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem0;                   // Bootmem0: Adr Master Volume
 
        057 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem1;                   // Bootmem1: value
 
        058 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem2;                   // Bootmem2: Mode config
 
        059 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem3;                   // Bootmem3: DSP enable, I2S std format
 
        060 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem4;                   // Bootmem4: end of program
 
        061 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem5;                   // Bootmem5: end of program
 
        062 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem6;                   // Bootmem6: end of program
 
        063 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem7;                   // Bootmem7: end of program
 
      default : data_read_out <= 8'b00000000;
    endcase
  end
end
//-------------------------------------Assign symbols to structs
assign audio_if.input_sel                       = reg__audio_if__input_sel ;
assign audio_if.signalgenerator_enable          = reg__audio_if__signalgenerator_enable ;
assign audio_if.Version                         = reg__audio_if__Version ;
assign clk_sys.debug_mux                        = reg__clk_sys__debug_mux ;
assign clk_sys.debug_enable                     = reg__clk_sys__debug_enable ;
assign modulator.cmut_enable                    = reg__modulator__cmut_enable ;
assign modulator.cmut_reg_en                    = reg__modulator__cmut_reg_en ;
assign modulator.cmut_mc                        = reg__modulator__cmut_mc ;
assign modulator.sr_locked_to_shut_cnt          = reg__modulator__sr_locked_to_shut_cnt ;
assign modulator.cmut_reg                       = reg__modulator__cmut_reg ;
assign modulator.cmut_mask                      = reg__modulator__cmut_mask ;
assign modulator.mod_enable                     = reg__modulator__mod_enable ;
assign modulator.div4_enable                    = reg__modulator__div4_enable ;
assign modulator.mod_fixed_track                = reg__modulator__mod_fixed_track ;
assign modulator.sine_sdmod                     = reg__modulator__sine_sdmod ;
assign modulator.fixed_delta                    = reg__modulator__fixed_delta ;
assign modulator.mod_cnt                        = reg__modulator__mod_cnt ;
assign modulator.shut_cnt                       = reg__modulator__shut_cnt ;
assign modulator.mix_length                     = reg__modulator__mix_length ;
assign modulator.phase_delay                    = reg__modulator__phase_delay ;
assign modulator.mixer_audio_const              = reg__modulator__mixer_audio_const ;
assign modulator.mixer_const_input_high         = reg__modulator__mixer_const_input_high ;
assign modulator.mixer_const_input_low          = reg__modulator__mixer_const_input_low ;
assign modulator.phase_inc                      = reg__modulator__phase_inc ;
assign modulator.phase_inc_frac                 = reg__modulator__phase_inc_frac ;
assign modulator.bpsd_a                         = reg__modulator__bpsd_a ;
assign modulator.down_samp_factor               = reg__modulator__down_samp_factor ;
assign debug.dummy                              = reg__debug__dummy ;
assign amp_cfg.config_trig                      = reg__amp_cfg__config_trig ;
assign amp_cfg.bootmem0                         = reg__amp_cfg__bootmem0 ;
assign amp_cfg.bootmem1                         = reg__amp_cfg__bootmem1 ;
assign amp_cfg.bootmem2                         = reg__amp_cfg__bootmem2 ;
assign amp_cfg.bootmem3                         = reg__amp_cfg__bootmem3 ;
assign amp_cfg.bootmem4                         = reg__amp_cfg__bootmem4 ;
assign amp_cfg.bootmem5                         = reg__amp_cfg__bootmem5 ;
assign amp_cfg.bootmem6                         = reg__amp_cfg__bootmem6 ;
assign amp_cfg.bootmem7                         = reg__amp_cfg__bootmem7 ;
assign sys_config.we                            = reg__sys_config__we ;
assign sys_config.clk_xo_12mhz                  = reg__sys_config__clk_xo_12mhz ;
assign sys_config.mod_fixed                     = reg__sys_config__mod_fixed ;
assign sys_config.output_flip                   = reg__sys_config__output_flip ;
assign sys_config.din                           = reg__sys_config__din ;
assign sys_config.db_sel0                       = reg__sys_config__db_sel0 ;
assign sys_config.db_sel1                       = reg__sys_config__db_sel1 ;
assign sys_config.db_sel2                       = reg__sys_config__db_sel2 ;
assign sys_config.db_sel3                       = reg__sys_config__db_sel3 ;
assign sys_config.db_sel4                       = reg__sys_config__db_sel4 ;
assign sys_config.audio_generator               = reg__sys_config__audio_generator ;
assign sys_config.audio_input_select            = reg__sys_config__audio_input_select ;
assign sys_config.audio_input_sel_mode          = reg__sys_config__audio_input_sel_mode ;
endmodule
