module SYS_TOP_dft (REF_CLK,RST,UART_CLK,RX_IN,par_err_reg ,stp_error_reg,TX_OUT,SI,SO,SE,test_mode,scan_clock,scan_rst);

	input SI,SE,test_mode,scan_clock,scan_rst;
	output SO;
	
	input REF_CLK,RST,UART_CLK,RX_IN;
	output TX_OUT;
	output par_err_reg,stp_error_reg;

	/////////////////////////////////////////////////////////////////////////////
	wire SYNC_RST_sys;
	wire SYNC_RST_UART;
	wire TX_CLK;
	wire RX_CLK;
	wire [7:0] REG0;
	wire [7:0] REG1;
	wire [7:0] REG2;
	wire [7:0] REG3;
	reg [1:0] Div_Ratio_RX;
	wire [7:0] P_DATA_reg_RX;
	wire data_valid_reg_RX;
	wire [7:0] RX_P_Data;
	wire RX_D_VLD;
	wire [15:0] ALU_OUT;
	wire OUT_Valid;

	wire [7:0] RdData;
	wire RdData_Valid;
	wire ALU_EN;
	wire [3:0]ALU_FUN;
	wire CLK_GATING_EN;
	wire [3:0] Address;
	wire Wr_En;
	wire Rd_En;
	wire [7:0] Wr_Data;
	wire [7:0]TX_P_Data;
	wire TX_D_VLD;
	wire clk_div_en;
	///////////////////////////////////////////////////////////////////////
	wire wfull; // not implemented in SYS_CTRL YET;
	/////////////////////////////////////////////////////////////////////////
	wire [7:0]r_data;
	wire rinc;
	wire rempty;
	wire busy;
	wire ALU_CLK;
	wire [5:0]prescale;
	////////////////////////////////////////////////////////////////////////
	wire UART_CLK_M;
	wire REF_CLK_M;
	wire TX_CLK_M;
	wire RX_CLK_M;
	
	wire  RST_M;
	wire SYNC_RST_sys_M;
	wire SYNC_RST_UART_M;
	////////////////////////////////////////////////////////////////////////
	assign UART_CLK_M =(test_mode)?scan_clock:UART_CLK;
	assign REF_CLK_M =(test_mode)?scan_clock:REF_CLK;
	assign TX_CLK_M =(test_mode)?scan_clock:TX_CLK;
	assign RX_CLK_M =(test_mode)?scan_clock:RX_CLK;
	////////////////////////////////////////////////////////////////////////
	assign RST_M =(test_mode)? scan_rst:RST;
	assign SYNC_RST_sys_M =(test_mode)? scan_rst:SYNC_RST_sys;
	assign SYNC_RST_UART_M =(test_mode)? scan_rst:SYNC_RST_UART;


	////////////////////////////////////////////////////////////////////////
	assign prescale=REG2[7:2];
	
	UART_RX RX(
	.clk(RX_CLK_M),
	.rst(SYNC_RST_UART_M),
	.RX_IN(RX_IN),
	.prescale(prescale),
	.PAR_EN(REG2[0]),
	.PAR_TYP(REG2[1]),
	.data_valid_reg(data_valid_reg_RX),
	.par_err_reg(par_err_reg),
	.stp_error_reg(stp_error_reg),
	.P_DATA_reg(P_DATA_reg_RX)
	);

	UART_TX TX(
	.P_DATA(r_data),
	.Data_Valid(~rempty),
	.PAR_TYP(REG2[1]),
	.PAR_EN(REG2[0]),
	.TX_OUT(TX_OUT),
	.busy(busy),
	.clk(TX_CLK_M),
	.rst(SYNC_RST_UART_M)
	);

	RST_SYNC RST_SYNC_REF_CLK(
	.RST(RST_M),
	.CLK(REF_CLK_M),
	.SYNC_RST(SYNC_RST_sys)
	);

	RST_SYNC RST_SYNC_UART_CLK(
	.RST(RST_M),
	.CLK(UART_CLK_M),
	.SYNC_RST(SYNC_RST_UART)
	);

	DATA_SYNC DATA_SYNC(
	.unsync_bus(P_DATA_reg_RX),
	.bus_enable(data_valid_reg_RX),
	.clk(REF_CLK_M),
	.rst(SYNC_RST_sys_M),
	.sync_bus(RX_P_Data),
	.enable_pulse(RX_D_VLD)
	);

	SYS_CTRL SYS_CTRL(
		.CLK(REF_CLK_M),
		.RST(SYNC_RST_sys_M),
		.ALU_OUT(ALU_OUT),
		.OUT_Valid(OUT_Valid),
		.RX_P_Data(RX_P_Data),
		.RX_D_VLD(RX_D_VLD),
		.RdData(RdData),
		.RdData_Valid(RdData_Valid),
		.ALU_EN(ALU_EN),
		.ALU_FUN(ALU_FUN),
		.CLK_GATING_EN(CLK_GATING_EN),
		.Address(Address),
		.Wr_En(Wr_En),
		.Rd_En(Rd_En),
		.Wr_Data(Wr_Data),
		.TX_P_Data(TX_P_Data),
		.TX_D_VLD(TX_D_VLD),
		.clk_div_en(clk_div_en),
		.wfull(wfull)
		);

	 clock_gating clk_gating(
		 .CLK_EN(test_mode | CLK_GATING_EN),
		 .CLK(REF_CLK_M),
		 .GATED_CLK(ALU_CLK)
		 );



	Pulse_Gen PULSE_GEN(
	.clk(TX_CLK_M),
	.rst(SYNC_RST_UART_M),
	.in(busy),
	.out(rinc)
	);

	ClkDiv #(.Range_for_division(8)) CLK_DIV_TX(
	.i_ref_clk(UART_CLK_M),
	.i_rst_n(SYNC_RST_UART_M),
	.i_clk_en(clk_div_en),
	.i_div_ratio(REG3),
	.o_div_clk(TX_CLK)
	);

	ClkDiv #(.Range_for_division(2)) CLK_DIV_RX(
	.i_ref_clk(UART_CLK_M),
	.i_rst_n(SYNC_RST_UART_M),
	.i_clk_en(clk_div_en),
	.i_div_ratio(Div_Ratio_RX),
	.o_div_clk(RX_CLK)
	);

	always @(*) begin
		case(REG2[7:2])
			'd32:Div_Ratio_RX=1;
			'd16:Div_Ratio_RX=2;
			'd8: Div_Ratio_RX=4;
			default:Div_Ratio_RX=1;
		endcase
	end

	FIFO_TOP FIFO(
	.w_data(TX_P_Data),
	.winc(TX_D_VLD),
	.w_clk(REF_CLK_M),
	.wrst_n(SYNC_RST_sys_M),
	.wfull(wfull),
	.r_data(r_data),
	.rinc(rinc),
	.rempty(rempty),
	.r_clk(TX_CLK_M),
	.rrst_n(SYNC_RST_UART_M)
	);
	
	RegFile REG (
	.CLK(REF_CLK_M),
	.RST(SYNC_RST_sys_M),
	.WrEn(Wr_En),
	.RdEn(Rd_En),
	.Address(Address),
	.WrData(Wr_Data),
	.RdData(RdData),
	.RdData_VLD(RdData_Valid),
	.REG0(REG0),
	.REG1(REG1),
	.REG2(REG2),
	.REG3(REG3)
	);

	 ALU ALU (
	  .A(REG0), 
	  .B(REG1),
	  .EN(ALU_EN),
	  .ALU_FUN(ALU_FUN),
	  .CLK(ALU_CLK),
	  .RST(SYNC_RST_sys_M),  
	  .ALU_OUT(ALU_OUT),
	  .OUT_VALID(OUT_Valid)
	);
  
	
endmodule
