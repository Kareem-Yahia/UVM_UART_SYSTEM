package pack1;
	class transaction;
		rand logic [5:0] prescale;
		rand logic PAR_EN;
		rand logic PAR_TYP;
		rand logic [10:0] frame ;

		constraint constr1 {
			frame[0]==0;//for start bit
			if(PAR_EN) //here for stop_bit
				frame[10]==1;
			else
				frame[9]==1;
		}

		constraint parity {
			if(PAR_EN) {
				if(!PAR_TYP) {
					frame[9]==(^frame[8:1]);
				} else {
					frame[9]==(~(^frame[8:1]));
				}
			} 

		}

		constraint cons_prescale {prescale dist{8:=50,16:=50};}
		constraint cons_parity {PAR_EN dist{1:=60,0:=40};}


		function new();

		endfunction
	endclass
endpackage