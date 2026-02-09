
class sys_base_test extends uvm_test;
	`uvm_component_utils(sys_base_test)


	top_env top_env_inst;
	sys_vseq_smoke_test sys_vseq_smoke_test_inst;

	//  confiugration objects 

	sys_config_obj sys_cfg;
	uart_config_obj uart_cfg;
	SYNC_config_obj SYNC_cfg;
	reg_file_config_obj reg_file_cfg;
	FIFO_config_obj FIFO_cfg;
	TX_config_obj TX_cfg;

	



	function new(string name = "sys_base_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		top_env_inst = top_env::type_id::create("top_env_inst",this);

		// Configuration Objects Build
		sys_cfg = sys_config_obj::type_id::create("sys_cfg");
		uart_cfg = uart_config_obj::type_id::create("uart_cfg");
		SYNC_cfg = SYNC_config_obj::type_id::create("SYNC_cfg");
		reg_file_cfg = reg_file_config_obj::type_id::create("reg_file_cfg");
		FIFO_cfg = FIFO_config_obj::type_id::create("FIFO_cfg");
		TX_cfg = TX_config_obj::type_id::create("TX_cfg");

		sys_vseq_smoke_test_inst = sys_vseq_smoke_test::type_id::create("sys_vseq_smoke_test_inst",this);



		// Virtual Interfaces

		if(!uvm_config_db #(virtual sys_if)::get(this, "", "sysif", sys_cfg.sys_vif))
			`uvm_fatal("build_phase", "Unable - to -get -vif -from uvm_config")
		uvm_config_db #(sys_config_obj)::set(this, "*", "sys_cfg", sys_cfg);

		/////////////////////////////////////////////////////////////////////////////

		if(!uvm_config_db #(virtual uart_if)::get(this, "", "uartif", uart_cfg.uart_vif))
			`uvm_fatal("build_phase", "Unable - to -get -vif -from uvm_config")
		uvm_config_db #(uart_config_obj)::set(this, "*", "uart_cfg", uart_cfg);

		///////////////////////////////////////////////////////////////////////////////

		if(!uvm_config_db #(virtual SYNC_if)::get(this, "", "SYNCif", SYNC_cfg.SYNC_vif))
			`uvm_fatal("build_phase", "Unable - to -get -vif -from uvm_config")
		uvm_config_db #(SYNC_config_obj)::set(this, "*", "SYNC_cfg", SYNC_cfg);

		//////////////////////////////////////////////////////////////////////////////////

		if(!uvm_config_db #(virtual reg_file_if)::get(this, "", "reg_fileif", reg_file_cfg.reg_fileif_v))
			`uvm_fatal("build_phase", "Unable - to -get -vif -from uvm_config")
		uvm_config_db #(reg_file_config_obj)::set(this, "*", "reg_file_cfg", reg_file_cfg);

		////////////////////////////////////////////////////////////////////////////////////

		if(!uvm_config_db #(virtual FIFO_if)::get(this, "", "FIFOif", FIFO_cfg.FIFO_vif))
			`uvm_fatal("build_phase", "Unable - to -get -vif -from uvm_config")
		uvm_config_db #(FIFO_config_obj)::set(this, "*", "FIFO_cfg", FIFO_cfg);
		FIFO_cfg.active = UVM_PASSIVE;

		/////////////////////////////////////////////////////////////////////////////////////

		if(!uvm_config_db #(virtual TX_if)::get(this, "", "TXif", TX_cfg.TX_vif))
			`uvm_fatal("build_phase", "Unable - to -get -vif -from uvm_config")
		uvm_config_db #(TX_config_obj)::set(this, "*", "TX_cfg", TX_cfg);

		// default configurations
		sys_cfg.active = UVM_ACTIVE;
		uart_cfg.active = UVM_PASSIVE;
		SYNC_cfg.active = UVM_PASSIVE;
		reg_file_cfg.active = UVM_PASSIVE;
		FIFO_cfg.active = UVM_PASSIVE;
		TX_cfg.active = UVM_PASSIVE;



	endfunction



	// end_of_elaboration_phase:- print_topology executes in bottom up manner.

	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();	
	endfunction



	// report_phase:- display result of the simulation.
	//	  executes in bottom up manner.


	virtual function void report_phase(uvm_phase phase);
   		uvm_report_server svr;
   			   		super.report_phase(phase);


   		svr = uvm_report_server::get_server();
   		if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)>0) begin
     		`uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
     		`uvm_info(get_type_name(), "----            TEST FAIL          ----", UVM_NONE)
     		`uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    	end
    	else begin
     		`uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
     		`uvm_info(get_type_name(), "----           TEST PASS           ----", UVM_NONE)
     		`uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    	end
  endfunction 

endclass 

class sys_smoke_test extends sys_base_test;
	`uvm_component_utils(sys_smoke_test)
	

	function new(string name = "sys_smoke_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);


		// Configurations Select
	
		sys_cfg.active = UVM_ACTIVE;
		uart_cfg.active = UVM_PASSIVE;
		SYNC_cfg.active = UVM_PASSIVE;
		reg_file_cfg.active = UVM_PASSIVE;
		FIFO_cfg.active = UVM_PASSIVE;
		TX_cfg.active = UVM_PASSIVE;



	endfunction



	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);

		sys_vseq_smoke_test_inst.start(top_env_inst.sys_vsequencer_inst);
		
		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this, 50);
		//After dropping the objection, this sets a drain time of 50 simulation time units for the current phase. 
		//This gives a bit of extra time (50 units) after all objections have been dropped to allow any
		//ongoing transactions or processes to gracefully finish before the phase officially ends.


	endtask

endclass 