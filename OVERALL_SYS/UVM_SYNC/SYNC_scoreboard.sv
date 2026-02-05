package SYNC_scoreboard_pkg;

	import SYNC_seq_item_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class SYNC_scoreboard extends uvm_scoreboard;
		`uvm_component_utils(SYNC_scoreboard)

		uvm_analysis_export #(SYNC_seq_item) sb_export;
		uvm_tlm_analysis_fifo #(SYNC_seq_item) sb_fifo;
		SYNC_seq_item seq_item_sb;
		
		int error_count=0;
		int correct_count=0;
		static int flag=0;
		static int counter=0;
		logic [7:0] frame;



			function new(string name="SYNC_scoreboard" , uvm_component parent=null);
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

			task check_syncronizer();
				if(seq_item_sb.sync_bus !=seq_item_sb.unsync_bus) begin
					`uvm_error(get_type_name(),$sformatf("synchronizer_ERROR:Time=%0t out=%8b but---> Expected=%8b\n",$time,seq_item_sb.sync_bus,seq_item_sb.unsync_bus));
					error_count++;
				end
				else begin
					`uvm_info(get_type_name(),$sformatf("synchronizer_Done:Time=%0t out=%8b and---> Expected=%8b\n",$time,seq_item_sb.sync_bus,seq_item_sb.unsync_bus),UVM_MEDIUM);
					correct_count++;
				end

			endtask

			
			task run_phase(uvm_phase phase);
				super.run_phase(phase);
				forever begin
					sb_fifo.get(seq_item_sb);
				`uvm_info("score_board(SYNC)",$sformatf("Done in SYNC DUT:%s",seq_item_sb.convert2string()),UVM_MEDIUM)
					check_syncronizer();
				end
			endtask

			function void report_phase(uvm_phase phase);
				super.report_phase(phase);
				`uvm_info("run_phase",$sformatf("totall successful transaction=%d",correct_count/2),UVM_MEDIUM)
				`uvm_info("run_phase",$sformatf("totall error transaction=%d",error_count/2),UVM_MEDIUM)
			endfunction

	endclass

endpackage 