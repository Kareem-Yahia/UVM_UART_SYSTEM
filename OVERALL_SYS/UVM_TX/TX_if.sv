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

   clocking cb_TX_CLK_TB @(posedge TX_CLK_TB);
      default input #1step output #1step;

      input  PAR_TYP ,PAR_EN ,TX_OUT , busy ;

      inout   P_DATA ,Data_Valid , rst ;


    endclocking 

    // There is phase shift between actual internal clock --- TB Clock that Model Master

     clocking cb_TX_CLK @(posedge clk);
      default input #1step output #1step;

      input  PAR_TYP ,PAR_EN ,TX_OUT , busy , Par_bit ;

      inout   P_DATA ,Data_Valid , rst ;


    endclocking 

endinterface