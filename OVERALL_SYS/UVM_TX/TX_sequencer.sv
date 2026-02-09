
	class TX_sequencer extends uvm_sequencer #(TX_seq_item);
		`uvm_component_utils(TX_sequencer)

		function new(string name="TX_sequencer",uvm_component parent=null);
			super.new(name,parent);
		endfunction

	endclass
