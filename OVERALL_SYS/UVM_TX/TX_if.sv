interface TX_if (TX_CLK_TB);
  
  
   input TX_CLK_TB;
   logic [7:0] P_DATA;
   logic Data_Valid;
   logic clk,rst;

   //output
   logic PAR_TYP,PAR_EN;
   logic  TX_OUT,busy;
   //internal signals
   logic Ser_Done,Ser_En,Ser_Data,Par_bit;
   logic [2:0] Mux_sel;

endinterface