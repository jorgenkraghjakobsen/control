
// Interface structures for registerbank symbol access


`ifndef _control_
  `define _control_

package control_pkg;// Wire interface for audio_if
typedef struct packed {
  logic [7:0] status;                          // Status from input audio interface [nc,PLL,SPDIF,I2S,RATE[3:0]]
  logic [2:0] input_sel;                       // 3:SIGGEN, 2:SPDIF, 1:I2S1(ADC), 0:I2S0
  logic       signalgenerator_enable;          // Enable signal generator
  logic [7:0] Version;                         // Indicates the HDL version flashed to FPGA
  logic [7:0] symbolShort;                     // clk pr symbol short
  logic [7:0] symbolMid;                       // clk pr symbol mid
  logic [7:0] symbolLong;                      // clk pr symbol long
} rb_audio_if_if_wire_t;

// Wire interface for clk_sys
typedef struct packed {
  logic [7:0] status;                          // Status from clock system
  logic [3:0] debug_mux;                       // Select internal signal to debug bus
  logic       debug_enable;                    // Disable debug bus output
} rb_clk_sys_if_wire_t;

// Wire interface for modulator
typedef struct packed {
  logic       cmut_enable;                     // Enable CMUT driver
  logic       cmut_reg_en;                     // Drive from register
  logic       cmut_mc;                         // CMUT MC high or low driver strength
  logic       sr_locked_to_shut_cnt;           // Derive sr down factor form shut cnt
  logic [7:0] cmut_reg;                        // CMUT overwrite register
  logic [7:0] cmut_mask;                       // cmut mask register
  logic       mod_enable;                      // modulator enable used for fixed modulation
  logic       div4_enable;                     // Set 1:4 mode - Default 1:5
  logic       mod_fixed_track;                 // track fixed modulation + 1
  logic       sine_sdmod;                      // Source modulator signal 0: counter ratio, 1: sigmadelta sine
  logic [3:0] fixed_delta;                     // Fixed delta (Added to mod_cnt)
  logic [7:0] mod_cnt;                         // fixed carry counter
  logic [7:0] shut_cnt;                        // shutter counter
  logic [7:0] mix_length;                      // mixer sample length
  logic [7:0] phase_delay;                     // Phase delay modulator
  logic       mixer_audio_const;               // Const input to mixer
  logic [7:0] mixer_const_input_high;          // Mixer const input high
  logic [7:0] mixer_const_input_low;           // Mixer const input low
  logic [7:0] phase_inc;                       // Modulator sine phase increment value, 256 added in block
  logic [7:0] phase_inc_frac;                  // Modulator sine phase increment fraction 
  logic [7:0] bpsd_a;                          // a coeffiecent bp centerfreq
  logic [7:0] down_samp_factor;                // Down sample rate for rate converter
} rb_modulator_if_wire_t;

// Wire interface for debug
typedef struct packed {
  logic       dummy;                           // dummy signal
} rb_debug_if_wire_t;

// Wire interface for amp_cfg
typedef struct packed {
  logic       config_trig;                     // Send config when high 
  logic [7:0] bootmem0;                        // Bootmem0: Adr Master Volume
  logic [7:0] bootmem1;                        // Bootmem1: value
  logic [7:0] bootmem2;                        // Bootmem2: Mode config
  logic [7:0] bootmem3;                        // Bootmem3: DSP enable, I2S std format
  logic [7:0] bootmem4;                        // Bootmem4: end of program
  logic [7:0] bootmem5;                        // Bootmem5: end of program
  logic [7:0] bootmem6;                        // Bootmem6: end of program
  logic [7:0] bootmem7;                        // Bootmem7: end of program
} rb_amp_cfg_if_wire_t;

// Wire interface for sys_config
typedef struct packed {
  logic       we;                              // Sin table write 
  logic       clk_xo_12mhz;                    // select external 12Mhz crystal for pll ref
  logic       mod_fixed;                       // Force fixed delta modultaion
  logic       output_flip;                     // flip modulator / shutter driver
  logic [7:0] din;                             // Write input value 
  logic [3:0] db_sel0;                         // Debug[0]
  logic [3:0] db_sel1;                         // Debug[1]
  logic [3:0] db_sel2;                         // Debug[2]
  logic [3:0] db_sel3;                         // Debug[3]
  logic [3:0] db_sel4;                         // Debug[4]
  logic       audio_generator;                 // Enable Audio Generator
  logic [1:0] audio_input_select;              // Audio input select (0:ADC,1:USB,2:SPDIF,3:ExtI2S)
  logic [1:0] audio_input_sel_mode;            // Audio input LED mode (0:off, 1: solid, 2: flash, 3: slow flash)
  logic [5:0] fifo_fill_level;                 // Rate converter FIFO fill level
} rb_sys_config_if_wire_t;


endpackage

`endif
