vlib work

vlog -f RTL_FILES.list +cover

vlog D:/ASU/Digital_IC_STUDY/Sherif_Hosney/Assignemnts/Advanced/Project/UVM_ADV_PROJECT/UVM_ADV_PROJECT/UVM/GLOBAL_PACKAGES/global_pkg.sv +cover

vlog D:/ASU/Digital_IC_STUDY/Sherif_Hosney/Assignemnts/Advanced/Project/UVM_ADV_PROJECT/UVM_ADV_PROJECT/UVM/INTERFACES/*

vlog D:/ASU/Digital_IC_STUDY/Sherif_Hosney/Assignemnts/Advanced/Project/UVM_ADV_PROJECT/UVM_ADV_PROJECT/UVM/TOP/top_tb.sv \
+incdir+D:/ASU/Digital_IC_STUDY/Sherif_Hosney/Assignemnts/Advanced/Project/UVM_ADV_PROJECT/UVM_ADV_PROJECT/UVM/UVM_UART_TX \
+incdir+D:/ASU/Digital_IC_STUDY/Sherif_Hosney/Assignemnts/Advanced/Project/UVM_ADV_PROJECT/UVM_ADV_PROJECT/UVM/UVM_UART_RX \
+incdir+D:/ASU/Digital_IC_STUDY/Sherif_Hosney/Assignemnts/Advanced/Project/UVM_ADV_PROJECT/UVM_ADV_PROJECT/UVM/UVM_MEMORY \
+incdir+D:/ASU/Digital_IC_STUDY/Sherif_Hosney/Assignemnts/Advanced/Project/UVM_ADV_PROJECT/UVM_ADV_PROJECT/UVM/UVM_AES \
+incdir+D:/ASU/Digital_IC_STUDY/Sherif_Hosney/Assignemnts/Advanced/Project/UVM_ADV_PROJECT/UVM_ADV_PROJECT/UVM/TOP \
+incdir+D:/ASU/Digital_IC_STUDY/Sherif_Hosney/Assignemnts/Advanced/Project/UVM_ADV_PROJECT/UVM_ADV_PROJECT/UVM/INTERFACES \
+incdir+D:/ASU/Digital_IC_STUDY/Sherif_Hosney/Assignemnts/Advanced/Project/UVM_ADV_PROJECT/UVM_ADV_PROJECT/UVM/GLOBAL_PACKAGES \
+incdir+D:/ASU/Digital_IC_STUDY/Sherif_Hosney/Assignemnts/Advanced/Project/UVM_ADV_PROJECT/UVM_ADV_PROJECT/UVM/CONFIGURATIONS \
+incdir+D:/ASU/Digital_IC_STUDY/Sherif_Hosney/Assignemnts/Advanced/Project/UVM_ADV_PROJECT/UVM_ADV_PROJECT/UVM \
+cover +define+UVM_REPORT_DISABLE_FILE


vsim -voptargs="+acc" work.top_tb -cover -classdebug -uvmcontrol=all +UVM_TESTNAME=sys_smoke_test 

#coverage save SPI_Wrapper_tb.ucdb -onexit -du SPI_Wrapper

#add wave *

do wave.do

run -all
coverage report -output assertion_coverage.txt -detail -assert 
coverage report -output functional_coverage_rpt.txt -srcfile=* -detail -all -dump -annotate -directive -cvg

#quit -sim

#vcover report SPI_Wrapper_tb.ucdb -details -annotate -all -output code_coverage_rpt.txt