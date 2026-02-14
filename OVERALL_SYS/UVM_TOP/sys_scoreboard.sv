
	class top_sys_scoreboard extends uvm_scoreboard;
		`uvm_component_utils(top_sys_scoreboard)

		uvm_analysis_export #(sys_seq_item) sb_export_sys;
		uvm_analysis_export #(uart_seq_item) sb_export_uart_rx;
		uvm_analysis_export #(TX_seq_item) sb_export_uart_tx;
		uvm_analysis_export #(SYNC_seq_item) sb_export_sync;

		uvm_tlm_analysis_fifo #(sys_seq_item) sb_fifo_sys;
		uvm_tlm_analysis_fifo #(uart_seq_item) sb_fifo_uart_rx;
		uvm_tlm_analysis_fifo #(TX_seq_item) sb_fifo_uart_tx;
		uvm_tlm_analysis_fifo #(SYNC_seq_item) sb_fifo_sync;


		sys_seq_item 		sys_seq_item_inst;
		uart_seq_item 	  uart_seq_item_inst ;
		TX_seq_item 		TX_seq_item_inst ;
		SYNC_seq_item 	  SYNC_seq_item_inst ;


		int error_count=0;
		int correct_count=0;



			function new(string name="top_sys_scoreboard" , uvm_component parent=null);
				super.new(name,parent);
			endfunction

			function void build_phase(uvm_phase phase);
				super.build_phase(phase);

				sb_export_sys 		= new("sb_export_sys",this);
				sb_export_uart_rx	= new("sb_export_uart_rx",this);
				sb_export_uart_tx	= new("sb_export_uart_tx",this);
				sb_export_sync		= new("sb_export_sync",this);

				sb_fifo_sys			= new("sb_fifo_sys",this);
				sb_fifo_uart_rx		= new("sb_fifo_uart_rx",this);
				sb_fifo_uart_tx		= new("sb_fifo_uart_tx",this);
				sb_fifo_sync		= new("sb_fifo_sync",this);

			endfunction

			function void connect_phase(uvm_phase phase);
				super.connect_phase(phase);

				sb_export_sys.connect(sb_fifo_sys.analysis_export);
				sb_export_uart_rx.connect(sb_fifo_uart_rx.analysis_export);
				sb_export_uart_tx.connect(sb_fifo_uart_tx.analysis_export);
				sb_export_sync.connect(sb_fifo_sync.analysis_export);

			endfunction

			task reg_file_golden ();
				// register file of 8 registers each of 16 bits width
				logic [WIDTH-1:0] temp_mem [DEPTH-1:0] ;    
				/*
				if(!RST) begin
			      for (int k=0 ; k < DEPTH ; k = k +1) begkn
					 if(k==2)
			          temp_mem[k] <= 'b100000_01 ;
					 else if (k==3) 
			          temp_mem[k] <= 'b0010_0000 ;
			         else
			          temp_mem[k] <= 'b0 ;		 
			    	end
				end
				else if (WrEn && !RdEn) begin
				  temp_mem[Address] <= WrData ;
				end

				else if (RdEn && !WrEn) begin    
				   RdData <= temp_mem[Address] ;
				   RdData_VLD <= 1'b1 ;
				end  
				else begin
				   RdData_VLD <= 1'b0 ;
				 end	 
				end
				*/
			endtask


			task check_alu_golden (int operand_1_temp,int operand_2_temp ,int opcode_temp ,int P_DATA);
				int expected_results ;
				case (opcode_temp) 
		          4'b0000: begin
		                    expected_results = operand_1_temp+operand_2_temp;
		                   end
		          4'b0001: begin
		                    expected_results = operand_1_temp-operand_2_temp;
		                   end
		          4'b0010: begin
		                    expected_results = operand_1_temp*operand_2_temp;
		                   end
		          4'b0011: begin
		                    expected_results = operand_1_temp/operand_2_temp;
		                   end
		          4'b0100: begin
		                    expected_results = operand_1_temp & operand_2_temp;
		                   end
		          4'b0101: begin
		                    expected_results = operand_1_temp | operand_2_temp;
		                   end
		          4'b0110: begin
		                    expected_results = ~ (operand_1_temp & operand_2_temp);
		                   end
		          4'b0111: begin
		                    expected_results = ~ (operand_1_temp | operand_2_temp);
		                   end     
		          4'b1000: begin
		                    expected_results =  (operand_1_temp ^ operand_2_temp);
		                   end
		          4'b1001: begin
		                    expected_results = ~ (operand_1_temp ^ operand_2_temp);
		                   end           
		          4'b1010: begin
		                   if (operand_1_temp==operand_2_temp)
		                      expected_results = 'b1;
		                   else
		                      expected_results = 'b0;
		                   end
		          4'b1011: begin
		                    if (operand_1_temp>operand_2_temp)
		                      expected_results = 'b10;
		                    else
		                      expected_results = 'b0;
		                   end 
		          4'b1100: begin
		                    if (operand_1_temp<operand_2_temp)
		                      expected_results = 'b11;
		                    else
		                      expected_results = 'b0;
		                   end     
		          4'b1101: begin
		                    expected_results = operand_1_temp>>1;
		                   end
		          4'b1110: begin 
		                    expected_results = operand_1_temp<<1;
		                   end
		         default: begin
		                    expected_results = 'b0;
		                  end
		         endcase


		         if(P_DATA != expected_results ) begin
					`uvm_error("Scoreboard - TOP_SYS",$sformatf("SYS_TOP ERROR:Time=%0t ALU OUT = %d  but---> Expected= %d \n",$time,P_DATA,expected_results ));
					error_count++;
				end
				else begin
					`uvm_info("Scoreboard - TOP_SYS",$sformatf("SYS_TOP DONE:Time=%0t ALU OUT = %d  Also---> Expected= %d \n",$time,P_DATA ,expected_results),UVM_MEDIUM);
					correct_count++;
				end

			endtask


			task check_command_type();
			

				logic [3:0] address_temp = 0 ;
				logic [7:0] data_temp  	= 0 ;
				int operand_1_temp;
				int operand_2_temp;
				int opcode_temp;

				sb_fifo_uart_rx.get(uart_seq_item_inst);
				sb_fifo_sync.get(SYNC_seq_item_inst);

				if (SYNC_seq_item_inst.sync_bus == WR_CMD )  begin
					`uvm_info("Scoreboard SYS",$sformatf("\n\n ********** System Received Reg File Write Command = %h \n\n",SYNC_seq_item_inst.sync_bus),UVM_MEDIUM)


					sb_fifo_uart_rx.get(uart_seq_item_inst);
					sb_fifo_sync.get(SYNC_seq_item_inst);
					address_temp = SYNC_seq_item_inst.sync_bus ;
					`uvm_info("Scoreboard SYS",$sformatf("\n\n ********** System Received Address of Reg File Write Command = %d \n\n",SYNC_seq_item_inst.sync_bus),UVM_MEDIUM)


					sb_fifo_uart_rx.get(uart_seq_item_inst);
					sb_fifo_sync.get(SYNC_seq_item_inst);
					data_temp = SYNC_seq_item_inst.sync_bus ;

					`uvm_info("Scoreboard SYS",$sformatf("\n\n ********** System Received Data of Reg File Write Command:  = %d and Address = %d  \n\n",SYNC_seq_item_inst.sync_bus , address_temp),UVM_MEDIUM)


				end 
				else if (SYNC_seq_item_inst.sync_bus == RD_CMD) begin
					`uvm_info("Scoreboard SYS",$sformatf("\n\n ********** System Received Reg File Read Command = %h \n\n",SYNC_seq_item_inst.sync_bus),UVM_MEDIUM)

					sb_fifo_uart_rx.get(uart_seq_item_inst);
					sb_fifo_sync.get(SYNC_seq_item_inst);
					address_temp = SYNC_seq_item_inst.sync_bus ;
					`uvm_info("Scoreboard SYS",$sformatf("\n\n ********** System Received Address of Reg File Read Command = %d \n\n",SYNC_seq_item_inst.sync_bus),UVM_MEDIUM)


					sb_fifo_uart_tx.get(TX_seq_item_inst);

					`uvm_info("Scoreboard SYS",$sformatf("\n\n ********** System TX Sending  Data of Reg File Read Command:  = %d and Address = %d  \n\n",TX_seq_item_inst.P_DATA , address_temp),UVM_MEDIUM)
					

				end

				else if (SYNC_seq_item_inst.sync_bus == ALU_WITH_OP)  begin
					`uvm_info("Scoreboard SYS",$sformatf("\n\n ********** System Received ALU With Operand Command = %h \n\n",SYNC_seq_item_inst.sync_bus),UVM_MEDIUM)

					sb_fifo_uart_rx.get(uart_seq_item_inst);
					sb_fifo_sync.get(SYNC_seq_item_inst);
					operand_1_temp = SYNC_seq_item_inst.sync_bus ;

					`uvm_info("Scoreboard SYS",$sformatf("\n\n ********** System Received Operand operand_1_temp  = %d \n\n",SYNC_seq_item_inst.sync_bus),UVM_MEDIUM)

					sb_fifo_uart_rx.get(uart_seq_item_inst);
					sb_fifo_sync.get(SYNC_seq_item_inst);
					operand_2_temp = SYNC_seq_item_inst.sync_bus ;

					`uvm_info("Scoreboard SYS",$sformatf("\n\n ********** System Received Operand operand_2_temp  = %d \n\n",SYNC_seq_item_inst.sync_bus),UVM_MEDIUM)

					sb_fifo_uart_rx.get(uart_seq_item_inst);
					sb_fifo_sync.get(SYNC_seq_item_inst);
					opcode_temp = SYNC_seq_item_inst.sync_bus ;

					`uvm_info("Scoreboard SYS",$sformatf("\n\n ********** System Received Fun OP Code  = %operand_2_temp \n\n",SYNC_seq_item_inst.sync_bus),UVM_MEDIUM)

					sb_fifo_uart_tx.get(TX_seq_item_inst);

					`uvm_info("Scoreboard SYS",$sformatf("\n\n ********** System TX Sending  Data of Reg File Read Command:  = %d and Address = %d  \n\n",TX_seq_item_inst.P_DATA , address_temp),UVM_MEDIUM)
					
					check_alu_golden(operand_1_temp,operand_2_temp , opcode_temp , TX_seq_item_inst.P_DATA);

					
				end

				else if (SYNC_seq_item_inst.sync_bus == ALU_WITHOUT_OP) begin
					
				end

			endtask



			task run_phase(uvm_phase phase);
				super.run_phase(phase);
				forever begin
			
				check_command_type();
				
				end
			endtask

			function void report_phase(uvm_phase phase);
				super.report_phase(phase);
				`uvm_info("Scoreboard SYS Reporting",$sformatf("totall successful transaction=%d",correct_count/2),UVM_MEDIUM)
				`uvm_info("Scoreboard SYS Reporting",$sformatf("totall error transaction=%d",error_count/2),UVM_MEDIUM)
			endfunction

	endclass 