class sys_env_virtual_sequencer extends uvm_sequencer ; 

    `uvm_component_utils(sys_env_virtual_sequencer)

    sys_sequencer_mem sys_sequencer_mem_inst;

    function new (string name = "sys_env_virtual_sequencer", uvm_component parent = null);
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