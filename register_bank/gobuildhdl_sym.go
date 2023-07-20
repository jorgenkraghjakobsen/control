// GoBank - where you put your registers

// Create new bank
// Add/move/delete/edit symbol

package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
)

type RegMap struct {
	name     string // Name of register bank
	version  int    // Version tag
	size     int    // Address space Number of bits in address vector   sections Section    // List of sections
	errorCnt int    // Current number of error duing output
	sections []Section
}

type Section struct {
	name        string   // Section name
	description string   // Section description
	parent      *Section // Allow section in sections
	offset      int      // Offset within RegMap
	size        int      // Section size
	symbols     []Symbol // Array of symbols. Double linked!!!
}

type Symbol struct {
	name        string  // Symbol name
	section     Section //
	address     int     // Address in given section
	size        int     // Number of bits in symbol
	pos         int     // Pointer to lsb in symbol
	reset       int     // Reset value
	readonly    bool    // Symbol is read only
	description string  // Long description
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {

	version_str := os.Args[1]

	version, err := strconv.Atoi(version_str)

	if err != nil {
		fmt.Printf("Error: %s is not a valid number\n", version_str)
		return
	}

	// Define each segment here ...
	var clk_sys []Symbol
	var audio_if []Symbol
	var modulator []Symbol
	var sys_config []Symbol
	var debug []Symbol
	var amp_cfg []Symbol

	// init segment with name, address and size
	audio_if_sec := Section{"audio_if", "Audio Interface config", nil, 0x00, 8, audio_if}
	clk_sys_sec := Section{"clk_sys", "Clock management", nil, 0x08, 8, clk_sys}
	modulator_sec := Section{"modulator", "Audio modulator config", nil, 0x10, 16, modulator}
	debug_sec := Section{"debug", "Debug config", nil, 0x20, 8, debug}
	sys_config_sec := Section{"sys_config", "System configuration", nil, 0x28, 8, sys_config}
	amp_cfg_sec := Section{"amp_cfg", "Config ma12070p amp", nil, 0x30, 16, amp_cfg}

	// Insert each symbol here									Name, section, address, size , pos, reset, value, readonly, description
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"cmut_enable", modulator_sec, 0, 1, 0, 0, false, "Enable CMUT driver"}) //Default 0
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"cmut_reg_en", modulator_sec, 0, 1, 1, 0, false, "Drive from register"})
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"cmut_mc", modulator_sec, 0, 1, 2, 0, false, "CMUT MC high or low driver strength"})
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"sr_locked_to_shut_cnt", modulator_sec, 0, 1, 3, 1, false, "Derive sr down factor form shut cnt"})

	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"cmut_reg", modulator_sec, 1, 8, 0, 0, false, "CMUT overwrite register"})
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"cmut_mask", modulator_sec, 2, 8, 0, 0b00000011, false, "cmut mask register"}) //Default 0b00000011

	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"mod_enable", modulator_sec, 3, 1, 0, 0, false, "modulator enable used for fixed modulation"})
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"div4_enable", modulator_sec, 3, 1, 1, 0, false, "Set 1:4 mode - Default 1:5"})
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"mod_fixed_track", modulator_sec, 3, 1, 2, 0, false, "track fixed modulation + 1"})
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"sine_sdmod", modulator_sec, 3, 1, 3, 1, false, "Source modulator signal 0: counter ratio, 1: sigmadelta sine"}) //Default 1

	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"fixed_delta", modulator_sec, 3, 4, 4, 0, false, "Fixed delta (Added to mod_cnt)"})
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"mod_cnt", modulator_sec, 4, 8, 0, 221, false, "fixed carry counter"})      //Default 221
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"shut_cnt", modulator_sec, 5, 8, 0, 109, false, "shutter counter"})         //Default 63 changed to 49 changed to 59 // double now 121 // 108
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"mix_length", modulator_sec, 6, 8, 0, 29, false, "mixer sample length"})    //Default 29
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"phase_delay", modulator_sec, 7, 8, 0, 12, false, "Phase delay modulator"}) //Default 12
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"mixer_audio_const", modulator_sec, 8, 1, 0, 0, false, "Const input to mixer"})
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"mixer_const_input_high", modulator_sec, 9, 8, 0, 0, false, "Mixer const input high"})
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"mixer_const_input_low", modulator_sec, 10, 8, 0, 0, false, "Mixer const input low"})
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"phase_inc", modulator_sec, 11, 8, 0, 15, false, "Modulator sine phase increment value, 256 added in block"}) //Default 15
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"phase_inc_frac", modulator_sec, 12, 8, 0, 0, false, "Modulator sine phase increment fraction "})             //Default 0
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"bpsd_a", modulator_sec, 13, 8, 0, 1, false, "a coeffiecent bp centerfreq"})                                  //Default 0b00111000 (ca 380 kHz) - 0b10000000
	modulator_sec.symbols = append(modulator_sec.symbols, Symbol{"down_samp_factor", modulator_sec, 14, 8, 0, 110, false, "Down sample rate for rate converter"})              //Default 164 changed to 128 // 109

	// XX mapping within single symbol
	amp_cfg_sec.symbols = append(amp_cfg_sec.symbols, Symbol{"config_trig", amp_cfg_sec, 0, 1, 0, 0, false, "Send config when high "})
	amp_cfg_sec.symbols = append(amp_cfg_sec.symbols, Symbol{"bootmem0", amp_cfg_sec, 8, 8, 0, 0x40, false, "Bootmem0: Adr Master Volume"})
	amp_cfg_sec.symbols = append(amp_cfg_sec.symbols, Symbol{"bootmem1", amp_cfg_sec, 9, 8, 0, 0x40, false, "Bootmem1: value"})
	amp_cfg_sec.symbols = append(amp_cfg_sec.symbols, Symbol{"bootmem2", amp_cfg_sec, 10, 8, 0, 53, false, "Bootmem2: Mode config"})
	amp_cfg_sec.symbols = append(amp_cfg_sec.symbols, Symbol{"bootmem3", amp_cfg_sec, 11, 8, 0, 0x08, false, "Bootmem3: DSP enable, I2S std format"})
	amp_cfg_sec.symbols = append(amp_cfg_sec.symbols, Symbol{"bootmem4", amp_cfg_sec, 12, 8, 0, 0xff, false, "Bootmem4: end of program"})
	amp_cfg_sec.symbols = append(amp_cfg_sec.symbols, Symbol{"bootmem5", amp_cfg_sec, 13, 8, 0, 0xff, false, "Bootmem5: end of program"})
	amp_cfg_sec.symbols = append(amp_cfg_sec.symbols, Symbol{"bootmem6", amp_cfg_sec, 14, 8, 0, 0xff, false, "Bootmem6: end of program"})
	amp_cfg_sec.symbols = append(amp_cfg_sec.symbols, Symbol{"bootmem7", amp_cfg_sec, 15, 8, 0, 0xff, false, "Bootmem7: end of program"})

	audio_if_sec.symbols = append(audio_if_sec.symbols, Symbol{"status", audio_if_sec, 0, 8, 0, 0, true, "Status from input audio interface [nc,PLL,SPDIF,I2S,RATE[3:0]]"})
	audio_if_sec.symbols = append(audio_if_sec.symbols, Symbol{"input_sel", audio_if_sec, 1, 3, 0, 1, false, "3:SIGGEN, 2:SPDIF, 1:I2S1(ADC), 0:I2S0"})
	audio_if_sec.symbols = append(audio_if_sec.symbols, Symbol{"signalgenerator_enable", audio_if_sec, 1, 1, 3, 0, false, "Enable signal generator"})
	audio_if_sec.symbols = append(audio_if_sec.symbols, Symbol{"Version", audio_if_sec, 2, 8, 0, version, false, "Indicates the HDL version flashed to FPGA"}) // HDL version
	//audio_if_sec.symbols = append(audio_if_sec.symbols, Symbol{"signal_freq_low", audio_if_sec, 2, 8, 0, 0xff, false, "Frequncy low"})
	//audio_if_sec.symbols = append(audio_if_sec.symbols, Symbol{"signal_freq_mid", audio_if_sec, 3, 8, 0, 0xff, false, "Frequncy mid"})
	//audio_if_sec.symbols = append(audio_if_sec.symbols, Symbol{"signal_freq_high", audio_if_sec, 4, 8, 0, 0xff, false, "Frequncy high"})
	audio_if_sec.symbols = append(audio_if_sec.symbols, Symbol{"symbolShort", audio_if_sec, 5, 8, 0, 0, true, "clk pr symbol short"})
	audio_if_sec.symbols = append(audio_if_sec.symbols, Symbol{"symbolMid", audio_if_sec, 6, 8, 0, 0, true, "clk pr symbol mid"})
	audio_if_sec.symbols = append(audio_if_sec.symbols, Symbol{"symbolLong", audio_if_sec, 7, 8, 0, 0, true, "clk pr symbol long"})

	clk_sys_sec.symbols = append(clk_sys_sec.symbols, Symbol{"debug_mux", clk_sys_sec, 6, 4, 0, 2, false, "Select internal signal to debug bus"})
	clk_sys_sec.symbols = append(clk_sys_sec.symbols, Symbol{"debug_enable", clk_sys_sec, 6, 1, 4, 1, false, "Disable debug bus output"})
	clk_sys_sec.symbols = append(clk_sys_sec.symbols, Symbol{"status", clk_sys_sec, 0, 8, 0, 0, true, "Status from clock system"})

	debug_sec.symbols = append(debug_sec.symbols, Symbol{"dummy", debug_sec, 0, 1, 0, 0, false, "dummy signal"})

	sys_config_sec.symbols = append(sys_config_sec.symbols, Symbol{"we", sys_config_sec, 0, 1, 0, 0, false, "Sin table write "})
	sys_config_sec.symbols = append(sys_config_sec.symbols, Symbol{"clk_xo_12mhz", sys_config_sec, 0, 1, 1, 0, false, "select external 12Mhz crystal for pll ref"})
	sys_config_sec.symbols = append(sys_config_sec.symbols, Symbol{"mod_fixed", sys_config_sec, 0, 1, 2, 0, false, "Force fixed delta modultaion"})
	sys_config_sec.symbols = append(sys_config_sec.symbols, Symbol{"output_flip", sys_config_sec, 0, 1, 3, 0, false, "flip modulator / shutter driver"})

	sys_config_sec.symbols = append(sys_config_sec.symbols, Symbol{"din", sys_config_sec, 1, 8, 0, 0, false, "Write input value "})

	sys_config_sec.symbols = append(sys_config_sec.symbols, Symbol{"db_sel0", sys_config_sec, 2, 4, 0, 0, false, "Debug[0]"})
	sys_config_sec.symbols = append(sys_config_sec.symbols, Symbol{"db_sel1", sys_config_sec, 2, 4, 4, 0, false, "Debug[1]"})
	sys_config_sec.symbols = append(sys_config_sec.symbols, Symbol{"db_sel2", sys_config_sec, 3, 4, 0, 0, false, "Debug[2]"})
	sys_config_sec.symbols = append(sys_config_sec.symbols, Symbol{"db_sel3", sys_config_sec, 3, 4, 4, 0, false, "Debug[3]"})
	sys_config_sec.symbols = append(sys_config_sec.symbols, Symbol{"db_sel4", sys_config_sec, 4, 4, 0, 0, false, "Debug[4]"})
	sys_config_sec.symbols = append(sys_config_sec.symbols, Symbol{"audio_generator", sys_config_sec, 5, 1, 0, 0, false, "Enable Audio Generator"})
	sys_config_sec.symbols = append(sys_config_sec.symbols, Symbol{"audio_input_select", sys_config_sec, 6, 2, 0, 1, false, "Audio input select (0:ADC,1:USB,2:SPDIF,3:ExtI2S)"}) //Default 1(USB)
	sys_config_sec.symbols = append(sys_config_sec.symbols, Symbol{"audio_input_sel_mode", sys_config_sec, 6, 2, 2, 1, false, "Audio input LED mode (0:off, 1: solid, 2: flash, 3: slow flash)"})
	sys_config_sec.symbols = append(sys_config_sec.symbols, Symbol{"fifo_fill_level", sys_config_sec, 7, 6, 0, 0, true, "Rate converter FIFO fill level"})

	// Build full registermap here
	regmap := RegMap{"control", 0x000001, 6, 0, []Section{audio_if_sec, clk_sys_sec, modulator_sec, debug_sec, amp_cfg_sec, sys_config_sec}}

	writeHDLIncludeStructFile(regmap)

	writeHDLHeader(regmap)
	writeHDLIncludes(regmap)
	writeHDLInterface(regmap)
	writeHDLRegister(regmap)
	writeHDLReadout(regmap)
	writeHDLAssign(regmap)

	writeRegFile(regmap)
	writeJSONFile(regmap)
}

