
///////////////////////////////////////////
class sys_env extends uvm_env;

    `uvm_component_utils(sys_env)

    function new (string name = "sys_env", uvm_component parent = null);
        super.new(name, parent);

    endfunction

    sys_agent_mem sys_agent_mem_inst;
    sys_scoreboard_1 sys_scoreboard_1_inst;
    sys_scoreboard_2 sys_scoreboard_2_inst;
    sys_scoreboard_3 sys_scoreboard_3_inst;
    sys_scoreboard_4 sys_scoreboard_4_inst;
    sys_scoreboard_5 sys_scoreboard_5_inst;
    sys_env_virtual_sequencer sys_env_virtual_sequencer_inst ;


    sys_env_config  sys_env_config;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (sys_env_config.has_agent["sys_agent_mem"]) begin
            sys_agent_mem_inst = sys_agent_mem::type_id::create("sys_agent_mem_inst", this);
            sys_agent_mem_inst.agent_config_inst = sys_env_config.agent_config_inst;
        end

        if (sys_env_config.has_scoreboard["sys_scoreboard_1"]) begin
            sys_scoreboard_1_inst = sys_scoreboard_1::type_id::create("sys_scoreboard_1_inst", this);
        end

        if (sys_env_config.has_scoreboard["sys_scoreboard_2"]) begin
            sys_scoreboard_2_inst = sys_scoreboard_2::type_id::create("sys_scoreboard_2_inst", this);
        end

        if (sys_env_config.has_scoreboard["sys_scoreboard_3"]) begin
            sys_scoreboard_3_inst = sys_scoreboard_3::type_id::create("sys_scoreboard_3_inst", this);
        end

        if (sys_env_config.has_scoreboard["sys_scoreboard_4"]) begin
            sys_scoreboard_4_inst = sys_scoreboard_4::type_id::create("sys_scoreboard_4_inst", this);
        end

        if (sys_env_config.has_scoreboard["sys_scoreboard_5"]) begin
            sys_scoreboard_5_inst = sys_scoreboard_5::type_id::create("sys_scoreboard_5_inst", this);
        end

        sys_env_virtual_sequencer_inst = sys_env_virtual_sequencer::type_id::create("sys_env_virtual_sequencer_inst", this);
        

    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        sys_env_config.agent_config_inst = sys_agent_mem_inst.agent_config_inst;
        sys_env_virtual_sequencer_inst.sys_sequencer_mem_inst = sys_agent_mem_inst.sys_sequencer_mem_inst;
    endfunction

  
endclass