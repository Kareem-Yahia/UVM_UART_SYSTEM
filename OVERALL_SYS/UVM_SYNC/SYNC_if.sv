interface SYNC_if (REF_CLK,TX_CLK_TB);
  
  parameter NUM_STAGES=2;
  parameter BUS_WIDTH= 8;

   input TX_CLK_TB;
   input REF_CLK;
   logic rst;
   logic [BUS_WIDTH-1:0]unsync_bus;
   logic bus_enable;
   logic  [BUS_WIDTH-1:0] sync_bus;
   logic  enable_pulse;

  logic internal_enable;
  logic internal_out_of_synchronizer;

endinterface