
	class uart_sequence_reset extends uvm_sequence #(uart_seq_item);
		`uvm_object_utils (uart_sequence_reset)

		uart_seq_item seq_item;

		function new (string name="uart_sequence_reset");
			super.new(name);
		endfunction

		task body;
			seq_item = uart_seq_item::type_id::create ("seq_item");

			seq_item.prescale=32;
			seq_item.PAR_EN=1;
			seq_item.PAR_TYP=0;

			start_item (seq_item);
				assert(seq_item.randomize() with {seq_item.rst==0;})
			finish_item(seq_item);

			/*start_item (seq_item);
				assert(seq_item.randomize() with {seq_item.rst==1;})
			finish_item(seq_item);
			*/

		endtask

	endclass

	class uart_sequence_main extends uvm_sequence #(uart_seq_item);
		`uvm_object_utils (uart_sequence_main)

		uart_seq_item seq_item;

		function new (string name="uart_sequence_main");
			super.new(name);
		endfunction
		parameter EVEN=0;
		parameter ODD=1;
		parameter PAR_ENABLE=1;
		parameter PAR_DISABLE=0;
		bit parity_type;
		bit parity_enable;




		task body;
			seq_item = uart_seq_item::type_id::create ("seq_item");
			parity_type=EVEN;
			parity_enable=PAR_ENABLE;

			send_specific_frame(0,'hAA,1,parity_type,parity_enable);
			hold();

			send_specific_frame(0,'hBB,1,parity_type,parity_enable);
			hold();
			send_specific_frame(0,'hCC,1,parity_type,parity_enable);
			hold();

			repeat (20) begin
				send_specific_frame(0,$random,1,parity_type,parity_enable);
			end

			///////////////////////////////////	
		endtask


		task send_specific_frame (input start,input [7:0] frame_t,input stop,input parity_type=EVEN,input parity_enable=1); // task used to send wrong frames
			  			uvm_resource_db#(logic [7:0])::set_override("*","frame_t", frame_t, this);

			  	seq_item.prescale=32;
			  	seq_item.PAR_EN=parity_enable;
			  	seq_item.PAR_TYP=parity_type;

			  start_item (seq_item);
				assert(seq_item.randomize() with {seq_item.RX_IN==start;seq_item.rst==1;})
			  finish_item(seq_item);

			for (int i = 0; i < 8; i++) begin
				 start_item (seq_item);
					assert(seq_item.randomize() with {seq_item.RX_IN==frame_t[i];seq_item.rst==1;})
			    finish_item(seq_item);
			end	

			if(parity_enable) begin
				if(parity_type==EVEN) begin
					start_item (seq_item);
						assert(seq_item.randomize() with {seq_item.RX_IN==^frame_t;seq_item.rst==1;})
			    	finish_item(seq_item);
				end
				else if(parity_type==ODD) begin
					start_item (seq_item);
						assert(seq_item.randomize() with {seq_item.RX_IN==~(^frame_t);seq_item.rst==1;})
			    	finish_item(seq_item);
				end
			end

			start_item (seq_item);
						assert(seq_item.randomize() with {seq_item.RX_IN==stop;seq_item.rst==1;})
			finish_item(seq_item);
		endtask

		task hold();
				seq_item.prescale=32;
			  	seq_item.PAR_EN=parity_enable;
			  	seq_item.PAR_TYP=parity_type;
			start_item (seq_item);
						assert(seq_item.randomize() with {seq_item.RX_IN==1;seq_item.rst==1;})
			finish_item(seq_item);
		endtask

	endclass
