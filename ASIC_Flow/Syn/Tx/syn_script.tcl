 ############################ Define Top Module ############################

set TOP_MODULE "TX_TOP"


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


# Set target and link libraries using UMC65 typical corner 
set_db library [list $LIB_PATH/uk65lscllmvbbr_110c-40_bc.lib]



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
    TX_TOP.v \
    up_sampler.v \
    up_sampler_HB.v 


elaborate $TOP_MODULE


########################### Design Constraints ############################

puts "###############################################"
puts "############ Applying Constraints ##############"
puts "###############################################"

read_sdc /home/pc7/cadence_work/MIMO_TX/syn/cons.tcl


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


########################### Write Outputs ###########################

puts "###############################################"
puts "########## Writing Output Reports #############"
puts "###############################################"

write_hdl > $TOP_MODULE.mapped.v
write_sdc > $TOP_MODULE.sdc
write_sdf > $TOP_MODULE.sdf

# Create reports directory if not present

report_area > report_syn/area.rpt
report_power > report_syn/power.rpt
report_timing -nworst 500  > report_syn/setup.rpt
report_clocks > report_syn/clocks.rpt
report_clocks -generated > report_syn/Gclocks.rpt




