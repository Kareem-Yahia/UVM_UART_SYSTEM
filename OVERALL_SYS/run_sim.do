vlib work

vlog -f ./RTL/source_file_rtl.txt  +cover 

vlog global_pkg.sv +cover 

vlog  ./UVM_TOP/top.sv  \
+incdir+RTL  \
+incdir+UVM_FIFO \
+incdir+UVM_REG_FILE \
+incdir+UVM_SYNC \
+incdir+UVM_TOP \
+incdir+UVM_TX \
+incdir+UVM_uart \
+cover \
+define+UART_RX_assertion \
+define+DATA_SYNC_sva  +define+UVM_REPORT_DISABLE_FILE_LINE


vsim -voptargs=+acc work.top +UVM_TESTNAME=sys_smoke_test -cover -classdebug -sv_seed 25 -l transcript.log

set NoQuitOnFinish 1


#run 0

do wave.do


#coverage save top.ucdb -onexit -du SYS_TOP
run -all
#coverage report -output functional_coverage_rpt.txt -srcfile=* -detail -all -dump -annotate -directive -cvg
#coverage report -output assertion_coverage.txt -detail -assert 
#quit -sim
#vcover report top.ucdb -details -annotate -all -output code_coverage_rpt.txt

#you can add -option to functional coverage
#you can add -classdebug in vsim command to access the classes in waveform
#you can add -uvmcontrol=all  in vsim command in case uvm
#in windows to create sourcefile.txt use dir /b > sourcefile.txt
#+UVM_TESTNAME=uart_test1 ---->option to create multiple tests



 