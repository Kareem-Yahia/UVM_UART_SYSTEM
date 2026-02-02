class sys_vseq_base extends uvm_sequence;

	`uvm_object_utils(sys_vseq_base)
	`uvm_declare_p_sequencer(top_env_virtual_sequencer)


	// sequencers declaration
	top_env_virtual_sequencer top_env_virtual_sequencer_inst ;


	// sequences declaration
	sys_rst_sequence sys_rst_sequence_inst;


	function new(string name = "sys_vseq_base");
		super.new(name);
	endfunction
	

	virtual task body ();

	    $cast(top_env_virtual_sequencer_inst,p_sequencer);

		// -------------------------------------------------------------------------------------- //
		// ------------------------------ Sequences Creation Start ------------------------------ //
		// -------------------------------------------------------------------------------------- //




        sys_rst_sequence_inst = sys_rst_sequence::type_id::create("sys_rst_sequence_inst");


		

	endtask : body



endclass 
