vlib work
vlog -f ./RTL/source_file_rtl.txt -f ./UVM_uart/sourcefile_uart.txt -f ./UVM_TX/sourcefile_TX.txt -f ./UVM_SYNC/sourcefile_SYNC.txt \
-f ./UVM_FIFO/sourcefile_FIFO.txt -f ./UVM_REG_FILE/sourcefile_REG_FILE.txt -f ./UVM_TOP/sourcefile_TOP.txt  +cover \
 +define+UART_RX_assertion 

vsim -voptargs=+acc work.top +UVM_TESTNAME=sys_test1 -cover -classdebug -sv_seed 25

add wave -position insertpoint  \
sim:/top/sysif/TX_CLK_TB 
add wave -position insertpoint  \
sim:/top/sys/TX_CLK \
sim:/top/sys/RX_CLK

add wave -position insertpoint  \
sim:/top/sysif/REF_CLK \
sim:/top/sysif/RST \
sim:/top/sysif/RX_IN \
sim:/top/sysif/TX_OUT \
sim:/top/sysif/par_err_reg \
sim:/top/sysif/stp_error_reg

add wave -position insertpoint  \
sim:/top/cs_SYS_CTRL \
sim:/top/cs_UART_RX \
sim:/top/cs_UART_TX

add wave -position insertpoint  \
sim:/top/uartif/rst \
sim:/top/uartif/prescale \
sim:/top/uartif/PAR_EN \
sim:/top/uartif/PAR_TYP \
sim:/top/uartif/data_valid_reg \
sim:/top/uartif/P_DATA_reg \

add wave -position insertpoint  \
sim:/top/SYNCif/unsync_bus \
sim:/top/SYNCif/bus_enable \
sim:/top/SYNCif/sync_bus \
sim:/top/SYNCif/enable_pulse

add wave -position insertpoint  \
sim:/top/reg_fileif/ADDR \
sim:/top/reg_fileif/WrEn \
sim:/top/reg_fileif/RdEn \
sim:/top/reg_fileif/Address \
sim:/top/reg_fileif/WrData \
sim:/top/reg_fileif/RdData \
sim:/top/reg_fileif/RdData_VLD \
sim:/top/reg_fileif/REG0 \
sim:/top/reg_fileif/REG1 \
sim:/top/reg_fileif/REG2 \
sim:/top/reg_fileif/REG3

add wave -position insertpoint  \
sim:/top/FIFOif/w_clk \
sim:/top/FIFOif/r_clk \
sim:/top/FIFOif/wrst_n \
sim:/top/FIFOif/rrst_n \
sim:/top/FIFOif/winc \
sim:/top/FIFOif/rinc \
sim:/top/FIFOif/w_data \
sim:/top/FIFOif/r_data \
sim:/top/FIFOif/wfull \
sim:/top/FIFOif/rempty

add wave -position insertpoint  \
sim:/top/TXif/P_DATA \
sim:/top/TXif/Data_Valid \
sim:/top/TXif/PAR_TYP \
sim:/top/TXif/PAR_EN \
sim:/top/TXif/TX_OUT \
sim:/top/TXif/busy \

#sim:/top/TXif/Ser_Done \
#sim:/top/TXif/Ser_En \
#sim:/top/TXif/Ser_Data \
#sim:/top/TXif/Par_bit \
#sim:/top/TXif/Mux_sel

add wave /top/sys/RX/asser1/uart_func_sva /top/sys/RX/asser1/uart_parity_even_sva /top/sys/RX/asser1/uart_parity_odd_sva /top/sys/RX/asser1/stp_error_reg_check_parity_exist_sva /top/sys/RX/asser1/stp_error_reg_check_no_parity_sva

#run 0


coverage save top.ucdb -onexit -du SYS_TOP
run -all
#coverage report -output functional_coverage_rpt.txt -srcfile=* -detail -all -dump -annotate -directive -cvg
coverage report -output assertion_coverage.txt -detail -assert 
#quit -sim
#vcover report top.ucdb -details -annotate -all -output code_coverage_rpt.txt

#you can add -option to functional coverage
#you can add -classdebug in vsim command to access the classes in waveform
#you can add -uvmcontrol=all  in vsim command in case uvm
#in windows to create sourcefile.txt use dir /b > sourcefile.txt
#+UVM_TESTNAME=uart_test1 ---->option to create multiple tests



 