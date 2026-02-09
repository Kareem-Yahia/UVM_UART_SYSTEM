
	class FIFO_env extends uvm_env;
		`uvm_component_utils(FIFO_env)

		FIFO_agent agent;
		FIFO_scoreboard score_board;
		
		FIFO_cov cov; 


		function new(string name="FIFO_env" , uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			agent=FIFO_agent::type_id::create("agent",this);
			score_board=FIFO_scoreboard::type_id::create("score_board",this);
			cov=FIFO_cov::type_id::create("cov",this);

		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			agent.agt_ap.connect(score_board.sb_export);
			agent.agt_ap.connect(cov.cov_export);
		endfunction

	endclass
