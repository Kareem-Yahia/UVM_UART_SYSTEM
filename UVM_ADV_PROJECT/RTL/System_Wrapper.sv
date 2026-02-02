module System_Wrapper #(
    parameter  DATA_WIDTH = 32,
    parameter  MEM_DEPTH  = 64,
    localparam ADDR_WIDTH = $clog2(MEM_DEPTH)
) (
    input       logic                               clk,
    input       logic                               clk_faster,
     // Control / selects
    input       logic                               rst_n,
    input       logic                               mux1_sel,
    input       logic                               mux2_sel,
    input       logic                               mem1_wr_en,
    input       logic                               mem2_wr_en,
    input       logic                               mem1_rd_en,
    input       logic                               mem2_rd_en,
    input       logic       [ADDR_WIDTH-1:0]        mem1_addr,
    input       logic       [ADDR_WIDTH-1:0]        mem2_addr,
    input       logic       [DATA_WIDTH-1:0]        mem1_data_in,
    input       logic       [DATA_WIDTH-1:0]        mem2_data_in,
    input       logic       [127:0]                 key,
    input       logic                               parity_en,
    input       logic                               parity_type,
    // UART RX ports
    input       logic                               RX_IN,
    input       logic       [5:0]                   prescale,
    output      logic                               uart_rx_data_valid,
    output      logic       [7:0]                   uart_rx_P_DATA_reg,
    output      logic                               uart_rx_par_err,
    output      logic                               uart_rx_stp_error,
    // UART TX ports
    output      logic                               uart_tx_out,
    output      logic                               uart_tx_busy,   
    // Memory output monitoring
    output     logic       [DATA_WIDTH-1:0]        mem1_data_out,
    output     logic       [DATA_WIDTH-1:0]        mem2_data_out,
    output     logic                               mem1_valid_out,
    output     logic                               mem2_valid_out
);


logic [127:0]          aes_out;
logic [DATA_WIDTH-1:0] mux1_out;
logic [DATA_WIDTH-1:0] mux2_out;
logic                  uart_tx_data_valid;


assign uart_tx_data_valid = (mux2_sel)? mem1_valid_out : mem2_valid_out;

AES_Encrypt aes_encrypt_inst (
    .in(mem1_data_out),
    .key(key),
    .out(aes_out)
);

memory #(.DATA_WIDTH(DATA_WIDTH),.MEM_DEPTH(MEM_DEPTH)) memory1_inst (
    .clk(clk),
    .rst_n(rst_n),
    .write_En(mem1_wr_en),
    .read_En(mem1_rd_en),
    .Address(mem1_addr),
    .Data_in(mux1_out),
    .Data_out(mem1_data_out),
    .Valid_out(mem1_valid_out)
);

memory #(.DATA_WIDTH(DATA_WIDTH),.MEM_DEPTH(MEM_DEPTH)) memory2_inst (
    .clk(clk),
    .rst_n(rst_n),
    .write_En(mem2_wr_en),
    .read_En(mem2_rd_en),
    .Address(mem2_addr),
    .Data_in(mem2_data_in),
    .Data_out(mem2_data_out),
    .Valid_out(mem2_valid_out)
);

Mux #(.DATA_WIDTH(DATA_WIDTH)) mux1_inst (
    .sel(mux1_sel),
    .in0(mem1_data_in),
    .in1(aes_out),
    .out(mux1_out)
);

Mux #(.DATA_WIDTH(DATA_WIDTH)) mux2_inst (
    .sel(mux2_sel),
    .in0(mem2_data_out),
    .in1(aes_out),
    .out(mux2_out)
);

UART_TX UART_TX_inst (
    .P_DATA     (mux2_out),
    .Data_Valid (uart_tx_data_valid),
    .PAR_TYP    (parity_type),
    .PAR_EN     (parity_en),
    .TX_OUT     (uart_tx_out),
    .busy       (uart_tx_busy),
    .clk        (clk),
    .rst        (rst_n)
);

UART_RX uart_rx_inst (
    .clk            (clk_faster),
    .rst            (rst_n),
    .RX_IN          (RX_IN),
    .prescale       (prescale),
    .PAR_EN         (parity_en),
    .PAR_TYP        (parity_type),
    .data_valid_reg (uart_rx_data_valid),
    .par_err_reg    (uart_rx_par_err),
    .stp_error_reg  (uart_rx_stp_error),
    .P_DATA_reg     (uart_rx_P_DATA_reg)
);

endmodule