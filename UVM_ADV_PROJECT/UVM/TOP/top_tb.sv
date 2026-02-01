module top_tb;
  
  import uvm_pkg::*;
  import global_pkg::*;
  
  `include "uvm_macros.svh"  
  `include "file_includes.svh"

  // simple clock / reset stimulus
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

   // UART RX FASTER clock
    initial begin
        clk_faster = 0;
        forever #(CLK_PERIOD/4) clk_faster = ~clk_faster;
    end 

    // Instantiating the interfaces
    sys_intf #( .DATA_WIDTH(DATA_WIDTH), .MEM_DEPTH(MEM_DEPTH) ) sys_if (.clk(clk), .clk_faster(clk_faster), .rst_n(rst_n) );
    
    intf mem_if();
    intf mem_if2();

    TX_if tx_if (); 

    uart_if rx_if ();

    AES_if #(.N(N), .Nr(Nr), .Nk(Nk)) aes_if();
   

    // Hook up UART RX signals (monitor outputs driven from DUT sub-instance)
    assign rx_if.data_valid_reg = dut_inst.uart_rx_inst.data_valid_reg;
    assign rx_if.P_DATA_reg     = dut_inst.uart_rx_inst.P_DATA_reg;
    assign rx_if.par_err_reg    = dut_inst.uart_rx_inst.par_err_reg;
    assign rx_if.stp_error_reg  = dut_inst.uart_rx_inst.stp_error_reg;

    // Drive RX stimulus/controls from DUT instance (dut_inst is authoritative)
    assign rx_if.RX_IN    = dut_inst.uart_rx_inst.RX_IN;
    assign rx_if.prescale = dut_inst.uart_rx_inst.prescale;
    assign rx_if.PAR_EN   = dut_inst.uart_rx_inst.PAR_EN;
    assign rx_if.PAR_TYP  = dut_inst.uart_rx_inst.PAR_TYP;
    assign rx_if.rst      = dut_inst.uart_rx_inst.rst;
    assign rx_if.clk      = dut_inst.uart_rx_inst.clk;

    // Hook up UART TX monitor (observe DUT TX outputs from instance)
    assign tx_if.TX_OUT    = dut_inst.UART_TX_inst.TX_OUT;
    assign tx_if.busy      = dut_inst.UART_TX_inst.busy;
    assign tx_if.PAR_EN    = dut_inst.UART_TX_inst.PAR_EN;
    assign tx_if.PAR_TYP   = dut_inst.UART_TX_inst.PAR_TYP;  
    assign tx_if.P_DATA    = dut_inst.UART_TX_inst.P_DATA;
    assign tx_if.Data_Valid= dut_inst.UART_TX_inst.Data_Valid;
    assign tx_if.rst       = dut_inst.UART_TX_inst.rst;
    assign tx_if.clk       = dut_inst.UART_TX_inst.clk;

    // AES interface: reflect DUT key and data from instance
    assign aes_if.key = dut_inst.aes_encrypt_inst.key;
    assign aes_if.in  = dut_inst.aes_encrypt_inst.in;
    assign aes_if.out = dut_inst.aes_encrypt_inst.out;

    // Memory interface: reflect memory control signals from DUT instance
  
    assign mem_if.Data_in   = dut_inst.memory1_inst.Data_in;
    assign mem_if.Address   = dut_inst.memory1_inst.Address;
    assign mem_if.write_En  = dut_inst.memory1_inst.write_En;
    assign mem_if.read_En   = dut_inst.memory1_inst.read_En;
    assign mem_if.clk       = dut_inst.memory1_inst.clk;
    assign mem_if.rst       = dut_inst.memory1_inst.rst;
    assign mem_if.Data_out  = dut_inst.memory1_inst.Data_out;
    assign mem_if.Valid_out = dut_inst.memory1_inst.Valid_out;


    // Second memory from DUT instance
    assign mem_if2.Data_in   = dut_inst.memory2_inst.Data_in;
    assign mem_if2.Address   = dut_inst.memory2_inst.Address;
    assign mem_if2.write_En  = dut_inst.memory2_inst.write_En;
    assign mem_if2.read_En   = dut_inst.memory2_inst.read_En;
    assign mem_if2.clk       = dut_inst.memory2_inst.clk;
    assign mem_if2.rst       = dut_inst.memory2_inst.rst_n;
    assign mem_if2.Data_out  = dut_inst.memory2_inst.Data_out;
    assign mem_if2.Valid_out = dut_inst.memory2_inst.Valid_out;

    // Instaniating the DUT

    System_Wrapper #(
        .DATA_WIDTH(DATA_WIDTH),
        .MEM_DEPTH(MEM_DEPTH)
    ) dut_inst (
    .clk                   (clk),
    .clk_faster           (clk_faster),
    .rst_n                 (rst_n),
    .mux1_sel              (sys_if.mux1_sel),
    .mux2_sel              (sys_if.mux2_sel),
    .mem1_wr_en            (sys_if.mem1_wr_en),
    .mem2_wr_en            (sys_if.mem2_wr_en),
    .mem1_rd_en            (sys_if.mem1_rd_en),
    .mem2_rd_en            (sys_if.mem2_rd_en),
    .mem1_addr             (sys_if.mem1_addr),
    .mem2_addr             (sys_if.mem2_addr),
    .mem1_data_in          (sys_if.mem1_data_in),
    .mem2_data_in          (sys_if.mem2_data_in),
    .key                   (sys_if.key),
    .parity_en             (sys_if.parity_en),
    .parity_type           (sys_if.parity_type),
    .RX_IN                 (sys_if.RX_IN),
    .prescale              (sys_if.prescale),
    .uart_rx_data_valid    (sys_if.uart_rx_data_valid),
    .uart_rx_P_DATA_reg    (sys_if.uart_rx_P_DATA_reg),
    .uart_rx_par_err       (sys_if.uart_rx_par_err),
    .uart_rx_stp_error     (sys_if.uart_rx_stp_error),
    .uart_tx_out           (sys_if.uart_tx_out),
    .uart_tx_busy          (sys_if.uart_tx_busy)
    );
  
  initial begin
    
    uvm_config_db#(virtual sys_intf)::set(null, "uvm_test_top", "sys_if", sys_if);
    uvm_config_db#(virtual intf)::set(null, "uvm_test_top", "mem_if", mem_if);
    uvm_config_db#(virtual intf)::set(null, "uvm_test_top", "mem_if2", mem_if2);
    uvm_config_db#(virtual TX_if)::set(null, "uvm_test_top", "tx_if", tx_if);
    uvm_config_db#(virtual uart_if)::set(null, "uvm_test_top", "rx_if", rx_if);
    uvm_config_db#(virtual AES_if)::set(null, "uvm_test_top", "aes_if", aes_if);

    run_test("smoke_test");
  end
  


endmodule