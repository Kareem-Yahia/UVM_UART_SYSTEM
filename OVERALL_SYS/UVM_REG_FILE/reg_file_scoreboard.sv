package reg_file_scoreboard_pkg;

	import reg_file_seq_item_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class reg_file_scoreboard extends uvm_scoreboard;
		`uvm_component_utils(reg_file_scoreboard)
		reg_file_seq_item seq_item_sb;

		uvm_analysis_export #(reg_file_seq_item) sb_export;
		uvm_tlm_analysis_fifo #(reg_file_seq_item) sb_fifo;

		int error_count=0;
		int correct_count=0;


		function new(string name="reg_file_scoreboard",uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			sb_export=new("sb_export",this);
			sb_fifo=new("sb_fifo",this);
		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			sb_export.connect(sb_fifo.analysis_export);
		endfunction

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			forever begin
				sb_fifo.get(seq_item_sb);
				//`uvm_info("run_phase",$sformatf("Done Dut=%s",seq_item_sb.convert2string()),UVM_MEDIUM);
			end
		endtask


			function void report_phase(uvm_phase phase);
				super.report_phase(phase);
				`uvm_info("run_phase",$sformatf("totall successgul transaction=%d",correct_count),UVM_MEDIUM)
				`uvm_info("run_phase",$sformatf("totall error transaction=%d",error_count),UVM_MEDIUM)
			endfunction


	endclass
	
endpackage