

	class reg_file_reset_sequence extends uvm_sequence #(reg_file_seq_item);
		`uvm_object_utils(reg_file_reset_sequence)
		
		reg_file_seq_item seq_item;

		function new(string name="reg_file_reset_sequence");
			super.new(name);
		endfunction

		task body();
			seq_item=reg_file_seq_item::type_id::create("seq_item");
			start_item(seq_item);
				assert(seq_item.randomize() with {seq_item.RST==0;})
			finish_item(seq_item);
		endtask

	endclass	


	class reg_file_main_sequence extends uvm_sequence #(reg_file_seq_item);
		`uvm_object_utils(reg_file_main_sequence)

		reg_file_seq_item seq_item;

		function new(string name="reg_file_main_sequence");
			super.new(name);
		endfunction

		task body();
			seq_item=reg_file_seq_item::type_id::create("seq_item");

			start_item(seq_item);
				assert(seq_item.randomize() with {seq_item.RST==1;seq_item.WrEn==1; seq_item.Address==0;})
			finish_item(seq_item);

			start_item(seq_item);
				assert(seq_item.randomize() with {seq_item.RST==1;seq_item.WrEn==1; seq_item.Address==1;})
			finish_item(seq_item);

			start_item(seq_item);
				assert(seq_item.randomize() with {seq_item.RST==1;seq_item.WrEn==1; seq_item.Address==2;})
			finish_item(seq_item);

			start_item(seq_item);
				assert(seq_item.randomize() with {seq_item.RST==1;seq_item.WrEn==1; seq_item.Address==3;})
			finish_item(seq_item);

			repeat(3) begin
				start_item(seq_item);
					assert(seq_item.randomize())
				finish_item(seq_item);
			end
		endtask

	endclass

	class reg_file_ral_sequence extends uvm_sequence #(reg_file_seq_item);
		`uvm_object_utils(reg_file_ral_sequence)
		
		reg_file_seq_item seq_item;
		ral_sys_reg_file_config ral_model;
		uvm_status_e status;
		int rdata;

		function new(string name="reg_file_ral_sequence");
			super.new(name);
		endfunction

		task body();
			seq_item=reg_file_seq_item::type_id::create("seq_item");

			//first we will get model from env after uvm start
			if(! uvm_config_db#(ral_sys_reg_file_config)::get(null,"","ral_model",ral_model) )
								`uvm_info("sequence","failed to get ral model interface",UVM_MEDIUM)
			// here we start ral
						`uvm_info("ral_sequence","HERE WE CHECK READ & WRITE \n \n",UVM_MEDIUM)

						//here we perform read and write transaction using write and read methods
						// note that it will update reg_model by it self
			ral_model.cfg.uart_config.write(status,8'hf2,UVM_FRONTDOOR);
			ral_model.cfg.uart_config.read(status,rdata,UVM_FRONTDOOR);
			`uvm_info("ral_sequence",$sformatf("rdata=%0h",rdata),UVM_MEDIUM)

			ral_model.cfg.ALU_Operand_A_config.write(status,8'hd5);
			ral_model.cfg.ALU_Operand_A_config.read(status,rdata);
			`uvm_info("ral_sequence",$sformatf("rdata=%0h",rdata),UVM_MEDIUM)

			ral_model.cfg.ALU_Operand_B_config.write(status,8'hcd);
			ral_model.cfg.ALU_Operand_B_config.read(status,rdata);
			`uvm_info("ral_sequence",$sformatf("rdata=%0h",rdata),UVM_MEDIUM)

			ral_model.cfg.Div_Ratio_config.write(status,8'hca);
			ral_model.cfg.Div_Ratio_config.read(status,rdata);
			`uvm_info("ral_sequence",$sformatf("rdata=%0h",rdata),UVM_MEDIUM)

			//______________________________________________________________________________________________

			//here we use set function
			//to set desired value note this value won't go to dut till i perform  update task
			ral_model.cfg.uart_config.set(8'haa);
			`uvm_info("ral_sequence",$sformatf(" desired =%0h mirrored=%0h ",ral_model.cfg.uart_config.get(),
				ral_model.cfg.uart_config.get_mirrored_value()),UVM_MEDIUM)
			
			// here we used (get_mirrored_value) to get last known values 
			// (get) methode it  return desired values in reg model

			//_____________________________________________________________________________________

			// here we use predict methode which will make value = f2 without any physical transaction
			// not when we use read later with uvm_check it compare between them if there is mismatch it reports
			ral_model.cfg.uart_config.predict(8'hf1);

			// here we will use mirror methode which update reg with mirrored values from dut using physical read transaction 
			ral_model.cfg.uart_config.mirror(status, UVM_CHECK);


			//__________________________________________________________________________________________________
			// test access certain fields
			ral_model.cfg.uart_config.parity_en.set(1);
			ral_model.cfg.uart_config.parity_type.set(1);
			ral_model.cfg.uart_config.prescale.set(6'b110110);
			ral_model.cfg.update(status);
						ral_model.cfg.uart_config.read(status,rdata,UVM_FRONTDOOR);
			`uvm_info("ral_sequence",$sformatf("rdata=%0b",rdata),UVM_MEDIUM)

			//______________________________________________________________________________________________________
			//here test backdoor access 
			//BACKDOOR WRITE THEN FRONT DOOR READ

			ral_model.cfg.uart_config.write(status,8'h77,UVM_BACKDOOR);
			ral_model.cfg.uart_config.read(status,rdata,UVM_FRONTDOOR);
			`uvm_info("ral_sequence",$sformatf("rdata=%0h",rdata),UVM_MEDIUM)

			ral_model.cfg.ALU_Operand_A_config.write(status,8'h22,UVM_BACKDOOR);
			ral_model.cfg.ALU_Operand_A_config.read(status,rdata,UVM_FRONTDOOR);
			`uvm_info("ral_sequence",$sformatf("rdata=%0h",rdata),UVM_MEDIUM)

			//______________________________________________________________________________________________________
			//here perform FRONT DOOR WRITE THEN BACKDOOR READ

			ral_model.cfg.ALU_Operand_B_config.write(status,8'h55,UVM_FRONTDOOR);
			#1;
			ral_model.cfg.ALU_Operand_B_config.read(status,rdata,UVM_BACKDOOR);
			`uvm_info("ral_sequence",$sformatf("rdata=%0h",rdata),UVM_MEDIUM)

		endtask

	endclass