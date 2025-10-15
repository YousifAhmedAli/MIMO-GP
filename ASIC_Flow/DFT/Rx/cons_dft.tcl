# Clock Definitions
set CLK_Name CLK_1
set CLK_PER 1

# 1. Master Clock
create_clock -name MASTER_CLK_1 -period $CLK_PER -waveform {0 0.5} [get_ports CLK_1]

# 2. Generated Clocks (use get_pins for hierarchical paths)
create_generated_clock -name CLK_2 -source [get_ports CLK_1] -divide_by 2 [get_pins CLK_DIV_2/O_DIV_CLK]

create_generated_clock -name CLK_16 -source [get_ports CLK_1] -divide_by 16 [get_pins CLK_DIV_16/O_DIV_CLK]

create_generated_clock -name CLK_32 -source [get_ports CLK_1] -divide_by 32 [get_pins CLK_DIV_32/O_DIV_CLK]


# 3. Scan Clock Definition
set CLK2_NAME scan_clk
set CLK2_PER 1000
create_clock -name $CLK2_NAME -period $CLK2_PER -waveform {0 500}  [get_ports scan_clk]



# 4. Input/Output Delays
set in_delay 0.5
set_input_delay $in_delay -clock MASTER_CLK_1 [get_ports {ADC_OUT ADC_OUT_2 ADC_OUT_3 ADC_OUT_4 CORDIC_EN PHI PHI_2 PHI_3 PHI_4}]


set out_delay 0.00625
set_output_delay $out_delay -clock CLK_32 [get_ports {I_Processor Q_Processor}]


set in2_delay  100
set out2_delay 100
# Scan Inputs
set_input_delay $in2_delay -clock $CLK2_NAME [get_ports test_mode]
set_input_delay $in2_delay -clock $CLK2_NAME [get_ports SE]

# Apply delay to each scan-in port
foreach si_port {SI0 SI1 SI2} {
    set_input_delay $in2_delay -clock $CLK2_NAME [get_ports $si_port]
}

# Scan Outputs
foreach so_port {SO0 SO1 SO2} {
    set_output_delay $out2_delay -clock $CLK2_NAME [get_ports $so_port]
}



# 5. Driving Cells
set_driving_cell -lib_cell CKBUFM4R -pin Z -library uk65lscllmvbbr_100c25_tc \
  [get_ports {ADC_OUT ADC_OUT_2 ADC_OUT_3 ADC_OUT_4 CORDIC_EN PHI PHI_2 PHI_3 PHI_4}]
set_driving_cell -lib_cell CKBUFM4R -pin Z -library uk65lscllmvbbr_100c25_tc [get_ports test_mode]
set_driving_cell -lib_cell CKBUFM4R -pin Z -library uk65lscllmvbbr_100c25_tc [get_ports SI0]
set_driving_cell -lib_cell CKBUFM4R -pin Z -library uk65lscllmvbbr_100c25_tc [get_ports SI1]
set_driving_cell -lib_cell CKBUFM4R -pin Z -library uk65lscllmvbbr_100c25_tc [get_ports SI2]
set_driving_cell -lib_cell CKBUFM4R -pin Z -library uk65lscllmvbbr_100c25_tc [get_ports SE]

# 6. Output Load
set_load 0.1 [get_ports {I_Processor Q_Processor}]

set_load 0.1 [get_ports SO0]
set_load 0.1 [get_ports SO1]
set_load 0.1 [get_ports SO2]
# Enable test mode for scan insertion
set_case_analysis 1 [get_ports test_mode]
#set_case_analysis 1 [get_ports SE]



# 7. Operating Conditions (Genus-compatible)
#set_operating_conditions \
#-max "wc" -max_library "uk65lscllmvbbr_108c125_wc" \
#-min "bc" -min_library "uk65lscllmvbbr_110c-40_bc" 

#set_dont_touch [get_ports CLK_1]

#set_dont_touch [get_nets RST]


