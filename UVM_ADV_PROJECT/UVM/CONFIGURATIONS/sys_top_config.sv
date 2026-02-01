class sys_top_config extends uvm_object;

    `uvm_object_utils(sys_top_config)


    bit  has_aes_environment;
    bit  has_memory1_environment;
    bit  has_memory2_environment;
    bit  has_uart_environment;
    bit  has_sys_environment;

    sys_env_config sys_env_config;
    aes_env_config aes_env_config;
    memory1_env_config memory1_env_config;
    memory2_env_config memory2_env_config;
    tx_env_config tx_env_config;
    rx_env_config rx_env_config;

    function new (string name = "sys_top_config");
        super.new(name);
        sys_env_config = new ("sys_env_config");
        aes_env_config = new ("aes_env_config");
        memory1_env_config = new ("memory1_env_config");
        memory2_env_config = new ("memory2_env_config");
        tx_env_config = new ("tx_env_config");
        rx_env_config = new ("rx_env_config");
    endfunction


    function void print_config();
        `uvm_info("SYS_TOP_CONFIG", $sformatf("has_aes_environment = %0b", has_aes_environment), UVM_LOW)
        `uvm_info("SYS_TOP_CONFIG", $sformatf("has_memory1_environment = %0b", has_memory1_environment), UVM_LOW)
        `uvm_info("SYS_TOP_CONFIG", $sformatf("has_memory2_environment = %0b", has_memory2_environment), UVM_LOW)
        `uvm_info("SYS_TOP_CONFIG", $sformatf("has_uart_environment = %0b", has_uart_environment), UVM_LOW)
        `uvm_info("SYS_TOP_CONFIG", $sformatf("has_sys_environment = %0b", has_sys_environment), UVM_LOW)
    endfunction

    function void has_aes_environment_set(bit val);
        has_aes_environment = val;
        if (val) begin
            `uvm_info("SYS_TOP_CONFIG", "AES Environment is included in the simulation", UVM_LOW)
        end

    endfunction  

    function void has_memory1_environment_set(bit val);
        has_memory1_environment = val;
        if (val) begin
            `uvm_info("SYS_TOP_CONFIG", "Memory1 Environment is included in the simulation", UVM_LOW)
        end
    endfunction

    function void has_memory2_environment_set(bit val);
        has_memory2_environment = val;
        if (val) begin
            `uvm_info("SYS_TOP_CONFIG", "Memory2 Environment is included in the simulation", UVM_LOW)
        end
    endfunction

    function void has_uart_environment_set(bit val);
        has_uart_environment = val;
        if (val) begin
            `uvm_info("SYS_TOP_CONFIG", "UART Environment is included in the simulation", UVM_LOW)
        end

    endfunction

    function void has_sys_environment_set(bit val);
        has_sys_environment = val;
        if (val) begin
            `uvm_info("SYS_TOP_CONFIG", "System Environment is included in the simulation", UVM_LOW)
        end

    endfunction

endclass