func writeJSONFile(r RegMap) {
	fNameStruct := fmt.Sprintf("reg_file_%s.json", r.name)
	f, err := os.Create(fNameStruct)
	check(err)
	defer f.Close()
	w := bufio.NewWriter(f)
	fmt.Fprintf(w, "// Register database SonicEdge build system\n")
	fmt.Fprintf(w, "{\n")
	fmt.Fprintf(w, "  \"registers\": [\n")
	for nsec, sec := range r.sections {
		for ns, s := range sec.symbols {
			fmt.Fprintf(w, "    {\n")
			fmt.Fprintf(w, "      \"symbol\"      : \"%s.%s\",\n", sec.name, s.name)
			fmt.Fprintf(w, "      \"address\"     : \"0x%02x\",\n", sec.offset+s.address)
			fmt.Fprintf(w, "      \"pos\"         : \"%d\",\n", s.pos)
			fmt.Fprintf(w, "      \"size\"        : \"%d\",\n", s.size)
			fmt.Fprintf(w, "      \"reset\"       : \"%d\",\n", s.reset)
			ro := 0
			if s.readonly {
				ro = 1
			}
			fmt.Fprintf(w, "      \"readonly\"    : \"%d\",\n", ro)
			fmt.Fprintf(w, "      \"description\" : \"%s\"\n", s.description)
			if (ns == len(sec.symbols)-1) && (nsec == len(r.sections)-1) {
				fmt.Fprintf(w, "    }\n")
			} else {
				fmt.Fprintf(w, "    },\n")
			}
		}
	}
	fmt.Fprintf(w, "  ]\n")
	fmt.Fprintf(w, "}\n")
	w.Flush()
}

