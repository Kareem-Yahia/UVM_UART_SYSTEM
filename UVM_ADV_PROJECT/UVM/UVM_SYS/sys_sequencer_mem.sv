class sys_sequencer_mem extends uvm_sequencer #(sys_seq_item_mem);

    `uvm_component_utils(sys_sequencer_mem)

    function new (string name = "sys_sequencer_mem", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
    endtask

    
endclass