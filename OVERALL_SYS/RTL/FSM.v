module FSM (clk,rst,system_outputs_flag,edge_cnt_flag,RX_IN,PAR_EN,bit_cnt
	,par_err,strt_glitch,stp_error,enable,dat_sample_en,deser_en,data_valid,par_chk_en,strt_chk_en,stp_chk_en,new_op_flag);

	localparam IDLE=0;
	localparam START=1;
	localparam DATA=2;
	localparam PARITY=3;
	localparam STOP=4;

	input clk,rst;
	input RX_IN;
	input PAR_EN;
	input edge_cnt_flag;
	input system_outputs_flag;

	input par_err,strt_glitch,stp_error;

	input [3:0] bit_cnt;

	output reg  enable,dat_sample_en,deser_en,data_valid,par_chk_en,strt_chk_en,stp_chk_en; 
	output reg new_op_flag;

	reg [2:0] cs,ns;

	//next state logic 

	always @(*) begin
		case(cs)
			IDLE: begin
				if(!RX_IN)
					ns=START;
				else
					ns=IDLE;	
			end

			START: begin
				if(strt_glitch && edge_cnt_flag )
					ns=IDLE;
				else if( edge_cnt_flag) // remember to edit constants 
					ns=DATA;
				else
					ns=START;		
			end

			DATA: begin
				if(  edge_cnt_flag && bit_cnt==8 && PAR_EN )
					ns=PARITY;
				else if (edge_cnt_flag && bit_cnt==8 &&  (!PAR_EN))
					ns=STOP;
				else
					ns=DATA;	
			end

			PARITY: begin
				if(par_err && system_outputs_flag)
					ns=IDLE;
				else if(edge_cnt_flag )
					ns=STOP;
				else
					ns=PARITY;	
			end

			STOP: begin
				if(stp_error && system_outputs_flag)
					ns=IDLE;
				else if (RX_IN && edge_cnt_flag )
					ns=IDLE;
				else if (!RX_IN && edge_cnt_flag )
					ns=START;	
				else
					ns=STOP;	
			end

			default: begin
				ns=IDLE;
			end
		endcase	
	end

	// STATE MEMORY

	always @(posedge clk or negedge rst) begin
		if(!rst)
			cs<=0;
		else
			cs<=ns;	
	end

	//output logic

	always @(*) begin

				enable=1'b0;
				dat_sample_en=1'b0;
				deser_en=1'b0;
				data_valid=1'b0;
				par_chk_en=1'b0;
				strt_chk_en=1'b0;
				stp_chk_en=1'b0;
				new_op_flag=1'b0;

		case(cs)
			IDLE: begin
				enable=1'b0;
				dat_sample_en=1'b0;
				deser_en=1'b0;
				data_valid=1'b0;
				par_chk_en=1'b0;
				strt_chk_en=1'b0;
				stp_chk_en=1'b0;
				new_op_flag=1'b0;
			end

			START: begin
				enable=1'b1;
				dat_sample_en=1'b1;
				deser_en=1'b0;
				data_valid=1'b0;
				par_chk_en=1'b0;

				if( edge_cnt_flag)
					strt_chk_en=1'b1;
				else
					strt_chk_en=1'b0;

				stp_chk_en=1'b0;
				new_op_flag=1'b1;
			end

			DATA: begin
				enable=1'b1;
				dat_sample_en=1'b1;

				if( edge_cnt_flag)
					deser_en=1'b1;
				else
					deser_en=1'b0;

				data_valid=1'b0;
				par_chk_en=1'b0;
				strt_chk_en=1'b0;
				stp_chk_en=1'b0;
				new_op_flag=1'b0;
			end

			PARITY: begin
				enable=1'b1;
				dat_sample_en=1'b1;
				deser_en=1'b0; 
				data_valid=1'b0;

				if( system_outputs_flag)
					par_chk_en=1'b1;
				else
					par_chk_en=1'b0;

				strt_chk_en=1'b0;
				stp_chk_en=1'b0;
				new_op_flag=1'b0;
			end

			STOP: begin
				enable=1'b1;
				dat_sample_en=1'b1;
				deser_en=1'b0;

				par_chk_en=1'b0;
				strt_chk_en=1'b0;

				if( system_outputs_flag)
					stp_chk_en=1'b1;
				else
					stp_chk_en=1'b0;
				//////////////////////////////// note here ///////////////////////////////////////////
				if( !stp_error && system_outputs_flag)
					data_valid=1'b1;
				else
					data_valid=1'b0;	

				new_op_flag=1'b0;	
			end

			default: begin
				enable=1'b0;
				dat_sample_en=1'b0;
				deser_en=1'b0;
				data_valid=1'b0;
				par_chk_en=1'b0;
				strt_chk_en=1'b0;
				stp_chk_en=1'b0;
				new_op_flag=1'b0;
			end
		endcase	
	end

	///////////////////////////////// ******************************************//////////////////////////////	
	
endmodule