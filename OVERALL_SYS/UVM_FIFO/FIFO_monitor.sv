package FIFO_monitor_pkg;
		import FIFO_seq_item_pkg::*;
		import FIFO_config_obj_pkg::*;
		import uvm_pkg::*;
		`include "uvm_macros.svh"

	class FIFO_monitor extends uvm_monitor;
			`uvm_component_utils(FIFO_monitor)

			virtual FIFO_if FIFOvif_monitor;
			FIFO_seq_item my_seq_item;
			uvm_analysis_port #(FIFO_seq_item) mon_ap;

			function new(string name="FIFO_monitor" , uvm_component parent=null);
				super.new(name,parent);
			endfunction

			function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			mon_ap=new("mon_ap",this);
		endfunction

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			forever begin
				my_seq_item=FIFO_seq_item::type_id::create("my_seq_item",this);
				
				mon1();
				mon_ap.write(my_seq_item);

				`uvm_info("run_phase",my_seq_item.convert2string(),UVM_HIGH)
			end
		endtask

		task mon1();
			  @(posedge FIFOvif_monitor.winc);
			 my_seq_item.wrst_n=FIFOvif_monitor.wrst_n;
			 my_seq_item.rrst_n=FIFOvif_monitor.rrst_n;
			 my_seq_item.winc=FIFOvif_monitor.winc;
			 
			 my_seq_item.rinc=FIFOvif_monitor.rinc;
			 my_seq_item.w_data=FIFOvif_monitor.w_data;
 
            my_seq_item.r_data=FIFOvif_monitor.r_data;
            my_seq_item.wfull=FIFOvif_monitor.wfull;
            my_seq_item.rempty=FIFOvif_monitor.rempty;


            ///////////////////////////////////////////////
		endtask
	endclass
endpackage