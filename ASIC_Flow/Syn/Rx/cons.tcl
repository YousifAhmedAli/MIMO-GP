# Clock Definitions
set CLK_PER 1

# 1. Master Clock
create_clock -name MASTER_CLK_1 -period $CLK_PER -waveform "0 [expr $CLK_PER/2]" [get_ports CLK_1]

# 2. Generated Clocks (use get_pins for hierarchical paths)
create_generated_clock -name CLK_2 -source [get_ports CLK_1] \
  -divide_by 2 [get_pins CLK_DIV_2/O_DIV_CLK]

create_generated_clock -name CLK_16 -source [get_ports CLK_1] \
  -divide_by 16 [get_pins CLK_DIV_16/O_DIV_CLK]

create_generated_clock -name CLK_32 -source [get_ports CLK_1] \
  -divide_by 32 [get_pins CLK_DIV_32/O_DIV_CLK]

# 3. Input/Output Delays
set in_delay [expr 0.2*$CLK_PER]
set in_delay32 [expr 0.2*$CLK_PER*32]

set_input_delay $in_delay -clock MASTER_CLK_1 [get_ports {ADC_OUT ADC_OUT_2 ADC_OUT_3 ADC_OUT_4}]
set_input_delay $in_delay32 -clock CLK_32 [get_ports {CORDIC_EN PHI PHI_2 PHI_3 PHI_4}]


set CLK_PER_OUT 32
set out_delay [expr 0.2*$CLK_PER_OUT]
set_output_delay $out_delay -clock CLK_32 [get_ports {I_Processor Q_Processor}]

# 4. Driving Cells
set_driving_cell -lib_cell CKBUFM4R -pin Z -library uk65lscllmvbbr_100c25_tc \
  [get_ports {ADC_OUT ADC_OUT_2 ADC_OUT_3 ADC_OUT_4 CORDIC_EN PHI PHI_2 PHI_3 PHI_4}]

# 5. Output Load
set_load 0.1 [get_ports {I_Processor Q_Processor}]

# 6. Operating Conditions (Genus-compatible)
#set_operating_conditions \
#-max "wc" -max_library "uk65lscllmvbbr_108c125_wc" \
#-min "bc" -min_library "uk65lscllmvbbr_110c-40_bc" 

#set_dont_touch [get_ports CLK_1]

#set_dont_touch [get_nets RST]


