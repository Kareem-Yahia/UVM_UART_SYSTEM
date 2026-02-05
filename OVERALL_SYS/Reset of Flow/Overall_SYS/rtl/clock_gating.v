module clock_gating(CLK_EN,CLK,GATED_CLK);
	
	input CLK_EN;
	input CLK;
	output GATED_CLK;

	/*reg CLK_EN_internal;

	always @(*) begin
		if(~CLK)
		CLK_EN_internal<=CLK_EN;
	end

	assign GATED_CLK=CLK_EN_internal & CLK;*/

	TLATNCAX3M gating (.E(CLK_EN),.CK(CLK),.ECK(GATED_CLK));

endmodule
