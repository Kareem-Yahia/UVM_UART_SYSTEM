package TX_seq_item_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh";

	class TX_seq_item extends uvm_sequence_item;
		`uvm_object_utils(TX_seq_item)

	 logic [7:0] P_DATA;
   logic Data_Valid;
   logic rst;

   //output
   logic PAR_TYP,PAR_EN;
   logic  TX_OUT,busy;

   //internal signals
   logic Ser_Done,Ser_En,Ser_Data,Par_bit;
   logic [2:0] Mux_sel;

	function new (string name ="TX_seq_item");
		super.new(name);
	endfunction 

		function string convert2string();
			return $sformatf("%s rst=%b, P_DATA=%b Data_Valid=%b  PAR_TYP=%b PAR_EN=%b TX_OUT=%h  busy=%b"
				,super.convert2string(),rst,P_DATA,Data_Valid,PAR_TYP,PAR_EN,TX_OUT,busy);
		endfunction
		
		function string convert2string_stimulus ();
			return $sformatf("%s rst=%b, P_DATA=%b Data_Valid=%b  PAR_TYP=%b PAR_EN=%b TX_OUT=%h  busy=%b"
				,super.convert2string(),rst,P_DATA,Data_Valid,PAR_TYP,PAR_EN,TX_OUT,busy);
		endfunction 

	endclass 
endpackage 