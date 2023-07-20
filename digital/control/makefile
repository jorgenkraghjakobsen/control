
COMP = se_audio_system

SIMULATOR = modelsim
#SIMULATOR = iverilog

SYNTH = yosys

WORKSPACE = $(shell ${HOME}/bin/maw -r)
#WORKSPACE = /home/karlhk/sonicEdge_sdk_fpga

#TECH  = fpga | processname eg sky130 | xfab180xt

TECH = fpga
BOARD = CMOD_S7
DEVICE = xc7s25csga225-1

#BOARD = S7_MINI
#DEVICE = xc7s25ftgb196-1

debug: 
	@echo "First Simulator 	$(SIMULATOR)" \
	@echo "Device 		$(DEVICE)" 


PIN_MAP = $(CURDIR)/$(COMP)_$(BOARD)_pins.xdc


include $(WORKSPACE)/flow/hdl/Flow.makefile

