/////////////////////////////////////////////////
class sys_smoke_test extends sys_base_test;

    `uvm_component_utils(sys_smoke_test)

    sys_vseq_smoke_test sys_vseq_smoke_test_inst ;

    function new (string name = "sys_smoke_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        sys_vseq_smoke_test_inst = sys_vseq_smoke_test::type_id::create("sys_vseq_smoke_test_inst", this);

        //sys_top_config_inst.has_aes_environment_set(1) ; 
        //sys_top_config_inst.has_memory1_environment_set(1) ; 
        //sys_top_config_inst.has_memory2_environment_set(1) ; 
        //sys_top_config_inst.has_uart_environment_set(1) ; 

    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);

        sys_vseq_smoke_test_inst.start(sys_top_env_inst.top_env_virtual_sequencer_inst);

        phase.drop_objection(this);

    endtask



endclass