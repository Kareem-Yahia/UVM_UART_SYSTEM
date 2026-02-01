module parity_check (parity_chk_en,PAR_TYP,sampled_bit,P_DATA,par_err);
	input parity_chk_en;
	input PAR_TYP;
	input [7:0] P_DATA;
	input sampled_bit;
	output reg par_err;

	always @(*) begin
		if(parity_chk_en) begin
			if(!PAR_TYP) begin //even parity
				if( (^P_DATA) !=  sampled_bit)
					par_err=1;
				else
					par_err=0;	
			end
			else begin
				if( (~(^P_DATA)) !=  sampled_bit) // odd parity
					par_err=1;
				else
					par_err=0;	
			end
		end
		else
			par_err=0;
	end
endmodule