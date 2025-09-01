transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {C:/Users/boram/Desktop/kernel_filtering/kernel_filtering.cache/compile_simlib/activehdl}
vlib activehdl/xpm
vlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../ipstatic" -l xpm -l xil_defaultlib \
"C:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93  \
"C:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" -l xpm -l xil_defaultlib \
"../../../../kernel_filtering.gen/sources_1/ip/clk_50/clk_50_clk_wiz.v" \
"../../../../kernel_filtering.gen/sources_1/ip/clk_50/clk_50.v" \

vlog -work xil_defaultlib \
"glbl.v"

