package TX_config_obj_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class TX_config_obj extends uvm_object;
		`uvm_object_utils(TX_config_obj)
		virtual TX_if TX_vif;
		uvm_active_passive_enum active;


		///////////////////////////// here_____________--we--_____________list_________ data /////////////////////////

		function new(string name="TX_config_obj");
			super.new(name);
		endfunction

	endclass

endpackage