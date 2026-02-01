package reg_file_sequencer_pkg;

	import reg_file_seq_item_pkg::*;
	import uvm_pkg::*;
		`include "uvm_macros.svh"

	class reg_file_sequencer extends uvm_sequencer #(reg_file_seq_item);
		`uvm_component_utils(reg_file_sequencer)

		function new(string name="reg_file_sequencer",uvm_component parent=null);
			super.new(name,parent);
		endfunction

	endclass
endpackage