package uart_agent_pkg;
	import uart_seq_item_pkg::*;
	import uart_driver_pkg::*;
	import uart_sequencer_pkg::*;
	import uart_monitor_pkg::*;
	import uart_config_obj_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class uart_agent extends uvm_agent;
		`uvm_component_utils(uart_agent)
		uart_sequencer sequencer;
		uart_driver driver;
		uart_monitor monitor;
		uart_config_obj uart_config_obj_agent;
		uvm_analysis_port #(uart_seq_item) agt_ap;



		function new(string name="uart_agent",uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			if(!uvm_config_db#(uart_config_obj)::get(this, "", "uart_cfg",uart_config_obj_agent))
			`uvm_info("build_phase","agent cann't get interface",UVM_MEDIUM)

		 if(uart_config_obj_agent.active==UVM_ACTIVE) begin
			sequencer=uart_sequencer::type_id::create("sequencer",this);
			driver=uart_driver::type_id::create("driver",this);
		end
			monitor=uart_monitor::type_id::create("monitor",this);


			agt_ap=new("agt_ap",this);
		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
					 if(uart_config_obj_agent.active==UVM_ACTIVE) begin
			driver.uartvif_driver=uart_config_obj_agent.uart_vif;
			driver.seq_item_port.connect(sequencer.seq_item_export);
					end

			monitor.uartvif_monitor=uart_config_obj_agent.uart_vif;
			monitor.mon_ap.connect(agt_ap);
		endfunction

	endclass

endpackage