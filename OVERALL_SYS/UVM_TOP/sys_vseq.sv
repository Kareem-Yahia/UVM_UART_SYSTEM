class sys_vseq_base extends uvm_sequence;

	`uvm_object_utils(sys_vseq_base)
	`uvm_declare_p_sequencer(sys_vsequencer)


	// sequencers declaration
	sys_vsequencer sys_vsequencer_inst ;


	// sequences declaration
	sys_sequence_reset  reset_seq ;
	sys_sequence_smoke main_seq ;


	function new(string name = "sys_vseq_base");
		super.new(name);
	endfunction
	

	virtual task pre_body ();

	    $cast(sys_vsequencer_inst,p_sequencer);

		// -------------------------------------------------------------------------------------- //
		// ------------------------------ Sequences Creation Start ------------------------------ //
		// -------------------------------------------------------------------------------------- //


		reset_seq 		= sys_sequence_reset::type_id::create("reset_seq");
		main_seq  		= sys_sequence_smoke::type_id::create("main_seq");

		

	endtask 



endclass 


class sys_vseq_smoke_test extends sys_vseq_base;

	`uvm_object_utils(sys_vseq_smoke_test)

	function new(string name = "sys_vseq_smoke_test");
		super.new(name);
	endfunction


	virtual task body ();

	`uvm_info(get_type_name(),
		          "\n    ==================== RESET ====================",
		          UVM_LOW)

	`uvm_info(get_type_name(),
	          "    Reset Asserted",
	          UVM_LOW)
	reset_seq.start(sys_vsequencer_inst.sys_sequencer_inst);

	`uvm_info(get_type_name(),
	          "    Reset Deasserted",
	          UVM_LOW)

	`uvm_info(get_type_name(),
	          "\n    ================= STIMULUS START =================",
	          UVM_LOW)

	`uvm_info(get_type_name(),
	          "    Running Main Sequence...",
	          UVM_LOW)
	main_seq.start(sys_vsequencer_inst.sys_sequencer_inst);

	`uvm_info(get_type_name(),
	          "\n    ================= STIMULUS END ===================",
	          UVM_LOW)
	

	endtask : body



endclass 
