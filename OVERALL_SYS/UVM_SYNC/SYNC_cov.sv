
class SYNC_cov extends uvm_component;

    `uvm_component_utils(SYNC_cov)
    
    uvm_analysis_export #(SYNC_seq_item) cov_export;
    uvm_tlm_analysis_fifo #(SYNC_seq_item) cov_fifo;
    
    SYNC_seq_item seq_item_cov;


    covergroup cg_SYNC;


       unsync_bus:coverpoint seq_item_cov.unsync_bus iff(seq_item_cov.rst){
                bins bin_wr_cmd             = {8'hAA} ;
                bins bin_rd_cmd             = {8'hBB} ;
                bins bin_alu_with_op_cmd    = {8'hCC} ;
                bins bin_alu_without_op_cmd = {8'hDD} ;
            }

        bus_enable:coverpoint seq_item_cov.bus_enable iff(seq_item_cov.rst){
                bins bin0                   ={0};
                bins bin1                   ={1};
            }

        sync_bus:coverpoint seq_item_cov.sync_bus iff(seq_item_cov.rst){
                bins bin_wr_cmd             = {8'hAA} ;
                bins bin_rd_cmd             = {8'hBB} ;
                bins bin_alu_with_op_cmd    = {8'hCC} ;
                bins bin_alu_without_op_cmd = {8'hDD} ;
   
            }

        enable_pulse:coverpoint seq_item_cov.enable_pulse iff(seq_item_cov.rst){
                bins bin0                   ={0};
                bins bin1                   ={1};
            }                                 

        cross_coverage: cross unsync_bus,bus_enable,sync_bus,enable_pulse  iff(seq_item_cov.rst)  {
            bins bin_complete_full_sync_wr_cmd = binsof(sync_bus.bin_wr_cmd) &&  
                                          binsof(unsync_bus.bin_wr_cmd) && 
                                          binsof(enable_pulse.bin1) ;


            bins bin_complete_full_sync_rd_cmd = binsof(sync_bus.bin_rd_cmd) &&  
                                          binsof(unsync_bus.bin_rd_cmd) && 
                                          binsof(enable_pulse.bin1) ;

            bins bin_complete_full_sync_alu_with_op_cmd = binsof(sync_bus.bin_alu_with_op_cmd) &&  
                                          binsof(unsync_bus.bin_alu_with_op_cmd) && 
                                          binsof(enable_pulse.bin1) ;
                                          
            bins bin_complete_full_sync_alu_without_op_cmd = binsof(sync_bus.bin_alu_without_op_cmd) &&  
                                          binsof(unsync_bus.bin_alu_without_op_cmd) && 
                                          binsof(enable_pulse.bin1) ;
        }
        
        endgroup        
    

        function new(string name="SYNC_cov", uvm_component parent=null);
         super.new(name, parent);
         cg_SYNC=new;
        
        endfunction 

        function void build_phase (uvm_phase phase);
        	super.build_phase(phase);
            seq_item_cov=SYNC_seq_item::type_id::create("seq_item_cov",this);
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
            cg_SYNC.sample();
    	end
    endtask : run_phase

	endclass
    