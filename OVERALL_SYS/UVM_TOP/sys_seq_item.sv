
	class sys_seq_item extends uvm_sequence_item;
		`uvm_object_utils(sys_seq_item)

	
	  rand logic RST,RX_IN;
	   //output
	  logic TX_OUT;
	  logic par_err_reg,stp_error_reg;

		constraint constr1 {RST dist {0:=2,1:=95};}

	function new (string name ="uart_seq_item");
		super.new(name);
	endfunction

	 

		function string convert2string();
			return $sformatf("%s RST=%b RX_IN=%b  TX_OUT=%b  par_err_reg=%b stp_error_reg=%b "
				,super.convert2string(),RST,RX_IN,TX_OUT,par_err_reg,stp_error_reg);
		endfunction
		
		function string convert2string_stimulus ();
			return $sformatf("%s RST=%b RX_IN=%b "
				,super.convert2string(),RST,RX_IN);
		endfunction 

	endclass  