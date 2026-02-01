
	class uart_monitor extends uvm_monitor;
			`uvm_component_utils(uart_monitor)

			virtual uart_if uartvif_monitor;
			uart_seq_item my_seq_item;
			uvm_analysis_port #(uart_seq_item) mon_ap;

			function new(string name="uart_monitor" , uvm_component parent=null);
				super.new(name,parent);
			endfunction

			function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			mon_ap=new("mon_ap",this);
		endfunction

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			forever begin
				my_seq_item=uart_seq_item::type_id::create("my_seq_item",this);
				
				mon1();
				mon_ap.write(my_seq_item);

				`uvm_info("run_phase",my_seq_item.convert2string(),UVM_HIGH)
			end
		endtask

		task mon1();
			  @(negedge uartvif_monitor.TX_CLK_TB);
			 my_seq_item.rst=uartvif_monitor.rst;
			 my_seq_item.RX_IN=uartvif_monitor.RX_IN;
			 my_seq_item.prescale=uartvif_monitor.prescale;
			 my_seq_item.PAR_EN=uartvif_monitor.PAR_EN;
			 my_seq_item.PAR_TYP=uartvif_monitor.PAR_TYP;

            //just for testing 
            my_seq_item.data_valid_reg=uartvif_monitor.data_valid_reg;
            my_seq_item.P_DATA_reg=uartvif_monitor.P_DATA_reg;
            my_seq_item.par_err_reg=uartvif_monitor.par_err_reg;
            my_seq_item.stp_error_reg=uartvif_monitor.stp_error_reg;

            ///////////////////////////////////////////////
		endtask
	endclass
