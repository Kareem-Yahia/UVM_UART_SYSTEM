`timescale 1ns/10ps
module SYS_TOP_tb();

	parameter clk_period_REF_CLK=20;
	parameter clk_period_UART_CLK=271.26;
	parameter TX_CLK_PERIOD=8680.55;
	parameter EVEN=0;
	parameter ODD=1;
	parameter PAR_ENABLE=1;
	parameter PAR_DISABLE=0;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	logic TX_CLK_TB;
	logic REF_CLK;
	logic UART_CLK;

	logic RST;
	logic RX_IN;
	logic  TX_OUT;
	logic  par_err_reg,stp_error_reg;

	typedef enum {IDLE,RF_WR_ADDR,RF_WR_DATA,RF_RD_ADDR,RF_SEND_TO_FIFO,ALU_OPERAND_A,ALU_OPERAND_B,ALU_OPERAND_FUN,ALU_SEND_TO_FIFO,ALU_SEND_TO_FIFO_2,ALU_NO_OPERAND_FUN} e_states;
	typedef enum {IDLE_RX,START_RX,DATA_RX,PARITY_RX,STOP_RX} e_states_uart_RX; 
	typedef enum {IDLE_TX,START_TX,DATA_TX,PARITY_TX,STOP_TX} e_states_uart_TX;


	e_states cs_SYS_CTRL;
	e_states_uart_RX cs_UART_RX;
	e_states_uart_TX cs_UART_TX;
	//e_states ns;
	assign cs_SYS_CTRL=e_states'(SYS_TOP.SYS_CTRL.cs);
	assign cs_UART_RX=e_states_uart_RX'(SYS_TOP.RX.fsm.cs);
	assign cs_UART_TX=e_states_uart_TX'(SYS_TOP.TX.Controller_TX.cs);

	//assign ns=e_states'(SYS_TOP.SYS_CTRL.ns);

	logic [10:0] Frame_Collected=0;
	int error_count=0;
	int correct_count=0;
	int command_number=0;
	int end_count=0;
	bit [7:0] DATA_CHECK_TASK=0;
	bit [7:0] DATA_CHECK_TASK_2=0;
	logic parity_ex=0;

	logic [15:0] ALU_OUT_EX_general=0;

	bit parity_type;
	bit parity_enable;
	int prescaler_time_sync=4;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	initial begin
		REF_CLK=0;
		forever begin
			#(clk_period_REF_CLK/2) REF_CLK=~REF_CLK;
		end
	end

	initial begin
		UART_CLK=0;
		forever begin
			#(clk_period_UART_CLK/2) UART_CLK=~UART_CLK;
		end
	end

	initial begin
		TX_CLK_TB=0;
		forever begin
			#(TX_CLK_PERIOD/2) TX_CLK_TB=~TX_CLK_TB;
		end
	end

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	SYS_TOP SYS_TOP(REF_CLK,RST,UART_CLK,RX_IN,par_err_reg ,stp_error_reg,TX_OUT);

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	task send_specific_frame (input start,input [7:0] frame_t,input stop,input parity_type=EVEN,input parity_enable=1); // task used to send wrong frames
		 		 @(negedge TX_CLK_TB);
		 RX_IN=start;
		 @(negedge TX_CLK_TB);

		for (int i = 0; i < 8; i++) begin
			 RX_IN=frame_t[i];
			 @(negedge TX_CLK_TB);
		end	

		if(parity_enable) begin
			if(parity_type==EVEN)
				RX_IN=^frame_t;
			else if(parity_type==ODD)
				RX_IN=~(^frame_t);
			@(negedge TX_CLK_TB);	
		end

		RX_IN=stop;
			@(negedge TX_CLK_TB);
	endtask

	task check_result_RX_binary(input [7:0] check_frame);
		if(SYS_TOP.P_DATA_reg_RX !=check_frame) begin
			$display("RX_ERROR:Time=%0t P_DATA_reg_RX=%8b but---> Expected=%8b\n",$time,SYS_TOP.P_DATA_reg_RX,check_frame);
			error_count++;
		end
		else begin
			$display("RX_Done:Time=%0t P_DATA_reg=%8b and---> Expected=%8b\n",$time,SYS_TOP.P_DATA_reg_RX,check_frame);
			correct_count++;
		end
	endtask

	task check_result_RX_hex(input [7:0] check_frame);
		if(SYS_TOP.P_DATA_reg_RX !=check_frame) begin
			$display("RX_ERROR:Time=%0t P_DATA_reg_RX=%8h but---> Expected=%8h\n",$time,SYS_TOP.P_DATA_reg_RX,check_frame);
			error_count++;
		end
		else begin
			$display("RX_Done:Time=%0t P_DATA_reg=%8h and---> Expected=%8h\n",$time,SYS_TOP.P_DATA_reg_RX,check_frame);
			correct_count++;
		end
	endtask

	task check_result_RX_decimal(input [7:0] check_frame);
		if(SYS_TOP.P_DATA_reg_RX !=check_frame) begin
			$display("RX_ERROR:Time=%0t P_DATA_reg_RX=%d but---> Expected=%d\n",$time,SYS_TOP.P_DATA_reg_RX,check_frame);
			error_count++;
		end
		else begin
			$display("RX_Done:Time=%0t P_DATA_reg=%d and---> Expected=%d\n",$time,SYS_TOP.P_DATA_reg_RX,check_frame);
			correct_count++;
		end
	endtask

	task check_syncronizer(input [7:0] check_frame);
		 repeat (4) @(negedge REF_CLK);
		if(SYS_TOP.RX_P_Data !=check_frame) begin
			$display("synchronizer_ERROR:Time=%0t out=%8b but---> Expected=%8b\n",$time,SYS_TOP.RX_P_Data,check_frame);
			error_count++;
		end
		else begin
			$display("synchronizer_Done:Time=%0t out=%8b and---> Expected=%8b\n",$time,SYS_TOP.RX_P_Data,check_frame);
			correct_count++;
		end

	endtask

	task check_write_done_in_register_file(input [7:0] check_frame, input [3:0]Address_t);
		repeat(2) @(negedge REF_CLK);
		if(SYS_TOP.REG.regArr[Address_t] !=check_frame) begin
			$display("Register_File_ERROR:Time=%0t DATA=%d Address_t=%d but---> Expected=%d\n",$time,SYS_TOP.REG.regArr[Address_t],Address_t,check_frame);
			error_count++;
		end
		else begin
			$display("Register_File_Done:Time=%0t DATA=%d Address_t=%d and---> Expected=%d\n",$time,SYS_TOP.REG.regArr[Address_t],Address_t,check_frame);
			correct_count++;
		end
	endtask

	task check_data_in_FIFO (input [3:0]Address_t, output [7:0] DATA_OUT_t);
		repeat(2) @(negedge REF_CLK);
				DATA_OUT_t=SYS_TOP.FIFO.FIFO_Memory.FIFO_MEM[SYS_TOP.FIFO.w_addr-1'b1];

		if(SYS_TOP.FIFO.FIFO_Memory.FIFO_MEM[SYS_TOP.FIFO.w_addr-1] !=SYS_TOP.REG.regArr[Address_t]) begin
			$display("FIFO_ERROR:Time=%0t DATA=%d  but---> Expected=%d\n",$time,SYS_TOP.FIFO.FIFO_Memory.FIFO_MEM[SYS_TOP.FIFO.w_addr-1'b1],SYS_TOP.REG.regArr[Address_t]);
			error_count++;
		end
		else begin
			$display("FIFO_Done:Time=%0t DATA=%d   and---> Expected=%d\n",$time,SYS_TOP.FIFO.FIFO_Memory.FIFO_MEM[SYS_TOP.FIFO.w_addr-1'b1],SYS_TOP.REG.regArr[Address_t]);
			correct_count++;
		end
	endtask

	task check_data_in_FIFO_from_alu (output [7:0] DATA_OUT_least,output [7:0] DATA_OUT_t_most);

			
			repeat(2) @(negedge REF_CLK);
			DATA_OUT_t_most=SYS_TOP.FIFO.FIFO_Memory.FIFO_MEM[SYS_TOP.FIFO.w_addr-1'b1];
			DATA_OUT_least=SYS_TOP.FIFO.FIFO_Memory.FIFO_MEM[SYS_TOP.FIFO.w_addr-2'b10];

			if({DATA_OUT_t_most,DATA_OUT_least} !=SYS_TOP.SYS_CTRL.ALU_OUT_temp) begin
				$display("FIFO_ERROR:Time=%0t DATA=%d  but---> Expected=%d\n",$time,{DATA_OUT_t_most,DATA_OUT_least},SYS_TOP.SYS_CTRL.ALU_OUT_temp);
				error_count++;
			end
			else begin
				$display("FIFO_Done:Time=%0t DATA=%d   and---> Expected=%d\n",$time,{DATA_OUT_t_most,DATA_OUT_least},SYS_TOP.SYS_CTRL.ALU_OUT_temp);
				correct_count++;
			end
			
		
	endtask

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

	task check_data_sent_from_TX_case_mul(input [7:0] DATA_t,input parity_type=EVEN,input parity_enable=1);
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
								@(negedge SYS_TOP.TX_CLK)

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

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	task golden_model(input [3:0] ALU_FUN_t,output [15:0] ALU_OUT_EX);
		case (ALU_FUN_t) 
          4'b0000: begin
                    ALU_OUT_EX = SYS_TOP.REG0+SYS_TOP.REG1;
                   end
          4'b0001: begin
                         ALU_OUT_EX = SYS_TOP.REG0-SYS_TOP.REG1;
                   end
          4'b0010: begin
                    ALU_OUT_EX = SYS_TOP.REG0*SYS_TOP.REG1;
                   end
          4'b0011: begin
                    ALU_OUT_EX = SYS_TOP.REG0/SYS_TOP.REG1;
                   end
          4'b0100: begin
                    ALU_OUT_EX = SYS_TOP.REG0 & SYS_TOP.REG1;
                   end
          4'b0101: begin
                    ALU_OUT_EX = SYS_TOP.REG0 | SYS_TOP.REG1;
                   end
          4'b0110: begin
                    ALU_OUT_EX = ~ (SYS_TOP.REG0 & SYS_TOP.REG1);
                   end
          4'b0111: begin
                    ALU_OUT_EX = ~ (SYS_TOP.REG0 | SYS_TOP.REG1);
                   end     
          4'b1000: begin
                    ALU_OUT_EX =  (SYS_TOP.REG0 ^ SYS_TOP.REG1);
                   end
          4'b1001: begin
                    ALU_OUT_EX = ~ (SYS_TOP.REG0 ^ SYS_TOP.REG1);
                   end           
          4'b1010: begin
                   if (SYS_TOP.REG0==SYS_TOP.REG1)
                      ALU_OUT_EX = 'b1;
                   else
                      ALU_OUT_EX = 'b0;
                   end
          4'b1011: begin
                    if (SYS_TOP.REG0>SYS_TOP.REG1)
                      ALU_OUT_EX = 'b10;
                    else
                      ALU_OUT_EX = 'b0;
                   end 
          4'b1100: begin
                    if (SYS_TOP.REG0<SYS_TOP.REG1)
                      ALU_OUT_EX = 'b11;
                    else
                      ALU_OUT_EX = 'b0;
                   end     
          4'b1101: begin
                    ALU_OUT_EX = SYS_TOP.REG0>>1;
                   end
          4'b1110: begin 
                    ALU_OUT_EX = SYS_TOP.REG0<<1;
                   end
         default: begin
                    ALU_OUT_EX = 'b0;
                  end
         endcase
	endtask

	task check_alu_out(input [3:0] ALU_FUN_t);
		golden_model(ALU_FUN_t,ALU_OUT_EX_general);
		@ (negedge REF_CLK);
		if(SYS_TOP.SYS_CTRL.ALU_OUT_temp !=ALU_OUT_EX_general) begin
			$display("ALU_ERROR:Time=%0t DATA=%d  but---> Expected=%d\n",$time,SYS_TOP.SYS_CTRL.ALU_OUT_temp,ALU_OUT_EX_general);
			error_count++;
		end
		else begin
			$display("ALU_Done:Time=%0t DATA=%d   and---> Expected=%d\n",$time,SYS_TOP.SYS_CTRL.ALU_OUT_temp,ALU_OUT_EX_general);
			correct_count++;
		end
	endtask


	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	task Register_File_Write_command (input [7:0] Address_t,input [7:0] DATA_t,input parity_type=EVEN,input parity_enable=1);
		$display("****************************************************************************************");
		$display("\t--------Register_File_Write_command ---/config/--- parity_enable=%b ,parity_type=%b \t \n",
			parity_enable,parity_type);
		$display("-------------- 1) WE RECEIVE COMMAND -------------------------");
		send_specific_frame(0,'hAA,1,parity_type,parity_enable);
		check_result_RX_hex('hAA);
		check_syncronizer('hAA);
				$display("------------- 2) WE RECEIVE ADDRESS ------------------");

		send_specific_frame(0,Address_t,1,parity_type,parity_enable);
		check_result_RX_decimal(Address_t);
		check_syncronizer(Address_t);
				$display("--------------- 3) WE RECEIVE DATA ----------------");

		send_specific_frame(0,DATA_t,1,parity_type,parity_enable);
		check_result_RX_decimal(DATA_t);
		check_syncronizer(DATA_t);
		check_write_done_in_register_file(DATA_t,Address_t);
		$display("****************************************************************************************");
	endtask

	task Register_File_Read_command (input [7:0] Address_t,input parity_type=EVEN,input parity_enable=1);
		$display("****************************************************************************************");
		$display("\t--------Register_File_Read_command ---/config/--- parity_enable=%b ,parity_type=%b \t \n",
			parity_enable,parity_type);

		$display("-------------- 1) WE RECEIVE COMMAND -------------------------");

		send_specific_frame(0,'hBB,1,parity_type,parity_enable);
		check_result_RX_hex('hBB);
		check_syncronizer('hBB);

				$display("------------- 2) WE RECEIVE ADDRESS ------------------");
		send_specific_frame(0,Address_t,1,parity_type,parity_enable);
		check_result_RX_decimal(Address_t);
		check_syncronizer(Address_t);

				$display("------------- 3) here we check that data moved from Rigster File to FIFO ------------------");

		check_data_in_FIFO(Address_t,DATA_CHECK_TASK);
				$display("------------- 3) here we check that Data is sent through TX ------------------");
		check_data_sent_from_TX(DATA_CHECK_TASK,parity_type,parity_enable);
				$display("****************************************************************************************");

	endtask

	task ALU_Operation_command_with_operand (input [7:0] Operand_A_t,input [7:0] Operand_B_t,input [3:0] ALU_FUN_t,input parity_type=EVEN,input parity_enable=1);

		$display("****************************************************************************************");
		$display("\t--------ALU_Operation_command_with_operand ---/config/--- parity_enable=%b ,parity_type=%b \t \n",
			parity_enable,parity_type);

		$display("-------------- 1) WE RECEIVE COMMAND -------------------------");

		send_specific_frame(0,'hCC,1,parity_type,parity_enable);
		check_result_RX_hex('hCC);
		check_syncronizer('hCC);

		$display("------------- 2) WE RECEIVE Operand_A ------------------");
		send_specific_frame(0,Operand_A_t,1,parity_type,parity_enable);
		check_result_RX_decimal(Operand_A_t);
		check_syncronizer(Operand_A_t);

			$display("------------- 3) WE RECEIVE Operand_B ------------------");
		send_specific_frame(0,Operand_B_t,1,parity_type,parity_enable);
		check_result_RX_decimal(Operand_B_t);
		check_syncronizer(Operand_B_t);

			$display("------------- 4) WE RECEIVE FUN ------------------");
		send_specific_frame(0,ALU_FUN_t,1,parity_type,parity_enable);
		check_result_RX_decimal(ALU_FUN_t);
		check_syncronizer(ALU_FUN_t);

         $display("------------- 5) CHECK OPERANDS IN REGISTERS ------------------");
		check_write_done_in_register_file(Operand_A_t,0);
		check_write_done_in_register_file(Operand_B_t,1);


			$display("------------- 6) here we check alu_operation through golden model ------------------");
		check_alu_out(ALU_FUN_t);

		$display("------------- 7) here we check that data moved from ALU to FIFO ------------------");
		check_data_in_FIFO_from_alu(DATA_CHECK_TASK,DATA_CHECK_TASK_2);
			$display("------------- 8) here we check that Data is sent through TX ------------------");		
			check_data_sent_from_TX(DATA_CHECK_TASK,parity_type,parity_enable);
			check_data_sent_from_TX_case_mul(DATA_CHECK_TASK_2,parity_type,parity_enable);

		$display("****************************************************************************************");
	endtask

	
	task ALU_Operation_command_with_No_operand (input [3:0] ALU_FUN_t,input parity_type=EVEN,input parity_enable=1);

		$display("****************************************************************************************");
		$display("\t--------ALU_Operation_command_with_No_operand ---/config/--- parity_enable=%b ,parity_type=%b \t \n",
			parity_enable,parity_type);

		$display("-------------- 1) WE RECEIVE COMMAND -------------------------");
		send_specific_frame(0,'hDD,1,parity_type,parity_enable);
		check_result_RX_hex('hDD);
		check_syncronizer('hDD);

			$display("------------- 2) WE RECEIVE FUN ------------------");
		send_specific_frame(0,ALU_FUN_t,1,parity_type,parity_enable);
		check_result_RX_decimal(ALU_FUN_t);
		check_syncronizer(ALU_FUN_t);

		$display("------------- 3) here we check alu_operation through golden model ------------------");
		check_alu_out(ALU_FUN_t);

		$display("------------- 4) here we check that data moved from ALU to FIFO ------------------");
		check_data_in_FIFO_from_alu(DATA_CHECK_TASK,DATA_CHECK_TASK_2);
			$display("------------- 5) here we check that Data is sent through TX ------------------");
		
			check_data_sent_from_TX(DATA_CHECK_TASK,parity_type,parity_enable);
			check_data_sent_from_TX_case_mul(DATA_CHECK_TASK_2,parity_type,parity_enable);

		$display("****************************************************************************************");




	endtask

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	initial begin
		RST=0;
		RX_IN=1;
		@(negedge TX_CLK_TB) RST=1;
		@(negedge TX_CLK_TB);

		////////////////////////////////////////////// 1st CONFIGURATION  //////////////////////////
		// prescaler=32 --- EVEN PARITY ----
		Register_File_Write_command(2,8'b100000_01);

		/////////////////////////////////////// Register_File_Write_command //////////////////////////////
		Register_File_Write_command(5,20);
		Register_File_Write_command(6,25);
		Register_File_Write_command(7,7);
		Register_File_Write_command(8,9);
		//////////////////////////////////////// HRegister_File_Read_command ///////////////////////////////
		Register_File_Read_command(5);
		Register_File_Read_command(6);
		Register_File_Read_command(7);
		Register_File_Read_command(8);
		//////////////////////////////////////// ALU_Operation_command_with_operand ///////////////////////////////

		ALU_Operation_command_with_operand(15,10,0);
		ALU_Operation_command_with_operand(15,10,1);
		ALU_Operation_command_with_operand(50,20,3);
		ALU_Operation_command_with_operand(60,10,4);
		ALU_Operation_command_with_operand(80,90,5);
		ALU_Operation_command_with_operand(15,30,6);
		ALU_Operation_command_with_operand(15,10,7);
		ALU_Operation_command_with_operand(15,10,8);
		ALU_Operation_command_with_operand(20,10,9);
		ALU_Operation_command_with_operand(50,20,10);
		ALU_Operation_command_with_operand(60,10,11);
		ALU_Operation_command_with_operand(80,90,12);
		ALU_Operation_command_with_operand(15,30,13);
				ALU_Operation_command_with_operand(20,10,2);
				ALU_Operation_command_with_operand(40,10,2);
				ALU_Operation_command_with_operand(50,10,2);



		//////////////////////////////////////// ALU_Operation_command_with_No_operand ///////////////////////////////
		ALU_Operation_command_with_No_operand(0);
		ALU_Operation_command_with_No_operand(1);
		ALU_Operation_command_with_No_operand(2);
		ALU_Operation_command_with_No_operand(3);
		ALU_Operation_command_with_No_operand(4);
		ALU_Operation_command_with_No_operand(5);
		ALU_Operation_command_with_No_operand(6);
		ALU_Operation_command_with_No_operand(7);
		ALU_Operation_command_with_No_operand(8);
		ALU_Operation_command_with_No_operand(9);
		ALU_Operation_command_with_No_operand(10);
		ALU_Operation_command_with_No_operand(11);
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////


		////////////////////////////////////////////// 2nd CONFIGURATION  //////////////////////////
		// prescaler=16 --- EVEN PARITY ----
		Register_File_Write_command(2,8'b10000_01);

		/////////////////////////////////////// Register_File_Write_command //////////////////////////////
		Register_File_Write_command(5,20);
		Register_File_Write_command(6,25);
		Register_File_Write_command(7,7);
		Register_File_Write_command(8,9);
		//////////////////////////////////////// HRegister_File_Read_command ///////////////////////////////
		Register_File_Read_command(5);
		Register_File_Read_command(6);
		Register_File_Read_command(7);
		Register_File_Read_command(8);
		//////////////////////////////////////// ALU_Operation_command_with_operand ///////////////////////////////
						prescaler_time_sync=3;

		ALU_Operation_command_with_operand(15,10,0);
		ALU_Operation_command_with_operand(15,10,1);
		ALU_Operation_command_with_operand(50,20,3);
		ALU_Operation_command_with_operand(60,10,4);
		ALU_Operation_command_with_operand(80,90,5);
		ALU_Operation_command_with_operand(15,30,6);
		ALU_Operation_command_with_operand(15,10,7);
		ALU_Operation_command_with_operand(15,10,8);
		ALU_Operation_command_with_operand(20,10,9);
		ALU_Operation_command_with_operand(50,20,10);
		ALU_Operation_command_with_operand(60,10,11);
		ALU_Operation_command_with_operand(80,90,12);
		ALU_Operation_command_with_operand(15,30,13);
				ALU_Operation_command_with_operand(20,10,2);
				ALU_Operation_command_with_operand(40,10,2);
				ALU_Operation_command_with_operand(50,10,2);



		//////////////////////////////////////// ALU_Operation_command_with_No_operand ///////////////////////////////
		ALU_Operation_command_with_No_operand(0);
		ALU_Operation_command_with_No_operand(1);
		ALU_Operation_command_with_No_operand(2);
		ALU_Operation_command_with_No_operand(3);
		ALU_Operation_command_with_No_operand(4);
		ALU_Operation_command_with_No_operand(5);
		ALU_Operation_command_with_No_operand(6);
		ALU_Operation_command_with_No_operand(7);
		ALU_Operation_command_with_No_operand(8);
		ALU_Operation_command_with_No_operand(9);
		ALU_Operation_command_with_No_operand(10);
		ALU_Operation_command_with_No_operand(11);
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		repeat(5) @(negedge TX_CLK_TB);

		////////////////////////////////////////////// 3rd CONFIGURATION  //////////////////////////
		// prescaler=16 --- ODD PARITY ----
				Register_File_Write_command(2,8'b010000_11);
				parity_type=ODD;
				parity_enable=PAR_ENABLE;

		/////////////////////////////////////// Register_File_Write_command //////////////////////////////
		Register_File_Write_command(5,20,parity_type,parity_enable);
		Register_File_Write_command(6,25,parity_type,parity_enable);
		Register_File_Write_command(7,7,parity_type,parity_enable);
		Register_File_Write_command(8,9,parity_type,parity_enable);
		//////////////////////////////////////// HRegister_File_Read_command ///////////////////////////////
		Register_File_Read_command(5,parity_type,parity_enable);
		Register_File_Read_command(6,parity_type,parity_enable);
		Register_File_Read_command(7,parity_type,parity_enable);
		Register_File_Read_command(8,parity_type,parity_enable);
		//////////////////////////////////////// ALU_Operation_command_with_operand ///////////////////////////////
						prescaler_time_sync=3;

		ALU_Operation_command_with_operand(15,10,0,parity_type,parity_enable);

		ALU_Operation_command_with_operand(15,10,1,parity_type,parity_enable);
		ALU_Operation_command_with_operand(50,20,3,parity_type,parity_enable);
		ALU_Operation_command_with_operand(60,10,4,parity_type,parity_enable);
		ALU_Operation_command_with_operand(80,90,5,parity_type,parity_enable);
		ALU_Operation_command_with_operand(15,30,6,parity_type,parity_enable);
		ALU_Operation_command_with_operand(15,10,7,parity_type,parity_enable);
		ALU_Operation_command_with_operand(15,10,8,parity_type,parity_enable);
		ALU_Operation_command_with_operand(20,10,9,parity_type,parity_enable);
		ALU_Operation_command_with_operand(50,20,10,parity_type,parity_enable);
		ALU_Operation_command_with_operand(60,10,11,parity_type,parity_enable);
		ALU_Operation_command_with_operand(80,90,12,parity_type,parity_enable);
		ALU_Operation_command_with_operand(15,30,13,parity_type,parity_enable);
				ALU_Operation_command_with_operand(20,10,2,parity_type,parity_enable);
				ALU_Operation_command_with_operand(40,10,2,parity_type,parity_enable);
				ALU_Operation_command_with_operand(50,10,2,parity_type,parity_enable);



		//////////////////////////////////////// ALU_Operation_command_with_No_operand ///////////////////////////////
		ALU_Operation_command_with_No_operand(0,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(1,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(2,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(3,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(4,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(5,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(6,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(7,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(8,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(9,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(10,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(11,parity_type,parity_enable);
				Register_File_Write_command(5,20,parity_type,parity_enable);

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		repeat(100) @(negedge TX_CLK_TB);
												prescaler_time_sync=4;

		
		////////////////////////////////////////////// 4th CONFIGURATION  //////////////////////////
		// prescaler=32 --- ODD PARITY ----
				Register_File_Write_command(2,8'b100000_11,ODD,1);
				parity_type=ODD;
				parity_enable=PAR_ENABLE;
										prescaler_time_sync=3;
												repeat(100) @(negedge TX_CLK_TB);



		/////////////////////////////////////// Register_File_Write_command //////////////////////////////
		Register_File_Write_command(5,20,parity_type,parity_enable);
		Register_File_Write_command(6,25,parity_type,parity_enable);
		Register_File_Write_command(7,7,parity_type,parity_enable);
		Register_File_Write_command(8,9,parity_type,parity_enable);
		//////////////////////////////////////// HRegister_File_Read_command ///////////////////////////////
		Register_File_Read_command(5,parity_type,parity_enable);
		Register_File_Read_command(6,parity_type,parity_enable);
		Register_File_Read_command(7,parity_type,parity_enable);
		Register_File_Read_command(8,parity_type,parity_enable);
		//////////////////////////////////////// ALU_Operation_command_with_operand ///////////////////////////////
						prescaler_time_sync=3;

		ALU_Operation_command_with_operand(15,10,0,parity_type,parity_enable);

		ALU_Operation_command_with_operand(15,10,1,parity_type,parity_enable);
		ALU_Operation_command_with_operand(50,20,3,parity_type,parity_enable);
		ALU_Operation_command_with_operand(60,10,4,parity_type,parity_enable);
		ALU_Operation_command_with_operand(80,90,5,parity_type,parity_enable);
		ALU_Operation_command_with_operand(15,30,6,parity_type,parity_enable);
		ALU_Operation_command_with_operand(15,10,7,parity_type,parity_enable);
		ALU_Operation_command_with_operand(15,10,8,parity_type,parity_enable);
		ALU_Operation_command_with_operand(20,10,9,parity_type,parity_enable);
		ALU_Operation_command_with_operand(50,20,10,parity_type,parity_enable);
		ALU_Operation_command_with_operand(60,10,11,parity_type,parity_enable);
		ALU_Operation_command_with_operand(80,90,12,parity_type,parity_enable);
		ALU_Operation_command_with_operand(15,30,13,parity_type,parity_enable);
				ALU_Operation_command_with_operand(20,10,2,parity_type,parity_enable);
				ALU_Operation_command_with_operand(40,10,2,parity_type,parity_enable);
				ALU_Operation_command_with_operand(50,10,2,parity_type,parity_enable);



		//////////////////////////////////////// ALU_Operation_command_with_No_operand ///////////////////////////////
		ALU_Operation_command_with_No_operand(0,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(1,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(2,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(3,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(4,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(5,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(6,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(7,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(8,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(9,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(10,parity_type,parity_enable);
		ALU_Operation_command_with_No_operand(11,parity_type,parity_enable);
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		
		$display("Finish:Time=%0t error_count=%d correct_count=%d",$time,error_count,correct_count);
		$stop;
	end

endmodule