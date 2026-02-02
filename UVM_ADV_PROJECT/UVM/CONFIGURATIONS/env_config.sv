class base_env_config  extends uvm_object;
  
  `uvm_object_utils(base_env_config)
    
    bit has_scoreboard [string];
    bit has_parent_sequencer;
    bit has_subscribers;
    bit has_agent[string];  

  // Constructor
  function new(string name = "base_env_config");
    super.new(name);
  endfunction


endclass

class sys_env_config extends base_env_config;
  
  `uvm_object_utils(sys_env_config)
  
  agent_config #(virtual sys_intf #(.DATA_WIDTH(DATA_WIDTH), .MEM_DEPTH(MEM_DEPTH))) agent_config_inst;

  // Constructor
  function new(string name = "sys_env_config");
    super.new(name);
    agent_config_inst = new();
    has_agent["sys_agent_mem"]   = 1 ;
    has_scoreboard["sys_scoreboard_1"] = 1 ;
    has_scoreboard["sys_scoreboard_2"] = 1 ;
    has_scoreboard["sys_scoreboard_3"] = 1 ;
    has_scoreboard["sys_scoreboard_4"] = 1 ;
    has_scoreboard["sys_scoreboard_5"] = 1 ;
    agent_config_inst.agent_type = UVM_ACTIVE ;
  endfunction




endclass

class aes_env_config extends base_env_config;
  
  `uvm_object_utils(aes_env_config)

  agent_config #(virtual AES_if #(.N(N), .Nr(Nr), .Nk(Nk))) agent_config_inst;

  
  // Constructor
  function new(string name = "aes_env_config");
    super.new(name);
    agent_config_inst = new();

  endfunction


endclass

class memory1_env_config extends base_env_config;
  
  `uvm_object_utils(memory1_env_config)

    agent_config #(virtual intf) agent_config_inst;

  
  // Constructor
  function new(string name = "memory1_env_config");
    super.new(name);
    agent_config_inst = new();
  endfunction


endclass

class memory2_env_config extends base_env_config;
  
  `uvm_object_utils(memory2_env_config)

  agent_config #(virtual intf) agent_config_inst;

  
  // Constructor
  function new(string name = "memory2_env_config");
    super.new(name);
    agent_config_inst = new();
  endfunction

endclass

class tx_env_config extends base_env_config;
  
  `uvm_object_utils(tx_env_config)
  
  agent_config #(virtual TX_if) agent_config_inst;
  
  // Constructor
  function new(string name = "tx_env_config");
    super.new(name);
    agent_config_inst = new();

  endfunction

endclass

class rx_env_config extends base_env_config;
  
  `uvm_object_utils(rx_env_config)

  agent_config #(virtual uart_if) agent_config_inst;

  
  // Constructor
  function new(string name = "rx_env_config");
    super.new(name);
    agent_config_inst = new();

  endfunction

endclass

