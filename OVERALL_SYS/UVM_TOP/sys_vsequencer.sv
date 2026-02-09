
	class sys_vsequencer extends uvm_sequencer #(sys_seq_item);
		`uvm_component_utils(sys_vsequencer)

		sys_sequencer  sys_sequencer_inst ;
		reg_file_sequencer  reg_file_sequencer_inst ;
		uart_sequencer  uart_sequencer_inst ;
		TX_sequencer TX_sequencer_inst ;
		SYNC_sequencer  SYNC_sequencer_inst ;
		FIFO_sequencer FIFO_sequencer_inst;


		function new(string name="sys_vsequencer",uvm_component parent=null);
			super.new(name,parent);
		endfunction

	endclass
