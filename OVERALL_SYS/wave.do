onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/sysif/TX_CLK_TB
add wave -noupdate /top/sys/TX_CLK
add wave -noupdate /top/sys/RX_CLK
add wave -noupdate /top/sysif/REF_CLK
add wave -noupdate /top/sysif/RST
add wave -noupdate /top/sysif/RX_IN
add wave -noupdate /top/sysif/TX_OUT
add wave -noupdate /top/sysif/par_err_reg
add wave -noupdate /top/sysif/stp_error_reg
add wave -noupdate -expand -group FSMS -color Yellow /top/cs_SYS_CTRL
add wave -noupdate -expand -group FSMS -color Yellow /top/cs_UART_RX
add wave -noupdate -expand -group FSMS -color Yellow /top/cs_UART_TX
add wave -noupdate -group UART_RX_MODULE /top/uartif/rst
add wave -noupdate -group UART_RX_MODULE /top/uartif/prescale
add wave -noupdate -group UART_RX_MODULE /top/uartif/PAR_EN
add wave -noupdate -group UART_RX_MODULE /top/uartif/PAR_TYP
add wave -noupdate -group UART_RX_MODULE /top/uartif/data_valid_reg
add wave -noupdate -group UART_RX_MODULE /top/uartif/P_DATA_reg
add wave -noupdate -expand -group ASYNC -color Magenta /top/SYNCif/unsync_bus
add wave -noupdate -expand -group ASYNC -color Magenta /top/SYNCif/bus_enable
add wave -noupdate -expand -group ASYNC -color Magenta /top/SYNCif/sync_bus
add wave -noupdate -expand -group ASYNC -color Magenta /top/SYNCif/enable_pulse
add wave -noupdate -group REG_FILE /top/reg_fileif/ADDR
add wave -noupdate -group REG_FILE /top/reg_fileif/WrEn
add wave -noupdate -group REG_FILE /top/reg_fileif/RdEn
add wave -noupdate -group REG_FILE /top/reg_fileif/Address
add wave -noupdate -group REG_FILE /top/reg_fileif/WrData
add wave -noupdate -group REG_FILE /top/reg_fileif/RdData
add wave -noupdate -group REG_FILE /top/reg_fileif/RdData_VLD
add wave -noupdate -group REG_FILE /top/reg_fileif/REG0
add wave -noupdate -group REG_FILE /top/reg_fileif/REG1
add wave -noupdate -group REG_FILE /top/reg_fileif/REG2
add wave -noupdate -group REG_FILE /top/reg_fileif/REG3
add wave -noupdate -group {ASYNC FIFO} /top/FIFOif/w_clk
add wave -noupdate -group {ASYNC FIFO} /top/FIFOif/r_clk
add wave -noupdate -group {ASYNC FIFO} /top/FIFOif/wrst_n
add wave -noupdate -group {ASYNC FIFO} /top/FIFOif/rrst_n
add wave -noupdate -group {ASYNC FIFO} /top/FIFOif/winc
add wave -noupdate -group {ASYNC FIFO} /top/FIFOif/rinc
add wave -noupdate -group {ASYNC FIFO} /top/FIFOif/w_data
add wave -noupdate -group {ASYNC FIFO} /top/FIFOif/r_data
add wave -noupdate -group {ASYNC FIFO} /top/FIFOif/wfull
add wave -noupdate -group {ASYNC FIFO} /top/FIFOif/rempty
add wave -noupdate -group UART_TX /top/TXif/P_DATA
add wave -noupdate -group UART_TX /top/TXif/Data_Valid
add wave -noupdate -group UART_TX /top/TXif/PAR_TYP
add wave -noupdate -group UART_TX /top/TXif/PAR_EN
add wave -noupdate -group UART_TX /top/TXif/TX_OUT
add wave -noupdate -group UART_TX /top/TXif/busy
add wave -noupdate /top/sys/RX/asser1/uart_func_sva
add wave -noupdate /top/sys/RX/asser1/uart_parity_even_sva
add wave -noupdate /top/sys/RX/asser1/uart_parity_odd_sva
add wave -noupdate /top/sys/RX/asser1/stp_error_reg_check_parity_exist_sva
add wave -noupdate /top/sys/RX/asser1/stp_error_reg_check_no_parity_sva
add wave -noupdate /top/sys/DATA_SYNC/asser2/check_func_async_sva
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1644505330 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {2834630860 ps}
