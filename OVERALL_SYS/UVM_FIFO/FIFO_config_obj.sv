
	class FIFO_config_obj extends uvm_object;
		`uvm_object_utils(FIFO_config_obj)
		virtual FIFO_if FIFO_vif;
		uvm_active_passive_enum active;


		///////////////////////////// here_____________--we--_____________list_________ data /////////////////////////

		function new(string name="FIFO_config_obj");
			super.new(name);
		endfunction

	endclass