########################### Define Top Module ############################
set top_module MIMO_RX_TOP

##################### Set Search Paths ######################
set_db init_lib_search_path [list \
        /home/cadence/MIMO_ASIC/MIMO_RX/std_cells \
        /home/cadence/MIMO_ASIC/MIMO_RX/rtl ]

################## Load Libraries ######################
set_db library {uk65lscllmvbbr_100c25_tc.lib \
                uk65lscllmvbbr_108c125_wc.lib \
                uk65lscllmvbbr_110c-40_bc.lib}

######################## Read RTL Files ########################
read_hdl -language sv [glob /home/cadence/MIMO_ASIC/MIMO_RX/rtl/*.v]


elaborate $top_module
current_design $top_module
###################### Define Scan ports #######################
define_test_mode -create_port test_mode -active high
define_shift_enable -name SE -active high -create_port SE
define_scan_chain -name chain0 -sdi SI0 -sdo SO0 -create_ports 
define_scan_chain -name chain1 -sdi SI1 -sdo SO1 -create_ports 
define_scan_chain -name chain2 -sdi SI2 -sdo SO2 -create_ports 



###################### Define Top Level ########################

#set_db dft_configuration_modes
#set_db test_clock scanclk
#set_db shift_enable scanrst
#set_db dft_num_scan_chains 4

#check_dft_rules > dft_rules.rpt


#################### Link Design #########################
puts "###############################################"
puts "######## Liniking All The Design Parts ########"
puts "###############################################"
check_design

#################### Load Constraints #########################
puts "###############################################"
puts "############ Design Constraints ##############"
puts "###############################################"

source /home/cadence/MIMO_ASIC/MIMO_RX/DFT/cons_dft.tcl

###################### Synthesis ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"
syn_generic
syn_map
syn_opt

############################## convert to scan ############################
convert_to_scan 
connect_scan_chains


####################### Save Outputs ########################
write_sdc > MIMO_RX_TOP_genus.sdc
write_sdf -timescale ps > MIMO_RX_TOP_genus.sdf

####################### Generate Reports ########################
report_area > area.rpt
report_power > power.rpt
report_timing -nworst 100 > timing.rpt
report_clocks > Mclocks.rpt
report_clocks -generated > Gclocks.rpt
report_dft_violations  > reports_DFT/dft_violations.rpt
report_scan_setup > reports_DFT/scan_setup.rpt
report_units > reports_DFT/units.rpt
report_scan_chains > reports_DFT/scanchains.rpt
write_hdl > design_dft.v
write_scandef > design_dft.scandef

#gui_raise
