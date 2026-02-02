class top_env_virtual_sequencer extends uvm_sequencer ; 

    `uvm_component_utils(top_env_virtual_sequencer)

    sys_env_virtual_sequencer sys_env_virtual_sequencer_inst;

    function new (string name = "top_env_virtual_sequencer", uvm_component parent = null);
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