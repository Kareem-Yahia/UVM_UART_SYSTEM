
	class ral_ALU_Operand_A_config extends uvm_reg;
		`uvm_object_utils(ral_ALU_Operand_A_config)
		
		rand uvm_reg_field ALU_Operand_A;
		

		//////// here in constructor we pass size=8 && functional coverage extension model 
		// ask about it !!!

		function new(string name="ral_ALU_Operand_A_config");
			super.new(name,8,build_coverage(UVM_NO_COVERAGE));
		endfunction

		// here we will use user function called build note it is not build_phase 
		// as this class extends uvm_object and here we don't have body or pre body
		// so we will call this function manual in reg_block when we build structure

		virtual function void build ();
			// first we will create registers 
			this.ALU_Operand_A=uvm_reg_field::type_id::create("ALU_Operand_A");
			

			// second we will configure it

			/*
			 // Function: configure
			   //
			   // Instance-specific configuration
			   //
			   // Specify the ~parent~ register of this field, its
			   // ~size~ in bits, the position of its least-significant bit
			   // within the register relative to the least-significant bit
			   // of the register, its ~access~ policy, volatility,
			   // "HARD" ~reset~ value, 
			   // whether the field value is actually reset
			   // (the ~reset~ value is ignored if ~FALSE~),
			   // whether the field value may be randomized and
			   // whether the field is the only one to occupy a byte lane in the register.
			   //
			   // See <set_access> for a specification of the pre-defined
			   // field access policies.
			   //
			   // If the field access policy is a pre-defined policy and NOT one of
			   // "RW", "WRC", "WRS", "WO", "W1", or "WO1",
			   // the value of ~is_rand~ is ignored and the rand_mode() for the
			   // field instance is turned off since it cannot be written.
			   //
			   extern function void configure(uvm_reg        parent,
			                                  int unsigned   size,
			                                  int unsigned   lsb_pos,
			                                  string         access,
			                                  bit            volatile,
			                                  uvm_reg_data_t reset,
			                                  bit            has_reset,
			                                  bit            is_rand,
			                                  bit            individually_accessible); 
			*/

			this.ALU_Operand_A.configure(this,8,0,"RW",0,'d0,1,0,1);
			
		endfunction

	endclass
