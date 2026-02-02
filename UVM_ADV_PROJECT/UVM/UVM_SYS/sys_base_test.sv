class sys_base_test extends uvm_test;

    `uvm_component_utils(sys_base_test)

    sys_top_env sys_top_env_inst;
    sys_top_config sys_top_config_inst;

    function new (string name = "sys_base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sys_top_env_inst = sys_top_env::type_id::create("sys_top_env_inst", this);
        sys_top_config_inst = sys_top_config::type_id::create("sys_top_config_inst", this);
        
        // interface set



        if (!uvm_config_db # (virtual sys_intf #(.DATA_WIDTH(DATA_WIDTH), .MEM_DEPTH(MEM_DEPTH)) )::get(this,"","sys_if", sys_top_config_inst.sys_env_config.agent_config_inst.vif)) begin
            `uvm_fatal("INTERFACE_GET", "sys_if is not set. Please set it before build_phase.")
        end

        if (!uvm_config_db # (virtual  AES_if #(.N(N), .Nr(Nr), .Nk(Nk)) )::get(this,"","aes_if", sys_top_config_inst.aes_env_config.agent_config_inst.vif)) begin
            `uvm_fatal("INTERFACE_GET", "AES is not set. Please set it before build_phase.")
        end

        if (!uvm_config_db # (virtual intf )::get(this,"","mem_if", sys_top_config_inst.memory1_env_config.agent_config_inst.vif)) begin
            `uvm_fatal("INTERFACE_GET", "intf (memory) is not set. Please set it before build_phase.")
        end

        if (!uvm_config_db # (virtual  intf )::get(this,"","mem_if2", sys_top_config_inst.memory2_env_config.agent_config_inst.vif)) begin
            `uvm_fatal("INTERFACE_GET", "intf (memory) is not set. Please set it before build_phase.")
        end

        if (!uvm_config_db # (virtual  TX_if )::get(this,"","tx_if", sys_top_config_inst.tx_env_config.agent_config_inst.vif)) begin
            `uvm_fatal("INTERFACE_GET", "TX_if is not set. Please set it before build_phase.")
        end 

        if (!uvm_config_db # (virtual uart_if )::get(this,"","rx_if", sys_top_config_inst.rx_env_config.agent_config_inst.vif)) begin
            `uvm_fatal("INTERFACE_GET", "uart_if (RX) is not set. Please set it before build_phase.")
        end

        sys_top_config_inst.has_sys_environment_set(1);

        uvm_config_db # (sys_top_config)::set(this, "sys_top_env_inst", "sys_top_config", sys_top_config_inst);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        this.print();
    endfunction    


     function void connect_phase (uvm_phase phase);
      super.connect_phase(phase);
      // $display("connect_test");
    endfunction



    function void report_phase(uvm_phase phase);
            uvm_report_server svr;
            super.report_phase(phase);
       
            svr = uvm_report_server::get_server();
            if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)>0) begin

                `uvm_info(get_type_name(), "\n-----------------\n----TEST FAIL----\n-----------------", UVM_NONE)
            end
            else begin
                `uvm_info(get_type_name(), "\n-----------------\n----TEST PASS----\n-----------------", UVM_NONE)
      
            end
      endfunction : report_phase


endclass   