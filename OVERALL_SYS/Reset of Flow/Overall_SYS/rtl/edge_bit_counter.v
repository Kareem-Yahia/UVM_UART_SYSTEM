module edge_bit_counter(clk,rst,PAR_EN,enable,prescale,edge_cnt,bit_cnt,edge_cnt_flag,system_outputs_flag);

	input clk,rst;
	input enable;
	input PAR_EN;
	input [5:0] prescale;
	output reg [4:0] edge_cnt;  // support up t0 32 prescale 
	output reg [3:0] bit_cnt;
	output edge_cnt_flag;
	output system_outputs_flag;

	reg bit_cnt_flag;
	reg  [5:0] prescale_sampled;

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//here we define edge_cnt

	always @(posedge clk or negedge rst) begin
		if(!rst)
			edge_cnt<=0;
		else begin
			if(enable) begin
				edge_cnt<=edge_cnt+1'b1;
				if(edge_cnt_flag)
				edge_cnt<=0;
			end
			else
				edge_cnt<=0;
		end	

	end


	//here we define bit_cnt
	always @(posedge clk or negedge rst) begin
		if(!rst)
			bit_cnt<=0;
		else begin
			if(enable) begin
				if(bit_cnt_flag && edge_cnt_flag ) 
					bit_cnt<=0;
				else if(edge_cnt_flag)
					bit_cnt<=bit_cnt+1'b1;
			end		
			else
					bit_cnt<=0;					
		end			
	end
	/***************************************************************************************************/
	//corner case when switching from prescale to another edge cnt flag change so frame becomes wrong
	//possible solution is to sample pre_scale

	always @(posedge clk or negedge rst ) begin
		if(!rst)
			prescale_sampled<=0;
		else begin
			if(bit_cnt==0)
				prescale_sampled<= prescale;
		end	
	end

	///////////////////here we define flag for bit_cnt &&edge_cnt/////////////////

	always @(posedge clk or negedge rst) begin
		if(!rst)
			bit_cnt_flag<=0;
		else begin
			if(PAR_EN) begin
				if(bit_cnt==10)
					bit_cnt_flag<=1;
				else
					bit_cnt_flag<=0;	
			end
			else begin
				if(bit_cnt==9)
					bit_cnt_flag<=1;
				else
					bit_cnt_flag<=0;	
			end
		end	
	end

	assign edge_cnt_flag=(edge_cnt==(prescale_sampled-1'b1));
	assign system_outputs_flag=(edge_cnt==(prescale_sampled-'d2));

	
endmodule