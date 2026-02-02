
//my_env
///////////////////////////////////////////
class sys_top_env extends uvm_env;

  `uvm_component_utils(sys_top_env)

    // Components

    sys_env sys_env_inst;
    sys_top_config sys_top_config_inst;
    top_env_virtual_sequencer top_env_virtual_sequencer_inst ; 

    function new (string name = "sys_top_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db #(sys_top_config)::get(this, "", "sys_top_config", sys_top_config_inst)) begin
            `uvm_fatal("SYS_TOP_CFG_ERR", "sys_top_config_inst is not set. Please set it before build_phase.")
        end

        if (sys_top_config_inst.has_sys_environment) begin
            `uvm_info("SYS_TOP_ENV", "Building SYS Environment as per configuration", UVM_LOW)
            sys_env_inst = sys_env::type_id::create("sys_env_inst", this);
            sys_env_inst.sys_env_config = sys_top_config_inst.sys_env_config;

        end 
        top_env_virtual_sequencer_inst =  top_env_virtual_sequencer::type_id::create("top_env_virtual_sequencer_inst", this);

    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        top_env_virtual_sequencer_inst.sys_env_virtual_sequencer_inst = sys_env_inst.sys_env_virtual_sequencer_inst;
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask

endclass