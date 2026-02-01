package reg_file_seq_item_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class reg_file_seq_item  extends uvm_sequence_item;
		`uvm_object_utils(reg_file_seq_item)

		function new (string name="reg_file_seq_item");
			super.new(name);
		endfunction

		parameter ADDR=4;
		parameter WIDTH=8;

		rand logic RST;
		rand logic WrEn;
		rand logic RdEn;
		rand logic [ADDR-1:0]   Address;
		rand logic [WIDTH-1:0]  WrData;

		logic [WIDTH-1:0]  RdData;
		logic  RdData_VLD;
	
		logic [WIDTH-1:0]  REG0;
		logic [WIDTH-1:0]  REG1;
		logic [WIDTH-1:0]  REG2;
		logic [WIDTH-1:0]  REG3;
		
		//just simple constraint 
		constraint constr1 {
			WrEn!=RdEn;
		}

		constraint constr2 {
			RST dist{1:=90,0:=10};
		}


		function string convert2string();
			return $sformatf("%s RST=%b  WrEn=%0b  RdEn=%0b Address=%0h WrData=%0h  RdData=%d RdData_VLD=%0b ",super.convert2string(),RST,WrEn,RdEn,Address,WrData,RdData,RdData_VLD);
		endfunction
		
		/*function string convert2string_stimulus ();
			return $sformatf("rst_n =%b, MOSI=%b,  SS_n=%b",rst_n_in,MOSI,SS_n);
		endfunction*/ 

	endclass

endpackage
