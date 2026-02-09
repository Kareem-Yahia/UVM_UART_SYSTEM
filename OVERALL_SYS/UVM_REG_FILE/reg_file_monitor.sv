
	class reg_file_monitor extends uvm_monitor;
		`uvm_component_utils(reg_file_monitor)

		uvm_analysis_port #(reg_file_seq_item) mon_ap;

		virtual reg_file_if reg_file_vif_monitor;
		reg_file_seq_item stim_seq_item;

		function new(string name="reg_file_monitor",uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			mon_ap=new("mon_ap",this);
		endfunction

		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
		endfunction

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			forever begin
				stim_seq_item=reg_file_seq_item::type_id::create("stim_seq_item");
				
				mon1();

				mon_ap.write(stim_seq_item);
				`uvm_info("monitor",stim_seq_item.convert2string(),UVM_HIGH)
			end
		endtask

		task mon1();
			  @(negedge reg_file_vif_monitor.REF_CLK);
				stim_seq_item.RST=reg_file_vif_monitor.RST;
				stim_seq_item.WrEn=reg_file_vif_monitor.WrEn;
				stim_seq_item.RdEn=reg_file_vif_monitor.RdEn;
				stim_seq_item.Address=reg_file_vif_monitor.Address;
				stim_seq_item.WrData=reg_file_vif_monitor.WrData;
				stim_seq_item.RdData=reg_file_vif_monitor.RdData;
				stim_seq_item.RdData_VLD=reg_file_vif_monitor.RdData_VLD;
				stim_seq_item.REG0=reg_file_vif_monitor.REG0;
				stim_seq_item.REG1=reg_file_vif_monitor.REG1;
				stim_seq_item.REG2=reg_file_vif_monitor.REG2;
				stim_seq_item.REG3=reg_file_vif_monitor.REG3;	 
            ///////////////////////////////////////////////
		endtask
	endclass
