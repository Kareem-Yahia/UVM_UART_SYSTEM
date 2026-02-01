package SYNC_agent_pkg;
	import SYNC_seq_item_pkg::*;
	//import SYNC_driver_pkg::*;
	//import SYNC_sequencer_pkg::*;
	import SYNC_monitor_pkg::*;
	import SYNC_config_obj_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class SYNC_agent extends uvm_agent;
		`uvm_component_utils(SYNC_agent)
		//SYNC_sequencer sequencer;
		//SYNC_driver driver;
		SYNC_monitor monitor;
		SYNC_config_obj SYNC_config_obj_agent;
		uvm_analysis_port #(SYNC_seq_item) agt_ap;



		function new(string name="SYNC_agent",uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			if(!uvm_config_db#(SYNC_config_obj)::get(this, "", "SYNC_cfg",SYNC_config_obj_agent))
			`uvm_info("build_phase","agent cann't get interface",UVM_MEDIUM)

		 /*
		 if(SYNC_config_obj_agent.active==UVM_ACTIVE) begin
			sequencer=SYNC_sequencer::type_id::create("sequencer",this);
			driver=SYNC_driver::type_id::create("driver",this);
		end
		*/
			monitor=SYNC_monitor::type_id::create("monitor",this);


			agt_ap=new("agt_ap",this);
		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
					/* if(SYNC_config_obj_agent.active==UVM_ACTIVE) begin
			driver.SYNCvif_driver=SYNC_config_obj_agent.SYNC_vif;
			driver.seq_item_port.connect(sequencer.seq_item_export);
					end*/

			monitor.SYNCvif_monitor=SYNC_config_obj_agent.SYNC_vif;
			monitor.mon_ap.connect(agt_ap);
		endfunction

	endclass

endpackage