vlib work
vlog -f ./RTL/source_file_rtl.txt -f ./UVM_uart/sourcefile_uart.txt -f ./UVM_TX/sourcefile_TX.txt -f ./UVM_SYNC/sourcefile_SYNC.txt \
-f ./UVM_FIFO/sourcefile_FIFO.txt -f ./UVM_REG_FILE/sourcefile_REG_FILE.txt -f ./UVM_TOP/sourcefile_TOP.txt global_pkg.sv  +cover \
 +define+UART_RX_assertion+DATA_SYNC_sva 

vsim -voptargs=+acc work.top +UVM_TESTNAME=sys_smoke_test -cover -classdebug -sv_seed 25 -l transcript.log

#run 0

do wave.do


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



 