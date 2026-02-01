package SYNC_config_obj_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class SYNC_config_obj extends uvm_object;
		`uvm_object_utils(SYNC_config_obj)
		virtual SYNC_if  SYNC_vif;
		uvm_active_passive_enum active;


		///////////////////////////// here_____________--we--_____________list_________ data /////////////////////////

		function new(string name="SYNC_config_obj");
			super.new(name);
		endfunction

	endclass

endpackage