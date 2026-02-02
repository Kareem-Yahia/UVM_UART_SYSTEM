class sys_rst_sequence extends uvm_sequence #(sys_seq_item_mem);
  
  `uvm_object_utils(sys_rst_sequence)

      sys_seq_item_mem seq_item;

  
  // Constructor
  function new(string name = "sys_rst_sequence");
    super.new(name);
  endfunction

  // Body task
  virtual task body();    
    seq_item = sys_seq_item_mem::type_id::create("seq_item");
    
    
    start_item(seq_item);
        assert(seq_item.randomize() with {        seq_item.rst_n == 0; }) ;
    finish_item(seq_item);
    

    start_item(seq_item);
        assert(seq_item.randomize() with {        seq_item.rst_n == 0; }) ;
    finish_item(seq_item);   

    
  endtask

endclass