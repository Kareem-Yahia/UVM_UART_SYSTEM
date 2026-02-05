package sys_sequencer_pkg;

	import sys_seq_item_pkg::*;
	import uvm_pkg::*;
		`include "uvm_macros.svh"

	class sys_sequencer extends uvm_sequencer #(sys_seq_item);
		`uvm_component_utils(sys_sequencer)

		function new(string name="sys_sequencer",uvm_component parent=null);
			super.new(name,parent);
		endfunction

	endclass
endpackage