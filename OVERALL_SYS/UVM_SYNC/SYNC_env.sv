
	class SYNC_env extends uvm_env;
		`uvm_component_utils(SYNC_env)

		SYNC_agent agent;
		SYNC_scoreboard score_board;
		
		SYNC_cov cov; 


		function new(string name="SYNC_env" , uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			agent=SYNC_agent::type_id::create("agent",this);
			score_board=SYNC_scoreboard::type_id::create("score_board",this);
			cov=SYNC_cov::type_id::create("cov",this);

		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			agent.agt_ap.connect(score_board.sb_export);
			agent.agt_ap.connect(cov.cov_export);
		endfunction

	endclass
