
	class TX_agent extends uvm_agent;
		`uvm_component_utils(TX_agent)
		TX_sequencer sequencer;
		//TX_driver driver;
		TX_monitor monitor;
		TX_config_obj TX_config_obj_agent;
		uvm_analysis_port #(TX_seq_item) agt_ap;



		function new(string name="TX_agent",uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			if(!uvm_config_db#(TX_config_obj)::get(this, "", "TX_cfg",TX_config_obj_agent))
			`uvm_info("build_phase","agent cann't get interface",UVM_MEDIUM)

		 /*
		 if(TX_config_obj_agent.active==UVM_ACTIVE) begin
			sequencer=TX_sequencer::type_id::create("sequencer",this);
			driver=TX_driver::type_id::create("driver",this);
		end
		*/
			monitor=TX_monitor::type_id::create("monitor",this);


			agt_ap=new("agt_ap",this);
		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
					/* if(TX_config_obj_agent.active==UVM_ACTIVE) begin
			driver.TXvif_driver=TX_config_obj_agent.TX_vif;
			driver.seq_item_port.connect(sequencer.seq_item_export);
					end*/

			monitor.TXvif_monitor=TX_config_obj_agent.TX_vif;
			monitor.mon_ap.connect(agt_ap);
		endfunction

	endclass
