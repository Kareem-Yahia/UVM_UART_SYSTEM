package SYNC_seq_item_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh";

	class SYNC_seq_item extends uvm_sequence_item;
		`uvm_object_utils(SYNC_seq_item)

	//INPUT 	
	parameter NUM_STAGES=2;
	parameter BUS_WIDTH= 8;
		logic rst;
  	rand logic [BUS_WIDTH-1:0]unsync_bus;
   rand logic bus_enable;
   //OUTPUT
   logic  [BUS_WIDTH-1:0] sync_bus;
   logic  enable_pulse;

   //internal signals
  	logic internal_enable;
  	logic internal_out_of_synchronizer;


	function new (string name ="SYNC_seq_item");
		super.new(name);
	endfunction 

		function string convert2string();
			return $sformatf("%s rst=%b, unsync_bus=%b bus_enable=%b  sync_bus=%b enable_pulse=%b"
				,super.convert2string(),rst,unsync_bus,bus_enable,sync_bus,enable_pulse);
		endfunction
		
		function string convert2string_stimulus ();
			return $sformatf("%s rst=%b, unsync_bus=%b bus_enable=%b"
				,super.convert2string(),rst,unsync_bus,bus_enable);
		endfunction 

	endclass 
endpackage 