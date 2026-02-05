puts "###############################################"
puts "############ Design Constraints #### ##########"
puts "###############################################"

# Constraints
# ----------------------------------------------------------------------------
#
# 1. Master Clock Definitions
#
# 2. Generated Clock Definitions
#
# 3. Clock Uncertainties
#
# 4. Clock Latencies 
#
# 5. Clock Relationships
#
# 6. set input/output delay on ports
#
# 7. Driving cells
#
# 8. Output load

####################################################################################
           #########################################################
                  #### Section 0 : DC Variables ####
           #########################################################
#################################################################################### 

# Prevent assign statements in the generated netlist (must be applied before compile command)
set_fix_multiple_port_nets -all -buffer_constants -feedthroughs


####################################################################################
           #########################################################
                  #### Section 1 : Clock Definition ####
           #########################################################
#################################################################################### 
# 1. Master Clock Definitions 
# 2. Generated Clock Definitions
# 3. Clock Latencies
# 4. Clock Uncertainties
# 5. Clock Transitions
####################################################################################

set REF_CLK_PER 20
set UART_CLK_PER 271.296

#3. SCAN_CLK (10 MHZ)
set CLK3_NAME SCAN_CLK
set CLK3_PER 100

create_clock -name REF_CLK1 -period $REF_CLK_PER -waveform "0 [expr $REF_CLK_PER/2]" [get_ports REF_CLK]
set_clock_uncertainty -setup 0.2 [get_clocks REF_CLK1]
set_clock_uncertainty -hold 0.1  [get_clocks REF_CLK1]


create_clock -name UART_CLK1 -period $UART_CLK_PER -waveform "0 [expr $UART_CLK_PER/2]" [get_ports UART_CLK]
set_clock_uncertainty -setup 0.2 [get_clocks UART_CLK1]
set_clock_uncertainty -hold 0.1  [get_clocks UART_CLK1]


create_generated_clock -master_clock REF_CLK1 -source [get_ports REF_CLK] \
                       -name "ALU_CLK" [get_port clk_gating/GATED_CLK] \
                       -divide_by 1
set_clock_uncertainty -setup 0.2 [get_clocks ALU_CLK]
set_clock_uncertainty -hold 0.1  [get_clocks ALU_CLK]


create_generated_clock -master_clock UART_CLK1 -source [get_ports UART_CLK] \
                       -name "RX_CLK" [get_port RX/clk] \
                       -divide_by 1
set_clock_uncertainty -setup 0.2 [get_clocks RX_CLK]
set_clock_uncertainty -hold 0.1  [get_clocks RX_CLK]

create_generated_clock -master_clock UART_CLK1 -source [get_ports UART_CLK] \
                       -name "TX_CLK" [get_port TX/clk] \
                       -divide_by 32
set_clock_uncertainty -setup 0.2 [get_clocks TX_CLK]
set_clock_uncertainty -hold 0.1  [get_clocks TX_CLK]


####### HERE WE WRITE DFT CLOCK ##############3
create_clock -name $CLK3_NAME -period $CLK3_PER -waveform "0 [expr $CLK3_PER/2]" [get_ports scan_clk]
set_clock_uncertainty -setup 0.2 [get_clocks $CLK3_NAME]
set_clock_uncertainty -hold 0.1   [get_clocks $CLK3_NAME]



					   
set_dont_touch_network [get_clocks {REF_CLK1 UART_CLK1 ALU_CLK RX_CLK TX_CLK scan_clock}]

####################################################################################
           #########################################################
                  #### Section 2 : Clocks Relationships ####
           #########################################################
####################################################################################

set_clock_groups -asynchronous -group [get_clocks {REF_CLK1 ALU_CLK}] -group [get_clocks {UART_CLK1 RX_CLK TX_CLK}] -group [get_clocks "SCAN_CLK"] 
####################################################################################
           #########################################################
             #### Section 3 : set input/output delay on ports ####
           #########################################################
####################################################################################

set TX_CLK [expr 32*$UART_CLK_PER]
set in_delay  [expr 0.2*$UART_CLK_PER]

set in2_delay  [expr 0.2*$CLK3_PER]
set out2_delay [expr 0.2*$CLK3_PER]

set out_delay  [expr 0.2*$TX_CLK]
set out2_delay  [expr 0.2*$UART_CLK_PER]

#Constrain Input Paths
set_input_delay $in_delay -clock RX_CLK [get_port RX_IN]

#Constrain Scan Input Paths
set_input_delay $in2_delay -clock $CLK3_NAME [get_port test_mode]
set_input_delay $in2_delay -clock $CLK3_NAME [get_port SI]
set_input_delay $in2_delay -clock $CLK3_NAME [get_port SE]

#Constrain Output Paths
set_output_delay $out_delay -clock TX_CLK [get_ports {TX_OUT} ]
set_output_delay $out2_delay -clock RX_CLK [get_ports {par_err_reg stp_error_reg}]

#Constrain Scan Output Paths
set_output_delay $out2_delay -clock $CLK3_NAME [get_port SO]


####################################################################################
           #########################################################
                  #### Section 4 : Driving cells ####
           #########################################################
####################################################################################

set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port RX_IN]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port test_mode]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port SI]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port SE]


####################################################################################
           #########################################################
                  #### Section 5 : Output load ####
           #########################################################
####################################################################################

set_load 0.1 [get_ports {TX_OUT par_err_reg stp_error_reg}]
set_load 0.1 [get_port SO]

####################################################################################
           #########################################################
                 #### Section 6 : Operating Condition ####
           #########################################################
####################################################################################

# Define the Worst Library for Max(#setup) analysis
# Define the Best Library for Min(hold) analysis

set_operating_conditions -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"

####################################################################################
           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################

#set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c

####################################################################################
           #########################################################
                  #### Section 8 : multicycle path ####
           #########################################################
####################################################################################

####################################################################################
           #########################################################
                  #### Section 8 : set_case_analysis ####
           #########################################################
####################################################################################

set_case_analysis 1 [get_port test_mode]

####################################################################################


