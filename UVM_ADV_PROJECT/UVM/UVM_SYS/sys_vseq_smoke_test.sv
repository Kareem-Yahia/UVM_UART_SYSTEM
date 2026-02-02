class sys_vseq_smoke_test extends sys_vseq_base;

	`uvm_object_utils(sys_vseq_smoke_test)

	function new(string name = "sys_vseq_smoke_test");
		super.new(name);
	endfunction


	virtual task body ();
	super.body();

	sys_rst_sequence_inst.start(top_env_virtual_sequencer_inst.sys_env_virtual_sequencer_inst.sys_sequencer_mem_inst);
	

	endtask : body



endclass 
