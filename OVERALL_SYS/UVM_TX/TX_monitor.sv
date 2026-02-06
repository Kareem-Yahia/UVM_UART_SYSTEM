package TX_monitor_pkg;
		import TX_seq_item_pkg::*;
		import TX_config_obj_pkg::*;
		import uvm_pkg::*;
		`include "uvm_macros.svh"

	class TX_monitor extends uvm_monitor;
			`uvm_component_utils(TX_monitor)

			virtual TX_if TXvif_monitor;
			TX_seq_item my_seq_item;
			uvm_analysis_port #(TX_seq_item) mon_ap;

			function new(string name="TX_monitor" , uvm_component parent=null);
				super.new(name,parent);
			endfunction

			function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			mon_ap=new("mon_ap",this);
		endfunction

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			forever begin
				my_seq_item=TX_seq_item::type_id::create("my_seq_item",this);
				
				mon1();
				if (TXvif_monitor.Data_Valid && TXvif_monitor.rst)
				mon_ap.write(my_seq_item);

				`uvm_info("run_phase",my_seq_item.convert2string(),UVM_HIGH)
			end
		endtask

		task mon1();
			@(TXvif_monitor.cb_TX_CLK);

			my_seq_item.P_DATA=TXvif_monitor.cb_TX_CLK_TB.P_DATA;
			my_seq_item.Data_Valid=TXvif_monitor.cb_TX_CLK_TB.Data_Valid;
			my_seq_item.PAR_TYP=TXvif_monitor.cb_TX_CLK_TB.PAR_TYP;

			my_seq_item.PAR_EN=TXvif_monitor.cb_TX_CLK_TB.PAR_EN;
			my_seq_item.TX_OUT=TXvif_monitor.cb_TX_CLK_TB.TX_OUT;

			my_seq_item.rst=TXvif_monitor.cb_TX_CLK_TB.rst;
			my_seq_item.Par_bit=TXvif_monitor.cb_TX_CLK_TB.Par_bit;
            
            ///////////////////////////////////////////////
		endtask
	endclass
endpackage