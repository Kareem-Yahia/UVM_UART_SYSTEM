
	class uart_config_obj extends uvm_object;
		`uvm_object_utils(uart_config_obj)
		virtual uart_if  uart_vif;
		uvm_active_passive_enum active;


		///////////////////////////// here_____________--we--_____________list_________ data /////////////////////////

		function new(string name="uart_config_obj");
			super.new(name);
		endfunction

	endclass
