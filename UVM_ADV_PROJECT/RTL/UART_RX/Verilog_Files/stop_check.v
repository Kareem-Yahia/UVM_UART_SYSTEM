module stop_check (stp_chk_en,stp_err,sampled_bit);
	
	input stp_chk_en;
	input sampled_bit;
	output reg stp_err;

	always @(*)begin
		if(stp_chk_en)
			if(sampled_bit!=1)
				stp_err=1;
			else
				stp_err=0;	
		else
			stp_err=0;

	end

endmodule