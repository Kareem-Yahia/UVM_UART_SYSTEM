
	class sys_env extends uvm_env;
		`uvm_component_utils(sys_env)

		sys_agent agent;
		sys_cov cov; 
		uvm_analysis_port #(sys_seq_item) sys_env_ap;


		function new(string name="sys_env" , uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			agent=sys_agent::type_id::create("agent",this);
			cov=sys_cov::type_id::create("cov",this);
			sys_env_ap = new ("sys_env_ap",this);

		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			agent.agt_ap.connect(cov.cov_export);

			agent.agt_ap.connect(sys_env_ap);

		endfunction

	endclass