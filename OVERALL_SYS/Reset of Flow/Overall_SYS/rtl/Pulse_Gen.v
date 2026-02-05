module Pulse_Gen (clk,rst,in,out);
	
	input clk,rst;
	input in;
	output out;

	reg q;

	always @(posedge clk or negedge rst) begin
		if(!rst) begin
			q<=0;
		end
		else begin
			q<=in;
		end
	end

	assign out=(~q)&in;

endmodule