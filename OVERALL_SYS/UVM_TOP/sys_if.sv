interface sys_if (UART_CLK,REF_CLK,TX_CLK_TB);
  
  input TX_CLK_TB;
  input UART_CLK;
  input REF_CLK;
  
   logic RST ,RX_IN;
   logic busy;
   
   //output

  logic TX_OUT;
  logic par_err_reg,stp_error_reg;

  clocking cb @(posedge TX_CLK_TB);
      default input #1step output #1step;

      input   TX_OUT, par_err_reg, stp_error_reg;

      inout   RST, RX_IN ;


    endclocking 

endinterface