package sys_driver_pkg;

  import uvm_pkg::*;
  import sys_config_obj_pkg::*;
  import sys_seq_item_pkg::*; 
  `include "uvm_macros.svh"

  class sys_driver extends uvm_driver #(sys_seq_item);
          `uvm_component_utils(sys_driver)

          sys_seq_item stim_seq_item;
          virtual sys_if sysvif_driver;

          function new(string name="sys_driver", uvm_component parent=null);
            super.new(name, parent);
          endfunction: new

          virtual task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
            stim_seq_item=sys_seq_item::type_id::create("stim_seq_item");

            seq_item_port.get_next_item(stim_seq_item);
              drive1();
            seq_item_port.item_done();

             `uvm_info(get_type_name(),stim_seq_item.convert2string_stimulus(),UVM_HIGH)

            end      
      endtask

      virtual task drive1();
            //here we drive inputs

            sysvif_driver.RST=stim_seq_item.RST;
            sysvif_driver.RX_IN=stim_seq_item.RX_IN;
            //output 
            stim_seq_item.par_err_reg=sysvif_driver.par_err_reg;
            stim_seq_item.stp_error_reg=sysvif_driver.stp_error_reg;
            stim_seq_item.TX_OUT=sysvif_driver.TX_OUT;

            
            ///////////////////////////////////////////////
            @(negedge sysvif_driver.TX_CLK_TB);

      endtask

  endclass
  
endpackage