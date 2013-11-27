test: compile
	echo "testing simulation memory"
	vsim -lib lib -novopt -c tb_one_port_mem -Gaddresses=32 -Gwidth=8  -do "run -all;"

	echo "testing that we select vendor mem 2048_8"
	vsim -lib lib -novopt -c tb_one_port_mem -Gaddresses=2048 -Gwidth=8 -do "run -all;"

	echo "testing that we select vendor mem 256_8"
	vsim -lib lib -novopt -c tb_one_port_mem -Gaddresses=256 -Gwidth=8 -do "run -all;"

	echo "testing simulation memory"
	vsim -lib lib -novopt -c tb_two_port_mem -Gaddresses=100 -Gwidth=8  -do "run -all;"

	echo "testing that we select vendor mem 2048_8"
	vsim -lib lib -novopt -c tb_two_port_mem -Gaddresses=4096 -Gwidth=32 -do "run -all;"

	echo "testing that we select vendor mem 128_8"
	vsim -lib lib -novopt -c tb_two_port_mem -Gaddresses=128 -Gwidth=8 -do "run -all;"


generate:
	./script/exampleOfGenerationScript.py -s vendorMemModels -d generated

compile: clean generate
	vlib lib
	vlog -work lib -novopt vendorMemModels/*.v
	vlog -work lib -novopt +incdir+generated+rtl  rtl/onePortMem.v
	vlog -work lib -novopt +incdir+generated+rtl  rtl/twoPortMem.v
	vlog -work lib -novopt +incdir+generated+rtl  tb/tb_one_port_mem.v
	vlog -work lib -novopt +incdir+generated+rtl  tb/tb_two_port_mem.v

gui: compile
	vsim -lib lib -novopt -Gwidth=8 -Gaddresses=128 tb_two_port_mem

clean:
	rm -rf lib
	rm -f transcript vsim.wlf 
	rm -f generated/*
