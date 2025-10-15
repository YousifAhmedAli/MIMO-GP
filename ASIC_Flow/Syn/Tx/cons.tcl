 ####################################################################################
# Constraints
####################################################################################
# Sections:
# 1. Master Clock Definitions
# 2. Generated Clock Definitions
# 3. Clock Relationships / Multicycle
# 4. Input/Output Delay Constraints
# 5. Driving Cells
# 6. Output Load
# 7. Operating Conditions
####################################################################################


####################################################################################
# 1. Master Clock Definitions
####################################################################################

set CLK1_NAME clk
set CLK1_PER 1

create_clock -name $CLK1_NAME -period $CLK1_PER -waveform {0 0.5} [get_ports clk]


####################################################################################
# 2. Generated Clocks (from clk)
####################################################################################

create_generated_clock -name clk_2 -source [get_ports clk] -divide_by 2    [get_pins clk_dut/clk_2]
create_generated_clock -name clk_16 -source [get_ports clk] -divide_by 16  [get_pins clk_dut/clk_16]
create_generated_clock -name clk_32 -source [get_ports clk] -divide_by 32  [get_pins clk_dut/clk_32]


####################################################################################
# 3. Clock Relationships / Multicycle Constraints
####################################################################################
set_multicycle_path -setup 2 -from clk_32 -to clk_16
set_multicycle_path -hold  1 -from clk_32 -to clk_16

set_multicycle_path -setup 8 -from clk_16 -to clk_2
set_multicycle_path -hold  7 -from clk_16 -to clk_2

set_multicycle_path -setup 2 -from clk_2 -to clk
set_multicycle_path -hold  1 -from clk_2 -to clk


####################################################################################
# 4. Input/Output Delays
####################################################################################
set in_delay 0.2
set out_delay 0.2

# Functional Inputs
set_input_delay $in_delay -clock clk_32 [get_ports in_data_1]
set_input_delay $in_delay -clock clk_32 [get_ports in_data_2]
set_input_delay $in_delay -clock clk_32 [get_ports phi]

# Functional Output
set_output_delay $out_delay -clock $CLK1_NAME [get_ports OUT_DUC]


####################################################################################
# 5. Driving Cells
####################################################################################

# Update library name if different from yours
set_driving_cell -library uk65lscllmvbbr_110c-40_bc -lib_cell BUFM4R -pin Z [get_ports in_data_1]
set_driving_cell -library uk65lscllmvbbr_110c-40_bc -lib_cell BUFM4R -pin Z [get_ports in_data_2]
set_driving_cell -library uk65lscllmvbbr_110c-40_bc -lib_cell BUFM4R -pin Z [get_ports phi]


####################################################################################
# 6. Output Load
####################################################################################

set_load 0.1 [get_ports OUT_DUC]

####################################################################################
# 7. Operating Conditions (for timing analysis)
####################################################################################

set_operating_conditions -library uk65lscllmvbbr_090c125_wc.lib \
    -max_library "uk65lscllmvbbr_090c125_wc.lib" \
    -min_library "uk65lscllmvbbr_110c-40_bc.lib"


