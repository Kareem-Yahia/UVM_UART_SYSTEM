package sys_config_obj_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class sys_config_obj extends uvm_object;
		`uvm_object_utils(sys_config_obj)
		virtual sys_if  sys_vif;
		uvm_active_passive_enum active;


		///////////////////////////// here_____________--we--_____________list_________ data /////////////////////////

		function new(string name="sys_config_obj");
			super.new(name);
		endfunction

	endclass

endpackage