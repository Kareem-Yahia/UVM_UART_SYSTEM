interface uart_if ();
  input UART_CLK;
  input TX_CLK_TB;
  
   logic  rst;
   logic  RX_IN;
   logic  [5:0] prescale;
   logic  PAR_EN,PAR_TYP;
   logic  data_valid_reg;
   logic  [7:0] P_DATA_reg;
   logic  par_err_reg,stp_error_reg;

endinterface