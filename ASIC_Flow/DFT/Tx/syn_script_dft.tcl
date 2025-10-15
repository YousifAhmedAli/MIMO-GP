 ############################ Define Top Module ############################

set TOP_MODULE "TX_TOP_dft"


###################### Define Working Directory ###########################

set WORK_DIR ./work
file mkdir $WORK_DIR

########################### Project and Library Paths ########################

puts "###########################################"
puts "#      Setting Design Libraries           #"
puts "###########################################"

set PROJECT_PATH /home/pc7/cadence_work/MIMO_TX
set RTL_PATH $PROJECT_PATH/RTL
set LIB_PATH /PDKs/umc65_std_cells/synopsys

# Set search path
set_db lib_search_path [list $LIB_PATH]
set_db init_hdl_search_path [list $PROJECT_PATH/RTL]


# Set target and link libraries using UMC65 typical corner (1.10V, 25°C)
set_db library [list $LIB_PATH/uk65lscllmvbbr_110c-40_bc.lib]



#set_db link_library [list /PDKs/umc65_std_cells/synopsys ]

########################### Read RTL Files #################################

puts "###########################################"
puts "#             Reading RTL Files           #"
puts "###########################################"

read_hdl -sv \
    clk_div.v \
    comb_interpolation.v \
    cordic.v \
    cwm_tx.v \
    cwm_tx_top.v \
    duc.v \
    E0_comb_interpolation.v \
    E0_HB.v \
    E1_comb_interpolation.v \
    E1_HB.v \
    E2_comb_interpolation.v \
    E3_comb_interpolation.v \
    E4_comb_interpolation.v \
    E5_comb_interpolation.v \
    E6_comb_interpolation.v \
    E7_comb_interpolation.v \
    HB_interpolation.v \
    interpolation.v \
    Noise_cancelling_net.v \
    Stage.v \
    Top.v \
    TX_TOP_dft.v \
    up_sampler.v \
    up_sampler_HB.v 


elaborate $TOP_MODULE


define_test_mode -create_port test_mode -active high
define_shift_enable -name SE -active high -create_port SE
define_scan_chain -name chain0 -sdi SI0 -sdo SO0 -create_ports 
define_scan_chain -name chain1 -sdi SI1 -sdo SO1 -create_ports 
define_scan_chain -name chain2 -sdi SI2 -sdo SO2 -create_ports 
define_scan_chain -name chain3 -sdi SI3 -sdo SO3 -create_ports 
define_scan_chain -name chain4 -sdi SI4 -sdo SO4 -create_ports 




########################### Design Constraints ############################

puts "###############################################"
puts "############ Applying Constraints ##############"
puts "###############################################"

read_sdc /home/pc7/cadence_work/MIMO_TX/syn/cons_dft.tcl


########################### Check Design ############################

puts "###############################################"
puts "########## Checking Design Consistency ########"
puts "###############################################"

check_design

########################### Compile Design ##########################

puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"

syn_gen
syn_map
syn_opt

############################## convert to scan ############################
convert_to_scan 
connect_scan_chains
########################### Write Outputs ###########################

puts "###############################################"
puts "########## Writing Output Reports #############"
puts "###############################################"

write_hdl > $TOP_MODULE.mapped.v
write_sdc > $TOP_MODULE.sdc
write_sdf > $TOP_MODULE.sdf

# Create reports directory if not present

report_area > reports_DFT/area.rpt
report_power > reports_DFT/power.rpt
report_timing -nworst 500  > reports_DFT/setup.rpt
report_clocks > reports_DFT/clocks.rpt
report_clocks -generated > reports_DFT/Gclocks.rpt
report_dft_violations  > reports_DFT/dft_violations.rpt
report_scan_setup > reports_DFT/scan_setup.rpt
report_units > reports_DFT/units.rpt
report_scan_chains > reports_DFT/scanchains.rpt


#insert_scan
write_hdl > design_dft.v
write_scandef > design_dft.scandef

