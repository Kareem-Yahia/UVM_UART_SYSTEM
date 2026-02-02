//interface
/////////////////////////////////
interface intf(input logic clk);
  
  parameter  DATA_WIDTH = 32 ;
  parameter  MEM_DEPTH  = 64 ;
  localparam ADDR_WIDTH = $clog2(MEM_DEPTH) ;

  logic rst_n;
  logic write_En;
  logic read_En;
  logic [ADDR_WIDTH-1:0] Address;
  logic [DATA_WIDTH-1:0] Data_in;
  logic [DATA_WIDTH-1:0] Data_out;
  logic Valid_out;


endinterface