module DATA_SYNC(unsync_bus,bus_enable,clk,rst,sync_bus,enable_pulse);
	
	parameter NUM_STAGES=2;
	parameter BUS_WIDTH= 8;

	input clk,rst;
	input [BUS_WIDTH-1:0]unsync_bus;
	input bus_enable;
	output reg [BUS_WIDTH-1:0] sync_bus;
	output reg enable_pulse;

	wire internal_enable;
	wire internal_out_of_synchronizer;

	///////////////////////////////////////////////
	always @(posedge clk or negedge rst) begin
		if(!rst) begin
			sync_bus<=0;
			enable_pulse<=0;
		end
		else begin
			enable_pulse<=internal_enable;
			
			if(internal_enable)
			sync_bus<=unsync_bus;
		end
	end

	///////// synchronizer//////////////////
	BIT_SYNC  #(.N(NUM_STAGES)) sync (clk,rst,bus_enable,internal_out_of_synchronizer);
	Pulse_Gen  Pulse_Gen1(clk,rst,internal_out_of_synchronizer,internal_enable);


endmodule