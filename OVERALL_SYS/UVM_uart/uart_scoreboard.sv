
	class uart_scoreboard extends uvm_scoreboard;
		`uvm_component_utils(uart_scoreboard)

		uvm_analysis_export #(uart_seq_item) sb_export;
		uvm_tlm_analysis_fifo #(uart_seq_item) sb_fifo;
		uart_seq_item seq_item_sb;
		
		int error_count=0;
		int correct_count=0;

		// Declaring Analysis Port To Send to Top Level Scoreboard
		uvm_analysis_port # (uart_seq_item) sb_port_uart_rx ; 

		// Golden Model Logic

		int flag=0;
		int counter=0;
		logic [10:0] Frame_Collected = 0;
		int end_count = 0 ;
		int stop_location = 10 ;
		int parity_enable_reserved = PAR_ENABLE;
		int parity_type_reserved =EVEN ;

			function new(string name="uart_scoreboard" , uvm_component parent=null);
				super.new(name,parent);
			endfunction

			function void build_phase(uvm_phase phase);
				super.build_phase(phase);
				sb_export=new("sb_export",this);
				sb_fifo=new("sb_fifo",this);
				sb_port_uart_rx = new ("sb_port_uart_rx", this);

			endfunction

			function void connect_phase(uvm_phase phase);
				super.connect_phase(phase);
				sb_export.connect(sb_fifo.analysis_export);
			endfunction


			task check_result_RX_hex(input [10:0] check_frame , uart_seq_item seq_item_sb_t , int parity_enable_reserved , int parity_type_reserved);
				
				// Data Check

				if(seq_item_sb_t.P_DATA_reg != check_frame[8:1] ) begin
					`uvm_error("Scoreboard - UART_RX",$sformatf("RX_ERROR:Time=%0t P_DATA_reg=%h but---> Expected=%h\n",$time,seq_item_sb_t.P_DATA_reg,check_frame[8:1]))
					error_count++;
				end
				else begin
					`uvm_info("Scoreboard - UART_RX",$sformatf("RX_DONE:Time=%0t P_DATA_reg=%h Also---> Expected=%h\n",$time,seq_item_sb_t.P_DATA_reg,check_frame[8:1]),UVM_MEDIUM)
					correct_count++;
				end

				// Parity Check

				if(parity_enable_reserved) begin

					if ( parity_type_reserved == EVEN ) begin

						if (check_frame[9] != ^check_frame[8:1]) begin
							if (seq_item_sb_t.par_err_reg) begin
								`uvm_warning("Scoreboard UART_RX (-ve)",$sformatf("RX_DONE:Time=%0t Input Parity wrong TB Must be Fixed Expected Even Parity \n ",$time))
							end
							else begin
								`uvm_error("Scoreboard UART_RX (-ve)",$sformatf("RX_DONE:Time=%0t Input Parity wrong and RX Not flagging Parity Error \n ",$time))
								error_count++;
							end
						end

					end 
					else if (parity_type_reserved == ODD ) begin
						if (check_frame[9] != ~(^check_frame[8:1]) ) begin
							if (seq_item_sb_t.par_err_reg) begin
								`uvm_warning("Scoreboard UART_RX (-ve)",$sformatf("RX_DONE:Time=%0t Input Parity wrong TB Must be Fixed Expected ODD Parity \n ",$time))
							end
							else begin
								`uvm_error("Scoreboard UART_RX (-ve)",$sformatf("RX_DONE:Time=%0t Input Parity wrong and RX Not flagging Parity Error \n ",$time))
								error_count++;

							end
						end
					end	
					
				end
				
				
				// Stop  Bit Check

				if(parity_enable_reserved) begin
					stop_location = 10;
				end 
				else begin
					stop_location = 9;

				end


				if (check_frame[stop_location] != 1'b1 ) begin
					if (seq_item_sb_t.stp_error_reg) begin
						`uvm_warning("Scoreboard UART_RX (-ve): ",$sformatf("RX_DONE:Time=%0t Input Stop bit  wrong TB Must be Fixed Expected Stop bit = 1 \n ",$time))
					end
					else begin
						`uvm_error("Scoreboard UART_RX (-ve): ",$sformatf("RX_DONE:Time=%0t Input Stop Bit  wrong and RX Not flagging Stop Bit Error \n ",$time))
						 error_count++;

					end
				end

				// Data Valid Check 

				if(seq_item_sb_t.data_valid_reg !=1'b1 ) begin
					`uvm_error("Scoreboard - UART_RX",$sformatf("RX_ERROR:Time=%0t data_valid_reg=%b but---> Expected= 1 \n",$time,seq_item_sb_t.data_valid_reg));
					error_count++;
				end
				else begin
					`uvm_info("Scoreboard - UART_RX",$sformatf("RX_DONE:Time=%0t data_valid_reg=%b Also---> Expected= 1 \n",$time,seq_item_sb_t.data_valid_reg),UVM_MEDIUM);
					correct_count++;
				end

			endtask



			task golden_model(uart_seq_item seq_item_sb_t);


				if(seq_item_sb_t.RX_IN === 1'b0 && seq_item_sb_t.rst !==0 && flag === 1'b0 ) begin
					flag=1;
					if (seq_item_sb_t.PAR_EN === PAR_ENABLE) begin
						parity_enable_reserved = PAR_ENABLE ;
						parity_type_reserved = seq_item_sb_t.PAR_TYP ;
						end_count = 11;
					end

					else begin
						parity_enable_reserved = PAR_DISABLE ;
						end_count = 10;
					end
				end

				if(flag) begin
					Frame_Collected[counter] = seq_item_sb_t.RX_IN ;
					counter = counter + 1;
			   		`uvm_info("Scoreboard - UART_RX",$sformatf("UART RX Received  :%s",seq_item_sb_t.convert2string()),UVM_HIGH)
				end

				if(counter === end_count && flag) begin
					check_result_RX_hex(Frame_Collected ,seq_item_sb_t , parity_enable_reserved , parity_type_reserved );
					counter=0;
					flag=0;
					Frame_Collected = 0 ;

					sb_port_uart_rx.write(seq_item_sb_t);
				end
			endtask


			task run_phase(uvm_phase phase);
				super.run_phase(phase);
				forever begin
					sb_fifo.get(seq_item_sb);
					golden_model(seq_item_sb);
				end
			endtask

			function void report_phase(uvm_phase phase);
				super.report_phase(phase);
				`uvm_info("Scoreboard UART_RX Reporting",$sformatf("Totall Successful Transaction=%d",correct_count/2),UVM_MEDIUM)
				`uvm_info("Scoreboard UART_RX Reporting",$sformatf("Totall Error Transaction=%d",error_count/2),UVM_MEDIUM)
			endfunction

	endclass