
class sys_seq_item_mem extends uvm_sequence_item;

    // Add sequence item fields here
   // logic                               clk,
   // logic                               clk_faster,
     // Control / selects
    rand logic                               rst_n;
    rand logic                               mux1_sel;
    rand logic                               mux2_sel;
    
    rand logic                               mem1_wr_en;
    rand logic                               mem1_rd_en;
    
    rand logic                               mem2_rd_en;
    rand logic                               mem2_wr_en;

    rand logic       [ADDR_WIDTH-1:0]        mem1_addr;
    rand logic       [ADDR_WIDTH-1:0]        mem2_addr;

    rand logic       [DATA_WIDTH-1:0]        mem1_data_in;
    rand logic       [DATA_WIDTH-1:0]        mem2_data_in;
    rand logic       [127:0]                 key;
    rand logic                               parity_en;
    rand logic                               parity_type;
    // UART RX ports
    rand logic                               RX_IN;
    rand logic       [5:0]                   prescale;

    // ---> outputs

    logic                               uart_rx_data_valid;
    logic       [7:0]                   uart_rx_P_DATA_reg;
    logic                               uart_rx_par_err;
    logic                               uart_rx_stp_error;
    // UART TX ports
    logic                               uart_tx_out;
    logic                               uart_tx_busy;   
    // Memory output monitoring
    logic       [DATA_WIDTH-1:0]        mem1_data_out;
    logic                               mem1_valid_out;
    
    logic       [DATA_WIDTH-1:0]        mem2_data_out;
    logic                               mem2_valid_out;

    `uvm_object_utils_begin(sys_seq_item_mem)
         // Control / selects
        `uvm_field_int(rst_n , UVM_DEFAULT)
        `uvm_field_int(mux1_sel , UVM_DEFAULT)
        `uvm_field_int(mux2_sel , UVM_DEFAULT)
        `uvm_field_int(mem1_wr_en , UVM_DEFAULT)
        `uvm_field_int(mem2_wr_en , UVM_DEFAULT)
        `uvm_field_int(mem1_rd_en , UVM_DEFAULT)
        `uvm_field_int(mem2_rd_en , UVM_DEFAULT)
        `uvm_field_int(mem1_addr , UVM_DEFAULT)
        `uvm_field_int(mem2_addr , UVM_DEFAULT)
        `uvm_field_int(mem1_data_in , UVM_DEFAULT)
        `uvm_field_int(mem2_data_in , UVM_DEFAULT)
        `uvm_field_int(key , UVM_DEFAULT)
        `uvm_field_int(parity_en , UVM_DEFAULT)
        `uvm_field_int(parity_type , UVM_DEFAULT)
        `uvm_field_int(RX_IN , UVM_DEFAULT)
        `uvm_field_int(prescale , UVM_DEFAULT)
        // UART RX ports
        `uvm_field_int(uart_rx_data_valid , UVM_DEFAULT)
        `uvm_field_int(uart_rx_P_DATA_reg , UVM_DEFAULT)
        `uvm_field_int(uart_rx_par_err , UVM_DEFAULT)
        `uvm_field_int(uart_rx_stp_error , UVM_DEFAULT)
        // UART TX ports
        `uvm_field_int(uart_tx_out , UVM_DEFAULT)
        `uvm_field_int(uart_tx_busy , UVM_DEFAULT)
        // Memory output monitoring
        `uvm_field_int(mem1_data_out , UVM_DEFAULT)
        `uvm_field_int(mem1_valid_out , UVM_DEFAULT)
        `uvm_field_int(mem2_data_out , UVM_DEFAULT)
        `uvm_field_int(mem2_valid_out , UVM_DEFAULT)
    `uvm_object_utils_end


  function new (string name ="sys_seq_item_mem");
    super.new(name);
  endfunction


   function string convert2string();
        return $sformatf("rst_n=%0b, mux1_sel=%0b, mux2_sel=%0b, mem1_wr_en=%0b, mem2_wr_en=%0b, mem1_rd_en=%0b, mem2_rd_en=%0b, mem1_addr=%0h, mem2_addr=%0h, mem1_data_in=%0h, mem2_data_in=%0h, key=%0h, parity_en=%0b, parity_type=%0b, RX_IN=%0b, prescale=%0h, uart_rx_data_valid=%0b, uart_rx_P_DATA_reg=%0h, uart_rx_par_err=%0b, uart_rx_stp_error=%0b, uart_tx_out=%0b, uart_tx_busy=%0b, mem1_data_out=%0h, mem1_valid_out=%0b, mem2_data_out=%0h, mem2_valid_out=%0b",
            rst_n, mux1_sel, mux2_sel, mem1_wr_en, mem2_wr_en, mem1_rd_en, mem2_rd_en,
            mem1_addr, mem2_addr, mem1_data_in, mem2_data_in,
            key, parity_en, parity_type,
            RX_IN, prescale,
            uart_rx_data_valid, uart_rx_P_DATA_reg,
            uart_rx_par_err, uart_rx_stp_error,
            uart_tx_out, uart_tx_busy,
            mem1_data_out, mem1_valid_out,
            mem2_data_out, mem2_valid_out);
    endfunction 

    constraint addr_range_c { 
        mem1_addr < MEM_DEPTH;
        mem2_addr < MEM_DEPTH;
    }
    
endclass