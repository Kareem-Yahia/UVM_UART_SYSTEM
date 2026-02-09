
	class SYNC_sequencer extends uvm_sequencer #(SYNC_seq_item);
		`uvm_component_utils(SYNC_sequencer)

		function new(string name="SYNC_sequencer",uvm_component parent=null);
			super.new(name,parent);
		endfunction

	endclass
