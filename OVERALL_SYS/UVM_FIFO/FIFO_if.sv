interface FIFO_if (TX_CLK_TB);
  
  
   parameter FIFO_DEPTH=8;
  parameter DATA_WIDTH=8;
  parameter N=2;//for synchronizer
  localparam POINTER_WIDTH= $clog2(FIFO_DEPTH)+1;

   input TX_CLK_TB;

  logic w_clk,r_clk;
  logic wrst_n,rrst_n;

  logic winc,rinc;
  logic [DATA_WIDTH-1:0] w_data;

  logic  [DATA_WIDTH-1:0] r_data;
  logic  wfull,rempty;

endinterface