###################################################################

# Created by write_sdc on Sat Aug 17 23:23:22 2024

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -max_library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -min scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c -min_library scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports RX_IN]
set_load -pin_load 0.1 [get_ports par_err_reg]
set_load -pin_load 0.1 [get_ports stp_error_reg]
set_load -pin_load 0.1 [get_ports TX_OUT]
create_clock [get_ports REF_CLK]  -name REF_CLK1  -period 20  -waveform {0 10}
set_clock_uncertainty -setup 0.2  [get_clocks REF_CLK1]
set_clock_uncertainty -hold 0.1  [get_clocks REF_CLK1]
create_clock [get_ports UART_CLK]  -name UART_CLK1  -period 271.296  -waveform {0 135.648}
set_clock_uncertainty -setup 0.2  [get_clocks UART_CLK1]
set_clock_uncertainty -hold 0.1  [get_clocks UART_CLK1]
create_generated_clock [get_pins clk_gating/GATED_CLK]  -name ALU_CLK  -source [get_ports REF_CLK]  -master_clock REF_CLK1  -divide_by 1  -add
set_clock_uncertainty -setup 0.2  [get_clocks ALU_CLK]
set_clock_uncertainty -hold 0.1  [get_clocks ALU_CLK]
create_generated_clock [get_pins RX/clk]  -name RX_CLK  -source [get_ports UART_CLK]  -master_clock UART_CLK1  -divide_by 1  -add
set_clock_uncertainty -setup 0.2  [get_clocks RX_CLK]
set_clock_uncertainty -hold 0.1  [get_clocks RX_CLK]
create_generated_clock [get_pins TX/clk]  -name TX_CLK  -source [get_ports UART_CLK]  -master_clock UART_CLK1  -divide_by 32  -add
set_clock_uncertainty -setup 0.2  [get_clocks TX_CLK]
set_clock_uncertainty -hold 0.1  [get_clocks TX_CLK]
group_path -name INOUT  -from [list [get_ports REF_CLK] [get_ports RST] [get_ports UART_CLK] [get_ports RX_IN]]  -to [list [get_ports par_err_reg] [get_ports stp_error_reg] [get_ports TX_OUT]]
group_path -name INREG  -from [list [get_ports REF_CLK] [get_ports RST] [get_ports UART_CLK] [get_ports RX_IN]]
group_path -name REGOUT  -to [list [get_ports par_err_reg] [get_ports stp_error_reg] [get_ports TX_OUT]]
set_input_delay -clock RX_CLK  54.2592  [get_ports RX_IN]
set_output_delay -clock RX_CLK  54.2592  [get_ports par_err_reg]
set_output_delay -clock RX_CLK  54.2592  [get_ports stp_error_reg]
set_output_delay -clock TX_CLK  1736.29  [get_ports TX_OUT]
set_clock_groups -asynchronous -name REF_CLK1_1 -group [list [get_clocks REF_CLK1] [get_clocks ALU_CLK]] -group [list [get_clocks UART_CLK1] [get_clocks RX_CLK] [get_clocks TX_CLK]]