func writeRegFile(r RegMap) {
	fNameStruct := fmt.Sprintf("reg_file_%s", r.name)
	f, err := os.Create(fNameStruct)
	check(err)
	defer f.Close()
	w := bufio.NewWriter(f)
	f.WriteString("// Register database SonicEdge build system\n")
	for _, sec := range r.sections {
		for _, s := range sec.symbols {
			fmt.Fprintf(w, "%s.%s 0x%02x %d %d %d %s\n", sec.name, s.name, sec.offset+s.address, s.pos, s.size, s.reset, s.description)
		}
	}
	w.Flush()
}

// If emply add a dummy signal or ignor

func writeHDLIncludeStructFile(r RegMap) {
	fNameStruct := fmt.Sprintf("rb_%s_struct.svh", r.name)
	f, err := os.Create(fNameStruct)
	check(err)
	defer f.Close()
	w := bufio.NewWriter(f)
	f.WriteString("\n// Interface structures for registerbank symbol access\n\n")
	fmt.Fprintf(w, "\n`ifndef _%s_\n", r.name)
	fmt.Fprintf(w, "  `define _%s_\n", r.name)
	fmt.Fprintf(w, "\npackage %s_pkg;", r.name)
	for _, sec := range r.sections {
		fmt.Fprintf(w, "// Wire interface for %s\n", sec.name)
		fmt.Fprintf(w, "typedef struct packed {\n")
		//fmt.Fprintf(w,"  logic dummy;\n")
		for i := 0; i < 8*(1<<sec.size); i++ {
			for _, s := range sec.symbols {
				if (s.address == i/8) && (s.pos == i%8) {
					fmt.Fprintf(w, "  logic ")
					var bitRange string
					if s.size == 1 {
						bitRange = "     "
					} else {
						bitRange = fmt.Sprintf("[%d:%d]", s.size-1, 0)
					}
					n := 30 - len(s.name)
					fmt.Fprintf(w, "%s %s; %*s // %s\n", bitRange, s.name, n, "", s.description)

				}
			}
		}
		fmt.Fprintf(w, "} rb_%s_if_wire_t;\n\n", sec.name)
	}
	fmt.Fprintf(w, "\nendpackage\n")
	fmt.Fprintf(w, "\n`endif\n")

	w.Flush()
}

