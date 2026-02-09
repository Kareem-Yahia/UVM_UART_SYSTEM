
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
            @(sysvif_driver.cb);
            // Inputs

            sysvif_driver.cb.RST           <=stim_seq_item.RST;
            sysvif_driver.cb.RX_IN         <=stim_seq_item.RX_IN;

            // Outputs

            stim_seq_item.par_err_reg      <=sysvif_driver.cb.par_err_reg;
            stim_seq_item.stp_error_reg   <=sysvif_driver.cb.stp_error_reg;
            stim_seq_item.TX_OUT          <=sysvif_driver.cb.TX_OUT;

            
            ///////////////////////////////////////////////

      endtask

  endclass
  