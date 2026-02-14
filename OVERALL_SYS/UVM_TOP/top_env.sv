
class top_env extends uvm_env;
	`uvm_component_utils(top_env)

	// Enviornments 
	sys_env sys_myenv;
	uart_env uart_myenv;
	SYNC_env SYNC_myenv;
	reg_file_env reg_file_myenv;
	FIFO_env FIFO_myenv;
	TX_env  TX_myenv;
	sys_vsequencer sys_vsequencer_inst;




	// Top Scorebord

	top_sys_scoreboard top_sys_scorebord_inst;

	function new(string name="top_env" , uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		// Environments Build 

		sys_myenv = sys_env::type_id::create("sys_myenv", this);
		uart_myenv = uart_env::type_id::create("uart_myenv", this);
		SYNC_myenv = SYNC_env::type_id::create("SYNC_myenv", this);
		reg_file_myenv = reg_file_env::type_id::create("reg_file_myenv", this);
		FIFO_myenv = FIFO_env::type_id::create("FIFO_myenv", this);
		TX_myenv = TX_env::type_id::create("TX_myenv", this);
		sys_vsequencer_inst = sys_vsequencer::type_id::create("sys_vsequencer_inst", this);

		// TOP Scoreboard

		top_sys_scorebord_inst=top_sys_scoreboard::type_id::create("top_sys_scorebord_inst",this);


	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		sys_vsequencer_inst.sys_sequencer_inst = sys_myenv.agent.sequencer ;
		sys_vsequencer_inst.reg_file_sequencer_inst= reg_file_myenv.main_agent.sequencer ;
		sys_vsequencer_inst.uart_sequencer_inst = uart_myenv.agent.sequencer  ;
		sys_vsequencer_inst.TX_sequencer_inst = TX_myenv.agent.sequencer ;
		sys_vsequencer_inst.SYNC_sequencer_inst = SYNC_myenv.agent.sequencer ;
		sys_vsequencer_inst.FIFO_sequencer_inst = FIFO_myenv.agent.sequencer;



		sys_myenv.sys_env_ap.connect(top_sys_scorebord_inst.sb_export_sys);
		uart_myenv.score_board.sb_port_uart_rx.connect (top_sys_scorebord_inst.sb_export_uart_rx) ;	
		SYNC_myenv.score_board.sb_port_uart_sync.connect (top_sys_scorebord_inst.sb_export_sync) ;	
		TX_myenv.score_board.sb_port_uart_tx.connect (top_sys_scorebord_inst.sb_export_uart_tx) ;	

	endfunction

endclass