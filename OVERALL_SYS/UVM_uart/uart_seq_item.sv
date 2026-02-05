package uart_seq_item_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh";

	class uart_seq_item extends uvm_sequence_item;
		`uvm_object_utils(uart_seq_item)

		//inputs 
		rand logic  rst;
	   rand logic  RX_IN;
	    logic  [5:0] prescale;
	    logic  PAR_EN,PAR_TYP;


	   //outputs
	   logic  data_valid_reg;
	   logic  [7:0] P_DATA_reg;
	   logic  par_err_reg,stp_error_reg;

		constraint constr1 {rst dist {0:=2,1:=90};}

	function new (string name ="uart_seq_item");
		super.new(name);
	endfunction 

		function string convert2string();
			return $sformatf("%s rst=%b, prescale=%b PAR_EN=%b  PAR_TYP=%b RX_IN=%b  data_valid=%b --> P_DATA=%h par_err=%b stp_error=%b"
				,super.convert2string(),rst,prescale,PAR_EN,PAR_TYP,RX_IN,data_valid_reg,P_DATA_reg,par_err_reg,stp_error_reg);
		endfunction
		
		function string convert2string_stimulus ();
			return $sformatf("%s rst=%b, prescale=%b PAR_EN=%b  PAR_TYP=%b RX_IN=%b "
				,super.convert2string(),rst,prescale,PAR_EN,PAR_TYP,RX_IN);
		endfunction 

	endclass 
endpackage 