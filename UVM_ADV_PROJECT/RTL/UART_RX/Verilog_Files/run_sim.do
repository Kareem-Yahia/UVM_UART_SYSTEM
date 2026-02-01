vlib work
vlog -f sourcefile.txt +cover
vsim -voptargs=+acc work.UART_RX_TB -cover
run 0
add wave -position insertpoint  \
sim:/UART_RX_TB/t
add wave *
add wave -position insertpoint  \
sim:/UART_RX_TB/u1/deser/deser_en \
sim:/UART_RX_TB/u1/deser/sampled_bit
add wave -position insertpoint  \
sim:/UART_RX_TB/u1/edg_cnt/edge_cnt \
sim:/UART_RX_TB/u1/edg_cnt/bit_cnt \
sim:/UART_RX_TB/u1/edg_cnt/edge_cnt_flag
add wave -position insertpoint  \
sim:/UART_RX_TB/u1/ds/sampled_bit

add wave -position insertpoint  \
sim:/UART_RX_TB/u1/ds/s1 \
sim:/UART_RX_TB/u1/ds/s2 \
sim:/UART_RX_TB/u1/ds/s3
add wave -position insertpoint  \
sim:/UART_RX_TB/u1/ds/dat_sample_en

add wave -position insertpoint  \
sim:/UART_RX_TB/u1/strt_glitch

add wave -position insertpoint  \
sim:/UART_RX_TB/u1/edg_cnt/bit_cnt_flag

add wave -position insertpoint  \
sim:/UART_RX_TB/u1/edg_cnt/prescale_sampled

add wave -position insertpoint  \
sim:/UART_RX_TB/send_specific_frame/frame_t



#coverage save UART_RX_TB.ucdb -onexit -du UART_RX
run -all
#coverage report -output functional_coverage_rpt.txt -srcfile=* -detail -all -dump -annotate -directive -cvg
#coverage report -output assertion_coverage.txt -detail -assert 
#quit -sim
#vcover report alu_seq_tb.ucdb -details -annotate -all -output code_coverage_rpt.txt

#you can add -option to functional coverage
#you can add -classdebug in vsim command to access the classes in waveform

 