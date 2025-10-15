 ####################################################################################
# Constraints
####################################################################################
# Sections:
# 0. Genus Variables / Settings
# 1. Master Clock Definitions
# 2. Generated Clock Definitions
# 3. Clock Uncertainties & Latencies
# 4. Clock Relationships / Multicycle
# 5. Input/Output Delay Constraints
# 6. Driving Cells
# 7. Output Load
# 8. Operating Conditions
# 9. Wire Load Model (optional)
# 10. Case Analysis (for DFT mode)
####################################################################################


####################################################################################
# 0. Genus DFT Variables (Required before compile)
####################################################################################
#set_fix_multiple_port_nets -all -buffer_constants -feedthroughs


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

#get_ports -of_objects [get_nets clk_2]
####################################################################################
# 3. Scan Clock Definition
####################################################################################

set CLK2_NAME scan_clk
set CLK2_PER 10

create_clock -name $CLK2_NAME -period $CLK2_PER -waveform {0 5} [get_ports scan_clk]


####################################################################################
# 4. Clock Relationships / Multicycle Constraints
####################################################################################
set_multicycle_path -setup 2 -from clk_32 -to clk_16
set_multicycle_path -hold  1 -from clk_32 -to clk_16

set_multicycle_path -setup 8 -from clk_16 -to clk_2
set_multicycle_path -hold  7 -from clk_16 -to clk_2

set_multicycle_path -setup 2 -from clk_2 -to clk
set_multicycle_path -hold  1 -from clk_2 -to clk


####################################################################################
# 5. Input/Output Delays
####################################################################################
set in_delay 0.2
set out_delay 0.2

set in2_delay  0.2
set out2_delay 0.2

# Functional Inputs
set_input_delay $in_delay -clock clk_32 [get_ports in_data_1]
set_input_delay $in_delay -clock clk_32 [get_ports in_data_2]
set_input_delay $in_delay -clock clk_32 [get_ports phi]

# Scan Inputs
set_input_delay $in2_delay -clock $CLK2_NAME [get_ports test_mode]
set_input_delay $in2_delay -clock $CLK2_NAME [get_ports SE]


# Apply delay to each scan-in port
foreach si_port {SI0 SI1 SI2 SI3 SI4} {
    set_input_delay $in2_delay -clock $CLK2_NAME [get_ports $si_port]
}

# Scan Outputs
foreach so_port {SO0 SO1 SO2 SO3 SO4} {
    set_output_delay $out2_delay -clock $CLK2_NAME [get_ports $so_port]
}

# Functional Output
set_output_delay $out_delay -clock $CLK1_NAME [get_ports OUT_DUC]



####################################################################################
# 6. Driving Cells
####################################################################################

# Update library name if different from yours
set_driving_cell -library uk65lscllmvbbr_110c-40_bc -lib_cell BUFM4R -pin Z [get_ports in_data_1]
set_driving_cell -library uk65lscllmvbbr_110c-40_bc -lib_cell BUFM4R -pin Z [get_ports in_data_2]
set_driving_cell -library uk65lscllmvbbr_110c-40_bc -lib_cell BUFM4R -pin Z [get_ports phi]

set_driving_cell -library uk65lscllmvbbr_110c-40_bc -lib_cell BUFM4R -pin Z [get_ports test_mode]
set_driving_cell -library uk65lscllmvbbr_110c-40_bc -lib_cell BUFM4R -pin Z [get_ports SI0]
set_driving_cell -library uk65lscllmvbbr_110c-40_bc -lib_cell BUFM4R -pin Z [get_ports SI1]
set_driving_cell -library uk65lscllmvbbr_110c-40_bc -lib_cell BUFM4R -pin Z [get_ports SI2]
set_driving_cell -library uk65lscllmvbbr_110c-40_bc -lib_cell BUFM4R -pin Z [get_ports SI3]
set_driving_cell -library uk65lscllmvbbr_110c-40_bc -lib_cell BUFM4R -pin Z [get_ports SI4]

set_driving_cell -library uk65lscllmvbbr_110c-40_bc -lib_cell BUFM4R -pin Z [get_ports SE]


####################################################################################
# 7. Output Load
####################################################################################

set_load 0.1 [get_ports OUT_DUC]
set_load 0.1 [get_ports SO0]
set_load 0.1 [get_ports SO1]
set_load 0.1 [get_ports SO2]
set_load 0.1 [get_ports SO3]
set_load 0.1 [get_ports SO4]

####################################################################################
# 8. Operating Conditions (for timing analysis)
####################################################################################

set_operating_conditions -library uk65lscllmvbbr_090c125_wc.lib \
    -max_library "uk65lscllmvbbr_090c125_wc.lib" \
    -min_library "uk65lscllmvbbr_110c-40_bc.lib"


####################################################################################
# 10. Case Analysis for Test Mode (For DFT)
####################################################################################
# Enable test mode for scan insertion
set_case_analysis 1 [get_ports test_mode]
set_case_analysis 1 [get_ports SE]