func writeHDLHeader(r RegMap) {
	fmt.Printf("// Register bank \n")
	fmt.Printf("// Auto generated code from %s version %d \n", r.name, r.version)
	fmt.Printf("// Written by Jørgen Kragh Jakobsen, All right reserved \n")
	fmt.Printf("//-----------------------------------------------------------------------------\n")
}

func writeHDLIncludes(r RegMap) {
	fmt.Printf("//`include \"rb_%s_struct.sv\"\n", r.name)
	fmt.Printf("import %s_pkg::*;\n", r.name)
	fmt.Printf("\n")
}

func writeHDLInterface(r RegMap) {
	fmt.Printf("module rb_%s\n", r.name)
	fmt.Printf("#(parameter ADR_BITS = %d\n", r.size)
	fmt.Printf(" )\n")
	fmt.Printf("(\n")
	fmt.Printf("	input  logic				clk,\n")
	fmt.Printf("	input  logic				resetb,\n")
	fmt.Printf("	input  logic [ADR_BITS-1:0]		address,\n")
	fmt.Printf("	input  logic [7:0]			data_write_in,\n")
	fmt.Printf("	output logic [7:0] 			data_read_out,\n")
	fmt.Printf("	input  logic 				reg_en,\n")
	fmt.Printf("	input  logic 				write_en,\n")
	fmt.Printf("//---------------------------------------------\n")
	var c = ','
	for i, sec := range r.sections {
		if i == len(r.sections)-1 {
			c = ' '
		}
		n := 20 - len(sec.name)
		fmt.Printf("	inout rb_%s_if_wire_t %*s%s%c\n", sec.name, n, "", sec.name, c)
	}
	fmt.Printf(");\n")
}

