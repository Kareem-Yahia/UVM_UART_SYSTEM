module SYS_CTRL(CLK,RST,ALU_OUT,OUT_Valid,RX_P_Data,RX_D_VLD,RdData,RdData_Valid,ALU_EN,ALU_FUN,CLK_GATING_EN,Address,Wr_En,Rd_En,Wr_Data,TX_P_Data,TX_D_VLD,clk_div_en,wfull);
	
	parameter OPER_WIDTH = 8;
    parameter OUT_WIDTH = OPER_WIDTH*2;

    /////////////////// state encoding ///////////////////////
    ///////////////////////////////////////////////////////
    localparam IDLE=0;
    localparam RF_WR_ADDR=1;
    localparam RF_WR_DATA=2;
    localparam RF_RD_ADDR=3;
    localparam RF_SEND_TO_FIFO=4;
    localparam ALU_OPERAND_A=5;
    localparam ALU_OPERAND_B=6;
    localparam ALU_OPERAND_FUN=7;
    localparam ALU_SEND_TO_FIFO=8;
    localparam ALU_SEND_TO_FIFO_2=9;
    localparam ALU_NO_OPERAND_FUN=10;
    



    ////////////////////////////////////////////////////////
	input CLK,RST;
	input [OUT_WIDTH-1:0]ALU_OUT;
	input OUT_Valid;
	input RX_D_VLD;
	input RdData_Valid;
	input [OPER_WIDTH-1:0] RdData;
	input [OPER_WIDTH-1:0] RX_P_Data;
	input wfull;
	//////////////////////////////////////////////////
	output reg ALU_EN;
	output reg CLK_GATING_EN;
	output reg [3:0] ALU_FUN;
	output reg [3:0] Address;
	output reg Wr_En;
	output reg [OPER_WIDTH-1:0] Wr_Data;
	output reg Rd_En;
	output reg  [OPER_WIDTH-1:0] TX_P_Data;
	output reg TX_D_VLD;
	output reg clk_div_en;
	///////////////////////////////////////////////////

	reg [3:0] cs,ns;

	reg  [OPER_WIDTH-1:0] Address_temp_out;
	reg  [OPER_WIDTH-1:0] Address_temp_in;
	reg  [OUT_WIDTH-1:0] ALU_OUT_temp;

	//////////////////////////////////////// state transition ///////////////////////////////////////
	always @ (*) begin
		case(cs)
			IDLE: begin
					case({RX_D_VLD,RX_P_Data})
						'h1AA: ns=RF_WR_ADDR;
						'h1BB: ns=RF_RD_ADDR;
						'h1CC: ns=ALU_OPERAND_A;
						'h1DD: ns=ALU_NO_OPERAND_FUN;
						default: ns=IDLE;
					endcase	
			end

			RF_WR_ADDR: begin
				if(RX_D_VLD)
					ns= RF_WR_DATA;
				else
					ns= RF_WR_ADDR;
			end
			RF_WR_DATA: begin
				if(RX_D_VLD)
					ns= IDLE;
				else
					ns= RF_WR_DATA;
			end

			RF_RD_ADDR: begin
				if(RdData_Valid)
					ns= RF_SEND_TO_FIFO;
				else
					ns= RF_RD_ADDR;
			end

			RF_SEND_TO_FIFO : begin
				if(!wfull)
					ns= IDLE;
				else
					ns= RF_SEND_TO_FIFO;
			end


			ALU_OPERAND_A: begin
				if(RX_D_VLD)
					ns= ALU_OPERAND_B;
				else
					ns= ALU_OPERAND_A;
			end
			ALU_OPERAND_B: begin
				if(RX_D_VLD)
					ns= ALU_OPERAND_FUN;
				else
					ns= ALU_OPERAND_B;
			end
			ALU_OPERAND_FUN: begin
				if(OUT_Valid)
					ns= ALU_SEND_TO_FIFO;
				else
					ns= ALU_OPERAND_FUN;
			end

			ALU_SEND_TO_FIFO : begin			
				 if(!wfull)
					ns=ALU_SEND_TO_FIFO_2;	
				else
					ns= ALU_SEND_TO_FIFO;
			end

			ALU_SEND_TO_FIFO_2 : begin
				if(!wfull)
					ns= IDLE;
				else
					ns= ALU_SEND_TO_FIFO_2;
			end

			ALU_NO_OPERAND_FUN: begin
				if(OUT_Valid)
					ns= ALU_SEND_TO_FIFO;
				else
					ns= ALU_NO_OPERAND_FUN;
			end

			default: ns=IDLE;
		endcase
	end

	//////////////////////////////////////////////////////////////////////////////////////////////
	always @(posedge CLK or negedge RST) begin
		if(!RST)
			cs<=IDLE;
		else
			cs<=ns;	
	end

	/////////////////////////////////////////////////////////////////////////////////////////////

	always @ (*) begin
		ALU_EN=0;
		CLK_GATING_EN=0;
		ALU_FUN=0;
		Address=0;
		Address_temp_in=Address_temp_out;
		Wr_Data=0;
		Wr_En=0;
		Rd_En=0;
		TX_P_Data=0;
		TX_D_VLD=0;
		clk_div_en=1;
		case(cs)
			IDLE: begin
				CLK_GATING_EN=0;
			end
			RF_WR_ADDR: begin
				if(RX_D_VLD)
					Address_temp_in=RX_P_Data;
			end
			RF_WR_DATA: begin
				Address=Address_temp_out;
				Wr_Data=RX_P_Data;
				if(RX_D_VLD)
					Wr_En=1;
			end

			RF_RD_ADDR: begin
				if(RX_D_VLD) begin
					Address=RX_P_Data;
					Rd_En=1;
				end
			end
			// here we wait till read_valid
			RF_SEND_TO_FIFO : begin
				CLK_GATING_EN=0;
				TX_P_Data=RdData;
				TX_D_VLD=1; //////////// ASK HERE /////////////////////////
			end

			ALU_OPERAND_A: begin
				if(RX_D_VLD) begin
					Wr_Data=RX_P_Data;
					Address=0;
					Wr_En=1;
				end
			end

			ALU_OPERAND_B: begin
				if(RX_D_VLD) begin
					Wr_Data=RX_P_Data;
					Address=1;
					Wr_En=1;
				end
			end
			//////////////////////////////////////////////////////////////////////
			ALU_OPERAND_FUN: begin
				CLK_GATING_EN=1;
				if(RX_D_VLD) begin
					ALU_FUN=RX_P_Data;
			 		ALU_EN=1;
				end
			end
			// think about operand isolation as operand B come later than A 
			////////////////////////////////////////////////////////////////////

			ALU_SEND_TO_FIFO : begin
				CLK_GATING_EN=0;
				TX_P_Data=ALU_OUT_temp[7:0];
				TX_D_VLD=1; //////////// ASK HERE /////////////////////////
			end

			ALU_SEND_TO_FIFO_2 : begin
				CLK_GATING_EN=0;
				TX_P_Data=ALU_OUT_temp[15:8];
				TX_D_VLD=1; //////////// ASK HERE /////////////////////////
			end

			ALU_NO_OPERAND_FUN: begin
				CLK_GATING_EN=1;
				if(RX_D_VLD) begin
					ALU_FUN=RX_P_Data;
					ALU_EN=1;
				end
			end
			default: begin
				ALU_EN=0;
				CLK_GATING_EN=0;
				ALU_FUN=0;
				Address=0;
				Address_temp_in=Address_temp_out;
				Wr_Data=0;
				Wr_En=0;
				Rd_En=0;
				TX_P_Data=0;
				TX_D_VLD=0;
				clk_div_en=1;
			end 
		endcase
	end  

	////// HERE WE Register Address //////////////////////////
	always @(posedge CLK or negedge RST) begin
		if(!RST) begin
			Address_temp_out<=0;
			ALU_OUT_temp<=0;
		end
		else begin
			Address_temp_out<=Address_temp_in;
			if(OUT_Valid)
				ALU_OUT_temp<=ALU_OUT;
		end
	end

	/////////////////////////////////////////////////////////////////	


endmodule