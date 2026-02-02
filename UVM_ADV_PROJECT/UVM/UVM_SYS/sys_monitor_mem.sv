
class sys_monitor_mem extends uvm_monitor;

    `uvm_component_utils(sys_monitor_mem)

    sys_seq_item_mem seq_item_inst;

    virtual sys_intf #(.DATA_WIDTH(DATA_WIDTH), .MEM_DEPTH(MEM_DEPTH)) sys_if;

    uvm_analysis_port #(sys_seq_item_mem) sys_monitor_ap;


    function new (string name = "sys_monitor_mem", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        seq_item_inst = sys_seq_item_mem :: type_id ::create("seq_item_inst",this);
        sys_monitor_ap = new ("sys_monitor_ap",this) ;

    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
    endfunction  

    extern task sys_monitor_stimulus();

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        sys_monitor_stimulus();
    endtask     


endclass

task sys_monitor_mem::sys_monitor_stimulus();

    forever begin
        @(sys_if.cb);

        // capture dut inputs into the sequence item
        seq_item_inst.rst_n            = sys_if.cb.rst_n;
        seq_item_inst.mux1_sel         = sys_if.cb.mux1_sel;
        seq_item_inst.mux2_sel         = sys_if.cb.mux2_sel;
        seq_item_inst.mem1_wr_en       = sys_if.cb.mem1_wr_en;
        seq_item_inst.mem2_wr_en       = sys_if.cb.mem2_wr_en;
        seq_item_inst.mem1_rd_en       = sys_if.cb.mem1_rd_en;
        seq_item_inst.mem2_rd_en       = sys_if.cb.mem2_rd_en;
        seq_item_inst.mem1_addr        = sys_if.cb.mem1_addr;
        seq_item_inst.mem2_addr        = sys_if.cb.mem2_addr;
        seq_item_inst.mem1_data_in     = sys_if.cb.mem1_data_in;
        seq_item_inst.mem2_data_in     = sys_if.cb.mem2_data_in;
        seq_item_inst.key              = sys_if.cb.key;
        seq_item_inst.parity_en        = sys_if.cb.parity_en;
        seq_item_inst.parity_type      = sys_if.cb.parity_type;
        seq_item_inst.RX_IN            = sys_if.cb.RX_IN;
        seq_item_inst.prescale         = sys_if.cb.prescale;
        seq_item_inst.uart_rx_data_valid = sys_if.cb.uart_rx_data_valid;
        seq_item_inst.uart_rx_P_DATA_reg = sys_if.cb.uart_rx_P_DATA_reg;
        seq_item_inst.uart_rx_par_err   = sys_if.cb.uart_rx_par_err;
        seq_item_inst.uart_rx_stp_error = sys_if.cb.uart_rx_stp_error;
        seq_item_inst.uart_tx_out       = sys_if.cb.uart_tx_out;
        seq_item_inst.uart_tx_busy      = sys_if.cb.uart_tx_busy;

        // Capture the DUT outputs into the sequence item
        seq_item_inst.mem1_data_out       = sys_if.cb.mem1_data_out;
        seq_item_inst.mem1_valid_out      = sys_if.cb.mem1_valid_out;
        seq_item_inst.mem2_data_out       = sys_if.cb.mem2_data_out;
        seq_item_inst.mem2_valid_out      = sys_if.cb.mem2_valid_out;

        // Send the sequence item to the analysis port
        sys_monitor_ap.write(seq_item_inst);
    end

endtask