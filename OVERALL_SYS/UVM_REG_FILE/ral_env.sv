package ral_env_pkg;

	import reg2reg_file_adapter_pkg::*;
	import ral_sys_reg_file_config_pkg::*;
	import reg2reg_file_adapter_pkg::*;
	import reg_file_agent_pkg::*;
	import reg_file_seq_item_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	class ral_env extends uvm_env;
		`uvm_component_utils(ral_env)

		reg2reg_file_adapter adapter;
		ral_sys_reg_file_config ral_model;
		uvm_reg_predictor #(reg_file_seq_item) predictor;
		reg_file_agent ral_agent;
		
		function new(string name="ral_env",uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			adapter=reg2reg_file_adapter::type_id::create("adapter");
			ral_model=ral_sys_reg_file_config::type_id::create("ral_model");
			predictor=uvm_reg_predictor #(reg_file_seq_item)::type_id::create("predictor",this);

			ral_model.build();
			ral_model.lock_model();//to prevent any modification

			uvm_config_db#(ral_sys_reg_file_config)::set(null, "*", "ral_model", ral_model);

		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			//// here we must make connections of predictor
			predictor.map=ral_model.default_map;
			predictor.adapter= adapter;
			// note connections of ral_model and adapter made in totall_env as sequencer not seen here 
		endfunction
	endclass
endpackage 

