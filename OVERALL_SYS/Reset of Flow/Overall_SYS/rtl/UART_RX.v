module UART_RX (clk,rst,RX_IN,prescale,PAR_EN,PAR_TYP,data_valid_reg,par_err_reg,stp_error_reg,P_DATA_reg);

	input clk,rst;
	input RX_IN;
	input [5:0] prescale;
	input PAR_EN,PAR_TYP;
	output reg data_valid_reg;
	output reg [7:0] P_DATA_reg;
	output reg par_err_reg,stp_error_reg;

	// *************************here we will define internal wires*******************************************
	wire edge_cnt_flag;
	wire strt_glitch;
	wire [3:0] bit_cnt;
	wire enable,dat_sample_en,deser_en,par_chk_en,strt_chk_en,stp_chk_en; 
	wire sampled_bit;
	wire [4:0] edge_cnt;
	wire new_op_flag;
	wire system_outputs_flag;
	wire data_valid;
	wire [7:0] P_DATA;
	wire par_err,stp_error;





	// *******************************************************************************************************

	 FSM fsm(.clk(clk),.rst(rst),.system_outputs_flag(system_outputs_flag),.edge_cnt_flag(edge_cnt_flag),.RX_IN(RX_IN),.PAR_EN(PAR_EN),.bit_cnt(bit_cnt)
	,.par_err(par_err),.strt_glitch(strt_glitch),.stp_error(stp_error),
	.enable(enable),.dat_sample_en(dat_sample_en),.deser_en(deser_en),
	.data_valid(data_valid),.par_chk_en(par_chk_en),.strt_chk_en(strt_chk_en),.stp_chk_en(stp_chk_en),.new_op_flag(new_op_flag));

	 edge_bit_counter edg_cnt(.clk(clk),.rst(rst),.PAR_EN(PAR_EN),.enable(enable),.prescale(prescale),
	 	.edge_cnt(edge_cnt),.bit_cnt(bit_cnt),.edge_cnt_flag(edge_cnt_flag),.system_outputs_flag(system_outputs_flag));

	 deserializer  deser(.clk(clk),.rst(rst),.new_op_flag(new_op_flag),.deser_en(deser_en),.sampled_bit(sampled_bit),.P_DATA(P_DATA));

	 data_sampling ds(.clk(clk),.rst(rst),.prescale(prescale),.edge_cnt(edge_cnt),.dat_sample_en(dat_sample_en),.RX_IN(RX_IN),.sampled_bit(sampled_bit));

	 parity_check par(.parity_chk_en(par_chk_en),.PAR_TYP(PAR_TYP),.sampled_bit(sampled_bit),.P_DATA(P_DATA),.par_err(par_err));

	 strt_check strt(.strt_chk_en(strt_chk_en),.strt_glitch(strt_glitch),.sampled_bit(sampled_bit));

	 stop_check stop(.stp_chk_en(stp_chk_en),.stp_err(stp_error),.sampled_bit(sampled_bit));

	 //here we register outputs 
	 always @(posedge clk or negedge rst ) begin
	 	if(!rst) begin
	 		P_DATA_reg<=0;
	 		stp_error_reg<=0;
	 		par_err_reg<=0;
	 		data_valid_reg<=0;
	 	end
	 	else begin
	 		stp_error_reg<=stp_error;
	 		par_err_reg <= par_err;
	 		data_valid_reg<=data_valid;
	 		if(data_valid)
	 		P_DATA_reg<=P_DATA;
	 	end
	 end


endmodule