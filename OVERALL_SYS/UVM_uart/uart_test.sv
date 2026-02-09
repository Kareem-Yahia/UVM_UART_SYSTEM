
	class uart_base_test extends uvm_test;
		`uvm_component_utils(uart_base_test)

		uart_env env;

		function new(string name = "uart_base_test", uvm_component parent = null);
			super.new(name, parent);
		endfunction : new

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			env = uart_env::type_id::create("env", this);
		endfunction

	endclass 

	class uart_test1 extends uart_base_test;
		`uvm_component_utils(uart_test1)
		
		uart_config_obj cfg;

		uart_sequence_reset reset_seq;
		uart_sequence_main main_seq;

		function new(string name = "uart_test1", uvm_component parent = null);
			super.new(name, parent);
		endfunction : new

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			reset_seq 		= uart_sequence_reset::type_id::create("reset_seq");
			main_seq  		= uart_sequence_main::type_id::create("main_seq");
			cfg = uart_config_obj::type_id::create("cfg");
			

			if(!uvm_config_db #(virtual uart_if)::get(this, "", "uartif", cfg.uart_vif))
				`uvm_fatal("build_phase", "Unable - to -get -vif -from uvm_config")

			uvm_config_db #(uart_config_obj)::set(this, "*", "uart_CFG", cfg);
			cfg.active = UVM_ACTIVE;

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
			reset_seq.start(env.agent.sequencer);
			`uvm_info(get_type_name(), "Reset Deasserted", UVM_LOW);

			`uvm_info(get_type_name(), "Stimulus Generation Started", UVM_LOW);

			`uvm_info(get_type_name(), "Running Main Sequence...", UVM_LOW);
			main_seq.start(env.agent.sequencer);

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