// this is top level model for ral that containt reg_block

package reg2reg_file_adapter_pkg;

	import reg_file_seq_item_pkg::*;
	
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	class reg2reg_file_adapter extends uvm_reg_adapter;
		`uvm_object_utils(reg2reg_file_adapter)

		
		
		function new(string name="reg2reg_file_adapter");
			super.new(name);
			supports_byte_enable=0;
			provides_responses=0;
		endfunction

		//note when you call generic read write to use reg model it must be converted to
		//bus transaction through following function read & write function make struc of 
		// data type uvm_reg_bus_op

		virtual function uvm_sequence_item reg2bus (const ref uvm_reg_bus_op rw);
				reg_file_seq_item pkt=reg_file_seq_item::type_id::create("reg_file_seq_item");
				pkt.RST=1;
								pkt.Address=rw.addr;
				if (rw.kind== UVM_WRITE) begin
					pkt.WrEn=1;
					pkt.RdEn=0;
					pkt.WrData=rw.data;
				end
				else if (rw.kind == UVM_READ )begin
					pkt.RdEn=1;
					pkt.WrEn=0;
					pkt.WrData=11;//dummy value
				end

				`uvm_info("adapter",$sformatf("reg2bus addr=%0h data=%0h kind=%s",pkt.Address,pkt.WrData,rw.kind),UVM_MEDIUM)

				return pkt;

		endfunction

				virtual function void bus2reg (uvm_sequence_item bus_item ,ref uvm_reg_bus_op rw);
				reg_file_seq_item pkt;
				
				if(!$cast(pkt,bus_item)) begin
					`uvm_fatal("adapter","failed to cast bus_item to pkt")
				end

					rw.addr=pkt.Address;
				if ( pkt.WrEn==1 ) begin
					rw.kind=UVM_WRITE;
					rw.data=pkt.WrData; 
				end
				else if (pkt.WrEn==0 )begin
					rw.kind=UVM_READ;
					rw.data=pkt.RdData;
				end



				`uvm_info("adapter",$sformatf("bus2reg pkt.WrEn=%b  addr=%0h data=%0h kind=%s status=%s ",
					pkt.WrEn,rw.addr,rw.data,rw.kind,rw.status.name()),UVM_MEDIUM)
				
		endfunction
	endclass
endpackage 

/*
These register read/write access calls create an internal generic register item
 of type uvm_reg_bus_op which is a simple struct as shown below.

 typedef struct {
  uvm_access_e       kind;       // Access type: UVM_READ/UVM_WRITE
  uvm_reg_addr_t     addr;       // Bus address, default 64 bits
  uvm_reg_data_t     data;       // Read/Write data, default 64 bits
  int                n_bits;     // Number of bits being transferred
  uvm_reg_byte_en    byte_en;    // Byte enable
  uvm_status_e       status;     // Result of transaction: UVM_IS_OK, UVM_HAS_X, UVM_NOT_OK
} uvm_reg_bus_op;

*/
