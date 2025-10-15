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

###################### Define Top Level ########################
current_design $top_module



#set_db dft_configuration_modes
#set_db test_clock scanclk
#set_db shift_enable scanrst
#set_db dft_num_scan_chains 4

#check_dft_rules > dft_rules.rpt


#################### Link Design #########################
puts "###############################################"
puts "######## Liniking All The Design Parts ########"
puts "###############################################"
check_design -unresolved

#################### Load Constraints #########################
puts "###############################################"
puts "############ Design Constraints ##############"
puts "###############################################"

source ./cons.tcl

###################### Synthesis ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"
syn_generic
syn_map
#set_db dft_scan_insertion true
syn_opt

#connect_scan_chains

#report_dft_scan > dft_scan.rpt
#report_dft_violations > dft_violations.rpt
#write_netlist design_dft.v

####################### Save Outputs ########################
write_hdl -generic > MIMO_RX_TOP_genus.v
write_sdc > MIMO_RX_TOP_genus.sdc
write_sdf -timescale ps > MIMO_RX_TOP_genus.sdf
#write_sdc -dft test_mode.sdc

#write_do_lec -file lec_script.do
####################### Generate Reports ########################
report_area > area.rpt
report_power > power.rpt
report_timing -nworst 100 > timing.rpt
report_clocks > Mclocks.rpt
report_clocks -generated > Gclocks.rpt
report_constraint > Constraints.rpt
#gui_raise
