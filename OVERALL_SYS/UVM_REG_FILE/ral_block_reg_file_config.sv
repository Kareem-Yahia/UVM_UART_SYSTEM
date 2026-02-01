package ral_block_reg_file_config_pkg;

	import ral_uart_config_pkg::*;	
	import ral_ALU_Operand_A_config_pkg::*;
	import ral_ALU_Operand_B_config_pkg::*;
	import ral_Div_Ratio_config_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	class ral_block_reg_file_config extends uvm_reg_block;
		`uvm_object_utils(ral_block_reg_file_config)

		ral_uart_config uart_config;
		ral_ALU_Operand_A_config  ALU_Operand_A_config;
		ral_ALU_Operand_B_config ALU_Operand_B_config;
		ral_Div_Ratio_config 	Div_Ratio_config ;
		
		
		function new(string name="ral_block_reg_file_config");
			super.new(name,build_coverage(UVM_NO_COVERAGE));
		endfunction

		
		// here we will use user function called build note it is not build_phase 
		// as this class extends uvm_object and here we don't have body or pre body
		virtual function void build ();

		// 1- we will create map (we will use default map in uvm_reg_block called default_map)
		// and then use function create 
		 /*
			 // Variable: default_map in uvm_reg_block
		   //
		   // Default address map
		   //
		   // Default address map for this block, to be used when no
		   // address map is specified for a register operation and that
		   // register is accessible from more than one address map.
		   //
		   // It is also the implicit address map for a block with a single,
		   // unnamed address map because it has only one physical interface.
		   //
		   uvm_reg_map default_map;
		 */

		 this.default_map=create_map("",0,1,UVM_LITTLE_ENDIAN,0);
		
		// 2- We will create register then config it 


		this.ALU_Operand_A_config=ral_ALU_Operand_A_config::type_id::create("ALU_Operand_A_config");
		this.ALU_Operand_A_config.configure(this,null,"");
		this.ALU_Operand_A_config.build();
		//hdl path to this top.reg_file.regArr[0]
		// we will put reg_path_in_dut / start bit / number of bits
		this.ALU_Operand_A_config.add_hdl_path_slice("regArr[0]",0,ALU_Operand_A_config.get_n_bits());
		this.default_map.add_reg(this.ALU_Operand_A_config,`UVM_REG_ADDR_WIDTH'h0,"RW",0);


	
		this.ALU_Operand_B_config=ral_ALU_Operand_B_config::type_id::create("ALU_Operand_B_config");
		this.ALU_Operand_B_config.configure(this,null,"");
		this.ALU_Operand_B_config.build();
		this.ALU_Operand_B_config.add_hdl_path_slice("regArr[1]",0,ALU_Operand_B_config.get_n_bits());
		this.default_map.add_reg(this.ALU_Operand_B_config,`UVM_REG_ADDR_WIDTH'h1,"RW",0);

		this.uart_config=ral_uart_config::type_id::create("uart_config");
		this.uart_config.configure(this,null,"");
		this.uart_config.build();
		this.uart_config.add_hdl_path_slice("regArr[2]",0,uart_config.get_n_bits());
		this.default_map.add_reg(this.uart_config,`UVM_REG_ADDR_WIDTH'h2,"RW",0);


		this.Div_Ratio_config=ral_Div_Ratio_config::type_id::create("Div_Ratio_config");
		this.Div_Ratio_config.configure(this,null,"");
		this.Div_Ratio_config.build();
		this.Div_Ratio_config.add_hdl_path_slice("regArr[3]",0,Div_Ratio_config.get_n_bits());
		this.default_map.add_reg(this.Div_Ratio_config,`UVM_REG_ADDR_WIDTH'h3,"RW",0);

		add_hdl_path("reg_file"); //here we put instance name of dut
		endfunction

	endclass

endpackage 

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

   // Function: configure of register not reg_block
   //
   // Instance-specific configuration
   //
   // Specify the parent block of this register.
   // May also set a parent register file for this register,
   //
   // If the register is implemented in a single HDL variable,
   // its name is specified as the ~hdl_path~.
   // Otherwise, if the register is implemented as a concatenation
   // of variables (usually one per field), then the HDL path
   // must be specified using the <add_hdl_path()> or
   // <add_hdl_path_slice> method.
   //
   extern function void configure (uvm_reg_block blk_parent,
                                   uvm_reg_file regfile_parent = null,
                                   string hdl_path = "");

	____________________________________________________________________________________________________________
   // Function: add_reg
   //
   // Add a register
   //
   // Add the specified register instance ~rg~ to this address map.
   //
   // The register is located at the specified address ~offset~ from
   // this maps configured base address.
   //
   // The ~rights~ specify the register's accessibility via this map.
   // Valid values are "RW", "RO", and "WO". Whether a register field
   // can be read or written depends on both the field's configured access
   // policy (see <uvm_reg_field::configure> and the register's rights in
   // the map being used to access the field. 
   //
   // The number of consecutive physical addresses occupied by the register
   // depends on the width of the register and the number of bytes in the
   // physical interface corresponding to this address map.
   //
   // If ~unmapped~ is TRUE, the register does not occupy any
   // physical addresses and the base address is ignored.
   // Unmapped registers require a user-defined ~frontdoor~ to be specified.
   //
   // A register may be added to multiple address maps
   // if it is accessible from multiple physical interfaces.
   // A register may only be added to an address map whose parent block
   // is the same as the register's parent block.
   //
   extern virtual function void add_reg (uvm_reg           rg,
                                         uvm_reg_addr_t    offset,
                                         string            rights = "RW",
                                         bit               unmapped=0,
                                         uvm_reg_frontdoor frontdoor=null);

    */                               