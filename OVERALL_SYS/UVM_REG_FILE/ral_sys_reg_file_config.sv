// this is top level model for ral that containt reg_block



	class ral_sys_reg_file_config extends uvm_reg_block;
		`uvm_object_utils(ral_sys_reg_file_config)

		rand ral_block_reg_file_config cfg;
		
		
		function new(string name="ral_sys_reg_file_config");
			super.new(name,build_coverage(UVM_NO_COVERAGE));
		endfunction

		
		// here we will use user function called build note it is not build_phase 
		// as this class extends uvm_object and here we don't have body or pre body
		virtual function void build ();

				this.default_map=create_map("",0,1,UVM_LITTLE_ENDIAN,0);
				this.cfg=ral_block_reg_file_config::type_id::create("cfg");
				/////// ask here !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				this.cfg.configure(this,"reg_file");
				this.cfg.build();

				//search for add submap later !!!!!!
				this.default_map.add_submap(this.cfg.default_map, `UVM_REG_ADDR_WIDTH'h0);
				add_hdl_path("top");

		endfunction

	endclass

/*
/////////////////// function used //////////////////////////////////////////////////////

 // Function: create_map
   //
   // Create an address map in this block
   //
   // Create an address map with the specified ~name~, then
   // configures it with the following properties.
   //
   // base_addr - the base address for the map. All registers, memories,
   //             and sub-blocks within the map will be at offsets to this
   //             address
   //
   // n_bytes   - the byte-width of the bus on which this map is used 
   //
   // endian    - the endian format. See <uvm_endianness_e> for possible
   //             values
   //
   // byte_addressing - specifies whether consecutive addresses refer are 1 byte
   //             apart (TRUE) or ~n_bytes~ apart (FALSE). Default is TRUE. 
   //
   //| APB = create_map("APB", 0, 1, UVM_LITTLE_ENDIAN, 1);
   //
   extern virtual function uvm_reg_map create_map(string name,
                                                  uvm_reg_addr_t base_addr,
                                                  int unsigned n_bytes,
                                                  uvm_endianness_e endian,
                                                  bit byte_addressing = 1);
   
	________________________________________________________________________________________________________

	here we will see configure of reg_block
	/ Function: configure
   //
   // Instance-specific configuration
   //
   // Specify the parent block of this block.
   // A block without parent is a root block.
   //
   // If the block file corresponds to a hierarchical RTL structure,
   // its contribution to the HDL path is specified as the ~hdl_path~.
   // Otherwise, the block does not correspond to a hierarchical RTL
   // structure (e.g. it is physically flattened) and does not contribute
   // to the hierarchical HDL path of any contained registers or memories.
   //
   extern function void configure(uvm_reg_block parent=null,
                                  string hdl_path="");


*/