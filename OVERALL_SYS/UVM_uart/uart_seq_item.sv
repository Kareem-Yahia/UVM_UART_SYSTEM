
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
		  string s,s1,s2,s3;

		    s1 = "\n--------------------------------------------------------------------------------\n";
		    s2 = "| rst | prescale | PAR_EN | PAR_TYP | RX_IN || data_valid | P_DATA | par | stp |\n";
		    s3 = "--------------------------------------------------------------------------------\n";

		  s = { s1,s2,s3,
		        $sformatf(
		          "|  %1b  |    %02d    |    %1b    |    %1b     |   %1b   ||      %1b      | 0x%02h  |  %1b  |  %1b  |\n",
		          rst,
		          prescale,
		          PAR_EN,
		          PAR_TYP,
		          RX_IN,
		          data_valid_reg,
		          P_DATA_reg,
		          par_err_reg,
		          stp_error_reg
		        )
		      };

		  return s;
		endfunction


		
		function string convert2string_stimulus ();
			return $sformatf("%s rst=%b, prescale=%b PAR_EN=%b  PAR_TYP=%b RX_IN=%b "
				,super.convert2string(),rst,prescale,PAR_EN,PAR_TYP,RX_IN);
		endfunction 

	endclass  