func getWriteSymbols(r RegMap, add int) (string, int, error) {
	var writeAddressStr string = ""
	var n = 0
	var sn = 0
	//	var symbolWriteStr string = ""
	//	var commentWriteStr string = ""
	for _, sec := range r.sections {
		if (add >= sec.offset) && (add < (sec.offset + sec.size)) { // We have the relevant section
			//fmt.Printf("\nFound add in section %s \n", sec.name)

			for _, s := range sec.symbols {
				//fmt.Printf("symbol:%s %d \n", s.name, s.address)
				if (s.address+sec.offset == add) && (!s.readonly) {
					ln := 40 - (len(sec.name) + len(s.name))
					if n == 0 {
						sn = 0
					} else {
						sn = 14
					}
					writeAddressStr = fmt.Sprintf("%s%*sreg__%s__%s%*s   <=   data_write_in[%d:%d];  // %s\n",
						writeAddressStr, sn, "", sec.name, s.name, ln, "", (s.pos+s.size)-1, s.pos, s.description)
					n++
				}
			}
		}
	}
	return writeAddressStr, n, nil
}

func writeHDLRegister(r RegMap) {
	fmt.Printf("//------------------------------------------------Write to registers and reset-\n")
	fmt.Printf("// Create registers\n")
	for _, sec := range r.sections {
		fmt.Printf("\n    // --- Section: %s  Offset: 0x%04x  Size: %d\n", sec.name, sec.offset, sec.size)
		for _, s := range sec.symbols {
			if !s.readonly {
				rangeStr := ""
				//fmt.Printf("symbol:%s %d \n", s.name, s.address)
				n := 40 - (len(sec.name) + len(s.name))
				if s.size > 1 {
					rangeStr = fmt.Sprintf("[%d:0]", s.size-1)
				}
				fmt.Printf("reg %s%*s reg__%s__%s;      %*s//%s\n", rangeStr, 6-len(rangeStr), "", sec.name, s.name,
					n, "", s.description)
			}
		}
	}

	fmt.Printf("\n")
	fmt.Printf("always_ff @(posedge clk)\n")
	fmt.Printf("begin\n")
	fmt.Printf("  if (resetb == 0)\n")
	fmt.Printf("  begin\n")
	// Per symbol
	for _, sec := range r.sections {
		//if (add >= sec.offset) && (add < (sec.offset + sec.size)) { // We have the relevant section
		fmt.Printf("\n    // --- Section: %s  Offset: 0x%04x  Size: %d\n", sec.name, sec.offset, sec.size)
		for _, s := range sec.symbols {
			if !s.readonly {
				//fmt.Printf("symbol:%s %d \n", s.name, s.address)
				n := 40 - (len(sec.name) + len(s.name))
				fmt.Printf("    reg__%s__%s%*s       <=  %d'b%08b;   //%s\n", sec.name, s.name, n, "", s.size, s.reset, s.description)
			}
		}
	}

	fmt.Printf("  end\n")
	fmt.Printf("  else\n")
	fmt.Printf("  begin\n")
	fmt.Printf("    if (write_en)\n")
	fmt.Printf("    begin\n")
	fmt.Printf("      case (address)\n")
	var beginTag string = ""
	for add := 0; add < int(math.Pow(float64(2), float64(r.size))); add++ {
		writeCaseProcess, n, _ := getWriteSymbols(r, add)
		if writeCaseProcess != "" {
			if n > 1 {
				beginTag = "begin"
			} else {
				beginTag = writeCaseProcess
			}
			fmt.Printf("        %03d : %s \n", add, beginTag)
			if n > 1 {
				fmt.Printf("              %s", writeCaseProcess)
				fmt.Printf("              end\n")
			}
		}
	}
	//fmt.Printf("        default :\n")
	fmt.Printf("      endcase \n")
	fmt.Printf("    end\n")
	fmt.Printf("  end\n")
	fmt.Printf("end\n")
}

