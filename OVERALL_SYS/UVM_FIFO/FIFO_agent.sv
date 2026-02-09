
	class FIFO_agent extends uvm_agent;
		`uvm_component_utils(FIFO_agent)
		FIFO_sequencer sequencer;
		//FIFO_driver driver;
		FIFO_monitor monitor;
		FIFO_config_obj FIFO_config_obj_agent;
		uvm_analysis_port #(FIFO_seq_item) agt_ap;



		function new(string name="FIFO_agent",uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			if(!uvm_config_db#(FIFO_config_obj)::get(this, "", "FIFO_cfg",FIFO_config_obj_agent))
			`uvm_info("build_phase","agent cann't get interface",UVM_MEDIUM)

		 /*
		 if(FIFO_config_obj_agent.active==UVM_ACTIVE) begin
			sequencer=FIFO_sequencer::type_id::create("sequencer",this);
			driver=FIFO_driver::type_id::create("driver",this);
		end
		*/
			monitor=FIFO_monitor::type_id::create("monitor",this);


			agt_ap=new("agt_ap",this);
		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
					/* if(FIFO_config_obj_agent.active==UVM_ACTIVE) begin
			driver.FIFOvif_driver=FIFO_config_obj_agent.FIFO_vif;
			driver.seq_item_port.connect(sequencer.seq_item_export);
					end*/

			monitor.FIFOvif_monitor=FIFO_config_obj_agent.FIFO_vif;
			monitor.mon_ap.connect(agt_ap);
		endfunction

	endclass