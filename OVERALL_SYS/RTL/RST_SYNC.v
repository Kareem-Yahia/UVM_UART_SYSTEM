module RST_SYNC(RST,CLK,SYNC_RST);

	parameter NUM_STAGES=3;

	input RST,CLK;
	output  SYNC_RST;

	reg  [NUM_STAGES-1:0] stages;

	always @(posedge CLK or negedge RST) begin
		if(!RST) begin
			stages<=0;
		end
		else begin
			stages<={stages[NUM_STAGES-2:0],1'b1};
		end
	end

	assign SYNC_RST=stages[NUM_STAGES-1];

endmodule