
	class reg_file_sequencer extends uvm_sequencer #(reg_file_seq_item);
		`uvm_component_utils(reg_file_sequencer)

		function new(string name="reg_file_sequencer",uvm_component parent=null);
			super.new(name,parent);
		endfunction

	endclass