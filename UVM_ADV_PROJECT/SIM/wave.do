onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/sys_if/clk
add wave -noupdate /top_tb/sys_if/clk_faster
add wave -noupdate /top_tb/sys_if/rst_n
add wave -noupdate /top_tb/sys_if/mux1_sel
add wave -noupdate /top_tb/sys_if/mux2_sel
add wave -noupdate /top_tb/sys_if/mem1_wr_en
add wave -noupdate /top_tb/sys_if/mem2_wr_en
add wave -noupdate /top_tb/sys_if/mem1_rd_en
add wave -noupdate /top_tb/sys_if/mem2_rd_en
add wave -noupdate /top_tb/sys_if/mem1_addr
add wave -noupdate /top_tb/sys_if/mem2_addr
add wave -noupdate /top_tb/sys_if/mem1_data_in
add wave -noupdate /top_tb/sys_if/mem2_data_in
add wave -noupdate /top_tb/sys_if/mem1_data_out
add wave -noupdate /top_tb/sys_if/mem2_data_out
add wave -noupdate /top_tb/sys_if/mem1_valid_out
add wave -noupdate /top_tb/sys_if/mem2_valid_out
add wave -noupdate /top_tb/sys_if/key
add wave -noupdate /top_tb/sys_if/parity_en
add wave -noupdate /top_tb/sys_if/parity_type
add wave -noupdate /top_tb/sys_if/RX_IN
add wave -noupdate /top_tb/sys_if/prescale
add wave -noupdate /top_tb/sys_if/uart_rx_data_valid
add wave -noupdate /top_tb/sys_if/uart_rx_P_DATA_reg
add wave -noupdate /top_tb/sys_if/uart_rx_par_err
add wave -noupdate /top_tb/sys_if/uart_rx_stp_error
add wave -noupdate /top_tb/sys_if/uart_tx_out
add wave -noupdate /top_tb/sys_if/uart_tx_busy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {691 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 302
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1601 ns}
