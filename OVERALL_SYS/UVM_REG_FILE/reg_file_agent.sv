
	class reg_file_agent extends uvm_agent;
		`uvm_component_utils(reg_file_agent)

		reg_file_sequencer sequencer;
		reg_file_driver    driver;
		reg_file_monitor monitor;
		reg_file_config_obj agent_config;

		uvm_analysis_port #(reg_file_seq_item) agent_ap;


		function new(string name="reg_file_agent",uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);			

			if(! uvm_config_db#(reg_file_config_obj)::get(this, "", "reg_file_cfg",agent_config ))
				`uvm_info("build_phase","agent get interface",UVM_MEDIUM)

			if (agent_config.active==UVM_ACTIVE) begin
				sequencer=reg_file_sequencer::type_id::create("sequencer",this);
				driver=reg_file_driver::type_id::create("driver",this);
			end

			monitor=reg_file_monitor::type_id::create("monitor",this);
			agent_ap=new("agent_ap",this);
				
		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			monitor.mon_ap.connect(agent_ap);
			monitor.reg_file_vif_monitor=agent_config.reg_fileif_v;

			if (agent_config.active==UVM_ACTIVE) begin
				driver.seq_item_port.connect(sequencer.seq_item_export);
				driver.reg_file_vif_driver=agent_config.reg_fileif_v;
			end
		endfunction

	endclass