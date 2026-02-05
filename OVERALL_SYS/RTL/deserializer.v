module deserializer (clk,rst,new_op_flag,deser_en,sampled_bit,P_DATA);

	input clk,rst;
	input new_op_flag;
	input deser_en,sampled_bit;
	output reg [7:0] P_DATA;

	//we should sample by bit_cnt

	always @(posedge clk or negedge rst) begin
		if(!rst)
			P_DATA<=0;
		else begin
			if(new_op_flag)
				P_DATA<=0;
			else begin
				if(deser_en) begin  //here we should shift >>
					P_DATA<={sampled_bit,P_DATA[7:1]};
				end
			end	
		end	
	end
endmodule