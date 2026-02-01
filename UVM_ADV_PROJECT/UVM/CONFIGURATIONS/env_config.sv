class base_env_config  extends uvm_object;
  
  `uvm_object_utils(base_env_config)
  
  // Constructor
  function new(string name = "base_env_config");
    super.new(name);
  endfunction

  bit has_scoreboard [string];
  bit has_parent_sequencer;
  bit has_subscribers;
  bit has_agent[string];

endclass

class sys_env_config extends base_env_config;
  
  `uvm_object_utils(sys_env_config)
  
  agent_config #(virtual sys_intf) agent_config_inst;

  
  // Constructor
  function new(string name = "sys_env_config");
    super.new(name);
    agent_config_inst = new();
  endfunction


endclass

class aes_env_config extends base_env_config;
  
  `uvm_object_utils(aes_env_config)
  
  // Constructor
  function new(string name = "aes_env_config");
    super.new(name);
  endfunction

  agent_config #(virtual aes_if) agent_config_inst;

endclass

class memory1_env_config extends base_env_config;
  
  `uvm_object_utils(memory1_env_config)
  
  // Constructor
  function new(string name = "memory1_env_config");
    super.new(name);
  endfunction

  agent_config #(virtual intf) agent_config_inst;

endclass

class memory2_env_config extends base_env_config;
  
  `uvm_object_utils(memory2_env_config)
  
  // Constructor
  function new(string name = "memory2_env_config");
    super.new(name);
  endfunction

  agent_config #(virtual intf) agent_config_inst;
endclass

class tx_env_config extends base_env_config;
  
  `uvm_object_utils(tx_env_config)
  
  // Constructor
  function new(string name = "tx_env_config");
    super.new(name);
  endfunction

  agent_config #(virtual tx_if) agent_config_inst;

endclass

class rx_env_config extends base_env_config;
  
  `uvm_object_utils(rx_env_config)
  
  // Constructor
  function new(string name = "rx_env_config");
    super.new(name);
  endfunction

  agent_config #(virtual uart_if) agent_config_inst;
endclass

