
	class sys_sequence_base extends uvm_sequence #(sys_seq_item);

		`uvm_object_utils(sys_sequence_base)

		sys_seq_item seq_item;

		bit parity_type;
		bit parity_enable;

		function new (string name = "sys_sequence_base");
			super.new ();

		endfunction


		task send_specific_frame (input start,input [7:0] frame_t,input stop,input parity_type=EVEN,input parity_enable=1); // task used to send wrong frames
			  			uvm_resource_db#(logic [7:0])::set_override("*","frame_t", frame_t, this);

			start_item (seq_item);
				assert(seq_item.randomize() with {seq_item.RX_IN==start;seq_item.RST==1;})
			finish_item(seq_item);

			for (int i = 0; i < 8; i++) begin
				 start_item (seq_item);
					assert(seq_item.randomize() with {seq_item.RX_IN==frame_t[i];seq_item.RST==1;})
			    finish_item(seq_item);
			end	

			if(parity_enable) begin
				if(parity_type==EVEN) begin
					start_item (seq_item);
						assert(seq_item.randomize() with {seq_item.RX_IN==^frame_t;seq_item.RST==1;})
			    	finish_item(seq_item);
				end
				else if(parity_type==ODD) begin
					start_item (seq_item);
						assert(seq_item.randomize() with {seq_item.RX_IN==~(^frame_t);seq_item.RST==1;})
			    	finish_item(seq_item);
				end
			end

			start_item (seq_item);
						assert(seq_item.randomize() with {seq_item.RX_IN==stop;seq_item.RST==1;})
			finish_item(seq_item);
		endtask

		task Register_File_Write_command (input [7:0] Address_t,input [7:0] DATA_t,input parity_type=EVEN,input parity_enable=1);

			send_specific_frame(0,'hAA,1,parity_type,parity_enable);
		
			send_specific_frame(0,Address_t,1,parity_type,parity_enable);

			send_specific_frame(0,DATA_t,1,parity_type,parity_enable);
		endtask

		task Register_File_Read_command (input [7:0] Address_t,input parity_type=EVEN,input parity_enable=1);
			
			send_specific_frame(0,'hBB,1,parity_type,parity_enable);
			
			send_specific_frame(0,Address_t,1,parity_type,parity_enable);

		endtask

		task ALU_Operation_command_with_operand (input [7:0] Operand_A_t,input [7:0] Operand_B_t,input [3:0] ALU_FUN_t,input parity_type=EVEN,input parity_enable=1);

			send_specific_frame(0,'hCC,1,parity_type,parity_enable);
			
			send_specific_frame(0,Operand_A_t,1,parity_type,parity_enable);
			
			send_specific_frame(0,Operand_B_t,1,parity_type,parity_enable);
			
			send_specific_frame(0,ALU_FUN_t,1,parity_type,parity_enable);
			
		endtask

		
		task ALU_Operation_command_with_No_operand (input [3:0] ALU_FUN_t,input parity_type=EVEN,input parity_enable=1);

	
			send_specific_frame(0,'hDD,1,parity_type,parity_enable);
			
			send_specific_frame(0,ALU_FUN_t,1,parity_type,parity_enable);

		endtask

		task hold();
			start_item (seq_item);
				assert(seq_item.randomize() with {seq_item.RX_IN==1;seq_item.RST==1;})
			finish_item(seq_item);
		endtask

		task initialize_uart_parity_en_even(input logic [5:0] prescale = PRESCALE_X8) ;
			hold();
			Register_File_Write_command(2,{prescale,1'b0,1'b1},parity_type,parity_enable);
			hold();

			parity_type=EVEN;
			parity_enable=PAR_ENABLE;
		endtask

		task initialize_uart_parity_en_odd(input logic [5:0] prescale = PRESCALE_X8) ;
			hold();
			Register_File_Write_command(2,{prescale,1'b1,1'b1},parity_type,parity_enable);
			hold();

			parity_type=ODD;
			parity_enable=PAR_ENABLE;

		endtask

		task initialize_uart_parity_disable(input logic [5:0] prescale = PRESCALE_X8) ;
			hold();
			Register_File_Write_command(2,{prescale,1'b0,1'b0},parity_type,parity_enable);
			hold();

			parity_type=EVEN;
			parity_enable=PAR_DISABLE;
		endtask

		task pre_body ;
			parity_type=EVEN;
			parity_enable=PAR_ENABLE;
		endtask





	endclass

	class sys_sequence_reset extends sys_sequence_base;
		`uvm_object_utils (sys_sequence_reset)


		function new (string name="sys_sequence_reset");
			super.new(name);
		endfunction

		task body;
			seq_item = sys_seq_item::type_id::create ("seq_item");

			
			repeat(10) begin
				start_item (seq_item);
					assert(seq_item.randomize() with {seq_item.RST==0;seq_item.RX_IN==1;})
				finish_item(seq_item);
			end

		endtask

	endclass

	class sys_sequence_smoke extends sys_sequence_base;
		`uvm_object_utils (sys_sequence_smoke)


		function new (string name="sys_sequence_smoke");
			super.new(name);
		endfunction

		task body;
			seq_item = sys_seq_item::type_id::create ("seq_item");
	
			//////////////////////////////////////////////////////////////////////////////////////////////

			initialize_uart_parity_en_even(PRESCALE_X8);


			parity_type=EVEN;
			parity_enable=PAR_ENABLE;
		


			Register_File_Write_command(5,20,parity_type,parity_enable);
			/*
			Register_File_Write_command(6,25,parity_type,parity_enable);
			Register_File_Read_command(5,parity_type,parity_enable);
			Register_File_Read_command(6,parity_type,parity_enable);

			//////////////////////////////////////////////////////////////////////////////////////////////
		
			
			initialize_uart_parity_en_odd(PRESCALE_X8);
			

			Register_File_Write_command(5,20,parity_type,parity_enable);
			Register_File_Write_command(6,25,parity_type,parity_enable);
			Register_File_Read_command(5,parity_type,parity_enable);
			Register_File_Read_command(6,parity_type,parity_enable);

			//////////////////////////////////////////////////////////////////////////////////////////////

			
			initialize_uart_parity_disable(PRESCALE_X8);

			Register_File_Write_command(5,20,parity_type,parity_enable);
			Register_File_Write_command(6,25,parity_type,parity_enable);
			Register_File_Read_command(5,parity_type,parity_enable);
			Register_File_Read_command(6,parity_type,parity_enable);
			
			
			*/
			///////////////////////////////////////////////////////////////////////////////////////////////
		endtask



	endclass
