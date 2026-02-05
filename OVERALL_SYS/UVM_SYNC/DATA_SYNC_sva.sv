module DATA_SYNC_sva(unsync_bus,bus_enable,clk,rst,sync_bus,enable_pulse);
	
	parameter NUM_STAGES=2;
	parameter BUS_WIDTH= 8;
	
	input clk,rst;
	input [BUS_WIDTH-1:0]unsync_bus;
	input bus_enable;
	input  [BUS_WIDTH-1:0] sync_bus;
	input  enable_pulse;


	always_comb begin
		if(!rst) begin
			check_async_reset: assert final ( sync_bus==0 && enable_pulse==0);
		end
	end

	property check_func_async ;
		@(posedge clk) $rose (bus_enable) |-> ##3  (enable_pulse &&  sync_bus == $past(unsync_bus,3));
	endproperty 


		
		check_func_async_sva: assert property (check_func_async);

		check_func_async_cov: cover property (check_func_async);
		
endmodule