class sys_driver_mem extends uvm_driver #(sys_seq_item_mem);

    `uvm_component_utils(sys_driver_mem)

    sys_seq_item_mem seq_item_inst;
    virtual sys_intf #(.DATA_WIDTH(DATA_WIDTH), .MEM_DEPTH(MEM_DEPTH)) sys_if;
    uvm_table_printer tprinter;


    function new (string name = "sys_driver_mem" , uvm_component parent = null);
        super.new(name , parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        seq_item_inst = sys_seq_item_mem :: type_id ::create("seq_item_inst",this);
        tprinter = new ();
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    extern task sys_driver_stimulus();


    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        sys_driver_stimulus();
    endtask

endclass


task sys_driver_mem::sys_driver_stimulus();

    forever begin
        // Get the next item from the sequencer
        seq_item_port.get_next_item(seq_item_inst);

        @(sys_if.cb);

        // Drive the DUT inputs using the sequence item data
        sys_if.cb.rst_n            <= seq_item_inst.rst_n;
        sys_if.cb.mux1_sel         <= seq_item_inst.mux1_sel;
        sys_if.cb.mux2_sel         <= seq_item_inst.mux2_sel;
        sys_if.cb.mem1_wr_en       <= seq_item_inst.mem1_wr_en;
        sys_if.cb.mem2_wr_en       <= seq_item_inst.mem2_wr_en;
        sys_if.cb.mem1_rd_en       <= seq_item_inst.mem1_rd_en;
        sys_if.cb.mem2_rd_en       <= seq_item_inst.mem2_rd_en;
        sys_if.cb.mem1_addr        <= seq_item_inst.mem1_addr;
        sys_if.cb.mem2_addr        <= seq_item_inst.mem2_addr;
        sys_if.cb.mem1_data_in     <= seq_item_inst.mem1_data_in;
        sys_if.cb.mem2_data_in     <= seq_item_inst.mem2_data_in;
        sys_if.cb.key              <= seq_item_inst.key;
        sys_if.cb.parity_en        <= seq_item_inst.parity_en;
        sys_if.cb.parity_type      <= seq_item_inst.parity_type;
        sys_if.cb.RX_IN            <= seq_item_inst.RX_IN;
        sys_if.cb.prescale         <= seq_item_inst.prescale;


        seq_item_inst.print(tprinter);

        seq_item_port.item_done();
    end
endtask