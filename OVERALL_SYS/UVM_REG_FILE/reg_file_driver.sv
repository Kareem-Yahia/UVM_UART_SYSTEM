package reg_file_driver_pkg;

	import reg_file_seq_item_pkg::*;
	import uvm_pkg::*;
		`include "uvm_macros.svh"

	class reg_file_driver extends uvm_driver #(reg_file_seq_item);
		`uvm_component_utils(reg_file_driver)

		virtual reg_file_if reg_file_vif_driver;
		reg_file_seq_item stim_seq_item;

		function new(string name="reg_file_driver",uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
		endfunction

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			forever begin
				stim_seq_item=reg_file_seq_item::type_id::create("stim_seq_item");
				seq_item_port.get_next_item(stim_seq_item);
				reg_file_vif_driver.RST=stim_seq_item.RST;
				reg_file_vif_driver.WrEn=stim_seq_item.WrEn;
				reg_file_vif_driver.RdEn=stim_seq_item.RdEn;
				reg_file_vif_driver.Address=stim_seq_item.Address;
				reg_file_vif_driver.WrData=stim_seq_item.WrData;

				@(negedge reg_file_vif_driver.REF_CLK);
					stim_seq_item.RdData=reg_file_vif_driver.RdData; //////this is very important
					stim_seq_item.RdData_VLD=reg_file_vif_driver.RdData_VLD;

				`uvm_info("driver",$sformatf("reg_file_vif_driver.Address=%0h  reg_file_vif_driver.WrData=%0h reg_file_vif_driver.WrEn=%0h"
					,reg_file_vif_driver.Address,reg_file_vif_driver.WrData,reg_file_vif_driver.WrEn),UVM_HIGH);
				seq_item_port.item_done();				
			end
		endtask

	endclass
endpackage