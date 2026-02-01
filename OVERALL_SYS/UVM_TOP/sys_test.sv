package sys_test_pkg;

	import sys_config_obj_pkg::*;
	import uart_config_obj_pkg::*;
	import SYNC_config_obj_pkg::*;
	import reg_file_config_obj_pkg::*;
	import FIFO_config_obj_pkg::*;
	import TX_config_obj_pkg::*;

	import sys_sequence_pkg::*;
	import sys_env_pkg::*;
	import uart_env_pkg::*;
	import SYNC_env_pkg::*;
	import reg_file_env_pkg::*;
	import FIFO_env_pkg::*;
	import TX_env_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	class sys_base_test extends uvm_test;
		`uvm_component_utils(sys_base_test)

		sys_env sys_myenv;
		uart_env uart_myenv;
		SYNC_env SYNC_myenv;
		reg_file_env reg_file_myenv;
		FIFO_env FIFO_myenv;
		TX_env  TX_myenv;

		function new(string name = "sys_base_test", uvm_component parent = null);
			super.new(name, parent);
		endfunction : new

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			sys_myenv = sys_env::type_id::create("sys_myenv", this);
			uart_myenv = uart_env::type_id::create("uart_myenv", this);
			SYNC_myenv = SYNC_env::type_id::create("SYNC_myenv", this);
			reg_file_myenv = reg_file_env::type_id::create("reg_file_myenv", this);
			FIFO_myenv = FIFO_env::type_id::create("FIFO_myenv", this);
			TX_myenv = TX_env::type_id::create("TX_myenv", this);

		endfunction

	endclass 

	class sys_test1 extends sys_base_test;
		`uvm_component_utils(sys_test1)
		
		sys_config_obj sys_cfg;
		uart_config_obj uart_cfg;
		SYNC_config_obj SYNC_cfg;
		reg_file_config_obj reg_file_cfg;
		FIFO_config_obj FIFO_cfg;
		TX_config_obj TX_cfg;

		sys_sequence_reset reset_seq;
		sys_sequence_main main_seq;

		function new(string name = "sys_test1", uvm_component parent = null);
			super.new(name, parent);
		endfunction : new

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			reset_seq 		= sys_sequence_reset::type_id::create("reset_seq");
			main_seq  		= sys_sequence_main::type_id::create("main_seq");
			sys_cfg = sys_config_obj::type_id::create("sys_cfg");
			uart_cfg = uart_config_obj::type_id::create("uart_cfg");
			SYNC_cfg = SYNC_config_obj::type_id::create("SYNC_cfg");
			reg_file_cfg = reg_file_config_obj::type_id::create("reg_file_cfg");
			FIFO_cfg = FIFO_config_obj::type_id::create("FIFO_cfg");
			TX_cfg = TX_config_obj::type_id::create("TX_cfg");

			

			if(!uvm_config_db #(virtual sys_if)::get(this, "", "sysif", sys_cfg.sys_vif))
				`uvm_fatal("build_phase", "Unable - to -get -vif -from uvm_config")

			uvm_config_db #(sys_config_obj)::set(this, "*", "sys_cfg", sys_cfg);
			sys_cfg.active = UVM_ACTIVE;

			/////////////////////////////////////////////////////////////////////////////

			if(!uvm_config_db #(virtual uart_if)::get(this, "", "uartif", uart_cfg.uart_vif))
				`uvm_fatal("build_phase", "Unable - to -get -vif -from uvm_config")

			uvm_config_db #(uart_config_obj)::set(this, "*", "uart_cfg", uart_cfg);
			uart_cfg.active = UVM_PASSIVE;

			///////////////////////////////////////////////////////////////////////////////

			if(!uvm_config_db #(virtual SYNC_if)::get(this, "", "SYNCif", SYNC_cfg.SYNC_vif))
				`uvm_fatal("build_phase", "Unable - to -get -vif -from uvm_config")

			uvm_config_db #(SYNC_config_obj)::set(this, "*", "SYNC_cfg", SYNC_cfg);
			SYNC_cfg.active = UVM_PASSIVE;

			//////////////////////////////////////////////////////////////////////////////////

			if(!uvm_config_db #(virtual reg_file_if)::get(this, "", "reg_fileif", reg_file_cfg.reg_fileif_v))
				`uvm_fatal("build_phase", "Unable - to -get -vif -from uvm_config")

			uvm_config_db #(reg_file_config_obj)::set(this, "*", "reg_file_cfg", reg_file_cfg);
			reg_file_cfg.active = UVM_PASSIVE;

			////////////////////////////////////////////////////////////////////////////////////

			if(!uvm_config_db #(virtual FIFO_if)::get(this, "", "FIFOif", FIFO_cfg.FIFO_vif))
				`uvm_fatal("build_phase", "Unable - to -get -vif -from uvm_config")

			uvm_config_db #(FIFO_config_obj)::set(this, "*", "FIFO_cfg", FIFO_cfg);
			FIFO_cfg.active = UVM_PASSIVE;

			/////////////////////////////////////////////////////////////////////////////////////

			if(!uvm_config_db #(virtual TX_if)::get(this, "", "TXif", TX_cfg.TX_vif))
				`uvm_fatal("build_phase", "Unable - to -get -vif -from uvm_config")

			uvm_config_db #(TX_config_obj)::set(this, "*", "TX_cfg", TX_cfg);
			TX_cfg.active = UVM_PASSIVE;

			//////////////////////////////////////////////////////////////////////////////////////


		endfunction

		// end_of_elaboration_phase:- print_topology executes in bottom up manner.

		virtual function void end_of_elaboration_phase(uvm_phase phase);
			super.end_of_elaboration_phase(phase);
			uvm_top.print_topology();	
		endfunction


		virtual task run_phase(uvm_phase phase);
			super.run_phase(phase);
			phase.raise_objection(this);
			`uvm_info(get_type_name(), "Reset Asserted", UVM_LOW);
			reset_seq.start(sys_myenv.agent.sequencer);
			`uvm_info(get_type_name(), "Reset Deasserted", UVM_LOW);

			`uvm_info(get_type_name(), "Stimulus Generation Started", UVM_LOW);

			`uvm_info(get_type_name(), "Running Main Sequence...", UVM_LOW);
			main_seq.start(sys_myenv.agent.sequencer);

			`uvm_info(get_type_name(), "Stimulus Generation Ended", UVM_LOW);
			phase.drop_objection(this);

			phase.phase_done.set_drain_time(this, 50);

			//After dropping the objection, this sets a drain time of 50 simulation time units for the current phase. 
			//This gives a bit of extra time (50 units) after all objections have been dropped to allow any
			//ongoing transactions or processes to gracefully finish before the phase officially ends.


		endtask


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
endpackage