func getReadSymbols(r RegMap, add int) (string, int, error) {
	var readAddressStr string = ""
	var n = 0
	var sn = 0
	for _, sec := range r.sections {
		if (add >= sec.offset) && (add < (sec.offset + sec.size)) { // We have the relevant section
			for _, s := range sec.symbols {
				//fmt.Printf("//symbol:%s %d \n", s.name, s.address)
				if s.address+sec.offset == add {
					sourceStr := ""
					if n == 0 {
						sn = 0
					} else {
						sn = 14
					}
					if s.readonly {
						sourceStr = fmt.Sprintf("%s.%s", sec.name, s.name)
					} else {
						sourceStr = fmt.Sprintf("reg__%s__%s", sec.name, s.name)
					}
					ln := 40 - len(sourceStr)
					readAddressStr = fmt.Sprintf("%s%*sdata_read_out[%d:%d]  <=  %s;%*s // %s\n",
						readAddressStr, sn, "",
						(s.pos+s.size)-1, s.pos, sourceStr, ln, "", s.description)
					n++
				}
			}
		}
	}
	return readAddressStr, n, nil
}

func writeHDLReadout(r RegMap) {
	fmt.Printf("//---------------------------------------------\n")
	fmt.Printf("always @(posedge clk )\n")
	fmt.Printf("begin\n")
	fmt.Printf("  if (resetb == 0)\n")
	fmt.Printf("    data_read_out <= 8'b00000000;\n")
	fmt.Printf("  else\n")
	fmt.Printf("  begin\n")
	fmt.Printf("    data_read_out <= 8'b00000000;\n")
	fmt.Printf("    case (address)\n")
	var beginTag string = ""
	for add := 0; add < int(math.Pow(float64(2), float64(r.size))); add++ {
		readCaseProcess, n, _ := getReadSymbols(r, add)
		//fmt.Printf("%d : -%d-%s-\n",add,n,readCaseProcess)
		if readCaseProcess != "" {
			if n > 1 {
				beginTag = "begin"
			} else {
				beginTag = readCaseProcess
			}
			fmt.Printf("        %03d : %s \n", add, beginTag)
			if n > 1 {
				fmt.Printf("              %s", readCaseProcess)
				fmt.Printf("              end\n")
			}
		}
	}
	fmt.Printf("      default : data_read_out <= 8'b00000000;\n")
	fmt.Printf("    endcase\n")
	fmt.Printf("  end\n")
	fmt.Printf("end\n")

}

func writeHDLAssign(r RegMap) {
	fmt.Printf("//-------------------------------------Assign symbols to structs\n")
	for _, sec := range r.sections {
		for _, s := range sec.symbols {
			if !s.readonly {
				// Find max length to fit all cases
				n := 40 - (len(sec.name) + len(s.name))
				fmt.Printf("assign %s.%s%*s= reg__%s__%s ;\n", sec.name, s.name, n, "", sec.name, s.name)
			}
		}
	}
	fmt.Printf("endmodule\n")
}
