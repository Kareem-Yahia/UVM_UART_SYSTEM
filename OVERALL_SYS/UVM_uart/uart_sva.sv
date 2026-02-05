module UART_RX_SVA (clk,rst,RX_IN,prescale,PAR_EN,PAR_TYP,data_valid_reg,par_err_reg,stp_error_reg,P_DATA_reg,edge_cnt_flag,bit_cnt);

	input clk,rst;
	input RX_IN;
	input [5:0] prescale;
	input PAR_EN,PAR_TYP;
	//DUT REAL OUTPUTS
	input   data_valid_reg;
	input   [7:0] P_DATA_reg;
	input   par_err_reg,stp_error_reg;
	input edge_cnt_flag;
	input [3:0] bit_cnt;

	//here we check_resest
	always_comb begin
		if(!rst) begin
			check_async_reset: assert final ( data_valid_reg==0 && P_DATA_reg==0  && par_err_reg==0 && stp_error_reg==0 );
		end
	end


	// here we check main functionality

	sequence delay_seq(v_delay);
      int delay;
      (1, delay = v_delay) ##1 first_match((1, delay = delay - 1) [*0:$] ##0 delay <= 0);
  	endsequence

	property uart_func;
		logic [7:0] data;
		int i;
		@(posedge clk) disable iff (!rst) ($fell(RX_IN) ##1 bit_cnt==0,i=0) |->  delay_seq(prescale - 1'd1) ##0 (delay_seq(prescale - 1'd1),data[i]=RX_IN,i++)[*8] ##1 delay_seq(prescale) ##0 (!par_err_reg && !stp_error_reg)  |->
			if (PAR_EN)
				 ##0 delay_seq(prescale) ##0 (!stp_error_reg) |-> (P_DATA_reg == data && data_valid_reg==1)
			else
				##0  (P_DATA_reg == data && data_valid_reg==1 && !par_err_reg && !stp_error_reg);
	endproperty

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/*
	property uart_func;
		logic [7:0] data;
		int i;
		@(posedge clk) disable iff (!rst) ($fell(RX_IN) ##1 bit_cnt==0,i=0) |->  delay_seq(prescale - 1'd1) ##0 (delay_seq(prescale - 1'd1),data[i]=RX_IN,i++)[*8] ##0 delay_seq(prescale)  |->
			if (PAR_EN)
				 ##0 delay_seq(prescale) ##1 (!par_err_reg && !stp_error_reg) throughout  (P_DATA_reg == data && data_valid_reg==1)
			else
				##1  (!par_err_reg && !stp_error_reg) throughout (P_DATA_reg == data && data_valid_reg==1 && !par_err_reg && !stp_error_reg);
	endproperty	
		*/

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//here we  check_parity

	property uart_parity_even;
		logic [7:0] data;
		int i;
		int parity_in;
		@(posedge clk) disable iff (!rst) ($fell(RX_IN) && PAR_EN && !PAR_TYP ##1 bit_cnt==0,i=0) |->  delay_seq(prescale - 1'd1) ##0 (delay_seq(prescale -1'd1),data[i]=RX_IN,i++)[*8] ##1 (delay_seq(prescale / 2),parity_in=RX_IN) |->
			if (parity_in != ^data)
				##0 delay_seq(prescale / 2) ##0 par_err_reg
			else
				##0 delay_seq(prescale / 2) ##0 !par_err_reg; 
	endproperty



	property uart_parity_odd;
		logic [7:0] data;
		int i;
		int parity_in;
		@(posedge clk) disable iff (!rst) ($fell(RX_IN) && PAR_EN && PAR_TYP ##1 bit_cnt==0,i=0) |->  delay_seq(prescale - 1'd1) ##0 (delay_seq(prescale -1'd1),data[i]=RX_IN,i++)[*8] ##1 (delay_seq(prescale / 2),parity_in=RX_IN) |->
			if (parity_in != (~^data))
				##0 delay_seq(prescale / 2 ) ##0 par_err_reg
			else
				##0 delay_seq(prescale / 2 ) ##0 !par_err_reg; 
	endproperty	

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	

	//here we check stop flag

	property stp_error_reg_check_parity_exist;
		
		@(posedge clk) disable iff (!rst) ($fell(RX_IN) && PAR_EN ##1 bit_cnt==0) |->  ##0 delay_seq(prescale - 1'd1)  ##0 delay_seq(9 * prescale) ##0 delay_seq(prescale / 2) |->
			if (RX_IN)
				 ##0 delay_seq(prescale / 2 ) ##0 !stp_error_reg
			else
				 ##0 delay_seq(prescale / 2 ) ##0 stp_error_reg; 
	endproperty

	property stp_error_reg_check_no_parity;

		@(posedge clk) disable iff (!rst) ($fell(RX_IN) && !PAR_EN ##1 bit_cnt==0) |->  ##0 delay_seq(prescale - 1'd1)  ##0 delay_seq(8 * prescale) ##0 delay_seq(prescale / 2) |->
			if (RX_IN)
				 ##0 delay_seq(prescale / 2 ) ##0 !stp_error_reg
			else
				 ##0 delay_seq(prescale / 2 ) ##0 stp_error_reg; 
	endproperty

		// remember to add corner case when parity error happen then stop error the assertion will continue

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	uart_func_sva : assert property (uart_func);
	uart_parity_even_sva : assert property (uart_parity_even);
	uart_parity_odd_sva : assert property (uart_parity_odd);
	stp_error_reg_check_parity_exist_sva : assert property (stp_error_reg_check_parity_exist);
	stp_error_reg_check_no_parity_sva : assert property (stp_error_reg_check_no_parity);

	uart_func_cov : cover property (uart_func);
	uart_parity_even_cov : cover property (uart_parity_even);
	uart_parity_odd_cov : cover property (uart_parity_odd);
	stp_error_reg_check_parity_exist_cov : cover property (stp_error_reg_check_parity_exist);
	stp_error_reg_check_no_parity_cov : cover property (stp_error_reg_check_no_parity);


endmodule