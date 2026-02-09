
	class reg_file_env extends uvm_env ;
		`uvm_component_utils(reg_file_env)

		//ral_env ral_env_model;
		reg_file_agent main_agent;
		reg_file_scoreboard score_board;

		function new(string name="reg_file_env",uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			main_agent=reg_file_agent::type_id::create("main_agent",this);
			score_board=reg_file_scoreboard::type_id::create("score_board",this);
			//ral_env_model=ral_env::type_id::create("ral_env_model",this);
			//uvm_reg::include_coverage("*",UVM_CVR_ALL);

		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
				main_agent.agent_ap.connect(score_board.sb_export);

				///////////////////////////////////////////////////////////
				//ral_env_model.ral_agent=main_agent;
				//main_agent.agent_ap.connect(ral_env_model.predictor.bus_in);

				//here we will connect ral model to adapter to sequencer
				//ral_env_model.ral_model.default_map.set_sequencer(main_agent.sequencer,ral_env_model.adapter);
				//ral_env_model.ral_model.default_map.set_auto_predict(0); //edit here
		endfunction

	endclass
