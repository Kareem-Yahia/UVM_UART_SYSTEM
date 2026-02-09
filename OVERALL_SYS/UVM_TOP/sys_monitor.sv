
	class sys_monitor extends uvm_monitor;
			`uvm_component_utils(sys_monitor)

			virtual sys_if sysvif_monitor;
			sys_seq_item my_seq_item;
			uvm_analysis_port #(sys_seq_item) mon_ap;

			function new(string name="sys_monitor" , uvm_component parent=null);
				super.new(name,parent);
			endfunction

			function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			mon_ap=new("mon_ap",this);
		endfunction

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			forever begin
				my_seq_item=sys_seq_item::type_id::create("my_seq_item",this);
				
				mon1();
				mon_ap.write(my_seq_item);

				`uvm_info("run_phase",my_seq_item.convert2string(),UVM_HIGH)
			end
		endtask

		task mon1();
			  @(posedge sysvif_monitor.busy);
			 my_seq_item.RST=sysvif_monitor.RST;
			 my_seq_item.RX_IN=sysvif_monitor.RX_IN;
			 my_seq_item.par_err_reg=sysvif_monitor.par_err_reg;
			 my_seq_item.stp_error_reg=sysvif_monitor.stp_error_reg;
			 my_seq_item.TX_OUT=sysvif_monitor.TX_OUT;

            ///////////////////////////////////////////////
		endtask
	endclass