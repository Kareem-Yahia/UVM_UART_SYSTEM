package uart_scoreboard_pkg;

	import uart_seq_item_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class uart_scoreboard extends uvm_scoreboard;
		`uvm_component_utils(uart_scoreboard)

		uvm_analysis_export #(uart_seq_item) sb_export;
		uvm_tlm_analysis_fifo #(uart_seq_item) sb_fifo;
		uart_seq_item seq_item_sb;
		
		int error_count=0;
		int correct_count=0;
		static int flag=0;
		static int counter=0;
		logic [7:0] frame;



			function new(string name="uart_scoreboard" , uvm_component parent=null);
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


			task check_result_RX_hex(input [7:0] check_frame);
				if(seq_item_sb.P_DATA_reg !=check_frame ) begin
					`uvm_error(get_type_name(),$sformatf("RX_ERROR:Time=%0t P_DATA_reg=%h but---> Expected=%h\n",$time,seq_item_sb.P_DATA_reg,check_frame))
					error_count++;
				end
				else begin
					`uvm_info(get_type_name(),$sformatf("RX_DONE:Time=%0t P_DATA_reg=%h but---> Expected=%h\n",$time,seq_item_sb.P_DATA_reg,check_frame),UVM_MEDIUM)
					correct_count++;
				end
				check_valid_flag_RX_hex();

			endtask

			task check_valid_flag_RX_hex();
				if(seq_item_sb.data_valid_reg !=1'b1 ) begin
					`uvm_error(get_type_name(),$sformatf("RX_ERROR:Time=%0t data_valid_reg=%b but---> Expected= 1 \n",$time,seq_item_sb.data_valid_reg));
					error_count++;
				end
				else begin
					`uvm_info(get_type_name(),$sformatf("RX_DONE:Time=%0t data_valid_reg=%b but---> Expected= 1 \n",$time,seq_item_sb.data_valid_reg),UVM_MEDIUM);
					correct_count++;
				end
			endtask

			task golden_model(uart_seq_item seq_item_sb_t);
				if(seq_item_sb.RX_IN==0 && seq_item_sb.rst!=0) begin
					flag=1;
				end
				if(flag) begin
					counter=counter+1;
				end
				if(counter==10) begin
					if (!uvm_resource_db#(logic [7:0])::read_by_name(get_full_name(),"frame_t", frame)) begin
  						`uvm_error("ResourceDB", "Failed to get frame_t")
					end
				end
				if(counter==11) begin
					check_result_RX_hex(frame);
					counter=0;
					flag=0;
				end
			endtask


			task run_phase(uvm_phase phase);
				super.run_phase(phase);
				forever begin
					sb_fifo.get(seq_item_sb);
				`uvm_info("score_board(UART_RX)",$sformatf("Done in UART DUT:%s",seq_item_sb.convert2string()),UVM_MEDIUM)
					golden_model(seq_item_sb);
				end
			endtask

			function void report_phase(uvm_phase phase);
				super.report_phase(phase);
				`uvm_info("run_phase",$sformatf("totall successful transaction=%d",correct_count/2),UVM_MEDIUM)
				`uvm_info("run_phase",$sformatf("totall error transaction=%d",error_count/2),UVM_MEDIUM)
			endfunction

	endclass

endpackage 