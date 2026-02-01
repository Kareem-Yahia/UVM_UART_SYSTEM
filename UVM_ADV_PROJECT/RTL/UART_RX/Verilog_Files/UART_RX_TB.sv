`timescale 1ns/10ps
import pack1::*;

module UART_RX_TB ();

	typedef enum {IDLE,START,DATA,PARITY,STOP} e_states; 
	
	parameter clk_period_TX=8680.55 ;//ns
	parameter clk_period_4=2170.13;
	parameter clk_period_8=1085.07;
	parameter clk_period_16=542.53;
	parameter clk_period_32=271.26;


	logic clk_tx,clk_4,clk_8,clk_16,clk_32,clk,rst;
	logic RX_IN;
	logic [5:0] prescale;
	logic PAR_EN,PAR_TYP;
	logic data_valid_reg;
	logic [7:0] P_DATA_reg;
	logic par_err_reg,stp_err_reg;
	transaction t;

	int error_count=0;
	int correct_count=0;


	e_states cs;
	assign cs=e_states'(u1.fsm.cs);

	initial begin
		clk_tx=0;
		forever
		#(clk_period_TX/2) clk_tx=~clk_tx; 
	end

	initial begin
		clk_4=0;
		forever
			#(clk_period_4/2) clk_4=~clk_4; 
	end

	initial begin
		clk_8=0;
		forever
			#(clk_period_8/2) clk_8=~clk_8; 
	end

	initial begin
		clk_16=0;
		forever
			#(clk_period_16/2) clk_16=~clk_16; 
	end

	initial begin
		clk_32=0;
		forever
			#(clk_period_32/2) clk_32=~clk_32; 
	end

	UART_RX u1(clk,rst,RX_IN,prescale,PAR_EN,PAR_TYP,data_valid_reg,par_err_reg,stp_err_reg,P_DATA_reg);

	task check_result(input [7:0] check_frame);
		if(P_DATA_reg!=check_frame) begin
			$display("ERROR:Time=%0t P_DATA_reg=%8b but---> Expected=%8b",$time,P_DATA_reg,check_frame);
			error_count++;
		end
		else begin
			$display("correct_count:Time=%0t P_DATA_reg=%8b but---> Expected=%8b",$time,P_DATA_reg,check_frame);
			correct_count++;
		end
	endtask

	task assert_reset();
		rst=0;
		RX_IN=1;
		@(negedge clk_tx);
		rst=1;
	endtask

	task send_specific_frame (input [5:0] prescale_chosen,input parity_enable,input parity_type,input start,input [7:0] frame_t,input parity,input stop); // task used to send wrong frames
		 PAR_TYP=parity_type;
		 PAR_EN=parity_enable;
		 prescale=prescale_chosen;
		 ///////////////////////////////////////////////
		 RX_IN=start;
		  @(negedge clk_tx);

		for (int i = 0; i < 8; i++) begin
			 RX_IN=frame_t[i];
			  @(negedge clk_tx);
		end	 
			 
		//RX_IN=^frame_t;
		if(parity_enable) begin
			RX_IN=parity;
			 @(negedge clk_tx);
		end	

		RX_IN=stop;
			@(negedge clk_tx);
	endtask

	task apply_vector (input [5:0] prescale_t);
		int stop;
		assert(t.randomize());
		PAR_EN=t.PAR_EN;
		prescale=prescale_t;
			if(PAR_EN)
				stop=11;
			else
				stop=10;

		PAR_TYP=t.PAR_TYP;
		for (int i = 0; i < stop; i++) begin
			RX_IN=t.frame[i];
			 @(negedge clk_tx);
		end
	endtask

	logic [1:0]clk_sel;
	always @(*) begin
		case(clk_sel)
			2'd0:clk=clk_4;
			2'd1:clk=clk_8;
			2'd2:clk=clk_16;
			2'd3:clk=clk_32;
		default:clk=0;
		endcase	
	end

	initial begin
		clk_sel=0;
		t=new();
		RX_IN=1; prescale=8; PAR_EN=1;PAR_TYP=0; // initialization
		assert_reset();
		///////////////////////////// pre_scale 4 ////////////////////////////////////
		repeat(5) begin
			apply_vector(4);
			check_result(t.frame[8:1]); //consequtive frames
		end

		repeat(5) begin
			apply_vector(4);
			check_result(t.frame[8:1]);
			repeat(2) @(negedge clk_tx); // not consequtive frames
		end

		/////////////////////////////////////////////////////////////////////////////////

		repeat(5) @(negedge clk_tx); // here we test if there is a delay when change pre_scale

		////////////////////////////// pre_scale 8 ////////////////////////////////
		clk_sel=1;

		repeat(5) begin
			apply_vector(8);
			check_result(t.frame[8:1]); //consequtive frames
		end 

		repeat(5) begin
			apply_vector(8);
			check_result(t.frame[8:1]);
			repeat(2) @(negedge clk_tx); // not consequtive frames
		end 

		///////////////////////////////////////////////////////////////////////////////////
		// here we test consecutive frames with different pre_scale

		/////////////////////////////////////////////pre_scale_16 //////////////////////
		clk_sel=2;
		repeat(5) begin
			apply_vector(16);
			check_result(t.frame[8:1]);
		end

		repeat(5) begin
			apply_vector(16);
			check_result(t.frame[8:1]);
			repeat(2) @(negedge clk_tx); // not consequtive frames
		end

		////////////////////////////////////////////////////////////////////////////
		repeat(3) @(negedge clk_tx);

		////////////////////////////////////pre_scale_32///////////////////////////
		clk_sel=3;

		repeat(5) begin
			apply_vector(32);
			check_result(t.frame[8:1]);
		end 

		repeat(5) begin
			apply_vector(32);
			check_result(t.frame[8:1]);
			repeat(4) @(negedge clk_tx); // not consequtive frames
		end 

		/////////////////////////////////////////////////////////////////////////////////////

		////////////////// here we will test when errors occur in frame ///////////////////////////////
		//send_specific_frame(prescale_chosen,parity_enable,parity_type,start,frame_t,parity,stop);
				clk_sel=1; //must change clk_here

		send_specific_frame(8,0,0,0,'h7,0,0); //here we made stop error
					$display("here we frame with stop error");
					check_result('h7);
					error_count--;
		////////////////////////////////////////////////////////////////////////			

		send_specific_frame(8,1,1,0,'h7,1,0); //here we made error in parity (odd)
							$display("here we frame with parity error (odd)");
					check_result('h7);
					error_count--;
		////////////////////////////////////////////////////////////////////////
		send_specific_frame(8,1,0,0,'h7,0,0); //here we made error in parity (even)
							$display("here we frame with parity error (even)");
					check_result('h7);
					error_count--;
		///////////////////////////////////////////////////////////////////////////////			


		//////////////////////////////////////////////////////////////////////////////////////////////
	 	$display("Finish:Time=%0t error_count=%d correct_count=%d",$time,error_count,correct_count);
		$stop;
	end


endmodule