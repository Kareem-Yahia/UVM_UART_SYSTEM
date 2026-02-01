class sys_base_test extends uvm_test;

    `uvm_component_utils(sys_base_test)

    sys_top_env sys_top_env_inst;
    sys_top_config sys_top_config_inst;

    function new (string name = "sys_base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sys_top_env_inst = sys_top_env::type_id::create("sys_top_env_inst", this);
        sys_top_config_inst = sys_top_config::type_id::create("sys_top_config_inst", this);
        // interface set

        if (!uvm_config_db # (virtual sys_intf)::get(this,"","sys_if", sys_top_config_inst.sys_env_config.agent_config_inst.vif)) begin
            `uvm_fatal("SYS_IF_ERR", "sys_if is not set. Please set it before build_phase.")
        end
        sys_top_config_inst.has_sys_environment_set(1);
        uvm_config_db # (sys_top_config)::set(this, "sys_top_env_inst", "sys_top_config", sys_top_config_inst);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        this.print();
    endfunction    


endclass   