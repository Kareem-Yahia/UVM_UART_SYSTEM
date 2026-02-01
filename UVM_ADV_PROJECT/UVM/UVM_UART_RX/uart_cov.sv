
    class uart_cov extends uvm_component;

    `uvm_component_utils(uart_cov)
    uvm_analysis_export #(uart_seq_item) cov_export;
    uvm_tlm_analysis_fifo #(uart_seq_item) cov_fifo;
    uart_seq_item seq_item_cov;

   
        covergroup cg_uart;
                a:coverpoint seq_item_cov.RX_IN iff(seq_item_cov.rst){
                        bins bin0=(1=>0);
                        option.at_least = 100;
                    }

                b:coverpoint seq_item_cov.prescale iff(seq_item_cov.rst){
                        bins bin0 []={8,16,32};
                    }
                c:coverpoint seq_item_cov.PAR_EN iff(seq_item_cov.rst){
                        bins bin0 []={0,1};
                    }
                d:coverpoint seq_item_cov.PAR_TYP iff(seq_item_cov.rst){
                        bins bin0 []={0,1};
                    }            
                e:coverpoint seq_item_cov.par_err_reg iff(seq_item_cov.rst){
                        bins bin0 []={0,1};
                    }
                f:coverpoint seq_item_cov.stp_error_reg iff(seq_item_cov.rst){
                        bins bin0 []={0,1};
                    }
                    
                     

                    cross_coverage: cross b,c,d,e,f iff(seq_item_cov.rst) ;

        endgroup
        
        function new(string name="uart_cov", uvm_component parent=null);
         super.new(name, parent);
         cg_uart=new;
        endfunction 

        function void build_phase (uvm_phase phase);
        	super.build_phase(phase);
            seq_item_cov=uart_seq_item::type_id::create("seq_item_cov",this);
        	cov_fifo=new("cov_fifo",this);
        	cov_export=new("cov_export",this);
        endfunction   

        function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        cov_export.connect(cov_fifo.analysis_export);
        endfunction: connect_phase


    task run_phase(uvm_phase phase);
    	super.run_phase(phase);
    	forever begin
    		cov_fifo.get(seq_item_cov);
            cg_uart.sample();
    	end
    endtask : run_phase

	endclass
    