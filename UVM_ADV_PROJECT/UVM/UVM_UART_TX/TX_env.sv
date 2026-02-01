
	class TX_env extends uvm_env;
		`uvm_component_utils(TX_env)

		TX_agent agent;
		TX_scoreboard score_board;
		
		TX_cov cov; 


		function new(string name="TX_env" , uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			agent=TX_agent::type_id::create("agent",this);
			score_board=TX_scoreboard::type_id::create("score_board",this);
			cov=TX_cov::type_id::create("cov",this);

		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			agent.agt_ap.connect(score_board.sb_export);
			agent.agt_ap.connect(cov.cov_export);
		endfunction

	endclass
