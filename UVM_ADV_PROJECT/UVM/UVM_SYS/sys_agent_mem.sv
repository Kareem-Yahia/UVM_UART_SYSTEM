class sys_agent_mem extends uvm_agent ;

    `uvm_component_utils(sys_agent_mem)
 
    sys_driver_mem sys_driver_mem_inst;
    sys_monitor_mem sys_monitor_mem_inst;
    sys_sequencer_mem sys_sequencer_mem_inst;

    agent_config #(virtual sys_intf) agent_config_inst;
    virtual sys_intf sys_if;
    uvm_analysis_port #(sys_seq_item_mem) sys_agent_ap;

    function new (string name = "sys_agent_mem", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        if (agent_config_inst.agent_type == UVM_ACTIVE) begin
            sys_sequencer_mem_inst = sys_sequencer_mem :: type_id :: create("sys_sequencer_mem_inst", this);
            sys_driver_mem_inst    = sys_driver_mem    :: type_id :: create("sys_driver_mem_inst", this);
        end 

        sys_monitor_mem_inst   = sys_monitor_mem   :: type_id :: create("sys_monitor_mem_inst", this);
        sys_if = agent_config_inst.vif;

    endfunction

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
    endtask

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);

        if (agent_config_inst.agent_type == UVM_ACTIVE) begin
            sys_driver_mem_inst.seq_item_port.connect(sys_sequencer_mem_inst.seq_item_export);
            sys_driver_mem_inst.sys_if = sys_if;
        end

        sys_monitor_mem_inst.sys_monitor_ap.connect(sys_agent_ap);
        sys_monitor_mem_inst.sys_if = sys_if;

    endfunction


endclass