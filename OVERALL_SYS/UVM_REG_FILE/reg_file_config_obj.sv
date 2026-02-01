package reg_file_config_obj_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class reg_file_config_obj extends uvm_object;
		`uvm_object_utils(reg_file_config_obj)
		virtual reg_file_if  reg_fileif_v;
		uvm_active_passive_enum active;


		///////////////////////////// here_____________--we--_____________list_________ data /////////////////////////

		function new(string name="reg_file_config_obj");
			super.new(name);
		endfunction

	endclass

endpackage