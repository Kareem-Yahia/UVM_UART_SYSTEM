`timescale 1ns/1ps

import sys_test_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

module top();

	//######################################################################################################################
	parameter clk_period_REF_CLK=20;
	parameter clk_period_UART_CLK=271.26;
	parameter TX_CLK_PERIOD=8680.55;

	logic TX_CLK_TB;
	logic UART_CLK;
	logic REF_CLK;

	//####################################################################################################################
	typedef enum {IDLE,RF_WR_ADDR,RF_WR_DATA,RF_RD_ADDR,RF_SEND_TO_FIFO,ALU_OPERAND_A,ALU_OPERAND_B,ALU_OPERAND_FUN,ALU_SEND_TO_FIFO,ALU_SEND_TO_FIFO_2,ALU_NO_OPERAND_FUN} e_states;
	typedef enum {IDLE_RX,START_RX,DATA_RX,PARITY_RX,STOP_RX} e_states_uart_RX; 
	typedef enum {IDLE_TX,START_TX,DATA_TX,PARITY_TX,STOP_TX} e_states_uart_TX;


	e_states cs_SYS_CTRL;
	e_states_uart_RX cs_UART_RX;
	e_states_uart_TX cs_UART_TX;
	e_states ns;

	assign cs_SYS_CTRL=e_states'(sys.SYS_CTRL.cs);
	assign cs_UART_RX=e_states_uart_RX'(sys.RX.fsm.cs);
	assign cs_UART_TX=e_states_uart_TX'(sys.TX.Controller_TX.cs);
	//#######################################################################################################################


	initial begin
		UART_CLK=0;
		forever begin
			#(clk_period_UART_CLK/2) UART_CLK=~UART_CLK;
		end
	end

	initial begin
		TX_CLK_TB=0;
		forever begin
			#(TX_CLK_PERIOD/2) TX_CLK_TB=~TX_CLK_TB;
		end
	end

	initial begin
		REF_CLK=0;
		forever begin
			#(clk_period_REF_CLK/2) REF_CLK=~REF_CLK;
		end
	end

	//#########################################################################################################################

	uart_if uartif(UART_CLK,TX_CLK_TB);
	SYNC_if SYNCif(REF_CLK,TX_CLK_TB);
	reg_file_if reg_fileif(REF_CLK);
	FIFO_if FIFOif(TX_CLK_TB);
	TX_if  TXif(TX_CLK_TB);
	sys_if sysif(UART_CLK,REF_CLK,TX_CLK_TB);


	//###########################################################################################################################



	SYS_TOP sys(sysif.REF_CLK,sysif.RST,sysif.UART_CLK,sysif.RX_IN,sysif.par_err_reg ,sysif.stp_error_reg,sysif.TX_OUT);

	//############################################ here we bind assertions ##################################################

	`ifdef  UART_RX_assertion
		bind sys.RX UART_RX_SVA asser1 (clk,rst,RX_IN,prescale,PAR_EN,PAR_TYP,data_valid_reg,par_err_reg,stp_error_reg,P_DATA_reg,edge_cnt_flag,bit_cnt); 
	`endif

	`ifdef  DATA_SYNC_sva
		bind sys.DATA_SYNC DATA_SYNC_sva asser2 (unsync_bus,bus_enable,clk,rst,sync_bus,enable_pulse);
	`endif



	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//##########################################################################################################################
	//########################################## HERE WE MAKE INTERNAL INTERFACES CONNECTIONS ##################################
	assign uartif.RX_IN=sysif.RX_IN;
	assign uartif.rst=sys.SYNC_RST_UART;
	assign uartif.prescale=sys.prescale;
	assign uartif.par_err_reg=sys.par_err_reg;
	assign uartif.stp_error_reg=sys.stp_error_reg;
	assign uartif.PAR_EN=sys.REG2[0];
	assign uartif.PAR_TYP=sys.REG2[1];
	assign uartif.data_valid_reg=sys.data_valid_reg_RX;
	assign uartif.P_DATA_reg=sys.P_DATA_reg_RX;
	//________________________________________________________________________________________________________________________
	
	assign SYNCif.rst=sys.SYNC_RST_sys;
	assign SYNCif.unsync_bus=sys.P_DATA_reg_RX;
	assign SYNCif.bus_enable=sys.data_valid_reg_RX;
	assign SYNCif.sync_bus=sys.RX_P_Data;
	assign SYNCif.enable_pulse=sys.RX_D_VLD;
	//_______________________________________________________________________________________________________________________

	assign FIFOif.w_data=sys.TX_P_Data;
	assign FIFOif.winc=sys.TX_D_VLD;
	assign FIFOif.w_clk=sys.REF_CLK;
	assign FIFOif.wrst_n=sys.SYNC_RST_sys;
	assign FIFOif.wfull=sys.wfull;
	assign FIFOif.r_data=sys.r_data;
	assign FIFOif.rinc=sys.rinc;
	assign FIFOif.rempty=sys.rempty;
	assign FIFOif.r_clk=sys.TX_CLK;
	assign FIFOif.rrst_n=sys.SYNC_RST_UART;

	//________________________________________________________________________________________________________________________

	assign reg_fileif.RST=sys.SYNC_RST_sys;
	assign reg_fileif.WrEn=sys.Wr_En;
	assign reg_fileif.RdEn=sys.Rd_En;
	assign reg_fileif.Address=sys.Address;
	assign reg_fileif.WrData=sys.Wr_Data;
	assign reg_fileif.RdData=sys.RdData;
	assign reg_fileif.RdData_VLD=sys.RdData_Valid;
	assign reg_fileif.REG0=sys.REG0;
	assign reg_fileif.REG1=sys.REG1;
	assign reg_fileif.REG2=sys.REG2;
	assign reg_fileif.REG3=sys.REG3;
	//__________________________________________________________________________________________________________________________

	assign TXif.P_DATA=sys.r_data;
	assign TXif.Data_Valid=sys.TX.Data_Valid;
	assign TXif.PAR_TYP=sys.REG2[1];
	assign TXif.PAR_EN=sys.REG2[0];
	assign TXif.TX_OUT=sys.TX_OUT;
	assign TXif.busy=sys.busy;
	assign TXif.clk=sys.TX_CLK;
	assign TXif.rst=sys.SYNC_RST_UART;
	assign TXif.Ser_Done=sys.TX.Ser_Done;
	assign TXif.Ser_En=sys.TX.Ser_En;
	assign TXif.Ser_Data=sys.TX.Ser_Data;
	assign TXif.Par_bit=sys.TX.Par_bit;
	assign TXif.Mux_sel=sys.TX.Mux_sel;

	assign sysif.busy=sys.busy;

	//_________________________________________________________________________________________________________________________


	

	//########################################################################################################################
	initial begin
		uvm_config_db#(virtual uart_if)::set(null, "uvm_test_top", "uartif",uartif);
		uvm_config_db#(virtual SYNC_if)::set(null, "uvm_test_top", "SYNCif",SYNCif);
		uvm_config_db#(virtual reg_file_if)::set(null, "uvm_test_top", "reg_fileif",reg_fileif);
		uvm_config_db#(virtual FIFO_if)::set(null, "uvm_test_top", "FIFOif",FIFOif);
		uvm_config_db#(virtual TX_if)::set(null, "uvm_test_top", "TXif",TXif);
		uvm_config_db#(virtual sys_if)::set(null, "uvm_test_top", "sysif",sysif);
		run_test("uvm_test_top");
	end

endmodule