module ClkDiv(i_ref_clk,i_rst_n,i_clk_en,i_div_ratio,o_div_clk);
	
	parameter Range_for_division=1024;

	input i_ref_clk;
	input i_rst_n;
	input i_clk_en;
	input [Range_for_division-1:0] i_div_ratio;

	output  o_div_clk;

	reg o_div_clk_internal;

	reg [(Range_for_division/2):0] counter;
	wire [(Range_for_division/2):0]  even_edge_toggle;
	wire [(Range_for_division/2):0]  odd_edge_toggle;
	wire divider_en;
	reg toggle_flag_odd;
	wire is_odd;

	always @(posedge i_ref_clk or negedge i_rst_n) begin
		if(!i_rst_n) begin
			counter<=0;
			o_div_clk_internal<=0;
			toggle_flag_odd<=0;
		end
		else begin
			if(divider_en) begin
				if(counter== even_edge_toggle && !is_odd) begin //here for even
					o_div_clk_internal<=~o_div_clk_internal;
					counter<=0;
				end
				else if ( (is_odd && counter== even_edge_toggle && !toggle_flag_odd) ||  (is_odd && counter== odd_edge_toggle && toggle_flag_odd)  ) begin
					o_div_clk_internal<=~o_div_clk_internal;
					counter<=0;
					toggle_flag_odd<=~toggle_flag_odd;
				end
				else
					counter<=counter+1;
			end
		end
	end

	//************************************************ FLAGS ***********************////////////////

	assign is_odd=i_div_ratio[0];
	assign even_edge_toggle= (i_div_ratio>>1)-1;
	assign odd_edge_toggle = (i_div_ratio>>1);
	assign divider_en=(i_clk_en && i_div_ratio!=0 && i_div_ratio !=1 );
	assign o_div_clk=(divider_en)?o_div_clk_internal:i_ref_clk;
	

endmodule