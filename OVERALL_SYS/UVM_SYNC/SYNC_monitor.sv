package SYNC_monitor_pkg;
		import SYNC_seq_item_pkg::*;
		import SYNC_config_obj_pkg::*;
		import uvm_pkg::*;
		`include "uvm_macros.svh"

	class SYNC_monitor extends uvm_monitor;
			`uvm_component_utils(SYNC_monitor)

			virtual SYNC_if SYNCvif_monitor;
			SYNC_seq_item my_seq_item;
			uvm_analysis_port #(SYNC_seq_item) mon_ap;

			function new(string name="SYNC_monitor" , uvm_component parent=null);
				super.new(name,parent);
			endfunction

			function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			mon_ap=new("mon_ap",this);
		endfunction

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			forever begin
				my_seq_item=SYNC_seq_item::type_id::create("my_seq_item",this);
				
				mon1();
				mon_ap.write(my_seq_item);

				`uvm_info("run_phase",my_seq_item.convert2string(),UVM_HIGH)
			end
		endtask

		task mon1();
			  @(posedge SYNCvif_monitor.bus_enable);
			 my_seq_item.rst=SYNCvif_monitor.rst;
			 my_seq_item.unsync_bus=SYNCvif_monitor.unsync_bus;
			 my_seq_item.bus_enable=SYNCvif_monitor.bus_enable;
			 repeat(3) @ (SYNCvif_monitor.REF_CLK);
			 my_seq_item.sync_bus=SYNCvif_monitor.sync_bus;
			 my_seq_item.enable_pulse=SYNCvif_monitor.enable_pulse;

            //just for testing 
            my_seq_item.internal_enable=SYNCvif_monitor.internal_enable;
            my_seq_item.internal_out_of_synchronizer=SYNCvif_monitor.internal_out_of_synchronizer;
            
            ///////////////////////////////////////////////
		endtask
	endclass
endpackage