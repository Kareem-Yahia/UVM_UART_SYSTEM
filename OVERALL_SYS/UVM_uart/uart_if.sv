interface uart_if (UART_CLK,TX_CLK_TB);
  
  input UART_CLK;
  input TX_CLK_TB;
  
   // Inputs
   logic  rst;
   logic  RX_IN;
   logic  [5:0] prescale;
   logic  PAR_EN,PAR_TYP;

   // Outputs
   logic  data_valid_reg;
   logic  [7:0] P_DATA_reg;
   logic  par_err_reg,stp_error_reg;

    clocking cb_TX_CLK_TB @(posedge TX_CLK_TB);
      default input #1step output #1step;

      input  data_valid_reg ,P_DATA_reg ,par_err_reg , stp_error_reg ;

      inout   rst ,RX_IN , prescale , PAR_EN , PAR_TYP ;


    endclocking 


    clocking cb_UART_CLK @(posedge UART_CLK);
      default input #1step output #1step;

      input  data_valid_reg ,P_DATA_reg ,par_err_reg , stp_error_reg ;

      inout   rst ,RX_IN , prescale , PAR_EN , PAR_TYP ;


    endclocking 

endinterface