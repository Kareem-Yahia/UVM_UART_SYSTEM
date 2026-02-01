/////////////////////////////////////////////////
class sys_smoke_test extends sys_base_test;

    `uvm_component_utils(sys_smoke_test)

    sys_rst_sequence sys_rst_sequence_inst;

    function new (string name = "sys_smoke_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        sys_rst_sequence_inst = sys_rst_sequence::type_id::create("sys_rst_sequence_inst", this);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        sys_rst_sequence_inst.start(sys_top_env_inst.sys_env_inst.sys_agent_mem_inst.sys_sequencer_mem_inst);

    endtask



endclass