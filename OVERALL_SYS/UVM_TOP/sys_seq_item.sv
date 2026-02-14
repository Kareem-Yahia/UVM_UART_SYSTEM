
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
	  string s,s1,s2,s3;

	    s1 = "\n----------------------------------------------------------\n";
	    s2 = "| RST | RX_IN || data_valid | TX_OUT | par_err | stp_error  \n";
	    s3 = "------------------------------------------------------------\n";

	  s = { s1,s2,s3,
	        $sformatf(
	          "|  %1b  |    %1b    |    %1b    |    %1b     |   %1b   \n",
	          RST,
	          RX_IN,
	          TX_OUT,
	          par_err_reg,
	          stp_error_reg
	        )
	      };

	  return s;
	endfunction

	function string convert2string_stimulus ();
		return $sformatf("%s RST=%b RX_IN=%b "
			,super.convert2string(),RST,RX_IN);
	endfunction 

	endclass  