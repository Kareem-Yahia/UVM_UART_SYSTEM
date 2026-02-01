
	class TX_scoreboard extends uvm_scoreboard;
		`uvm_component_utils(TX_scoreboard)

		uvm_analysis_export #(TX_seq_item) sb_export;
		uvm_tlm_analysis_fifo #(TX_seq_item) sb_fifo;
		TX_seq_item seq_item_sb;
		
		int error_count=0;
		int correct_count=0;
		static int flag=0;
		static int counter=0;
		logic [7:0] frame;



			function new(string name="TX_scoreboard" , uvm_component parent=null);
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


			/*
			task check_data_sent_from_TX(input [7:0] DATA_t,input parity_type=EVEN,input parity_enable=1);
				if (parity_type== EVEN)
						parity_ex=^(DATA_t);
					else
						parity_ex=~(^(DATA_t));

				if (parity_enable)
					end_count=11;
				else
					end_count=10;
								Frame_Collected=0;

				//Here We Collect Frame
					
					repeat(prescaler_time_sync) @(negedge SYS_TOP.TX_CLK);
				Frame_Collected[0]=TX_OUT;

				for(int i=1;i<end_count;i++) begin
					@(negedge SYS_TOP.TX_CLK)
					Frame_Collected[i]=TX_OUT;
				end
				check_results_out_off_system(DATA_t);
				 @(negedge TX_CLK_TB);
			endtask


			task check_results_out_off_system (input [7:0] DATA_t,input parity_enable=1);
				 @(negedge SYS_TOP.TX_CLK);
				if(DATA_t !=Frame_Collected[8:1]) begin
					$display("TX_ERROR:Time=%0t DATA=%0b  but---> Expected=%0b\n",$time,Frame_Collected[8:1],DATA_t);
					error_count++;
				end
				else begin
					$display("TX_DONE:Time=%0t DATA=%0b  and---> Expected=%0b\n",$time,Frame_Collected[8:1],DATA_t);
					correct_count++;
				end

				if(parity_enable) begin
					if(parity_ex !=Frame_Collected[9]) begin
						$display("TX_ERROR:Time=%0t parity=%0b  but---> Expected=%0b\n",$time,Frame_Collected[9],parity_ex);
						error_count++;
					end
					else begin
						$display("TX_DONE:Time=%0t parity=%0b  and---> Expected=%0b\n",$time,Frame_Collected[9],parity_ex);
						correct_count++;
					end
				end		
			endtask
			*/




			task run_phase(uvm_phase phase);
				super.run_phase(phase);
				forever begin
					sb_fifo.get(seq_item_sb);
				`uvm_info("score_board(TX)",$sformatf("Done in TX DUT:%s",seq_item_sb.convert2string()),UVM_MEDIUM)
					//check_TXronizer();
				end
			endtask

			function void report_phase(uvm_phase phase);
				super.report_phase(phase);
				`uvm_info("run_phase",$sformatf("totall successful transaction=%d",correct_count/2),UVM_MEDIUM)
				`uvm_info("run_phase",$sformatf("totall error transaction=%d",error_count/2),UVM_MEDIUM)
			endfunction

	endclass

