package global_pkg ;
		localparam EVEN=0;
		localparam ODD=1;
		localparam PAR_ENABLE=1;
		localparam PAR_DISABLE=0;
		localparam PRESCALE_X8 = 8;
		localparam PRESCALE_X16 = 16;
		localparam PRESCALE_X32 = 32;
		localparam  WIDTH = 8;
		localparam  DEPTH = 16

		typedef enum logic [7:0] {WR_CMD = 8'hAA , RD_CMD = 8'hBB , ALU_WITH_OP = 8'hCC , ALU_WITHOUT_OP = 8'hDD } cmd_e;

endpackage 