interface sys_if (UART_CLK,REF_CLK,TX_CLK_TB);
  
  input TX_CLK_TB;
  input UART_CLK;
  input REF_CLK;
  
   logic REF_CLK,RST,UART_CLK,RX_IN;
   logic busy;
   
   //output

  logic TX_OUT;
  logic par_err_reg,stp_error_reg;

endinterface