module strt_check (strt_chk_en,strt_glitch,sampled_bit);
	
	input strt_chk_en;
	input sampled_bit;
	output reg  strt_glitch;

	always @(*)begin
		if(strt_chk_en)
			if(sampled_bit!=0)
				strt_glitch=1;
			else
				strt_glitch=0;	
		else
			strt_glitch=0;

	end

endmodule