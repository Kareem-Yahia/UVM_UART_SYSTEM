package sys_agent_pkg;
	import sys_seq_item_pkg::*;
	import sys_driver_pkg::*;
	import sys_sequencer_pkg::*;
	import sys_monitor_pkg::*;
	import sys_config_obj_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class sys_agent extends uvm_agent;
		`uvm_component_utils(sys_agent)
		sys_sequencer sequencer;
		sys_driver driver;
		sys_monitor monitor;
		sys_config_obj sys_config_obj_agent;
		uvm_analysis_port #(sys_seq_item) agt_ap;



		function new(string name="sys_agent",uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			if(!uvm_config_db#(sys_config_obj)::get(this, "", "sys_cfg",sys_config_obj_agent))
			`uvm_info("build_phase","agent cann't get interface",UVM_MEDIUM)

		 if(sys_config_obj_agent.active==UVM_ACTIVE) begin
			sequencer=sys_sequencer::type_id::create("sequencer",this);
			driver=sys_driver::type_id::create("driver",this);
		end
			monitor=sys_monitor::type_id::create("monitor",this);


			agt_ap=new("agt_ap",this);
		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
					 if(sys_config_obj_agent.active==UVM_ACTIVE) begin
			driver.sysvif_driver=sys_config_obj_agent.sys_vif;
			driver.seq_item_port.connect(sequencer.seq_item_export);
					end

			monitor.sysvif_monitor=sys_config_obj_agent.sys_vif;
			monitor.mon_ap.connect(agt_ap);
		endfunction

	endclass

endpackage