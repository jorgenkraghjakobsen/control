
all: build install gen


build: gobuildhdl_sym.go 
	go build gobuildhdl_sym.go 
	
install: gobuildhdl_sym
	cp gobuildhdl_sym /home/$(USER)/bin

gen: 	
	cd ../digital/rb_control; \
	gobuildhdl_sym 1234 > rb_control.sv; \
	cp  reg_file_control ../../test/.reg_file_control 
	
	 
	
		 
	
