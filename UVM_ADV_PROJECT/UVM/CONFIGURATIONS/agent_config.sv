class agent_config #(type intf_type = virtual  sys_intf) extends uvm_object;
  
  `uvm_object_utils(agent_config)
  
  function new(string name = "agent_config");
    super.new(name);
  endfunction

   uvm_active_passive_enum agent_type;

   intf_type vif;

endclass
