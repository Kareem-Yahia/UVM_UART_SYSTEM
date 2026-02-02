interface sys_intf #(
        parameter int DATA_WIDTH = 32,
    parameter int MEM_DEPTH  = 64,
    localparam int ADDR_WIDTH = $clog2(MEM_DEPTH)
) (
    input logic clk,
);
    
    logic rst_n ;

    // Control / selects
    logic                               mux1_sel;
    logic                               mux2_sel;

    // Memory control
    logic                               mem1_wr_en;
    logic                               mem2_wr_en;
    logic                               mem1_rd_en;
    logic                               mem2_rd_en;
    logic [ADDR_WIDTH-1:0]              mem1_addr;
    logic [ADDR_WIDTH-1:0]              mem2_addr;
    logic [DATA_WIDTH-1:0]              mem1_data_in;
    logic [DATA_WIDTH-1:0]              mem2_data_in;

    // AES key and parity
    logic [127:0]                       key;
    logic                               parity_en;
    logic                               parity_type;

    // UART RX inputs
    logic                               RX_IN;
    logic [5:0]                         prescale;

    // UART RX outputs
    logic                               uart_rx_data_valid;
    logic [7:0]                         uart_rx_P_DATA_reg;
    logic                               uart_rx_par_err;
    logic                               uart_rx_stp_error;

    // UART TX outputs
    logic                               uart_tx_out;
    logic                               uart_tx_busy;

    // Modports for DUT and Testbench
    modport dut (
        input  clk,
        input  rst_n,
        input  mux1_sel,
        input  mux2_sel,
        input  mem1_wr_en,
        input  mem2_wr_en,
        input  mem1_rd_en,
        input  mem2_rd_en,
        input  mem1_addr,
        input  mem2_addr,
        input  mem1_data_in,
        input  mem2_data_in,
        input  key,
        input  parity_en,
        input  parity_type,
        input  RX_IN,
        input  prescale,
        output uart_rx_data_valid,
        output uart_rx_P_DATA_reg,
        output uart_rx_par_err,
        output uart_rx_stp_error,
        output uart_tx_out,
        output uart_tx_busy
    );



endinterface : sys_intf