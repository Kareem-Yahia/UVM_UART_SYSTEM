

	class TX_scoreboard extends uvm_scoreboard;
		`uvm_component_utils(TX_scoreboard)

		uvm_analysis_export #(TX_seq_item) sb_export;
		uvm_tlm_analysis_fifo #(TX_seq_item) sb_fifo;
		TX_seq_item seq_item_sb;
		
		int error_count=0;
		int correct_count=0;
		
		int flag=0;
		int end_count = 0 ;
		int counter=0;

		bit parity_enable_reserved =  PAR_ENABLE;
		bit parity_type_reserved = EVEN ;
		logic parity_ex ;
		logic [7:0] p_data_reserved = 0;
		logic [10:0] frame_collected = 0;



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


			
			task check_data_sent_from_TX(TX_seq_item seq_item_sb_t);

				if(seq_item_sb_t.Data_Valid === 1'b1 && seq_item_sb.TX_OUT === 1'b0 && seq_item_sb_t.rst !==0 && flag === 1'b0 ) begin
					flag=1;
					p_data_reserved  = seq_item_sb_t.P_DATA ;

					if (seq_item_sb_t.PAR_EN === PAR_ENABLE) begin
						
						parity_enable_reserved = PAR_ENABLE ;
						parity_type_reserved = seq_item_sb_t.PAR_TYP ;

						if (parity_type_reserved== EVEN) begin
							parity_ex=^(p_data_reserved);
						end
						else begin
							parity_ex=~(^(p_data_reserved));

						end

						end_count = 11;
					end

					else begin
						parity_enable_reserved = PAR_DISABLE ;
						end_count = 10;
					end
				end

				if(flag) begin
					frame_collected[counter] = seq_item_sb_t.TX_OUT ;
					counter = counter + 1;

				end

				if(counter === end_count && flag) begin
					check_results_out_off_system( p_data_reserved, parity_ex ,frame_collected ,parity_enable_reserved );
					counter=0;
					flag=0;
					frame_collected = 0 ;
					parity_ex = 0 ;
					p_data_reserved = 0 ;
				end


			endtask


			task check_results_out_off_system (input [7:0] p_data_reserved, input parity_ex ,input [10:0] frame_collected , input parity_enable_reserved);

				if(p_data_reserved !=frame_collected[8:1]) begin
					`uvm_error("Scoreboard - UART_TX" , $sformatf("TX_ERROR:Time=%0t DATA=%0b  but---> Expected=%0b\n",$time,frame_collected[8:1],p_data_reserved) );
					error_count++;
				end
				else begin
					`uvm_info("Scoreboard - UART_TX" , $sformatf("TX_DONE:Time=%0t DATA=%0b  Also---> Expected=%0b\n",$time,frame_collected[8:1],p_data_reserved) ,  UVM_MEDIUM);
					correct_count++;
				end

				if(parity_enable_reserved) begin
					if(parity_ex !=frame_collected[9]) begin
						`uvm_error("Scoreboard - UART_TX" , $sformatf("TX_ERROR:Time=%0t parity=%0b  but---> Expected=%0b\n",$time,frame_collected[9],parity_ex));
						error_count++;
					end
					else begin
						`uvm_info("Scoreboard - UART_TX" , $sformatf("TX_DONE:Time=%0t parity=%0b  and---> Expected=%0b\n",$time,frame_collected[9],parity_ex) , UVM_MEDIUM );
						correct_count++;
					end
				end	

			endtask
			
		

			task run_phase(uvm_phase phase);
				super.run_phase(phase);
				forever begin
					sb_fifo.get(seq_item_sb);
				    `uvm_info("Scoreboard UART_TX",$sformatf("UART TX Frame Sent : %s",seq_item_sb.convert2string()),UVM_MEDIUM)
					check_data_sent_from_TX(seq_item_sb);
				end
			endtask

			function void report_phase(uvm_phase phase);
				super.report_phase(phase);
				`uvm_info("Scoreboard UART_TX Reporting",$sformatf("totall successful transaction=%d",correct_count/2),UVM_MEDIUM)
				`uvm_info("Scoreboard UART_TX Reporting",$sformatf("totall error transaction=%d",error_count/2),UVM_MEDIUM)
			endfunction

	endclass 