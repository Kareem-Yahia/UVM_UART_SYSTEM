
########################### Define Top Module ############################
                                                   
set top_module SYS_TOP

##################### Define Working Library Directory ######################
                                                   
define_design_lib work -path ./work

set_svf SYS_TOP.svf

################## Design Compiler Library Files #setup ######################

puts "###########################################"
puts "#      #setting Design Libraries           #"
puts "###########################################"

#Add the path of the libraries to the search_path variable
lappend search_path /home/IC/Assignments/Overall_SYS/std_cells
lappend search_path /home/IC/Assignments/Overall_SYS/rtl

set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

## Standard Cell libraries 
set target_library [list $SSLIB $TTLIB $FFLIB]

## Standard Cell & Hard Macros libraries 
set link_library [list * $SSLIB $TTLIB $FFLIB]  

######################## Reading RTL Files #################################

puts "###########################################"
puts "#             Reading RTL Files           #"
puts "###########################################"

set file_format verilog

#ALU
analyze -format $file_format ALU.v
#FIFO
analyze -format $file_format BIT_SYNC.v
analyze -format $file_format FIFO_Memory.v
analyze -format $file_format FIFO_rptr.v
analyze -format $file_format FIFO_wptr.v
analyze -format $file_format FIFO_TOP.v
analyze -format $file_format BUS_SYNC.v
analyze -format $file_format binary_to_gray.v
#CLK_DIVIDER
analyze -format $file_format ClkDiv.v
#CLK_GATING
analyze -format $file_format clock_gating.v
#DATA_SYNC
analyze -format $file_format DATA_SYNC.v
#REGISTER_FILE
analyze -format $file_format RegFile.v
#PULSE_GENERATOR
analyze -format $file_format Pulse_Gen.v
#RST_SYNC
analyze -format $file_format RST_SYNC.v
#SYS_CONTROLLER
analyze -format $file_format SYS_CTRL.v
#UART_RX
analyze -format $file_format data_sampling.v
analyze -format $file_format deserializer.v
analyze -format $file_format edge_bit_counter.v
analyze -format $file_format parity_check.v
analyze -format $file_format stop_check.v
analyze -format $file_format strt_check.v
analyze -format $file_format UART_RX.v
analyze -format $file_format FSM.v
#UART_TX
analyze -format $file_format UART_Mux.v
analyze -format $file_format Parity_Calc.v
analyze -format $file_format Serializer.v
analyze -format $file_format UART_TX.v
analyze -format $file_format Controller_TX.v

#SYS_TOP
analyze -format $file_format SYS_TOP.v

elaborate -lib WORK SYS_TOP

###################### Defining toplevel ###################################

current_design $top_module

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## checking design consistency ##########"
puts "###############################################"

check_design

############################### Path groups ################################
puts "###############################################"
puts "################ Path groups ##################"
puts "###############################################"

group_path -name INREG -from [all_inputs]
group_path -name REGOUT -to [all_outputs]
group_path -name INOUT -from [all_inputs] -to [all_outputs]

#################### Define Design Constraints #########################

source -echo ./cons.tcl

###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"

compile -map_effort high
set_svf -off

#############################################################################
# Write out Design after initial compile
#############################################################################

write_file -format verilog -hierarchy -output SYS_TOP.v
write_file -format ddc -hierarchy -output SYS_TOP.ddc
write_sdc  -nosplit SYS_TOP.sdc
write_sdf           SYS_TOP.sdf

################# reporting #######################

report_area -hierarchy > area.rpt
report_power -hierarchy > power.rpt
report_timing -max_paths 100 -delay_type min > hold.rpt
report_timing -max_paths 100 -delay_type max > setup.rpt
report_clock -attributes > clocks.rpt 
report_constraint -all_violators > constraints.rpt

############################################################################
# DFT Preparation Section
############################################################################

set flops_per_chain 100

set num_flops [sizeof_collection [all_registers -edge_triggered]]

set num_chains [expr $num_flops / $flops_per_chain + 1 ]

################# starting graphical user interface #######################

#gui_start

#exit

