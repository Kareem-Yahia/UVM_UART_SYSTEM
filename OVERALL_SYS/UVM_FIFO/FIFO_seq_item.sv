package FIFO_seq_item_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh";

	class FIFO_seq_item extends uvm_sequence_item;
		`uvm_object_utils(FIFO_seq_item)

		parameter FIFO_DEPTH=8;
	  parameter DATA_WIDTH=8;
	  parameter N=2;//for synchronizer
	  localparam POINTER_WIDTH= $clog2(FIFO_DEPTH)+1;

	//INPUT 	
		logic w_clk,r_clk;
	  logic wrst_n,rrst_n;

	  logic winc,rinc;
	  logic [DATA_WIDTH-1:0] w_data;

	  //output
	  logic  [DATA_WIDTH-1:0] r_data;
	  logic  wfull,rempty;


	function new (string name ="FIFO_seq_item");
		super.new(name);
	endfunction 

		function string convert2string();
			return $sformatf("%s wrst_n=%b, rrst_n=%b winc=%b  rinc=%b w_data=%b r_data=%h  wfull=%b  rempty=%b"
				,super.convert2string(),wrst_n,rrst_n,winc,rinc,w_data,r_data,wfull,rempty);
		endfunction
		
		function string convert2string_stimulus ();
			return $sformatf("%s wrst_n=%b, rrst_n=%b winc=%b  rinc=%b w_data=%b"
				,super.convert2string(),wrst_n,rrst_n,winc,rinc,w_data);
		endfunction 

	endclass 
endpackage 