
  class uart_driver extends uvm_driver #(uart_seq_item);
          `uvm_component_utils(uart_driver)

          uart_seq_item stim_seq_item;
          virtual uart_if uartvif_driver;

          function new(string name="uart_driver", uvm_component parent=null);
            super.new(name, parent);
          endfunction: new

          virtual task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
            stim_seq_item=uart_seq_item::type_id::create("stim_seq_item");

            seq_item_port.get_next_item(stim_seq_item);
              drive1();
            seq_item_port.item_done();

             `uvm_info(get_type_name(),stim_seq_item.convert2string_stimulus(),UVM_HIGH)

            end      
      endtask

      virtual task drive1();
            //here we drive inputs

            uartvif_driver.rst=stim_seq_item.rst;
            uartvif_driver.RX_IN=stim_seq_item.RX_IN;
            uartvif_driver.prescale=stim_seq_item.prescale;
            uartvif_driver.PAR_EN=stim_seq_item.PAR_EN;
            uartvif_driver.PAR_TYP=stim_seq_item.PAR_TYP;

            //just for testing 
            stim_seq_item.data_valid_reg=uartvif_driver.data_valid_reg;
            stim_seq_item.P_DATA_reg=uartvif_driver.P_DATA_reg;
            stim_seq_item.par_err_reg=uartvif_driver.par_err_reg;
            stim_seq_item.stp_error_reg=uartvif_driver.stp_error_reg;

            ///////////////////////////////////////////////
            @(negedge uartvif_driver.TX_CLK_TB);

      endtask

  endclass
  