package global_pkg;  

  // Global parameters
    parameter int CLK_PERIOD = 20;
 // Parameters matching System_Wrapper defaults
    localparam int DATA_WIDTH = 32;
    localparam int MEM_DEPTH  = 64;
    localparam int ADDR_WIDTH = $clog2(MEM_DEPTH);

  /// AES parameters
    parameter N  = 128;
    parameter Nr = 10;
    parameter Nk = 4;
    localparam TESTS = 1000;
    logic                                  clk;
    logic                           clk_faster;


endpackage : global_pkg