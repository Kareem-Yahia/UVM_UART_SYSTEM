
class TX_cov extends uvm_component;

    `uvm_component_utils(TX_cov)
    uvm_analysis_export #(TX_seq_item) cov_export;
    uvm_tlm_analysis_fifo #(TX_seq_item) cov_fifo;
    TX_seq_item seq_item_cov;

   
    covergroup cg_TX;
        a:coverpoint seq_item_cov.Data_Valid iff(seq_item_cov.rst){
                    bins bin0=(0=>1);
                    option.at_least = 24;
            }

        b:coverpoint seq_item_cov.PAR_EN iff(seq_item_cov.rst){
                bins bin0 []={0,1};
            }
        c:coverpoint seq_item_cov.PAR_TYP iff(seq_item_cov.rst){
                bins bin0 []={0,1};
            }            
        d:coverpoint seq_item_cov.busy iff(seq_item_cov.rst){
                bins bin0 []={0,1};
            }
   

        cross_coverage: cross a,b,c,d iff(seq_item_cov.rst) ;

    endgroup        
        

    function new(string name="TX_cov", uvm_component parent=null);
     super.new(name, parent);
     cg_TX=new;

    endfunction 

    function void build_phase (uvm_phase phase);
    	super.build_phase(phase);
        seq_item_cov=TX_seq_item::type_id::create("seq_item_cov",this);
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
            cg_TX.sample();
    	end
    endtask : run_phase

endclass
    