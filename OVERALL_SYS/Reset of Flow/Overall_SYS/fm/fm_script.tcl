
###################################################################
########################### Variables #############################
###################################################################

set SSLIB "/home/IC/Assignments/Overall_SYS/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/IC/Assignments/Overall_SYS/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/IC/Assignments/Overall_SYS/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

###################################################################
############################ Guidance #############################
###################################################################

# Synopsys setup variable
set synopsys_auto_setup true
set verification_verify_directly_undriven_output false

# Formality Setup File
set_svf "/home/IC/Assignments/Overall_SYS/syn/SYS_TOP.svf"
###################################################################
###################### Reference Container ########################
###################################################################

# Read Reference Design Verilog Files
read_verilog -container Ref [glob /home/IC/Assignments/Overall_SYS/rtl/*.v]

# Read Reference technology libraries
read_db -container Ref $TTLIB

# set the top Reference Design 

set_reference_design SYS_TOP
set_top SYS_TOP

###################################################################
#################### Implementation Container #####################
###################################################################

# Read Implementation Design Files
read_verilog -netlist -container Imp "/home/IC/Assignments/Overall_SYS/syn/SYS_TOP.v"

# Read Implementation technology libraries

read_db -container Imp $TTLIB

# set the top Implementation Design
set_implementation_design SYS_TOP
set_top SYS_TOP


###################### Matching Compare points ####################

match

######################### Run Verification ########################

set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

########################### Reporting ############################# 
report_passing_points > "passing_points.rpt"
report_failing_points > "failing_points.rpt"
report_aborted_points > "aborted_points.rpt"
report_unverified_points > "unverified_points.rpt"


start_gui

