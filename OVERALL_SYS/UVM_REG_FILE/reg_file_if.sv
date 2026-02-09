interface reg_file_if (REF_CLK);

	parameter ADDR=4;
	parameter WIDTH=8;

	input REF_CLK;

	logic RST;
	logic WrEn;
	logic RdEn;
	logic [ADDR-1:0]   Address;
	logic [WIDTH-1:0]  WrData;
	logic [WIDTH-1:0]  RdData;
	logic  RdData_VLD;
	
	logic [WIDTH-1:0]  REG0;
	logic [WIDTH-1:0]  REG1;
	logic [WIDTH-1:0]  REG2;
	logic [WIDTH-1:0]  REG3;
endinterface 