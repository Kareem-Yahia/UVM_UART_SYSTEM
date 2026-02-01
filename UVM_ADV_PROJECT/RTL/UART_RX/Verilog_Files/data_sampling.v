module data_sampling (clk,rst,prescale,edge_cnt,dat_sample_en,RX_IN,sampled_bit);

	input clk,rst;
	input [5:0] prescale;
	input [4:0] edge_cnt;
	input dat_sample_en,RX_IN;
	output reg sampled_bit;

	wire [4:0] No1,No2,No3; //here we define samples no
	reg s1,s2,s3; //here we define samples it_self

	assign 	No1=prescale>>1;
	assign 	No2=No1-1'b1;
	assign 	No3=No1+1'b1;
	

	// we will support oversampling by 3 only

	//here we will define 3 muxs to sample data
	always @(posedge clk or negedge rst) begin
		if(!rst)
			{s1,s2,s3}<=0;
		else begin
			if(dat_sample_en) begin
				if(edge_cnt==No1)
					s1<=RX_IN;
				
				if(edge_cnt==No2)
					s2<=RX_IN;
				
				if(edge_cnt==No3)
					s3<=RX_IN;
			end		
		end		
	end

	always @(*) begin
		case({s1,s2,s3})
			3'b000: sampled_bit=0;
			3'b001: sampled_bit=0;
			3'b010: sampled_bit=0;
			3'b011: sampled_bit=1;
			3'b100: sampled_bit=0;
			3'b101: sampled_bit=1;
			3'b110: sampled_bit=1;
			3'b111: sampled_bit=1;
			default: sampled_bit=0;
		endcase
	end
endmodule