/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Sat Aug 17 23:23:22 2024
/////////////////////////////////////////////////////////////


module FSM ( clk, rst, system_outputs_flag, edge_cnt_flag, RX_IN, PAR_EN, 
        bit_cnt, par_err, strt_glitch, stp_error, enable, dat_sample_en, 
        deser_en, data_valid, par_chk_en, strt_chk_en, stp_chk_en, new_op_flag
 );
  input [3:0] bit_cnt;
  input clk, rst, system_outputs_flag, edge_cnt_flag, RX_IN, PAR_EN, par_err,
         strt_glitch, stp_error;
  output enable, dat_sample_en, deser_en, data_valid, par_chk_en, strt_chk_en,
         stp_chk_en, new_op_flag;
  wire   enable, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n1, n2, n3, n5, n6, n7, n8;
  wire   [2:0] cs;
  wire   [2:0] ns;
  assign dat_sample_en = enable;

  DFFRQX2M \cs_reg[1]  ( .D(ns[1]), .CK(clk), .RN(rst), .Q(cs[1]) );
  DFFRQX2M \cs_reg[2]  ( .D(ns[2]), .CK(clk), .RN(rst), .Q(cs[2]) );
  DFFRX1M \cs_reg[0]  ( .D(ns[0]), .CK(clk), .RN(rst), .Q(cs[0]), .QN(n6) );
  NOR3X2M U3 ( .A(cs[1]), .B(cs[2]), .C(n6), .Y(new_op_flag) );
  NOR2BX2M U4 ( .AN(stp_chk_en), .B(stp_error), .Y(data_valid) );
  INVXLM U5 ( .A(edge_cnt_flag), .Y(n3) );
  OAI221X1M U6 ( .A0(n11), .A1(n7), .B0(strt_glitch), .B1(n9), .C0(n16), .Y(
        ns[1]) );
  INVX2M U7 ( .A(n9), .Y(strt_chk_en) );
  NAND2XLM U8 ( .A(edge_cnt_flag), .B(new_op_flag), .Y(n9) );
  NOR2X2M U9 ( .A(n3), .B(n7), .Y(deser_en) );
  OAI2BB1X2M U10 ( .A0N(n11), .A1N(n12), .B0(n13), .Y(ns[2]) );
  AOI33XLM U11 ( .A0(n14), .A1(n3), .A2(n5), .B0(edge_cnt_flag), .B1(n15), 
        .B2(n10), .Y(n13) );
  NAND2X2M U12 ( .A(stp_error), .B(system_outputs_flag), .Y(n14) );
  NAND2X2M U13 ( .A(par_err), .B(system_outputs_flag), .Y(n15) );
  AND2X1M U14 ( .A(system_outputs_flag), .B(n5), .Y(stp_chk_en) );
  INVX2M U15 ( .A(n12), .Y(n7) );
  INVX2M U16 ( .A(n21), .Y(n5) );
  NAND2X2M U17 ( .A(n18), .B(n16), .Y(ns[0]) );
  AOI32X1M U18 ( .A0(n6), .A1(n8), .A2(n20), .B0(new_op_flag), .B1(n3), .Y(n18) );
  OAI32X1M U19 ( .A0(n3), .A1(RX_IN), .A2(n1), .B0(cs[2]), .B1(RX_IN), .Y(n20)
         );
  INVX2M U20 ( .A(n14), .Y(n1) );
  NAND3XLM U21 ( .A(bit_cnt[3]), .B(edge_cnt_flag), .C(n19), .Y(n17) );
  NOR3X2M U22 ( .A(bit_cnt[0]), .B(bit_cnt[2]), .C(bit_cnt[1]), .Y(n19) );
  AOI33X2M U23 ( .A0(n10), .A1(n3), .A2(n15), .B0(PAR_EN), .B1(n2), .B2(n12), 
        .Y(n16) );
  INVX2M U24 ( .A(n17), .Y(n2) );
  NOR2X2M U25 ( .A(n17), .B(PAR_EN), .Y(n11) );
  AND2X1M U26 ( .A(system_outputs_flag), .B(n10), .Y(par_chk_en) );
  NOR3X2M U27 ( .A(cs[0]), .B(cs[2]), .C(n8), .Y(n12) );
  NOR3X2M U28 ( .A(n6), .B(cs[2]), .C(n8), .Y(n10) );
  NAND3X2M U29 ( .A(n6), .B(n8), .C(cs[2]), .Y(n21) );
  NAND2X2M U30 ( .A(n21), .B(n22), .Y(enable) );
  OAI21BX1M U31 ( .A0(cs[0]), .A1(cs[1]), .B0N(cs[2]), .Y(n22) );
  INVX2M U32 ( .A(cs[1]), .Y(n8) );
endmodule


module edge_bit_counter ( clk, rst, PAR_EN, enable, prescale, edge_cnt, 
        bit_cnt, edge_cnt_flag, system_outputs_flag );
  input [5:0] prescale;
  output [4:0] edge_cnt;
  output [3:0] bit_cnt;
  input clk, rst, PAR_EN, enable;
  output edge_cnt_flag, system_outputs_flag;
  wire   N10, N11, N12, N13, N14, N21, N22, N23, N24, N25, bit_cnt_flag, N48,
         N51, N52, N53, N54, N55, N56, N57, N58, N59, N60, N61, N62, n7, n13,
         n14, n15, n16, n17, n18, n21, n22, n23, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, \sub_85/carry[5] , \sub_85/carry[4] ,
         \sub_85/carry[3] , \add_24/carry[4] , \add_24/carry[3] ,
         \add_24/carry[2] , n1, n2, n3, n4, n5, n6, n8, n9, n10, n11, n12, n19,
         n20, n24, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46,
         n47, n48, n49, n50;
  wire   [5:0] prescale_sampled;

  DFFRQX2M \bit_cnt_reg[3]  ( .D(n34), .CK(clk), .RN(rst), .Q(bit_cnt[3]) );
  DFFRQX2M \bit_cnt_reg[2]  ( .D(n31), .CK(clk), .RN(rst), .Q(bit_cnt[2]) );
  DFFRQX2M \bit_cnt_reg[1]  ( .D(n32), .CK(clk), .RN(rst), .Q(bit_cnt[1]) );
  DFFRQX2M \bit_cnt_reg[0]  ( .D(n33), .CK(clk), .RN(rst), .Q(bit_cnt[0]) );
  DFFRQX2M \edge_cnt_reg[4]  ( .D(N25), .CK(clk), .RN(rst), .Q(edge_cnt[4]) );
  DFFRQX2M \prescale_sampled_reg[5]  ( .D(n30), .CK(clk), .RN(rst), .Q(
        prescale_sampled[5]) );
  DFFRQX2M \prescale_sampled_reg[4]  ( .D(n29), .CK(clk), .RN(rst), .Q(
        prescale_sampled[4]) );
  DFFRQX2M \edge_cnt_reg[0]  ( .D(N21), .CK(clk), .RN(rst), .Q(edge_cnt[0]) );
  DFFRQX2M \edge_cnt_reg[3]  ( .D(N24), .CK(clk), .RN(rst), .Q(edge_cnt[3]) );
  DFFRQX2M \edge_cnt_reg[2]  ( .D(N23), .CK(clk), .RN(rst), .Q(edge_cnt[2]) );
  DFFRQX2M \edge_cnt_reg[1]  ( .D(N22), .CK(clk), .RN(rst), .Q(edge_cnt[1]) );
  DFFRQX2M \prescale_sampled_reg[2]  ( .D(n27), .CK(clk), .RN(rst), .Q(
        prescale_sampled[2]) );
  DFFRQX2M \prescale_sampled_reg[3]  ( .D(n28), .CK(clk), .RN(rst), .Q(
        prescale_sampled[3]) );
  DFFRQX2M \prescale_sampled_reg[0]  ( .D(n25), .CK(clk), .RN(rst), .Q(N57) );
  DFFRQX2M \prescale_sampled_reg[1]  ( .D(n26), .CK(clk), .RN(rst), .Q(
        prescale_sampled[1]) );
  DFFRX1M bit_cnt_flag_reg ( .D(N48), .CK(clk), .RN(rst), .Q(bit_cnt_flag), 
        .QN(n43) );
  NOR2X2M U3 ( .A(prescale_sampled[5]), .B(\sub_85/carry[5] ), .Y(n1) );
  INVX2M U4 ( .A(n7), .Y(n44) );
  NOR2X2M U5 ( .A(n49), .B(edge_cnt_flag), .Y(n18) );
  NAND3X2M U6 ( .A(edge_cnt_flag), .B(n43), .C(enable), .Y(n13) );
  AOI31X2M U7 ( .A0(enable), .A1(n43), .A2(n14), .B0(n18), .Y(n15) );
  AND2X2M U8 ( .A(N13), .B(n18), .Y(N24) );
  AND2X2M U9 ( .A(N12), .B(n18), .Y(N23) );
  AND2X2M U10 ( .A(N11), .B(n18), .Y(N22) );
  NAND4X2M U11 ( .A(n46), .B(n47), .C(n48), .D(n45), .Y(n7) );
  INVX2M U12 ( .A(enable), .Y(n49) );
  OAI32X1M U13 ( .A0(n49), .A1(bit_cnt_flag), .A2(n21), .B0(n15), .B1(n45), 
        .Y(n34) );
  AOI32XLM U14 ( .A0(edge_cnt_flag), .A1(n45), .A2(n22), .B0(bit_cnt[3]), .B1(
        n48), .Y(n21) );
  NOR2X2M U15 ( .A(n14), .B(n48), .Y(n22) );
  OAI32X1M U16 ( .A0(n13), .A1(bit_cnt[2]), .A2(n14), .B0(n15), .B1(n48), .Y(
        n31) );
  OAI31X1M U17 ( .A0(n13), .A1(bit_cnt[1]), .A2(n46), .B0(n16), .Y(n32) );
  OAI21X2M U18 ( .A0(n17), .A1(n18), .B0(bit_cnt[1]), .Y(n16) );
  NOR2X2M U19 ( .A(n13), .B(bit_cnt[0]), .Y(n17) );
  AO21XLM U20 ( .A0(bit_cnt[0]), .A1(n18), .B0(n17), .Y(n33) );
  INVX2M U21 ( .A(N57), .Y(N51) );
  INVX2M U22 ( .A(prescale_sampled[3]), .Y(n6) );
  AND2X2M U23 ( .A(N14), .B(n18), .Y(N25) );
  AND2X2M U24 ( .A(N10), .B(n18), .Y(N21) );
  INVX2M U25 ( .A(edge_cnt[0]), .Y(N10) );
  INVX2M U26 ( .A(prescale_sampled[1]), .Y(N58) );
  NOR3X2M U27 ( .A(n45), .B(bit_cnt[2]), .C(n23), .Y(N48) );
  AOI33X2M U28 ( .A0(n50), .A1(n47), .A2(bit_cnt[0]), .B0(bit_cnt[1]), .B1(n46), .B2(PAR_EN), .Y(n23) );
  INVX2M U29 ( .A(PAR_EN), .Y(n50) );
  NAND2X2M U30 ( .A(bit_cnt[1]), .B(bit_cnt[0]), .Y(n14) );
  INVX2M U31 ( .A(bit_cnt[2]), .Y(n48) );
  INVX2M U32 ( .A(bit_cnt[0]), .Y(n46) );
  INVX2M U33 ( .A(bit_cnt[3]), .Y(n45) );
  INVX2M U34 ( .A(bit_cnt[1]), .Y(n47) );
  ADDHX1M U35 ( .A(edge_cnt[1]), .B(edge_cnt[0]), .CO(\add_24/carry[2] ), .S(
        N11) );
  ADDHX1M U36 ( .A(edge_cnt[2]), .B(\add_24/carry[2] ), .CO(\add_24/carry[3] ), 
        .S(N12) );
  AO22X1M U37 ( .A0(N57), .A1(n7), .B0(prescale[0]), .B1(n44), .Y(n25) );
  AO22X1M U38 ( .A0(prescale_sampled[1]), .A1(n7), .B0(prescale[1]), .B1(n44), 
        .Y(n26) );
  AO22X1M U39 ( .A0(prescale_sampled[2]), .A1(n7), .B0(prescale[2]), .B1(n44), 
        .Y(n27) );
  AO22X1M U40 ( .A0(prescale_sampled[3]), .A1(n7), .B0(prescale[3]), .B1(n44), 
        .Y(n28) );
  AO22X1M U41 ( .A0(prescale_sampled[4]), .A1(n7), .B0(prescale[4]), .B1(n44), 
        .Y(n29) );
  AO22X1M U42 ( .A0(prescale_sampled[5]), .A1(n7), .B0(prescale[5]), .B1(n44), 
        .Y(n30) );
  ADDHX1M U43 ( .A(edge_cnt[3]), .B(\add_24/carry[3] ), .CO(\add_24/carry[4] ), 
        .S(N13) );
  XNOR2X1M U44 ( .A(\sub_85/carry[5] ), .B(prescale_sampled[5]), .Y(N62) );
  OR2X1M U45 ( .A(prescale_sampled[4]), .B(\sub_85/carry[4] ), .Y(
        \sub_85/carry[5] ) );
  XNOR2X1M U46 ( .A(\sub_85/carry[4] ), .B(prescale_sampled[4]), .Y(N61) );
  OR2X1M U47 ( .A(prescale_sampled[3]), .B(\sub_85/carry[3] ), .Y(
        \sub_85/carry[4] ) );
  XNOR2X1M U48 ( .A(\sub_85/carry[3] ), .B(prescale_sampled[3]), .Y(N60) );
  OR2X1M U49 ( .A(prescale_sampled[2]), .B(prescale_sampled[1]), .Y(
        \sub_85/carry[3] ) );
  XNOR2X1M U50 ( .A(prescale_sampled[1]), .B(prescale_sampled[2]), .Y(N59) );
  CLKXOR2X2M U51 ( .A(\add_24/carry[4] ), .B(edge_cnt[4]), .Y(N14) );
  NAND2BX1M U52 ( .AN(prescale_sampled[1]), .B(N51), .Y(n2) );
  OAI2BB1X1M U53 ( .A0N(N57), .A1N(prescale_sampled[1]), .B0(n2), .Y(N52) );
  NOR2X1M U54 ( .A(n2), .B(prescale_sampled[2]), .Y(n3) );
  AO21XLM U55 ( .A0(n2), .A1(prescale_sampled[2]), .B0(n3), .Y(N53) );
  CLKNAND2X2M U56 ( .A(n3), .B(n6), .Y(n4) );
  OAI21X1M U57 ( .A0(n3), .A1(n6), .B0(n4), .Y(N54) );
  XNOR2X1M U58 ( .A(prescale_sampled[4]), .B(n4), .Y(N55) );
  NOR2X1M U59 ( .A(prescale_sampled[4]), .B(n4), .Y(n5) );
  CLKXOR2X2M U60 ( .A(prescale_sampled[5]), .B(n5), .Y(N56) );
  NOR2BX1M U61 ( .AN(N51), .B(edge_cnt[0]), .Y(n8) );
  OAI2B2X1M U62 ( .A1N(edge_cnt[1]), .A0(n8), .B0(N52), .B1(n8), .Y(n11) );
  NOR2BX1M U63 ( .AN(edge_cnt[0]), .B(N51), .Y(n9) );
  OAI2B2X1M U64 ( .A1N(N52), .A0(n9), .B0(edge_cnt[1]), .B1(n9), .Y(n10) );
  NAND3BX1M U65 ( .AN(N56), .B(n11), .C(n10), .Y(n24) );
  CLKXOR2X2M U66 ( .A(N55), .B(edge_cnt[4]), .Y(n20) );
  CLKXOR2X2M U67 ( .A(N53), .B(edge_cnt[2]), .Y(n19) );
  CLKXOR2X2M U68 ( .A(N54), .B(edge_cnt[3]), .Y(n12) );
  NOR4X1M U69 ( .A(n24), .B(n20), .C(n19), .D(n12), .Y(edge_cnt_flag) );
  NOR2BX1M U70 ( .AN(edge_cnt[0]), .B(N57), .Y(n35) );
  OAI2B2X1M U71 ( .A1N(N58), .A0(n35), .B0(edge_cnt[1]), .B1(n35), .Y(n38) );
  NOR2BX1M U72 ( .AN(N57), .B(edge_cnt[0]), .Y(n36) );
  OAI2B2X1M U73 ( .A1N(edge_cnt[1]), .A0(n36), .B0(N58), .B1(n36), .Y(n37) );
  NAND4BBX1M U74 ( .AN(n1), .BN(N62), .C(n38), .D(n37), .Y(n42) );
  CLKXOR2X2M U75 ( .A(N61), .B(edge_cnt[4]), .Y(n41) );
  CLKXOR2X2M U76 ( .A(N59), .B(edge_cnt[2]), .Y(n40) );
  CLKXOR2X2M U77 ( .A(N60), .B(edge_cnt[3]), .Y(n39) );
  NOR4X1M U78 ( .A(n42), .B(n41), .C(n40), .D(n39), .Y(system_outputs_flag) );
endmodule


module deserializer ( clk, rst, new_op_flag, deser_en, sampled_bit, P_DATA );
  output [7:0] P_DATA;
  input clk, rst, new_op_flag, deser_en, sampled_bit;
  wire   n1, n2, n3, n4, n5, n6, n7, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n8, n9;

  DFFRX1M \P_DATA_reg[5]  ( .D(n15), .CK(clk), .RN(rst), .Q(P_DATA[5]), .QN(n3) );
  DFFRX1M \P_DATA_reg[1]  ( .D(n19), .CK(clk), .RN(rst), .Q(P_DATA[1]), .QN(n7) );
  DFFRX1M \P_DATA_reg[4]  ( .D(n16), .CK(clk), .RN(rst), .Q(P_DATA[4]), .QN(n4) );
  DFFRQX2M \P_DATA_reg[0]  ( .D(n12), .CK(clk), .RN(rst), .Q(P_DATA[0]) );
  DFFRX1M \P_DATA_reg[7]  ( .D(n13), .CK(clk), .RN(rst), .Q(P_DATA[7]), .QN(n1) );
  DFFRX1M \P_DATA_reg[3]  ( .D(n17), .CK(clk), .RN(rst), .Q(P_DATA[3]), .QN(n5) );
  DFFRX1M \P_DATA_reg[6]  ( .D(n14), .CK(clk), .RN(rst), .Q(P_DATA[6]), .QN(n2) );
  DFFRX1M \P_DATA_reg[2]  ( .D(n18), .CK(clk), .RN(rst), .Q(P_DATA[2]), .QN(n6) );
  INVX2M U3 ( .A(n11), .Y(n8) );
  INVX2M U4 ( .A(n10), .Y(n9) );
  NAND2BX2M U5 ( .AN(new_op_flag), .B(deser_en), .Y(n10) );
  NOR2X2M U6 ( .A(new_op_flag), .B(n9), .Y(n11) );
  OAI22X1M U7 ( .A0(n7), .A1(n8), .B0(n10), .B1(n6), .Y(n19) );
  OAI22X1M U8 ( .A0(n8), .A1(n6), .B0(n10), .B1(n5), .Y(n18) );
  OAI22X1M U9 ( .A0(n8), .A1(n5), .B0(n10), .B1(n4), .Y(n17) );
  OAI22X1M U10 ( .A0(n8), .A1(n4), .B0(n10), .B1(n3), .Y(n16) );
  OAI22X1M U11 ( .A0(n8), .A1(n3), .B0(n10), .B1(n2), .Y(n15) );
  OAI22X1M U12 ( .A0(n8), .A1(n2), .B0(n10), .B1(n1), .Y(n14) );
  OAI2BB2X1M U13 ( .B0(n10), .B1(n7), .A0N(P_DATA[0]), .A1N(n11), .Y(n12) );
  OAI2BB2X1M U14 ( .B0(n8), .B1(n1), .A0N(sampled_bit), .A1N(n9), .Y(n13) );
endmodule


module data_sampling ( clk, rst, prescale, edge_cnt, dat_sample_en, RX_IN, 
        sampled_bit );
  input [5:0] prescale;
  input [4:0] edge_cnt;
  input clk, rst, dat_sample_en, RX_IN;
  output sampled_bit;
  wire   s3, s2, s1, n18, n19, n20, \add_14/carry[4] , \add_14/carry[3] ,
         \add_14/carry[2] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36;
  wire   [4:0] No2;
  wire   [4:0] No3;

  DFFRX1M s1_reg ( .D(n18), .CK(clk), .RN(rst), .Q(s1), .QN(n5) );
  DFFRX1M s2_reg ( .D(n20), .CK(clk), .RN(rst), .Q(s2), .QN(n6) );
  DFFRQX1M s3_reg ( .D(n19), .CK(clk), .RN(rst), .Q(s3) );
  CLKXOR2X2M U3 ( .A(edge_cnt[0]), .B(prescale[1]), .Y(n26) );
  CLKXOR2X2M U4 ( .A(edge_cnt[0]), .B(prescale[1]), .Y(n15) );
  ADDHX1M U5 ( .A(prescale[2]), .B(prescale[1]), .CO(\add_14/carry[2] ), .S(
        No3[1]) );
  ADDHX1M U6 ( .A(prescale[3]), .B(\add_14/carry[2] ), .CO(\add_14/carry[3] ), 
        .S(No3[2]) );
  INVX2M U7 ( .A(prescale[3]), .Y(n4) );
  ADDHX1M U8 ( .A(prescale[4]), .B(\add_14/carry[3] ), .CO(\add_14/carry[4] ), 
        .S(No3[3]) );
  NOR2X1M U9 ( .A(prescale[2]), .B(prescale[1]), .Y(n1) );
  AO21XLM U10 ( .A0(prescale[1]), .A1(prescale[2]), .B0(n1), .Y(No2[1]) );
  CLKNAND2X2M U11 ( .A(n1), .B(n4), .Y(n2) );
  OAI21X1M U12 ( .A0(n1), .A1(n4), .B0(n2), .Y(No2[2]) );
  XNOR2X1M U13 ( .A(prescale[4]), .B(n2), .Y(No2[3]) );
  NOR2X1M U14 ( .A(prescale[4]), .B(n2), .Y(n3) );
  CLKXOR2X2M U15 ( .A(prescale[5]), .B(n3), .Y(No2[4]) );
  CLKXOR2X2M U16 ( .A(\add_14/carry[4] ), .B(prescale[5]), .Y(No3[4]) );
  OAI21X1M U17 ( .A0(n5), .A1(n6), .B0(n7), .Y(sampled_bit) );
  OAI21X1M U18 ( .A0(s1), .A1(s2), .B0(s3), .Y(n7) );
  OAI22X1M U19 ( .A0(n8), .A1(n9), .B0(n10), .B1(n6), .Y(n20) );
  NOR2X1M U20 ( .A(n8), .B(n11), .Y(n10) );
  NAND4X1M U21 ( .A(n12), .B(n13), .C(n14), .D(n15), .Y(n8) );
  NOR2X1M U22 ( .A(n16), .B(n17), .Y(n14) );
  CLKXOR2X2M U23 ( .A(edge_cnt[2]), .B(No2[2]), .Y(n17) );
  CLKXOR2X2M U24 ( .A(edge_cnt[1]), .B(No2[1]), .Y(n16) );
  XNOR2X1M U25 ( .A(edge_cnt[3]), .B(No2[3]), .Y(n13) );
  XNOR2X1M U26 ( .A(edge_cnt[4]), .B(No2[4]), .Y(n12) );
  OAI2B2X1M U27 ( .A1N(s3), .A0(n21), .B0(n9), .B1(n22), .Y(n19) );
  NOR2X1M U28 ( .A(n11), .B(n22), .Y(n21) );
  NAND4X1M U29 ( .A(n23), .B(n24), .C(n25), .D(n26), .Y(n22) );
  NOR2X1M U30 ( .A(n27), .B(n28), .Y(n25) );
  CLKXOR2X2M U31 ( .A(edge_cnt[2]), .B(No3[2]), .Y(n28) );
  CLKXOR2X2M U32 ( .A(edge_cnt[1]), .B(No3[1]), .Y(n27) );
  XNOR2X1M U33 ( .A(edge_cnt[3]), .B(No3[3]), .Y(n24) );
  XNOR2X1M U34 ( .A(edge_cnt[4]), .B(No3[4]), .Y(n23) );
  OAI22X1M U35 ( .A0(n9), .A1(n29), .B0(n30), .B1(n5), .Y(n18) );
  NOR2X1M U36 ( .A(n11), .B(n29), .Y(n30) );
  CLKINVX1M U37 ( .A(dat_sample_en), .Y(n11) );
  NAND4X1M U38 ( .A(n31), .B(n32), .C(n33), .D(n34), .Y(n29) );
  XNOR2X1M U39 ( .A(edge_cnt[0]), .B(prescale[1]), .Y(n34) );
  NOR2X1M U40 ( .A(n35), .B(n36), .Y(n33) );
  CLKXOR2X2M U41 ( .A(prescale[3]), .B(edge_cnt[2]), .Y(n36) );
  CLKXOR2X2M U42 ( .A(prescale[2]), .B(edge_cnt[1]), .Y(n35) );
  XNOR2X1M U43 ( .A(edge_cnt[3]), .B(prescale[4]), .Y(n32) );
  XNOR2X1M U44 ( .A(edge_cnt[4]), .B(prescale[5]), .Y(n31) );
  CLKNAND2X2M U45 ( .A(RX_IN), .B(dat_sample_en), .Y(n9) );
endmodule


module parity_check ( parity_chk_en, PAR_TYP, sampled_bit, P_DATA, par_err );
  input [7:0] P_DATA;
  input parity_chk_en, PAR_TYP, sampled_bit;
  output par_err;
  wire   n1, n2, n3, n4, n5, n6;

  NOR2BX2M U3 ( .AN(parity_chk_en), .B(n1), .Y(par_err) );
  XOR3XLM U4 ( .A(n2), .B(n3), .C(n4), .Y(n1) );
  XOR3XLM U5 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n5), .Y(n3) );
  XNOR2X2M U6 ( .A(sampled_bit), .B(PAR_TYP), .Y(n4) );
  XNOR2X2M U7 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n5) );
  XOR3XLM U8 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n6), .Y(n2) );
  XNOR2X2M U9 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n6) );
endmodule


module strt_check ( strt_chk_en, strt_glitch, sampled_bit );
  input strt_chk_en, sampled_bit;
  output strt_glitch;


  AND2X2M U2 ( .A(strt_chk_en), .B(sampled_bit), .Y(strt_glitch) );
endmodule


module stop_check ( stp_chk_en, stp_err, sampled_bit );
  input stp_chk_en, sampled_bit;
  output stp_err;


  NOR2BX2M U2 ( .AN(stp_chk_en), .B(sampled_bit), .Y(stp_err) );
endmodule


module UART_RX ( clk, rst, RX_IN, prescale, PAR_EN, PAR_TYP, data_valid_reg, 
        par_err_reg, stp_error_reg, P_DATA_reg );
  input [5:0] prescale;
  output [7:0] P_DATA_reg;
  input clk, rst, RX_IN, PAR_EN, PAR_TYP;
  output data_valid_reg, par_err_reg, stp_error_reg;
  wire   system_outputs_flag, edge_cnt_flag, par_err, strt_glitch, stp_error,
         enable, dat_sample_en, deser_en, data_valid, par_chk_en, strt_chk_en,
         stp_chk_en, new_op_flag, sampled_bit, n2, n3, n4, n5, n6, n7, n8, n9,
         n1, n10, n11;
  wire   [3:0] bit_cnt;
  wire   [4:0] edge_cnt;
  wire   [7:0] P_DATA;

  FSM fsm ( .clk(clk), .rst(n1), .system_outputs_flag(system_outputs_flag), 
        .edge_cnt_flag(edge_cnt_flag), .RX_IN(RX_IN), .PAR_EN(PAR_EN), 
        .bit_cnt(bit_cnt), .par_err(par_err), .strt_glitch(strt_glitch), 
        .stp_error(stp_error), .enable(enable), .dat_sample_en(dat_sample_en), 
        .deser_en(deser_en), .data_valid(data_valid), .par_chk_en(par_chk_en), 
        .strt_chk_en(strt_chk_en), .stp_chk_en(stp_chk_en), .new_op_flag(
        new_op_flag) );
  edge_bit_counter edg_cnt ( .clk(clk), .rst(n1), .PAR_EN(PAR_EN), .enable(
        enable), .prescale(prescale), .edge_cnt(edge_cnt), .bit_cnt(bit_cnt), 
        .edge_cnt_flag(edge_cnt_flag), .system_outputs_flag(
        system_outputs_flag) );
  deserializer deser ( .clk(clk), .rst(n1), .new_op_flag(new_op_flag), 
        .deser_en(deser_en), .sampled_bit(sampled_bit), .P_DATA(P_DATA) );
  data_sampling ds ( .clk(clk), .rst(n1), .prescale(prescale), .edge_cnt(
        edge_cnt), .dat_sample_en(dat_sample_en), .RX_IN(RX_IN), .sampled_bit(
        sampled_bit) );
  parity_check par ( .parity_chk_en(par_chk_en), .PAR_TYP(PAR_TYP), 
        .sampled_bit(sampled_bit), .P_DATA(P_DATA), .par_err(par_err) );
  strt_check strt ( .strt_chk_en(strt_chk_en), .strt_glitch(strt_glitch), 
        .sampled_bit(sampled_bit) );
  stop_check stop ( .stp_chk_en(stp_chk_en), .stp_err(stp_error), 
        .sampled_bit(sampled_bit) );
  DFFRQX2M \P_DATA_reg_reg[7]  ( .D(n9), .CK(clk), .RN(n1), .Q(P_DATA_reg[7])
         );
  DFFRQX2M \P_DATA_reg_reg[6]  ( .D(n8), .CK(clk), .RN(n1), .Q(P_DATA_reg[6])
         );
  DFFRQX2M \P_DATA_reg_reg[5]  ( .D(n7), .CK(clk), .RN(n1), .Q(P_DATA_reg[5])
         );
  DFFRQX2M \P_DATA_reg_reg[4]  ( .D(n6), .CK(clk), .RN(n1), .Q(P_DATA_reg[4])
         );
  DFFRQX2M \P_DATA_reg_reg[3]  ( .D(n5), .CK(clk), .RN(n1), .Q(P_DATA_reg[3])
         );
  DFFRQX2M \P_DATA_reg_reg[2]  ( .D(n4), .CK(clk), .RN(n1), .Q(P_DATA_reg[2])
         );
  DFFRQX2M \P_DATA_reg_reg[1]  ( .D(n3), .CK(clk), .RN(n1), .Q(P_DATA_reg[1])
         );
  DFFRQX2M \P_DATA_reg_reg[0]  ( .D(n2), .CK(clk), .RN(n1), .Q(P_DATA_reg[0])
         );
  DFFRQX2M par_err_reg_reg ( .D(par_err), .CK(clk), .RN(n1), .Q(par_err_reg)
         );
  DFFRQX2M data_valid_reg_reg ( .D(data_valid), .CK(clk), .RN(n1), .Q(
        data_valid_reg) );
  DFFRQX2M stp_error_reg_reg ( .D(stp_error), .CK(clk), .RN(n1), .Q(
        stp_error_reg) );
  INVX2M U3 ( .A(data_valid), .Y(n11) );
  INVX4M U4 ( .A(n10), .Y(n1) );
  INVX2M U5 ( .A(rst), .Y(n10) );
  AO22X1M U6 ( .A0(P_DATA_reg[0]), .A1(n11), .B0(data_valid), .B1(P_DATA[0]), 
        .Y(n2) );
  AO22X1M U7 ( .A0(P_DATA_reg[1]), .A1(n11), .B0(P_DATA[1]), .B1(data_valid), 
        .Y(n3) );
  AO22X1M U8 ( .A0(P_DATA_reg[2]), .A1(n11), .B0(P_DATA[2]), .B1(data_valid), 
        .Y(n4) );
  AO22X1M U9 ( .A0(P_DATA_reg[3]), .A1(n11), .B0(P_DATA[3]), .B1(data_valid), 
        .Y(n5) );
  AO22X1M U10 ( .A0(P_DATA_reg[4]), .A1(n11), .B0(P_DATA[4]), .B1(data_valid), 
        .Y(n6) );
  AO22X1M U11 ( .A0(P_DATA_reg[5]), .A1(n11), .B0(P_DATA[5]), .B1(data_valid), 
        .Y(n7) );
  AO22X1M U12 ( .A0(P_DATA_reg[6]), .A1(n11), .B0(P_DATA[6]), .B1(data_valid), 
        .Y(n8) );
  AO22X1M U13 ( .A0(P_DATA_reg[7]), .A1(n11), .B0(P_DATA[7]), .B1(data_valid), 
        .Y(n9) );
endmodule


module Controller_TX ( Data_Valid, PAR_EN, Ser_Done, Mux_sel, Ser_En, busy, 
        clk, rst );
  output [2:0] Mux_sel;
  input Data_Valid, PAR_EN, Ser_Done, clk, rst;
  output Ser_En, busy;
  wire   N43, n6, n7, n8, n9, n10, n1, n2, n3, n4, n5;
  wire   [2:0] cs;
  wire   [2:0] ns;
  assign Mux_sel[2] = N43;

  DFFRQX2M \cs_reg[0]  ( .D(n1), .CK(clk), .RN(rst), .Q(cs[0]) );
  DFFRQX2M \cs_reg[1]  ( .D(ns[1]), .CK(clk), .RN(rst), .Q(cs[1]) );
  DFFRQX2M \cs_reg[2]  ( .D(ns[2]), .CK(clk), .RN(rst), .Q(cs[2]) );
  INVX2M U3 ( .A(Mux_sel[1]), .Y(n4) );
  OAI21X2M U4 ( .A0(n4), .A1(n3), .B0(n10), .Y(Mux_sel[0]) );
  NAND2X2M U5 ( .A(Mux_sel[1]), .B(n3), .Y(n7) );
  OAI21X2M U6 ( .A0(n6), .A1(n7), .B0(n8), .Y(ns[1]) );
  AOI2B1X1M U7 ( .A1N(n6), .A0(n3), .B0(n4), .Y(ns[2]) );
  NOR2X2M U8 ( .A(n5), .B(cs[2]), .Y(Mux_sel[1]) );
  OAI211X2M U9 ( .A0(cs[2]), .A1(n3), .B0(n10), .C0(n4), .Y(busy) );
  INVX2M U10 ( .A(cs[0]), .Y(n3) );
  NAND3X2M U11 ( .A(n3), .B(n5), .C(cs[2]), .Y(n10) );
  INVX2M U12 ( .A(cs[1]), .Y(n5) );
  INVX2M U13 ( .A(n9), .Y(n1) );
  AOI32X1M U14 ( .A0(n2), .A1(Ser_Done), .A2(PAR_EN), .B0(Data_Valid), .B1(N43), .Y(n9) );
  INVX2M U15 ( .A(n7), .Y(n2) );
  NOR3X2M U16 ( .A(cs[1]), .B(cs[2]), .C(cs[0]), .Y(N43) );
  NAND2X2M U17 ( .A(n8), .B(n7), .Y(Ser_En) );
  OR3X2M U18 ( .A(cs[2]), .B(cs[1]), .C(n3), .Y(n8) );
  NOR2BX2M U19 ( .AN(Ser_Done), .B(PAR_EN), .Y(n6) );
endmodule


module Serializer ( P_Data, Data_Valid, Ser_En, clk, rst, Ser_Done, Ser_Data, 
        busy );
  input [7:0] P_Data;
  input Data_Valid, Ser_En, clk, rst, busy;
  output Ser_Done, Ser_Data;
  wire   n1, n4, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n2, n3, n5, n6, n7, n8;
  wire   [7:0] LSR;
  wire   [2:0] Counter;

  DFFRQX2M \LSR_reg[7]  ( .D(n27), .CK(clk), .RN(rst), .Q(LSR[7]) );
  DFFRQX2M \LSR_reg[6]  ( .D(n28), .CK(clk), .RN(rst), .Q(LSR[6]) );
  DFFRQX2M \LSR_reg[5]  ( .D(n29), .CK(clk), .RN(rst), .Q(LSR[5]) );
  DFFRQX2M \LSR_reg[4]  ( .D(n30), .CK(clk), .RN(rst), .Q(LSR[4]) );
  DFFRQX2M \LSR_reg[3]  ( .D(n31), .CK(clk), .RN(rst), .Q(LSR[3]) );
  DFFRQX2M \LSR_reg[2]  ( .D(n32), .CK(clk), .RN(rst), .Q(LSR[2]) );
  DFFRQX2M \LSR_reg[1]  ( .D(n33), .CK(clk), .RN(rst), .Q(LSR[1]) );
  DFFRQX2M \Counter_reg[2]  ( .D(n36), .CK(clk), .RN(rst), .Q(Counter[2]) );
  DFFRX1M \LSR_reg[0]  ( .D(n34), .CK(clk), .RN(rst), .QN(n1) );
  DFFRQX2M \Counter_reg[1]  ( .D(n25), .CK(clk), .RN(rst), .Q(Counter[1]) );
  DFFRQX2M \Counter_reg[0]  ( .D(n37), .CK(clk), .RN(rst), .Q(Counter[0]) );
  DFFRX1M Ser_Done_reg ( .D(n35), .CK(clk), .RN(rst), .Q(Ser_Done), .QN(n4) );
  DFFRQX2M Ser_Data_reg ( .D(n26), .CK(clk), .RN(rst), .Q(Ser_Data) );
  INVX2M U3 ( .A(n11), .Y(n3) );
  NAND2X2M U4 ( .A(n20), .B(n11), .Y(n12) );
  NAND2X2M U5 ( .A(n7), .B(n20), .Y(n11) );
  INVX2M U6 ( .A(n20), .Y(n2) );
  NAND2BX2M U7 ( .AN(busy), .B(Data_Valid), .Y(n20) );
  AOI21X2M U8 ( .A0(n5), .A1(n7), .B0(n2), .Y(n9) );
  INVX2M U9 ( .A(n24), .Y(n7) );
  OAI32X1M U10 ( .A0(n8), .A1(Counter[2]), .A2(n10), .B0(n23), .B1(n6), .Y(n36) );
  AOI21BX2M U11 ( .A0(n7), .A1(n8), .B0N(n9), .Y(n23) );
  OAI32X1M U12 ( .A0(n24), .A1(Counter[0]), .A2(n2), .B0(n5), .B1(n20), .Y(n37) );
  OAI2B1X2M U13 ( .A1N(LSR[1]), .A0(n12), .B0(n18), .Y(n33) );
  AOI22X1M U14 ( .A0(LSR[2]), .A1(n3), .B0(P_Data[1]), .B1(n2), .Y(n18) );
  OAI2B1X2M U15 ( .A1N(LSR[2]), .A0(n12), .B0(n17), .Y(n32) );
  AOI22X1M U16 ( .A0(LSR[3]), .A1(n3), .B0(P_Data[2]), .B1(n2), .Y(n17) );
  OAI2B1X2M U17 ( .A1N(LSR[3]), .A0(n12), .B0(n16), .Y(n31) );
  AOI22X1M U18 ( .A0(LSR[4]), .A1(n3), .B0(P_Data[3]), .B1(n2), .Y(n16) );
  OAI2B1X2M U19 ( .A1N(LSR[4]), .A0(n12), .B0(n15), .Y(n30) );
  AOI22X1M U20 ( .A0(LSR[5]), .A1(n3), .B0(P_Data[4]), .B1(n2), .Y(n15) );
  OAI2B1X2M U21 ( .A1N(LSR[5]), .A0(n12), .B0(n14), .Y(n29) );
  AOI22X1M U22 ( .A0(LSR[6]), .A1(n3), .B0(P_Data[5]), .B1(n2), .Y(n14) );
  OAI2B1X2M U23 ( .A1N(LSR[6]), .A0(n12), .B0(n13), .Y(n28) );
  AOI22X1M U24 ( .A0(LSR[7]), .A1(n3), .B0(P_Data[6]), .B1(n2), .Y(n13) );
  OAI2BB2X1M U25 ( .B0(n21), .B1(n4), .A0N(n21), .A1N(n3), .Y(n35) );
  OAI32X1M U26 ( .A0(n22), .A1(n11), .A2(n6), .B0(n7), .B1(n2), .Y(n21) );
  NAND2X2M U27 ( .A(Counter[1]), .B(Counter[0]), .Y(n22) );
  OAI21X2M U28 ( .A0(n1), .A1(n12), .B0(n19), .Y(n34) );
  AOI22X1M U29 ( .A0(LSR[1]), .A1(n3), .B0(P_Data[0]), .B1(n2), .Y(n19) );
  NAND3X2M U30 ( .A(n7), .B(n20), .C(Counter[0]), .Y(n10) );
  AO2B2X2M U31 ( .B0(P_Data[7]), .B1(n2), .A0(LSR[7]), .A1N(n12), .Y(n27) );
  OAI22X1M U32 ( .A0(n9), .A1(n8), .B0(Counter[1]), .B1(n10), .Y(n25) );
  OAI2BB2X1M U33 ( .B0(n11), .B1(n1), .A0N(Ser_Data), .A1N(n11), .Y(n26) );
  NAND2X2M U34 ( .A(Ser_En), .B(n4), .Y(n24) );
  INVX2M U35 ( .A(Counter[0]), .Y(n5) );
  INVX2M U36 ( .A(Counter[1]), .Y(n8) );
  INVX2M U37 ( .A(Counter[2]), .Y(n6) );
endmodule


module Parity_Calc ( P_DATA, Data_Valid, Par_Type, Par_En, Par_bit, clk, rst, 
        busy );
  input [7:0] P_DATA;
  input Data_Valid, Par_Type, Par_En, clk, rst, busy;
  output Par_bit;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n1;

  DFFRQX2M Par_bit_reg ( .D(n9), .CK(clk), .RN(rst), .Q(Par_bit) );
  XNOR2X2M U3 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n8) );
  NOR2BX2M U4 ( .AN(Par_En), .B(n2), .Y(n9) );
  AOI22X1M U5 ( .A0(n1), .A1(n3), .B0(Par_bit), .B1(n4), .Y(n2) );
  INVX2M U6 ( .A(n4), .Y(n1) );
  NAND2BX2M U7 ( .AN(busy), .B(Data_Valid), .Y(n4) );
  XOR3XLM U8 ( .A(Par_Type), .B(n5), .C(n6), .Y(n3) );
  XOR3XLM U9 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n7), .Y(n6) );
  XOR3XLM U10 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n8), .Y(n5) );
  XNOR2X2M U11 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n7) );
endmodule


module UART_Mux ( Mux_Sel, Start_Bit, Stop_Bit, ser_data, Par_Bit, No_Trans, 
        TX_OUT );
  input [2:0] Mux_Sel;
  input Start_Bit, Stop_Bit, ser_data, Par_Bit, No_Trans;
  output TX_OUT;
  wire   n3, n4, n5, n6, n1, n2;

  INVX2M U2 ( .A(Mux_Sel[0]), .Y(n1) );
  OAI2B1X4M U3 ( .A1N(n3), .A0(Mux_Sel[2]), .B0(n4), .Y(TX_OUT) );
  NAND4X2M U4 ( .A(No_Trans), .B(Mux_Sel[2]), .C(n1), .D(n2), .Y(n4) );
  OAI22X1M U5 ( .A0(n5), .A1(n2), .B0(Mux_Sel[1]), .B1(n6), .Y(n3) );
  INVX2M U6 ( .A(Mux_Sel[1]), .Y(n2) );
  AOI22X1M U7 ( .A0(ser_data), .A1(n1), .B0(Par_Bit), .B1(Mux_Sel[0]), .Y(n5)
         );
  AOI22X1M U8 ( .A0(Start_Bit), .A1(n1), .B0(Stop_Bit), .B1(Mux_Sel[0]), .Y(n6) );
endmodule


module UART_TX ( P_DATA, Data_Valid, PAR_TYP, PAR_EN, TX_OUT, busy, clk, rst
 );
  input [7:0] P_DATA;
  input Data_Valid, PAR_TYP, PAR_EN, clk, rst;
  output TX_OUT, busy;
  wire   Ser_Done, Ser_En, Ser_Data, Par_bit, n1, n2;
  wire   [2:0] Mux_sel;

  Controller_TX Controller_TX ( .Data_Valid(Data_Valid), .PAR_EN(PAR_EN), 
        .Ser_Done(Ser_Done), .Mux_sel(Mux_sel), .Ser_En(Ser_En), .busy(busy), 
        .clk(clk), .rst(n1) );
  Serializer Serializer ( .P_Data(P_DATA), .Data_Valid(Data_Valid), .Ser_En(
        Ser_En), .clk(clk), .rst(n1), .Ser_Done(Ser_Done), .Ser_Data(Ser_Data), 
        .busy(busy) );
  Parity_Calc Parity_Calc ( .P_DATA(P_DATA), .Data_Valid(Data_Valid), 
        .Par_Type(PAR_TYP), .Par_En(PAR_EN), .Par_bit(Par_bit), .clk(clk), 
        .rst(n1), .busy(busy) );
  UART_Mux mux ( .Mux_Sel(Mux_sel), .Start_Bit(1'b0), .Stop_Bit(1'b1), 
        .ser_data(Ser_Data), .Par_Bit(Par_bit), .No_Trans(1'b1), .TX_OUT(
        TX_OUT) );
  INVX2M U3 ( .A(n2), .Y(n1) );
  INVX2M U4 ( .A(rst), .Y(n2) );
endmodule


module RST_SYNC_0 ( RST, CLK, SYNC_RST );
  input RST, CLK;
  output SYNC_RST;

  wire   [1:0] stages;

  DFFRQX2M \stages_reg[2]  ( .D(stages[1]), .CK(CLK), .RN(RST), .Q(SYNC_RST)
         );
  DFFRQX2M \stages_reg[1]  ( .D(stages[0]), .CK(CLK), .RN(RST), .Q(stages[1])
         );
  DFFRQX2M \stages_reg[0]  ( .D(1'b1), .CK(CLK), .RN(RST), .Q(stages[0]) );
endmodule


module RST_SYNC_1 ( RST, CLK, SYNC_RST );
  input RST, CLK;
  output SYNC_RST;

  wire   [1:0] stages;

  DFFRQX2M \stages_reg[2]  ( .D(stages[1]), .CK(CLK), .RN(RST), .Q(SYNC_RST)
         );
  DFFRQX2M \stages_reg[1]  ( .D(stages[0]), .CK(CLK), .RN(RST), .Q(stages[1])
         );
  DFFRQX2M \stages_reg[0]  ( .D(1'b1), .CK(CLK), .RN(RST), .Q(stages[0]) );
endmodule


module BIT_SYNC_N2_0 ( clk, rst, IN, OUT );
  input clk, rst, IN;
  output OUT;
  wire   \stage[0] ;

  DFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .CK(clk), .RN(rst), .Q(OUT) );
  DFFRQX2M \stage_reg[0]  ( .D(IN), .CK(clk), .RN(rst), .Q(\stage[0] ) );
endmodule


module Pulse_Gen_1 ( clk, rst, in, out );
  input clk, rst, in;
  output out;
  wire   q;

  DFFRQX2M q_reg ( .D(in), .CK(clk), .RN(rst), .Q(q) );
  NOR2BX2M U3 ( .AN(in), .B(q), .Y(out) );
endmodule


module DATA_SYNC ( unsync_bus, bus_enable, clk, rst, sync_bus, enable_pulse );
  input [7:0] unsync_bus;
  output [7:0] sync_bus;
  input bus_enable, clk, rst;
  output enable_pulse;
  wire   internal_enable, internal_out_of_synchronizer, n2, n3, n4, n5, n6, n7,
         n8, n9, n1;

  BIT_SYNC_N2_0 sync ( .clk(clk), .rst(rst), .IN(bus_enable), .OUT(
        internal_out_of_synchronizer) );
  Pulse_Gen_1 Pulse_Gen1 ( .clk(clk), .rst(rst), .in(
        internal_out_of_synchronizer), .out(internal_enable) );
  DFFRQX2M \sync_bus_reg[7]  ( .D(n9), .CK(clk), .RN(rst), .Q(sync_bus[7]) );
  DFFRQX2M \sync_bus_reg[4]  ( .D(n6), .CK(clk), .RN(rst), .Q(sync_bus[4]) );
  DFFRQX2M \sync_bus_reg[5]  ( .D(n7), .CK(clk), .RN(rst), .Q(sync_bus[5]) );
  DFFRQX2M \sync_bus_reg[6]  ( .D(n8), .CK(clk), .RN(rst), .Q(sync_bus[6]) );
  DFFRQX2M \sync_bus_reg[3]  ( .D(n5), .CK(clk), .RN(rst), .Q(sync_bus[3]) );
  DFFRQX2M \sync_bus_reg[0]  ( .D(n2), .CK(clk), .RN(rst), .Q(sync_bus[0]) );
  DFFRQX2M \sync_bus_reg[1]  ( .D(n3), .CK(clk), .RN(rst), .Q(sync_bus[1]) );
  DFFRQX2M \sync_bus_reg[2]  ( .D(n4), .CK(clk), .RN(rst), .Q(sync_bus[2]) );
  DFFRQX2M enable_pulse_reg ( .D(internal_enable), .CK(clk), .RN(rst), .Q(
        enable_pulse) );
  INVX2M U3 ( .A(internal_enable), .Y(n1) );
  AO22X1M U4 ( .A0(unsync_bus[0]), .A1(internal_enable), .B0(sync_bus[0]), 
        .B1(n1), .Y(n2) );
  AO22X1M U5 ( .A0(unsync_bus[1]), .A1(internal_enable), .B0(sync_bus[1]), 
        .B1(n1), .Y(n3) );
  AO22X1M U6 ( .A0(unsync_bus[2]), .A1(internal_enable), .B0(sync_bus[2]), 
        .B1(n1), .Y(n4) );
  AO22X1M U7 ( .A0(unsync_bus[3]), .A1(internal_enable), .B0(sync_bus[3]), 
        .B1(n1), .Y(n5) );
  AO22X1M U8 ( .A0(unsync_bus[4]), .A1(internal_enable), .B0(sync_bus[4]), 
        .B1(n1), .Y(n6) );
  AO22X1M U9 ( .A0(unsync_bus[5]), .A1(internal_enable), .B0(sync_bus[5]), 
        .B1(n1), .Y(n7) );
  AO22X1M U10 ( .A0(unsync_bus[6]), .A1(internal_enable), .B0(sync_bus[6]), 
        .B1(n1), .Y(n8) );
  AO22X1M U11 ( .A0(unsync_bus[7]), .A1(internal_enable), .B0(sync_bus[7]), 
        .B1(n1), .Y(n9) );
endmodule


module SYS_CTRL ( CLK, RST, ALU_OUT, OUT_Valid, RX_P_Data, RX_D_VLD, RdData, 
        RdData_Valid, ALU_EN, ALU_FUN, CLK_GATING_EN, Address, Wr_En, Rd_En, 
        Wr_Data, TX_P_Data, TX_D_VLD, clk_div_en, wfull );
  input [15:0] ALU_OUT;
  input [7:0] RX_P_Data;
  input [7:0] RdData;
  output [3:0] ALU_FUN;
  output [3:0] Address;
  output [7:0] Wr_Data;
  output [7:0] TX_P_Data;
  input CLK, RST, OUT_Valid, RX_D_VLD, RdData_Valid, wfull;
  output ALU_EN, CLK_GATING_EN, Wr_En, Rd_En, TX_D_VLD, clk_div_en;
  wire   n1, n3, n4, n5, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n21, n23, n24, n25, n26, n27, n28, n29, n31, n34, n35, n38, n43, n44,
         n49, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n65, n66,
         n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n89, n90, n91, n92, n2, n6, n7, n8, n20, n41, n42, n45, n46,
         n47, n50, n51, n52, n64, n67, n68, n69, n70, n87, n88, n93, n94, n95,
         n96, n97, n98;
  wire   [3:0] cs;
  wire   [3:0] ns;
  wire   [15:0] ALU_OUT_temp;
  assign clk_div_en = 1'b1;

  DFFRQX2M \ALU_OUT_temp_reg[7]  ( .D(n78), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[7]) );
  DFFRQX2M \ALU_OUT_temp_reg[6]  ( .D(n77), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[6]) );
  DFFRQX2M \ALU_OUT_temp_reg[5]  ( .D(n76), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[5]) );
  DFFRQX2M \ALU_OUT_temp_reg[4]  ( .D(n75), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[4]) );
  DFFRQX2M \ALU_OUT_temp_reg[3]  ( .D(n74), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[3]) );
  DFFRQX2M \ALU_OUT_temp_reg[2]  ( .D(n73), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[2]) );
  DFFRQX2M \ALU_OUT_temp_reg[1]  ( .D(n72), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[1]) );
  DFFRQX2M \ALU_OUT_temp_reg[0]  ( .D(n71), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[0]) );
  DFFRQX2M \ALU_OUT_temp_reg[15]  ( .D(n86), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[15]) );
  DFFRQX2M \ALU_OUT_temp_reg[14]  ( .D(n85), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[14]) );
  DFFRQX2M \ALU_OUT_temp_reg[13]  ( .D(n84), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[13]) );
  DFFRQX2M \ALU_OUT_temp_reg[12]  ( .D(n83), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[12]) );
  DFFRQX2M \ALU_OUT_temp_reg[11]  ( .D(n82), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[11]) );
  DFFRQX2M \ALU_OUT_temp_reg[10]  ( .D(n81), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[10]) );
  DFFRQX2M \ALU_OUT_temp_reg[9]  ( .D(n80), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[9]) );
  DFFRQX2M \ALU_OUT_temp_reg[8]  ( .D(n79), .CK(CLK), .RN(RST), .Q(
        ALU_OUT_temp[8]) );
  DFFRX1M \Address_temp_out_reg[3]  ( .D(n92), .CK(CLK), .RN(RST), .QN(n64) );
  DFFRX1M \Address_temp_out_reg[2]  ( .D(n91), .CK(CLK), .RN(RST), .QN(n67) );
  DFFRX1M \Address_temp_out_reg[1]  ( .D(n90), .CK(CLK), .RN(RST), .QN(n68) );
  DFFRX1M \Address_temp_out_reg[0]  ( .D(n89), .CK(CLK), .RN(RST), .QN(n69) );
  DFFRQX2M \cs_reg[2]  ( .D(ns[2]), .CK(CLK), .RN(RST), .Q(cs[2]) );
  DFFRQX2M \cs_reg[3]  ( .D(ns[3]), .CK(CLK), .RN(RST), .Q(cs[3]) );
  DFFRQX2M \cs_reg[1]  ( .D(ns[1]), .CK(CLK), .RN(RST), .Q(cs[1]) );
  DFFRQX2M \cs_reg[0]  ( .D(ns[0]), .CK(CLK), .RN(RST), .Q(cs[0]) );
  NOR2X2M U3 ( .A(n96), .B(n66), .Y(ALU_FUN[2]) );
  NOR2X2M U4 ( .A(n98), .B(n66), .Y(ALU_FUN[0]) );
  OAI22X2M U5 ( .A0(n96), .A1(n45), .B0(n21), .B1(n67), .Y(Address[2]) );
  INVX2M U6 ( .A(n11), .Y(n46) );
  INVX2M U7 ( .A(Rd_En), .Y(n45) );
  INVX2M U8 ( .A(n18), .Y(n41) );
  INVX2M U9 ( .A(wfull), .Y(n8) );
  INVX2M U10 ( .A(n29), .Y(n50) );
  OAI22X4M U11 ( .A0(n95), .A1(n45), .B0(n21), .B1(n64), .Y(Address[3]) );
  NOR3X2M U12 ( .A(n52), .B(n47), .C(n51), .Y(n11) );
  NOR2X2M U13 ( .A(n97), .B(n66), .Y(ALU_FUN[1]) );
  NOR2X2M U14 ( .A(n46), .B(n70), .Y(Rd_En) );
  OAI22X1M U15 ( .A0(n97), .A1(n45), .B0(n21), .B1(n68), .Y(Address[1]) );
  OAI2B1X2M U16 ( .A1N(n65), .A0(n4), .B0(n5), .Y(CLK_GATING_EN) );
  NAND2X2M U17 ( .A(n65), .B(n43), .Y(n21) );
  NAND2X2M U18 ( .A(n65), .B(n55), .Y(n29) );
  NOR2X2M U19 ( .A(n95), .B(n66), .Y(ALU_FUN[3]) );
  INVX2M U20 ( .A(n43), .Y(n52) );
  OAI222X1M U21 ( .A0(n70), .A1(n29), .B0(n21), .B1(n69), .C0(n98), .C1(n45), 
        .Y(Address[0]) );
  OA21X2M U22 ( .A0(n9), .A1(n70), .B0(n21), .Y(n54) );
  NOR3X2M U23 ( .A(n98), .B(n14), .C(n94), .Y(n18) );
  NOR2X2M U24 ( .A(n54), .B(n98), .Y(Wr_Data[0]) );
  NOR2X2M U25 ( .A(n54), .B(n97), .Y(Wr_Data[1]) );
  NOR2X2M U26 ( .A(n54), .B(n96), .Y(Wr_Data[2]) );
  NOR2X2M U27 ( .A(n54), .B(n95), .Y(Wr_Data[3]) );
  NOR2X2M U28 ( .A(n54), .B(n94), .Y(Wr_Data[4]) );
  NOR2X2M U29 ( .A(n54), .B(n93), .Y(Wr_Data[5]) );
  NOR2X2M U30 ( .A(n54), .B(n88), .Y(Wr_Data[6]) );
  NOR2X2M U31 ( .A(n54), .B(n87), .Y(Wr_Data[7]) );
  NAND4X2M U32 ( .A(n47), .B(n51), .C(n43), .D(n44), .Y(n14) );
  NOR3X2M U33 ( .A(n87), .B(n70), .C(n95), .Y(n44) );
  OAI22X1M U34 ( .A0(n42), .A1(n64), .B0(n95), .B1(n49), .Y(n92) );
  OAI22X1M U35 ( .A0(n42), .A1(n69), .B0(n98), .B1(n49), .Y(n89) );
  OAI22X1M U36 ( .A0(n42), .A1(n68), .B0(n97), .B1(n49), .Y(n90) );
  OAI22X1M U37 ( .A0(n42), .A1(n67), .B0(n96), .B1(n49), .Y(n91) );
  AOI21X2M U38 ( .A0(n9), .A1(n21), .B0(n70), .Y(Wr_En) );
  AND3X2M U39 ( .A(n55), .B(n47), .C(n51), .Y(n12) );
  OR3X2M U40 ( .A(n2), .B(n6), .C(n12), .Y(TX_D_VLD) );
  INVX2M U41 ( .A(n66), .Y(ALU_EN) );
  INVX2M U42 ( .A(n49), .Y(n42) );
  AND2X2M U43 ( .A(n34), .B(n29), .Y(n9) );
  OAI222X1M U44 ( .A0(n1), .A1(n41), .B0(n3), .B1(n4), .C0(n5), .C1(n20), .Y(
        ns[3]) );
  AOI21X2M U45 ( .A0(wfull), .A1(n51), .B0(n47), .Y(n3) );
  INVX2M U46 ( .A(n7), .Y(n20) );
  NOR2BX2M U47 ( .AN(cs[2]), .B(cs[3]), .Y(n55) );
  NOR2X2M U48 ( .A(cs[2]), .B(cs[3]), .Y(n43) );
  NOR2X2M U49 ( .A(n51), .B(cs[0]), .Y(n65) );
  NAND2X2M U50 ( .A(RX_D_VLD), .B(CLK_GATING_EN), .Y(n66) );
  INVX2M U51 ( .A(cs[1]), .Y(n51) );
  INVX2M U52 ( .A(cs[0]), .Y(n47) );
  NAND2BX2M U53 ( .AN(cs[2]), .B(cs[3]), .Y(n4) );
  NAND3X2M U54 ( .A(n55), .B(cs[0]), .C(cs[1]), .Y(n5) );
  AOI221XLM U55 ( .A0(n2), .A1(wfull), .B0(n50), .B1(RX_D_VLD), .C0(n28), .Y(
        n26) );
  OAI22X1M U56 ( .A0(n7), .A1(n5), .B0(RdData_Valid), .B1(n46), .Y(n28) );
  NOR3X2M U57 ( .A(n41), .B(RX_P_Data[6]), .C(RX_P_Data[2]), .Y(n35) );
  NAND3X2M U58 ( .A(RX_D_VLD), .B(cs[0]), .C(n53), .Y(n49) );
  NOR3X2M U59 ( .A(TX_D_VLD), .B(cs[2]), .C(cs[1]), .Y(n53) );
  OAI211X2M U60 ( .A0(n7), .A1(n5), .B0(n9), .C0(n10), .Y(ns[2]) );
  AOI221XLM U61 ( .A0(RdData_Valid), .A1(n11), .B0(n12), .B1(wfull), .C0(n13), 
        .Y(n10) );
  NOR4X1M U62 ( .A(RX_P_Data[4]), .B(RX_P_Data[0]), .C(n14), .D(n1), .Y(n13)
         );
  INVX2M U63 ( .A(RX_P_Data[2]), .Y(n96) );
  INVX2M U64 ( .A(RX_P_Data[1]), .Y(n97) );
  INVX2M U65 ( .A(n63), .Y(TX_P_Data[0]) );
  AOI222X1M U66 ( .A0(n2), .A1(ALU_OUT_temp[8]), .B0(n6), .B1(ALU_OUT_temp[0]), 
        .C0(n12), .C1(RdData[0]), .Y(n63) );
  INVX2M U67 ( .A(n62), .Y(TX_P_Data[1]) );
  AOI222X1M U68 ( .A0(n2), .A1(ALU_OUT_temp[9]), .B0(n6), .B1(ALU_OUT_temp[1]), 
        .C0(n12), .C1(RdData[1]), .Y(n62) );
  INVX2M U69 ( .A(n61), .Y(TX_P_Data[2]) );
  AOI222X1M U70 ( .A0(n2), .A1(ALU_OUT_temp[10]), .B0(n6), .B1(ALU_OUT_temp[2]), .C0(n12), .C1(RdData[2]), .Y(n61) );
  INVX2M U71 ( .A(n60), .Y(TX_P_Data[3]) );
  AOI222X1M U72 ( .A0(n2), .A1(ALU_OUT_temp[11]), .B0(n6), .B1(ALU_OUT_temp[3]), .C0(n12), .C1(RdData[3]), .Y(n60) );
  INVX2M U73 ( .A(n59), .Y(TX_P_Data[4]) );
  AOI222X1M U74 ( .A0(n2), .A1(ALU_OUT_temp[12]), .B0(n6), .B1(ALU_OUT_temp[4]), .C0(n12), .C1(RdData[4]), .Y(n59) );
  INVX2M U75 ( .A(n58), .Y(TX_P_Data[5]) );
  AOI222X1M U76 ( .A0(n2), .A1(ALU_OUT_temp[13]), .B0(n6), .B1(ALU_OUT_temp[5]), .C0(n12), .C1(RdData[5]), .Y(n58) );
  INVX2M U77 ( .A(n57), .Y(TX_P_Data[6]) );
  AOI222X1M U78 ( .A0(n2), .A1(ALU_OUT_temp[14]), .B0(n6), .B1(ALU_OUT_temp[6]), .C0(n12), .C1(RdData[6]), .Y(n57) );
  INVX2M U79 ( .A(n56), .Y(TX_P_Data[7]) );
  AOI222X1M U80 ( .A0(n2), .A1(ALU_OUT_temp[15]), .B0(n6), .B1(ALU_OUT_temp[7]), .C0(n12), .C1(RdData[7]), .Y(n56) );
  INVX2M U81 ( .A(RX_P_Data[0]), .Y(n98) );
  INVX2M U82 ( .A(RX_D_VLD), .Y(n70) );
  INVX2M U83 ( .A(RX_P_Data[3]), .Y(n95) );
  NAND3X2M U84 ( .A(cs[0]), .B(n51), .C(n55), .Y(n34) );
  NAND4X2M U85 ( .A(n23), .B(n24), .C(n25), .D(n26), .Y(ns[0]) );
  NAND4BX1M U86 ( .AN(n14), .B(n19), .C(n98), .D(n94), .Y(n23) );
  AOI22X1M U87 ( .A0(n17), .A1(n70), .B0(n6), .B1(n8), .Y(n25) );
  NAND3X2M U88 ( .A(RX_P_Data[5]), .B(RX_P_Data[1]), .C(n35), .Y(n24) );
  BUFX2M U89 ( .A(n27), .Y(n2) );
  NOR3X2M U90 ( .A(n47), .B(cs[1]), .C(n4), .Y(n27) );
  BUFX2M U91 ( .A(n31), .Y(n6) );
  NOR3X2M U92 ( .A(cs[0]), .B(cs[1]), .C(n4), .Y(n31) );
  OAI31X1M U93 ( .A0(n52), .A1(cs[1]), .A2(n47), .B0(n34), .Y(n17) );
  NAND4X2M U94 ( .A(RX_P_Data[6]), .B(RX_P_Data[2]), .C(n97), .D(n93), .Y(n1)
         );
  OAI2B11X2M U95 ( .A1N(CLK_GATING_EN), .A0(n7), .B0(n15), .C0(n16), .Y(ns[1])
         );
  OA22X2M U96 ( .A0(n21), .A1(RX_D_VLD), .B0(n46), .B1(RdData_Valid), .Y(n15)
         );
  AOI221XLM U97 ( .A0(RX_D_VLD), .A1(n17), .B0(n18), .B1(n19), .C0(n50), .Y(
        n16) );
  BUFX2M U98 ( .A(OUT_Valid), .Y(n7) );
  INVX2M U99 ( .A(RX_P_Data[4]), .Y(n94) );
  INVX2M U100 ( .A(RX_P_Data[6]), .Y(n88) );
  INVX2M U101 ( .A(RX_P_Data[5]), .Y(n93) );
  NAND2X2M U102 ( .A(n1), .B(n38), .Y(n19) );
  NAND4X2M U103 ( .A(RX_P_Data[5]), .B(RX_P_Data[1]), .C(n96), .D(n88), .Y(n38) );
  INVX2M U104 ( .A(RX_P_Data[7]), .Y(n87) );
  AO22X1M U105 ( .A0(n20), .A1(ALU_OUT_temp[0]), .B0(ALU_OUT[0]), .B1(n7), .Y(
        n71) );
  AO22X1M U106 ( .A0(n20), .A1(ALU_OUT_temp[1]), .B0(ALU_OUT[1]), .B1(n7), .Y(
        n72) );
  AO22X1M U107 ( .A0(n20), .A1(ALU_OUT_temp[2]), .B0(ALU_OUT[2]), .B1(n7), .Y(
        n73) );
  AO22X1M U108 ( .A0(n20), .A1(ALU_OUT_temp[3]), .B0(ALU_OUT[3]), .B1(n7), .Y(
        n74) );
  AO22X1M U109 ( .A0(n20), .A1(ALU_OUT_temp[4]), .B0(ALU_OUT[4]), .B1(n7), .Y(
        n75) );
  AO22X1M U110 ( .A0(n20), .A1(ALU_OUT_temp[5]), .B0(ALU_OUT[5]), .B1(n7), .Y(
        n76) );
  AO22X1M U111 ( .A0(n20), .A1(ALU_OUT_temp[6]), .B0(ALU_OUT[6]), .B1(n7), .Y(
        n77) );
  AO22X1M U112 ( .A0(n20), .A1(ALU_OUT_temp[7]), .B0(ALU_OUT[7]), .B1(n7), .Y(
        n78) );
  AO22X1M U113 ( .A0(n20), .A1(ALU_OUT_temp[8]), .B0(ALU_OUT[8]), .B1(n7), .Y(
        n79) );
  AO22X1M U114 ( .A0(n20), .A1(ALU_OUT_temp[9]), .B0(ALU_OUT[9]), .B1(n7), .Y(
        n80) );
  AO22X1M U115 ( .A0(n20), .A1(ALU_OUT_temp[10]), .B0(ALU_OUT[10]), .B1(n7), 
        .Y(n81) );
  AO22X1M U116 ( .A0(n20), .A1(ALU_OUT_temp[11]), .B0(ALU_OUT[11]), .B1(n7), 
        .Y(n82) );
  AO22X1M U117 ( .A0(n20), .A1(ALU_OUT_temp[12]), .B0(ALU_OUT[12]), .B1(n7), 
        .Y(n83) );
  AO22X1M U118 ( .A0(n20), .A1(ALU_OUT_temp[13]), .B0(ALU_OUT[13]), .B1(n7), 
        .Y(n84) );
  AO22X1M U119 ( .A0(n20), .A1(ALU_OUT_temp[14]), .B0(ALU_OUT[14]), .B1(n7), 
        .Y(n85) );
  AO22X1M U120 ( .A0(n20), .A1(ALU_OUT_temp[15]), .B0(ALU_OUT[15]), .B1(n7), 
        .Y(n86) );
endmodule


module clock_gating ( CLK_EN, CLK, GATED_CLK );
  input CLK_EN, CLK;
  output GATED_CLK;


  TLATNCAX3M gating ( .E(CLK_EN), .CK(CLK), .ECK(GATED_CLK) );
endmodule


module Pulse_Gen_0 ( clk, rst, in, out );
  input clk, rst, in;
  output out;
  wire   q;

  DFFRQX2M q_reg ( .D(in), .CK(clk), .RN(rst), .Q(q) );
  NOR2BX2M U3 ( .AN(in), .B(q), .Y(out) );
endmodule


module ClkDiv_Range_for_division8 ( i_ref_clk, i_rst_n, i_clk_en, i_div_ratio, 
        o_div_clk );
  input [7:0] i_div_ratio;
  input i_ref_clk, i_rst_n, i_clk_en;
  output o_div_clk;
  wire   o_div_clk_internal, toggle_flag_odd, N17, N18, N19, N20, n17, n18,
         n19, n20, n21, n22, n23, \add_39/carry[4] , \add_39/carry[3] ,
         \add_39/carry[2] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37;
  wire   [4:0] counter;
  wire   [4:0] even_edge_toggle;

  DFFRQX2M o_div_clk_internal_reg ( .D(n17), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        o_div_clk_internal) );
  DFFRQX2M toggle_flag_odd_reg ( .D(n23), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        toggle_flag_odd) );
  DFFRQX2M \counter_reg[4]  ( .D(n18), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        counter[4]) );
  DFFRQX2M \counter_reg[3]  ( .D(n19), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        counter[3]) );
  DFFRQX2M \counter_reg[0]  ( .D(n22), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        counter[0]) );
  DFFRQX2M \counter_reg[1]  ( .D(n21), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        counter[1]) );
  DFFRQX2M \counter_reg[2]  ( .D(n20), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        counter[2]) );
  MX2X2M U3 ( .A(i_ref_clk), .B(o_div_clk_internal), .S0(n37), .Y(o_div_clk)
         );
  OAI2B2X1M U4 ( .A1N(n9), .A0(counter[0]), .B0(n37), .B1(n8), .Y(n22) );
  ADDHX1M U5 ( .A(counter[2]), .B(\add_39/carry[2] ), .CO(\add_39/carry[3] ), 
        .S(N18) );
  ADDHX1M U6 ( .A(counter[1]), .B(counter[0]), .CO(\add_39/carry[2] ), .S(N17)
         );
  ADDHX1M U7 ( .A(counter[3]), .B(\add_39/carry[3] ), .CO(\add_39/carry[4] ), 
        .S(N19) );
  INVX2M U8 ( .A(i_div_ratio[3]), .Y(n4) );
  INVX2M U9 ( .A(i_div_ratio[1]), .Y(even_edge_toggle[0]) );
  NOR2X1M U10 ( .A(i_div_ratio[2]), .B(i_div_ratio[1]), .Y(n1) );
  AO21XLM U11 ( .A0(i_div_ratio[1]), .A1(i_div_ratio[2]), .B0(n1), .Y(
        even_edge_toggle[1]) );
  CLKNAND2X2M U12 ( .A(n1), .B(n4), .Y(n2) );
  OAI21X1M U13 ( .A0(n1), .A1(n4), .B0(n2), .Y(even_edge_toggle[2]) );
  XNOR2X1M U14 ( .A(i_div_ratio[4]), .B(n2), .Y(even_edge_toggle[3]) );
  NOR2X1M U15 ( .A(i_div_ratio[4]), .B(n2), .Y(n3) );
  CLKXOR2X2M U16 ( .A(i_div_ratio[5]), .B(n3), .Y(even_edge_toggle[4]) );
  CLKXOR2X2M U17 ( .A(\add_39/carry[4] ), .B(counter[4]), .Y(N20) );
  XNOR2X1M U18 ( .A(toggle_flag_odd), .B(n5), .Y(n23) );
  OR2X1M U19 ( .A(n6), .B(n7), .Y(n5) );
  OAI2BB2X1M U20 ( .B0(n37), .B1(n10), .A0N(N17), .A1N(n9), .Y(n21) );
  AO22X1M U21 ( .A0(n7), .A1(counter[2]), .B0(N18), .B1(n9), .Y(n20) );
  AO22X1M U22 ( .A0(n7), .A1(counter[3]), .B0(N19), .B1(n9), .Y(n19) );
  AO22X1M U23 ( .A0(n7), .A1(counter[4]), .B0(N20), .B1(n9), .Y(n18) );
  AND3X1M U24 ( .A(n11), .B(n6), .C(n37), .Y(n9) );
  CLKINVX1M U25 ( .A(n7), .Y(n37) );
  CLKXOR2X2M U26 ( .A(o_div_clk_internal), .B(n12), .Y(n17) );
  AOI21X1M U27 ( .A0(n6), .A1(n11), .B0(n7), .Y(n12) );
  NAND2BX1M U28 ( .AN(n13), .B(i_clk_en), .Y(n7) );
  NOR4BX1M U29 ( .AN(n14), .B(i_div_ratio[2]), .C(i_div_ratio[3]), .D(
        i_div_ratio[1]), .Y(n13) );
  NOR4X1M U30 ( .A(i_div_ratio[7]), .B(i_div_ratio[6]), .C(i_div_ratio[5]), 
        .D(i_div_ratio[4]), .Y(n14) );
  OR2X1M U31 ( .A(n15), .B(i_div_ratio[0]), .Y(n11) );
  CLKNAND2X2M U32 ( .A(n16), .B(i_div_ratio[0]), .Y(n6) );
  MXI2X1M U33 ( .A(n15), .B(n24), .S0(toggle_flag_odd), .Y(n16) );
  NAND4X1M U34 ( .A(n25), .B(n26), .C(n27), .D(n28), .Y(n24) );
  CLKXOR2X2M U35 ( .A(n10), .B(i_div_ratio[2]), .Y(n28) );
  CLKINVX1M U36 ( .A(counter[1]), .Y(n10) );
  NOR2X1M U37 ( .A(n29), .B(n30), .Y(n27) );
  CLKXOR2X2M U38 ( .A(i_div_ratio[1]), .B(counter[0]), .Y(n30) );
  CLKXOR2X2M U39 ( .A(i_div_ratio[3]), .B(counter[2]), .Y(n29) );
  XNOR2X1M U40 ( .A(counter[3]), .B(i_div_ratio[4]), .Y(n26) );
  XNOR2X1M U41 ( .A(counter[4]), .B(i_div_ratio[5]), .Y(n25) );
  NAND4X1M U42 ( .A(n31), .B(n32), .C(n33), .D(n34), .Y(n15) );
  CLKXOR2X2M U43 ( .A(n8), .B(even_edge_toggle[0]), .Y(n34) );
  CLKINVX1M U44 ( .A(counter[0]), .Y(n8) );
  NOR2X1M U45 ( .A(n35), .B(n36), .Y(n33) );
  CLKXOR2X2M U46 ( .A(even_edge_toggle[2]), .B(counter[2]), .Y(n36) );
  CLKXOR2X2M U47 ( .A(even_edge_toggle[1]), .B(counter[1]), .Y(n35) );
  XNOR2X1M U48 ( .A(counter[3]), .B(even_edge_toggle[3]), .Y(n32) );
  XNOR2X1M U49 ( .A(counter[4]), .B(even_edge_toggle[4]), .Y(n31) );
endmodule


module ClkDiv_Range_for_division2 ( i_ref_clk, i_rst_n, i_clk_en, i_div_ratio, 
        o_div_clk );
  input [1:0] i_div_ratio;
  input i_ref_clk, i_rst_n, i_clk_en;
  output o_div_clk;
  wire   o_div_clk_internal, toggle_flag_odd, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n1, n2, n3, n4;
  wire   [1:0] counter;

  DFFRQX2M o_div_clk_internal_reg ( .D(n22), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        o_div_clk_internal) );
  DFFRQX2M toggle_flag_odd_reg ( .D(n25), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        toggle_flag_odd) );
  DFFRQX2M \counter_reg[0]  ( .D(n24), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        counter[0]) );
  DFFRQX2M \counter_reg[1]  ( .D(n23), .CK(i_ref_clk), .RN(i_rst_n), .Q(
        counter[1]) );
  MX2X2M U3 ( .A(i_ref_clk), .B(o_div_clk_internal), .S0(n2), .Y(o_div_clk) );
  NAND2X2M U4 ( .A(n4), .B(n17), .Y(n18) );
  NAND2X2M U5 ( .A(n2), .B(n4), .Y(n16) );
  INVX2M U6 ( .A(n15), .Y(n2) );
  OAI32X1M U7 ( .A0(n15), .A1(counter[0]), .A2(n1), .B0(n2), .B1(n3), .Y(n24)
         );
  INVX2M U8 ( .A(n18), .Y(n1) );
  INVX2M U9 ( .A(counter[1]), .Y(n4) );
  OAI31X1M U10 ( .A0(n18), .A1(n3), .A2(n15), .B0(n19), .Y(n23) );
  OAI21X2M U11 ( .A0(n3), .A1(n15), .B0(counter[1]), .Y(n19) );
  OAI2B1X2M U12 ( .A1N(toggle_flag_odd), .A0(n20), .B0(n21), .Y(n25) );
  NAND4X2M U13 ( .A(n2), .B(i_div_ratio[0]), .C(n3), .D(n4), .Y(n21) );
  NOR2BX2M U14 ( .AN(i_div_ratio[0]), .B(n16), .Y(n20) );
  NAND2X2M U15 ( .A(toggle_flag_odd), .B(i_div_ratio[0]), .Y(n17) );
  INVX2M U16 ( .A(counter[0]), .Y(n3) );
  OAI2B1X2M U17 ( .A1N(o_div_clk_internal), .A0(n12), .B0(n13), .Y(n22) );
  NOR2X2M U18 ( .A(n14), .B(n16), .Y(n12) );
  OR4X1M U19 ( .A(n14), .B(n15), .C(counter[1]), .D(o_div_clk_internal), .Y(
        n13) );
  XNOR2X2M U20 ( .A(n17), .B(counter[0]), .Y(n14) );
  NAND2X2M U21 ( .A(i_div_ratio[1]), .B(i_clk_en), .Y(n15) );
endmodule


module FIFO_Memory_FIFO_DEPTH8_DATA_WIDTH8 ( w_clk, rst, w_data, w_en, w_addr, 
        r_addr, r_data );
  input [7:0] w_data;
  input [2:0] w_addr;
  input [2:0] r_addr;
  output [7:0] r_data;
  input w_clk, rst, w_en;
  wire   N10, N11, N12, \FIFO_MEM[7][7] , \FIFO_MEM[7][6] , \FIFO_MEM[7][5] ,
         \FIFO_MEM[7][4] , \FIFO_MEM[7][3] , \FIFO_MEM[7][2] ,
         \FIFO_MEM[7][1] , \FIFO_MEM[7][0] , \FIFO_MEM[6][7] ,
         \FIFO_MEM[6][6] , \FIFO_MEM[6][5] , \FIFO_MEM[6][4] ,
         \FIFO_MEM[6][3] , \FIFO_MEM[6][2] , \FIFO_MEM[6][1] ,
         \FIFO_MEM[6][0] , \FIFO_MEM[5][7] , \FIFO_MEM[5][6] ,
         \FIFO_MEM[5][5] , \FIFO_MEM[5][4] , \FIFO_MEM[5][3] ,
         \FIFO_MEM[5][2] , \FIFO_MEM[5][1] , \FIFO_MEM[5][0] ,
         \FIFO_MEM[4][7] , \FIFO_MEM[4][6] , \FIFO_MEM[4][5] ,
         \FIFO_MEM[4][4] , \FIFO_MEM[4][3] , \FIFO_MEM[4][2] ,
         \FIFO_MEM[4][1] , \FIFO_MEM[4][0] , \FIFO_MEM[3][7] ,
         \FIFO_MEM[3][6] , \FIFO_MEM[3][5] , \FIFO_MEM[3][4] ,
         \FIFO_MEM[3][3] , \FIFO_MEM[3][2] , \FIFO_MEM[3][1] ,
         \FIFO_MEM[3][0] , \FIFO_MEM[2][7] , \FIFO_MEM[2][6] ,
         \FIFO_MEM[2][5] , \FIFO_MEM[2][4] , \FIFO_MEM[2][3] ,
         \FIFO_MEM[2][2] , \FIFO_MEM[2][1] , \FIFO_MEM[2][0] ,
         \FIFO_MEM[1][7] , \FIFO_MEM[1][6] , \FIFO_MEM[1][5] ,
         \FIFO_MEM[1][4] , \FIFO_MEM[1][3] , \FIFO_MEM[1][2] ,
         \FIFO_MEM[1][1] , \FIFO_MEM[1][0] , \FIFO_MEM[0][7] ,
         \FIFO_MEM[0][6] , \FIFO_MEM[0][5] , \FIFO_MEM[0][4] ,
         \FIFO_MEM[0][3] , \FIFO_MEM[0][2] , \FIFO_MEM[0][1] ,
         \FIFO_MEM[0][0] , n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n1, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95,
         n96, n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107,
         n108, n109, n110, n111, n112, n113;
  assign N10 = r_addr[0];
  assign N11 = r_addr[1];
  assign N12 = r_addr[2];

  DFFRQX2M \FIFO_MEM_reg[5][7]  ( .D(n68), .CK(w_clk), .RN(n100), .Q(
        \FIFO_MEM[5][7] ) );
  DFFRQX2M \FIFO_MEM_reg[5][6]  ( .D(n67), .CK(w_clk), .RN(n100), .Q(
        \FIFO_MEM[5][6] ) );
  DFFRQX2M \FIFO_MEM_reg[5][5]  ( .D(n66), .CK(w_clk), .RN(n100), .Q(
        \FIFO_MEM[5][5] ) );
  DFFRQX2M \FIFO_MEM_reg[5][4]  ( .D(n65), .CK(w_clk), .RN(n100), .Q(
        \FIFO_MEM[5][4] ) );
  DFFRQX2M \FIFO_MEM_reg[5][3]  ( .D(n64), .CK(w_clk), .RN(n100), .Q(
        \FIFO_MEM[5][3] ) );
  DFFRQX2M \FIFO_MEM_reg[5][2]  ( .D(n63), .CK(w_clk), .RN(n100), .Q(
        \FIFO_MEM[5][2] ) );
  DFFRQX2M \FIFO_MEM_reg[5][1]  ( .D(n62), .CK(w_clk), .RN(n100), .Q(
        \FIFO_MEM[5][1] ) );
  DFFRQX2M \FIFO_MEM_reg[5][0]  ( .D(n61), .CK(w_clk), .RN(n100), .Q(
        \FIFO_MEM[5][0] ) );
  DFFRQX2M \FIFO_MEM_reg[1][7]  ( .D(n36), .CK(w_clk), .RN(n102), .Q(
        \FIFO_MEM[1][7] ) );
  DFFRQX2M \FIFO_MEM_reg[1][6]  ( .D(n35), .CK(w_clk), .RN(n102), .Q(
        \FIFO_MEM[1][6] ) );
  DFFRQX2M \FIFO_MEM_reg[1][5]  ( .D(n34), .CK(w_clk), .RN(n102), .Q(
        \FIFO_MEM[1][5] ) );
  DFFRQX2M \FIFO_MEM_reg[1][4]  ( .D(n33), .CK(w_clk), .RN(n102), .Q(
        \FIFO_MEM[1][4] ) );
  DFFRQX2M \FIFO_MEM_reg[1][3]  ( .D(n32), .CK(w_clk), .RN(n103), .Q(
        \FIFO_MEM[1][3] ) );
  DFFRQX2M \FIFO_MEM_reg[1][2]  ( .D(n31), .CK(w_clk), .RN(n103), .Q(
        \FIFO_MEM[1][2] ) );
  DFFRQX2M \FIFO_MEM_reg[1][1]  ( .D(n30), .CK(w_clk), .RN(n103), .Q(
        \FIFO_MEM[1][1] ) );
  DFFRQX2M \FIFO_MEM_reg[1][0]  ( .D(n29), .CK(w_clk), .RN(n103), .Q(
        \FIFO_MEM[1][0] ) );
  DFFRQX2M \FIFO_MEM_reg[7][7]  ( .D(n84), .CK(w_clk), .RN(n99), .Q(
        \FIFO_MEM[7][7] ) );
  DFFRQX2M \FIFO_MEM_reg[7][6]  ( .D(n83), .CK(w_clk), .RN(n99), .Q(
        \FIFO_MEM[7][6] ) );
  DFFRQX2M \FIFO_MEM_reg[7][5]  ( .D(n82), .CK(w_clk), .RN(n99), .Q(
        \FIFO_MEM[7][5] ) );
  DFFRQX2M \FIFO_MEM_reg[7][4]  ( .D(n81), .CK(w_clk), .RN(n99), .Q(
        \FIFO_MEM[7][4] ) );
  DFFRQX2M \FIFO_MEM_reg[7][3]  ( .D(n80), .CK(w_clk), .RN(n99), .Q(
        \FIFO_MEM[7][3] ) );
  DFFRQX2M \FIFO_MEM_reg[7][2]  ( .D(n79), .CK(w_clk), .RN(n99), .Q(
        \FIFO_MEM[7][2] ) );
  DFFRQX2M \FIFO_MEM_reg[7][1]  ( .D(n78), .CK(w_clk), .RN(n99), .Q(
        \FIFO_MEM[7][1] ) );
  DFFRQX2M \FIFO_MEM_reg[7][0]  ( .D(n77), .CK(w_clk), .RN(n99), .Q(
        \FIFO_MEM[7][0] ) );
  DFFRQX2M \FIFO_MEM_reg[3][7]  ( .D(n52), .CK(w_clk), .RN(n101), .Q(
        \FIFO_MEM[3][7] ) );
  DFFRQX2M \FIFO_MEM_reg[3][6]  ( .D(n51), .CK(w_clk), .RN(n101), .Q(
        \FIFO_MEM[3][6] ) );
  DFFRQX2M \FIFO_MEM_reg[3][5]  ( .D(n50), .CK(w_clk), .RN(n101), .Q(
        \FIFO_MEM[3][5] ) );
  DFFRQX2M \FIFO_MEM_reg[3][4]  ( .D(n49), .CK(w_clk), .RN(n101), .Q(
        \FIFO_MEM[3][4] ) );
  DFFRQX2M \FIFO_MEM_reg[3][3]  ( .D(n48), .CK(w_clk), .RN(n101), .Q(
        \FIFO_MEM[3][3] ) );
  DFFRQX2M \FIFO_MEM_reg[3][2]  ( .D(n47), .CK(w_clk), .RN(n101), .Q(
        \FIFO_MEM[3][2] ) );
  DFFRQX2M \FIFO_MEM_reg[3][1]  ( .D(n46), .CK(w_clk), .RN(n101), .Q(
        \FIFO_MEM[3][1] ) );
  DFFRQX2M \FIFO_MEM_reg[3][0]  ( .D(n45), .CK(w_clk), .RN(n102), .Q(
        \FIFO_MEM[3][0] ) );
  DFFRQX2M \FIFO_MEM_reg[6][7]  ( .D(n76), .CK(w_clk), .RN(n99), .Q(
        \FIFO_MEM[6][7] ) );
  DFFRQX2M \FIFO_MEM_reg[6][6]  ( .D(n75), .CK(w_clk), .RN(n99), .Q(
        \FIFO_MEM[6][6] ) );
  DFFRQX2M \FIFO_MEM_reg[6][5]  ( .D(n74), .CK(w_clk), .RN(n99), .Q(
        \FIFO_MEM[6][5] ) );
  DFFRQX2M \FIFO_MEM_reg[6][4]  ( .D(n73), .CK(w_clk), .RN(n99), .Q(
        \FIFO_MEM[6][4] ) );
  DFFRQX2M \FIFO_MEM_reg[6][3]  ( .D(n72), .CK(w_clk), .RN(n99), .Q(
        \FIFO_MEM[6][3] ) );
  DFFRQX2M \FIFO_MEM_reg[6][2]  ( .D(n71), .CK(w_clk), .RN(n100), .Q(
        \FIFO_MEM[6][2] ) );
  DFFRQX2M \FIFO_MEM_reg[6][1]  ( .D(n70), .CK(w_clk), .RN(n100), .Q(
        \FIFO_MEM[6][1] ) );
  DFFRQX2M \FIFO_MEM_reg[6][0]  ( .D(n69), .CK(w_clk), .RN(n100), .Q(
        \FIFO_MEM[6][0] ) );
  DFFRQX2M \FIFO_MEM_reg[2][7]  ( .D(n44), .CK(w_clk), .RN(n102), .Q(
        \FIFO_MEM[2][7] ) );
  DFFRQX2M \FIFO_MEM_reg[2][6]  ( .D(n43), .CK(w_clk), .RN(n102), .Q(
        \FIFO_MEM[2][6] ) );
  DFFRQX2M \FIFO_MEM_reg[2][5]  ( .D(n42), .CK(w_clk), .RN(n102), .Q(
        \FIFO_MEM[2][5] ) );
  DFFRQX2M \FIFO_MEM_reg[2][4]  ( .D(n41), .CK(w_clk), .RN(n102), .Q(
        \FIFO_MEM[2][4] ) );
  DFFRQX2M \FIFO_MEM_reg[2][3]  ( .D(n40), .CK(w_clk), .RN(n102), .Q(
        \FIFO_MEM[2][3] ) );
  DFFRQX2M \FIFO_MEM_reg[2][2]  ( .D(n39), .CK(w_clk), .RN(n102), .Q(
        \FIFO_MEM[2][2] ) );
  DFFRQX2M \FIFO_MEM_reg[2][1]  ( .D(n38), .CK(w_clk), .RN(n102), .Q(
        \FIFO_MEM[2][1] ) );
  DFFRQX2M \FIFO_MEM_reg[2][0]  ( .D(n37), .CK(w_clk), .RN(n102), .Q(
        \FIFO_MEM[2][0] ) );
  DFFRQX2M \FIFO_MEM_reg[4][7]  ( .D(n60), .CK(w_clk), .RN(n100), .Q(
        \FIFO_MEM[4][7] ) );
  DFFRQX2M \FIFO_MEM_reg[4][6]  ( .D(n59), .CK(w_clk), .RN(n100), .Q(
        \FIFO_MEM[4][6] ) );
  DFFRQX2M \FIFO_MEM_reg[4][5]  ( .D(n58), .CK(w_clk), .RN(n101), .Q(
        \FIFO_MEM[4][5] ) );
  DFFRQX2M \FIFO_MEM_reg[4][4]  ( .D(n57), .CK(w_clk), .RN(n101), .Q(
        \FIFO_MEM[4][4] ) );
  DFFRQX2M \FIFO_MEM_reg[4][3]  ( .D(n56), .CK(w_clk), .RN(n101), .Q(
        \FIFO_MEM[4][3] ) );
  DFFRQX2M \FIFO_MEM_reg[4][2]  ( .D(n55), .CK(w_clk), .RN(n101), .Q(
        \FIFO_MEM[4][2] ) );
  DFFRQX2M \FIFO_MEM_reg[4][1]  ( .D(n54), .CK(w_clk), .RN(n101), .Q(
        \FIFO_MEM[4][1] ) );
  DFFRQX2M \FIFO_MEM_reg[4][0]  ( .D(n53), .CK(w_clk), .RN(n101), .Q(
        \FIFO_MEM[4][0] ) );
  DFFRQX2M \FIFO_MEM_reg[0][7]  ( .D(n28), .CK(w_clk), .RN(n103), .Q(
        \FIFO_MEM[0][7] ) );
  DFFRQX2M \FIFO_MEM_reg[0][6]  ( .D(n27), .CK(w_clk), .RN(n103), .Q(
        \FIFO_MEM[0][6] ) );
  DFFRQX2M \FIFO_MEM_reg[0][5]  ( .D(n26), .CK(w_clk), .RN(n103), .Q(
        \FIFO_MEM[0][5] ) );
  DFFRQX2M \FIFO_MEM_reg[0][4]  ( .D(n25), .CK(w_clk), .RN(n103), .Q(
        \FIFO_MEM[0][4] ) );
  DFFRQX2M \FIFO_MEM_reg[0][3]  ( .D(n24), .CK(w_clk), .RN(n103), .Q(
        \FIFO_MEM[0][3] ) );
  DFFRQX2M \FIFO_MEM_reg[0][2]  ( .D(n23), .CK(w_clk), .RN(n103), .Q(
        \FIFO_MEM[0][2] ) );
  DFFRQX2M \FIFO_MEM_reg[0][1]  ( .D(n22), .CK(w_clk), .RN(n103), .Q(
        \FIFO_MEM[0][1] ) );
  DFFRQX2M \FIFO_MEM_reg[0][0]  ( .D(n21), .CK(w_clk), .RN(n103), .Q(
        \FIFO_MEM[0][0] ) );
  BUFX2M U2 ( .A(n18), .Y(n95) );
  BUFX2M U3 ( .A(n14), .Y(n96) );
  BUFX2M U4 ( .A(n97), .Y(n101) );
  BUFX2M U5 ( .A(n97), .Y(n100) );
  BUFX2M U6 ( .A(n97), .Y(n99) );
  BUFX2M U7 ( .A(n98), .Y(n102) );
  BUFX2M U8 ( .A(n98), .Y(n103) );
  BUFX2M U9 ( .A(rst), .Y(n97) );
  BUFX2M U10 ( .A(rst), .Y(n98) );
  NAND3X2M U11 ( .A(n104), .B(n105), .C(n17), .Y(n16) );
  NAND3X2M U12 ( .A(n104), .B(n105), .C(n12), .Y(n11) );
  NAND3X2M U13 ( .A(w_addr[0]), .B(n12), .C(w_addr[1]), .Y(n15) );
  NAND3X2M U14 ( .A(n12), .B(n105), .C(w_addr[0]), .Y(n13) );
  NOR2BX2M U15 ( .AN(w_en), .B(w_addr[2]), .Y(n12) );
  OAI2BB2X1M U16 ( .B0(n11), .B1(n113), .A0N(\FIFO_MEM[0][0] ), .A1N(n11), .Y(
        n21) );
  OAI2BB2X1M U17 ( .B0(n11), .B1(n112), .A0N(\FIFO_MEM[0][1] ), .A1N(n11), .Y(
        n22) );
  OAI2BB2X1M U18 ( .B0(n11), .B1(n111), .A0N(\FIFO_MEM[0][2] ), .A1N(n11), .Y(
        n23) );
  OAI2BB2X1M U19 ( .B0(n11), .B1(n110), .A0N(\FIFO_MEM[0][3] ), .A1N(n11), .Y(
        n24) );
  OAI2BB2X1M U20 ( .B0(n11), .B1(n109), .A0N(\FIFO_MEM[0][4] ), .A1N(n11), .Y(
        n25) );
  OAI2BB2X1M U21 ( .B0(n11), .B1(n108), .A0N(\FIFO_MEM[0][5] ), .A1N(n11), .Y(
        n26) );
  OAI2BB2X1M U22 ( .B0(n11), .B1(n107), .A0N(\FIFO_MEM[0][6] ), .A1N(n11), .Y(
        n27) );
  OAI2BB2X1M U23 ( .B0(n11), .B1(n106), .A0N(\FIFO_MEM[0][7] ), .A1N(n11), .Y(
        n28) );
  OAI2BB2X1M U24 ( .B0(n113), .B1(n15), .A0N(\FIFO_MEM[3][0] ), .A1N(n15), .Y(
        n45) );
  OAI2BB2X1M U25 ( .B0(n112), .B1(n15), .A0N(\FIFO_MEM[3][1] ), .A1N(n15), .Y(
        n46) );
  OAI2BB2X1M U26 ( .B0(n111), .B1(n15), .A0N(\FIFO_MEM[3][2] ), .A1N(n15), .Y(
        n47) );
  OAI2BB2X1M U27 ( .B0(n110), .B1(n15), .A0N(\FIFO_MEM[3][3] ), .A1N(n15), .Y(
        n48) );
  OAI2BB2X1M U28 ( .B0(n109), .B1(n15), .A0N(\FIFO_MEM[3][4] ), .A1N(n15), .Y(
        n49) );
  OAI2BB2X1M U29 ( .B0(n108), .B1(n15), .A0N(\FIFO_MEM[3][5] ), .A1N(n15), .Y(
        n50) );
  OAI2BB2X1M U30 ( .B0(n107), .B1(n15), .A0N(\FIFO_MEM[3][6] ), .A1N(n15), .Y(
        n51) );
  OAI2BB2X1M U31 ( .B0(n106), .B1(n15), .A0N(\FIFO_MEM[3][7] ), .A1N(n15), .Y(
        n52) );
  OAI2BB2X1M U32 ( .B0(n113), .B1(n13), .A0N(\FIFO_MEM[1][0] ), .A1N(n13), .Y(
        n29) );
  OAI2BB2X1M U33 ( .B0(n112), .B1(n13), .A0N(\FIFO_MEM[1][1] ), .A1N(n13), .Y(
        n30) );
  OAI2BB2X1M U34 ( .B0(n111), .B1(n13), .A0N(\FIFO_MEM[1][2] ), .A1N(n13), .Y(
        n31) );
  OAI2BB2X1M U35 ( .B0(n110), .B1(n13), .A0N(\FIFO_MEM[1][3] ), .A1N(n13), .Y(
        n32) );
  OAI2BB2X1M U36 ( .B0(n109), .B1(n13), .A0N(\FIFO_MEM[1][4] ), .A1N(n13), .Y(
        n33) );
  OAI2BB2X1M U37 ( .B0(n108), .B1(n13), .A0N(\FIFO_MEM[1][5] ), .A1N(n13), .Y(
        n34) );
  OAI2BB2X1M U38 ( .B0(n107), .B1(n13), .A0N(\FIFO_MEM[1][6] ), .A1N(n13), .Y(
        n35) );
  OAI2BB2X1M U39 ( .B0(n106), .B1(n13), .A0N(\FIFO_MEM[1][7] ), .A1N(n13), .Y(
        n36) );
  OAI2BB2X1M U40 ( .B0(n113), .B1(n16), .A0N(\FIFO_MEM[4][0] ), .A1N(n16), .Y(
        n53) );
  OAI2BB2X1M U41 ( .B0(n112), .B1(n16), .A0N(\FIFO_MEM[4][1] ), .A1N(n16), .Y(
        n54) );
  OAI2BB2X1M U42 ( .B0(n111), .B1(n16), .A0N(\FIFO_MEM[4][2] ), .A1N(n16), .Y(
        n55) );
  OAI2BB2X1M U43 ( .B0(n110), .B1(n16), .A0N(\FIFO_MEM[4][3] ), .A1N(n16), .Y(
        n56) );
  OAI2BB2X1M U44 ( .B0(n109), .B1(n16), .A0N(\FIFO_MEM[4][4] ), .A1N(n16), .Y(
        n57) );
  OAI2BB2X1M U45 ( .B0(n108), .B1(n16), .A0N(\FIFO_MEM[4][5] ), .A1N(n16), .Y(
        n58) );
  OAI2BB2X1M U46 ( .B0(n107), .B1(n16), .A0N(\FIFO_MEM[4][6] ), .A1N(n16), .Y(
        n59) );
  OAI2BB2X1M U47 ( .B0(n106), .B1(n16), .A0N(\FIFO_MEM[4][7] ), .A1N(n16), .Y(
        n60) );
  BUFX2M U48 ( .A(n19), .Y(n94) );
  NAND3X2M U49 ( .A(w_addr[1]), .B(n104), .C(n17), .Y(n19) );
  BUFX2M U50 ( .A(n20), .Y(n93) );
  NAND3X2M U51 ( .A(w_addr[1]), .B(w_addr[0]), .C(n17), .Y(n20) );
  OAI2BB2X1M U52 ( .B0(n113), .B1(n96), .A0N(\FIFO_MEM[2][0] ), .A1N(n96), .Y(
        n37) );
  OAI2BB2X1M U53 ( .B0(n112), .B1(n96), .A0N(\FIFO_MEM[2][1] ), .A1N(n96), .Y(
        n38) );
  OAI2BB2X1M U54 ( .B0(n111), .B1(n96), .A0N(\FIFO_MEM[2][2] ), .A1N(n96), .Y(
        n39) );
  OAI2BB2X1M U55 ( .B0(n110), .B1(n96), .A0N(\FIFO_MEM[2][3] ), .A1N(n96), .Y(
        n40) );
  OAI2BB2X1M U56 ( .B0(n109), .B1(n96), .A0N(\FIFO_MEM[2][4] ), .A1N(n96), .Y(
        n41) );
  OAI2BB2X1M U57 ( .B0(n108), .B1(n96), .A0N(\FIFO_MEM[2][5] ), .A1N(n96), .Y(
        n42) );
  OAI2BB2X1M U58 ( .B0(n107), .B1(n96), .A0N(\FIFO_MEM[2][6] ), .A1N(n96), .Y(
        n43) );
  OAI2BB2X1M U59 ( .B0(n106), .B1(n96), .A0N(\FIFO_MEM[2][7] ), .A1N(n96), .Y(
        n44) );
  OAI2BB2X1M U60 ( .B0(n113), .B1(n95), .A0N(\FIFO_MEM[5][0] ), .A1N(n95), .Y(
        n61) );
  OAI2BB2X1M U61 ( .B0(n112), .B1(n95), .A0N(\FIFO_MEM[5][1] ), .A1N(n95), .Y(
        n62) );
  OAI2BB2X1M U62 ( .B0(n111), .B1(n95), .A0N(\FIFO_MEM[5][2] ), .A1N(n95), .Y(
        n63) );
  OAI2BB2X1M U63 ( .B0(n110), .B1(n95), .A0N(\FIFO_MEM[5][3] ), .A1N(n95), .Y(
        n64) );
  OAI2BB2X1M U64 ( .B0(n109), .B1(n95), .A0N(\FIFO_MEM[5][4] ), .A1N(n95), .Y(
        n65) );
  OAI2BB2X1M U65 ( .B0(n108), .B1(n95), .A0N(\FIFO_MEM[5][5] ), .A1N(n95), .Y(
        n66) );
  OAI2BB2X1M U66 ( .B0(n107), .B1(n95), .A0N(\FIFO_MEM[5][6] ), .A1N(n95), .Y(
        n67) );
  OAI2BB2X1M U67 ( .B0(n106), .B1(n95), .A0N(\FIFO_MEM[5][7] ), .A1N(n95), .Y(
        n68) );
  OAI2BB2X1M U68 ( .B0(n113), .B1(n94), .A0N(\FIFO_MEM[6][0] ), .A1N(n94), .Y(
        n69) );
  OAI2BB2X1M U69 ( .B0(n112), .B1(n94), .A0N(\FIFO_MEM[6][1] ), .A1N(n94), .Y(
        n70) );
  OAI2BB2X1M U70 ( .B0(n111), .B1(n94), .A0N(\FIFO_MEM[6][2] ), .A1N(n94), .Y(
        n71) );
  OAI2BB2X1M U71 ( .B0(n110), .B1(n94), .A0N(\FIFO_MEM[6][3] ), .A1N(n94), .Y(
        n72) );
  OAI2BB2X1M U72 ( .B0(n109), .B1(n94), .A0N(\FIFO_MEM[6][4] ), .A1N(n94), .Y(
        n73) );
  OAI2BB2X1M U73 ( .B0(n108), .B1(n94), .A0N(\FIFO_MEM[6][5] ), .A1N(n94), .Y(
        n74) );
  OAI2BB2X1M U74 ( .B0(n107), .B1(n94), .A0N(\FIFO_MEM[6][6] ), .A1N(n94), .Y(
        n75) );
  OAI2BB2X1M U75 ( .B0(n106), .B1(n94), .A0N(\FIFO_MEM[6][7] ), .A1N(n94), .Y(
        n76) );
  OAI2BB2X1M U76 ( .B0(n113), .B1(n93), .A0N(\FIFO_MEM[7][0] ), .A1N(n93), .Y(
        n77) );
  OAI2BB2X1M U77 ( .B0(n112), .B1(n93), .A0N(\FIFO_MEM[7][1] ), .A1N(n93), .Y(
        n78) );
  OAI2BB2X1M U78 ( .B0(n111), .B1(n93), .A0N(\FIFO_MEM[7][2] ), .A1N(n93), .Y(
        n79) );
  OAI2BB2X1M U79 ( .B0(n110), .B1(n93), .A0N(\FIFO_MEM[7][3] ), .A1N(n93), .Y(
        n80) );
  OAI2BB2X1M U80 ( .B0(n109), .B1(n93), .A0N(\FIFO_MEM[7][4] ), .A1N(n93), .Y(
        n81) );
  OAI2BB2X1M U81 ( .B0(n108), .B1(n93), .A0N(\FIFO_MEM[7][5] ), .A1N(n93), .Y(
        n82) );
  OAI2BB2X1M U82 ( .B0(n107), .B1(n93), .A0N(\FIFO_MEM[7][6] ), .A1N(n93), .Y(
        n83) );
  OAI2BB2X1M U83 ( .B0(n106), .B1(n93), .A0N(\FIFO_MEM[7][7] ), .A1N(n93), .Y(
        n84) );
  INVX2M U84 ( .A(w_data[0]), .Y(n113) );
  INVX2M U85 ( .A(w_data[1]), .Y(n112) );
  INVX2M U86 ( .A(w_data[2]), .Y(n111) );
  INVX2M U87 ( .A(w_data[3]), .Y(n110) );
  INVX2M U88 ( .A(w_data[4]), .Y(n109) );
  INVX2M U89 ( .A(w_data[5]), .Y(n108) );
  INVX2M U90 ( .A(w_data[6]), .Y(n107) );
  INVX2M U91 ( .A(w_data[7]), .Y(n106) );
  AND2X2M U92 ( .A(w_addr[2]), .B(w_en), .Y(n17) );
  NAND3X2M U93 ( .A(n12), .B(n104), .C(w_addr[1]), .Y(n14) );
  NAND3X2M U94 ( .A(w_addr[0]), .B(n105), .C(n17), .Y(n18) );
  INVX2M U95 ( .A(w_addr[1]), .Y(n105) );
  INVX2M U96 ( .A(w_addr[0]), .Y(n104) );
  MX2X2M U97 ( .A(n88), .B(n87), .S0(N12), .Y(r_data[6]) );
  MX4X1M U98 ( .A(\FIFO_MEM[0][6] ), .B(\FIFO_MEM[1][6] ), .C(\FIFO_MEM[2][6] ), .D(\FIFO_MEM[3][6] ), .S0(n92), .S1(N11), .Y(n88) );
  MX4X1M U99 ( .A(\FIFO_MEM[4][6] ), .B(\FIFO_MEM[5][6] ), .C(\FIFO_MEM[6][6] ), .D(\FIFO_MEM[7][6] ), .S0(n91), .S1(N11), .Y(n87) );
  MX2X2M U100 ( .A(n6), .B(n5), .S0(N12), .Y(r_data[2]) );
  MX4X1M U101 ( .A(\FIFO_MEM[0][2] ), .B(\FIFO_MEM[1][2] ), .C(
        \FIFO_MEM[2][2] ), .D(\FIFO_MEM[3][2] ), .S0(n92), .S1(N11), .Y(n6) );
  MX4X1M U102 ( .A(\FIFO_MEM[4][2] ), .B(\FIFO_MEM[5][2] ), .C(
        \FIFO_MEM[6][2] ), .D(\FIFO_MEM[7][2] ), .S0(n91), .S1(N11), .Y(n5) );
  MX2X2M U103 ( .A(n8), .B(n7), .S0(N12), .Y(r_data[3]) );
  MX4X1M U104 ( .A(\FIFO_MEM[0][3] ), .B(\FIFO_MEM[1][3] ), .C(
        \FIFO_MEM[2][3] ), .D(\FIFO_MEM[3][3] ), .S0(n92), .S1(N11), .Y(n8) );
  MX4X1M U105 ( .A(\FIFO_MEM[4][3] ), .B(\FIFO_MEM[5][3] ), .C(
        \FIFO_MEM[6][3] ), .D(\FIFO_MEM[7][3] ), .S0(n91), .S1(N11), .Y(n7) );
  MX2X2M U106 ( .A(n90), .B(n89), .S0(N12), .Y(r_data[7]) );
  MX4X1M U107 ( .A(\FIFO_MEM[0][7] ), .B(\FIFO_MEM[1][7] ), .C(
        \FIFO_MEM[2][7] ), .D(\FIFO_MEM[3][7] ), .S0(n92), .S1(N11), .Y(n90)
         );
  MX4X1M U108 ( .A(\FIFO_MEM[4][7] ), .B(\FIFO_MEM[5][7] ), .C(
        \FIFO_MEM[6][7] ), .D(\FIFO_MEM[7][7] ), .S0(n91), .S1(N11), .Y(n89)
         );
  MX2X2M U109 ( .A(n10), .B(n9), .S0(N12), .Y(r_data[4]) );
  MX4X1M U110 ( .A(\FIFO_MEM[0][4] ), .B(\FIFO_MEM[1][4] ), .C(
        \FIFO_MEM[2][4] ), .D(\FIFO_MEM[3][4] ), .S0(n92), .S1(N11), .Y(n10)
         );
  MX4X1M U111 ( .A(\FIFO_MEM[4][4] ), .B(\FIFO_MEM[5][4] ), .C(
        \FIFO_MEM[6][4] ), .D(\FIFO_MEM[7][4] ), .S0(n91), .S1(N11), .Y(n9) );
  MX2X2M U112 ( .A(n2), .B(n1), .S0(N12), .Y(r_data[0]) );
  MX4X1M U113 ( .A(\FIFO_MEM[0][0] ), .B(\FIFO_MEM[1][0] ), .C(
        \FIFO_MEM[2][0] ), .D(\FIFO_MEM[3][0] ), .S0(n92), .S1(N11), .Y(n2) );
  MX4X1M U114 ( .A(\FIFO_MEM[4][0] ), .B(\FIFO_MEM[5][0] ), .C(
        \FIFO_MEM[6][0] ), .D(\FIFO_MEM[7][0] ), .S0(n91), .S1(N11), .Y(n1) );
  MX2X2M U115 ( .A(n86), .B(n85), .S0(N12), .Y(r_data[5]) );
  MX4X1M U116 ( .A(\FIFO_MEM[0][5] ), .B(\FIFO_MEM[1][5] ), .C(
        \FIFO_MEM[2][5] ), .D(\FIFO_MEM[3][5] ), .S0(n92), .S1(N11), .Y(n86)
         );
  MX4X1M U117 ( .A(\FIFO_MEM[4][5] ), .B(\FIFO_MEM[5][5] ), .C(
        \FIFO_MEM[6][5] ), .D(\FIFO_MEM[7][5] ), .S0(n91), .S1(N11), .Y(n85)
         );
  MX2X2M U118 ( .A(n4), .B(n3), .S0(N12), .Y(r_data[1]) );
  MX4X1M U119 ( .A(\FIFO_MEM[0][1] ), .B(\FIFO_MEM[1][1] ), .C(
        \FIFO_MEM[2][1] ), .D(\FIFO_MEM[3][1] ), .S0(n92), .S1(N11), .Y(n4) );
  MX4X1M U120 ( .A(\FIFO_MEM[4][1] ), .B(\FIFO_MEM[5][1] ), .C(
        \FIFO_MEM[6][1] ), .D(\FIFO_MEM[7][1] ), .S0(n91), .S1(N11), .Y(n3) );
  BUFX2M U121 ( .A(N10), .Y(n91) );
  BUFX2M U122 ( .A(N10), .Y(n92) );
endmodule


module binary_to_gray_POINTER_WIDTH4_0 ( binary, gray );
  input [3:0] binary;
  output [3:0] gray;
  wire   \binary[3] ;
  assign gray[3] = \binary[3] ;
  assign \binary[3]  = binary[3];

  CLKXOR2X2M U1 ( .A(binary[1]), .B(binary[0]), .Y(gray[0]) );
  CLKXOR2X2M U2 ( .A(binary[2]), .B(binary[1]), .Y(gray[1]) );
  CLKXOR2X2M U3 ( .A(\binary[3] ), .B(binary[2]), .Y(gray[2]) );
endmodule


module FIFO_rptr_POINTER_WIDTH4 ( r_clk, rrst_n, rinc, rempty, r_addr, 
        gray_rptr, gray_wptr );
  output [2:0] r_addr;
  output [3:0] gray_rptr;
  input [3:0] gray_wptr;
  input r_clk, rrst_n, rinc;
  output rempty;
  wire   \rptr[3] , n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14;

  binary_to_gray_POINTER_WIDTH4_0 b2g ( .binary({\rptr[3] , r_addr}), .gray(
        gray_rptr) );
  DFFRQX2M \rptr_reg[3]  ( .D(n11), .CK(r_clk), .RN(rrst_n), .Q(\rptr[3] ) );
  DFFRQX2M \rptr_reg[0]  ( .D(n14), .CK(r_clk), .RN(rrst_n), .Q(r_addr[0]) );
  DFFRQX2M \rptr_reg[2]  ( .D(n12), .CK(r_clk), .RN(rrst_n), .Q(r_addr[2]) );
  DFFRQX2M \rptr_reg[1]  ( .D(n13), .CK(r_clk), .RN(rrst_n), .Q(r_addr[1]) );
  INVX2M U3 ( .A(n2), .Y(rempty) );
  XNOR2X2M U4 ( .A(gray_wptr[1]), .B(gray_rptr[1]), .Y(n7) );
  NAND4X2M U5 ( .A(n7), .B(n8), .C(n9), .D(n10), .Y(n2) );
  XNOR2X2M U6 ( .A(gray_wptr[3]), .B(gray_rptr[3]), .Y(n9) );
  XNOR2X2M U7 ( .A(gray_wptr[2]), .B(gray_rptr[2]), .Y(n10) );
  XNOR2X2M U8 ( .A(gray_wptr[0]), .B(gray_rptr[0]), .Y(n8) );
  NOR2BX2M U9 ( .AN(r_addr[0]), .B(n6), .Y(n5) );
  XNOR2X2M U10 ( .A(r_addr[2]), .B(n4), .Y(n12) );
  XNOR2X2M U11 ( .A(r_addr[0]), .B(n6), .Y(n14) );
  NAND2X2M U12 ( .A(r_addr[1]), .B(n5), .Y(n4) );
  NAND2X2M U13 ( .A(rinc), .B(n2), .Y(n6) );
  CLKXOR2X2M U14 ( .A(r_addr[1]), .B(n5), .Y(n13) );
  CLKXOR2X2M U15 ( .A(\rptr[3] ), .B(n3), .Y(n11) );
  NOR2BX2M U16 ( .AN(r_addr[2]), .B(n4), .Y(n3) );
endmodule


module binary_to_gray_POINTER_WIDTH4_1 ( binary, gray );
  input [3:0] binary;
  output [3:0] gray;
  wire   \binary[3] ;
  assign gray[3] = \binary[3] ;
  assign \binary[3]  = binary[3];

  CLKXOR2X2M U1 ( .A(\binary[3] ), .B(binary[2]), .Y(gray[2]) );
  CLKXOR2X2M U2 ( .A(binary[1]), .B(binary[0]), .Y(gray[0]) );
  CLKXOR2X2M U3 ( .A(binary[2]), .B(binary[1]), .Y(gray[1]) );
endmodule


module FIFO_wptr_POINTER_WIDTH4 ( w_clk, wrst_n, winc, wfull, waddr, gray_wptr, 
        gray_rptr );
  output [2:0] waddr;
  output [3:0] gray_wptr;
  input [3:0] gray_rptr;
  input w_clk, wrst_n, winc;
  output wfull;
  wire   \wptr[3] , n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14;

  binary_to_gray_POINTER_WIDTH4_1 b2g ( .binary({\wptr[3] , waddr}), .gray(
        gray_wptr) );
  DFFRQX2M \wptr_reg[3]  ( .D(n11), .CK(w_clk), .RN(wrst_n), .Q(\wptr[3] ) );
  DFFRQX2M \wptr_reg[2]  ( .D(n12), .CK(w_clk), .RN(wrst_n), .Q(waddr[2]) );
  DFFRQX2M \wptr_reg[0]  ( .D(n14), .CK(w_clk), .RN(wrst_n), .Q(waddr[0]) );
  DFFRQX2M \wptr_reg[1]  ( .D(n13), .CK(w_clk), .RN(wrst_n), .Q(waddr[1]) );
  INVX2M U3 ( .A(n2), .Y(wfull) );
  NAND2X2M U4 ( .A(winc), .B(n2), .Y(n6) );
  XNOR2X2M U5 ( .A(gray_wptr[1]), .B(gray_rptr[1]), .Y(n7) );
  NOR2BX2M U6 ( .AN(waddr[0]), .B(n6), .Y(n5) );
  XNOR2X2M U7 ( .A(waddr[2]), .B(n4), .Y(n12) );
  NAND4X2M U8 ( .A(n7), .B(n8), .C(n9), .D(n10), .Y(n2) );
  CLKXOR2X2M U9 ( .A(gray_wptr[3]), .B(gray_rptr[3]), .Y(n10) );
  CLKXOR2X2M U10 ( .A(gray_wptr[2]), .B(gray_rptr[2]), .Y(n9) );
  XNOR2X2M U11 ( .A(gray_wptr[0]), .B(gray_rptr[0]), .Y(n8) );
  NAND2X2M U12 ( .A(waddr[1]), .B(n5), .Y(n4) );
  CLKXOR2X2M U13 ( .A(waddr[1]), .B(n5), .Y(n13) );
  CLKXOR2X2M U14 ( .A(\wptr[3] ), .B(n3), .Y(n11) );
  NOR2BX2M U15 ( .AN(waddr[2]), .B(n4), .Y(n3) );
  XNOR2X2M U16 ( .A(waddr[0]), .B(n6), .Y(n14) );
endmodule


module BIT_SYNC_N2_8 ( clk, rst, IN, OUT );
  input clk, rst, IN;
  output OUT;
  wire   \stage[0] ;

  DFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .CK(clk), .RN(rst), .Q(OUT) );
  DFFRQX2M \stage_reg[0]  ( .D(IN), .CK(clk), .RN(rst), .Q(\stage[0] ) );
endmodule


module BIT_SYNC_N2_7 ( clk, rst, IN, OUT );
  input clk, rst, IN;
  output OUT;
  wire   \stage[0] ;

  DFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .CK(clk), .RN(rst), .Q(OUT) );
  DFFRQX2M \stage_reg[0]  ( .D(IN), .CK(clk), .RN(rst), .Q(\stage[0] ) );
endmodule


module BIT_SYNC_N2_6 ( clk, rst, IN, OUT );
  input clk, rst, IN;
  output OUT;
  wire   \stage[0] ;

  DFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .CK(clk), .RN(rst), .Q(OUT) );
  DFFRQX2M \stage_reg[0]  ( .D(IN), .CK(clk), .RN(rst), .Q(\stage[0] ) );
endmodule


module BIT_SYNC_N2_5 ( clk, rst, IN, OUT );
  input clk, rst, IN;
  output OUT;
  wire   \stage[0] ;

  DFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .CK(clk), .RN(rst), .Q(OUT) );
  DFFRQX2M \stage_reg[0]  ( .D(IN), .CK(clk), .RN(rst), .Q(\stage[0] ) );
endmodule


module BUS_SYNC_N2_POINTER_WIDTH4_0 ( clk, rst, IN, OUT );
  input [3:0] IN;
  output [3:0] OUT;
  input clk, rst;


  BIT_SYNC_N2_8 \BIT_SYNC_INST[0].BIT_SYNC_i  ( .clk(clk), .rst(rst), .IN(
        IN[0]), .OUT(OUT[0]) );
  BIT_SYNC_N2_7 \BIT_SYNC_INST[1].BIT_SYNC_i  ( .clk(clk), .rst(rst), .IN(
        IN[1]), .OUT(OUT[1]) );
  BIT_SYNC_N2_6 \BIT_SYNC_INST[2].BIT_SYNC_i  ( .clk(clk), .rst(rst), .IN(
        IN[2]), .OUT(OUT[2]) );
  BIT_SYNC_N2_5 \BIT_SYNC_INST[3].BIT_SYNC_i  ( .clk(clk), .rst(rst), .IN(
        IN[3]), .OUT(OUT[3]) );
endmodule


module BIT_SYNC_N2_4 ( clk, rst, IN, OUT );
  input clk, rst, IN;
  output OUT;
  wire   \stage[0] ;

  DFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .CK(clk), .RN(rst), .Q(OUT) );
  DFFRQX2M \stage_reg[0]  ( .D(IN), .CK(clk), .RN(rst), .Q(\stage[0] ) );
endmodule


module BIT_SYNC_N2_3 ( clk, rst, IN, OUT );
  input clk, rst, IN;
  output OUT;
  wire   \stage[0] ;

  DFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .CK(clk), .RN(rst), .Q(OUT) );
  DFFRQX2M \stage_reg[0]  ( .D(IN), .CK(clk), .RN(rst), .Q(\stage[0] ) );
endmodule


module BIT_SYNC_N2_2 ( clk, rst, IN, OUT );
  input clk, rst, IN;
  output OUT;
  wire   \stage[0] ;

  DFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .CK(clk), .RN(rst), .Q(OUT) );
  DFFRQX2M \stage_reg[0]  ( .D(IN), .CK(clk), .RN(rst), .Q(\stage[0] ) );
endmodule


module BIT_SYNC_N2_1 ( clk, rst, IN, OUT );
  input clk, rst, IN;
  output OUT;
  wire   \stage[0] ;

  DFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .CK(clk), .RN(rst), .Q(OUT) );
  DFFRQX2M \stage_reg[0]  ( .D(IN), .CK(clk), .RN(rst), .Q(\stage[0] ) );
endmodule


module BUS_SYNC_N2_POINTER_WIDTH4_1 ( clk, rst, IN, OUT );
  input [3:0] IN;
  output [3:0] OUT;
  input clk, rst;


  BIT_SYNC_N2_4 \BIT_SYNC_INST[0].BIT_SYNC_i  ( .clk(clk), .rst(rst), .IN(
        IN[0]), .OUT(OUT[0]) );
  BIT_SYNC_N2_3 \BIT_SYNC_INST[1].BIT_SYNC_i  ( .clk(clk), .rst(rst), .IN(
        IN[1]), .OUT(OUT[1]) );
  BIT_SYNC_N2_2 \BIT_SYNC_INST[2].BIT_SYNC_i  ( .clk(clk), .rst(rst), .IN(
        IN[2]), .OUT(OUT[2]) );
  BIT_SYNC_N2_1 \BIT_SYNC_INST[3].BIT_SYNC_i  ( .clk(clk), .rst(rst), .IN(
        IN[3]), .OUT(OUT[3]) );
endmodule


module FIFO_TOP ( w_data, winc, w_clk, wrst_n, wfull, r_data, rinc, rempty, 
        r_clk, rrst_n );
  input [7:0] w_data;
  output [7:0] r_data;
  input winc, w_clk, wrst_n, rinc, r_clk, rrst_n;
  output wfull, rempty;
  wire   wclken, n1, n2;
  wire   [2:0] w_addr;
  wire   [2:0] r_addr;
  wire   [3:0] gray_rptr;
  wire   [3:0] gray_wptr_afterSYNC;
  wire   [3:0] gray_wptr;
  wire   [3:0] gray_rptr_afterSYNC;

  FIFO_Memory_FIFO_DEPTH8_DATA_WIDTH8 FIFO_Memory ( .w_clk(w_clk), .rst(n1), 
        .w_data(w_data), .w_en(wclken), .w_addr(w_addr), .r_addr(r_addr), 
        .r_data(r_data) );
  FIFO_rptr_POINTER_WIDTH4 FIFO_rptr ( .r_clk(r_clk), .rrst_n(rrst_n), .rinc(
        rinc), .rempty(rempty), .r_addr(r_addr), .gray_rptr(gray_rptr), 
        .gray_wptr(gray_wptr_afterSYNC) );
  FIFO_wptr_POINTER_WIDTH4 FIFO_wptr ( .w_clk(w_clk), .wrst_n(n1), .winc(winc), 
        .wfull(wfull), .waddr(w_addr), .gray_wptr(gray_wptr), .gray_rptr(
        gray_rptr_afterSYNC) );
  BUS_SYNC_N2_POINTER_WIDTH4_0 BUS_SYNC_w2r ( .clk(r_clk), .rst(rrst_n), .IN(
        gray_wptr), .OUT(gray_wptr_afterSYNC) );
  BUS_SYNC_N2_POINTER_WIDTH4_1 BUS_SYNC_r2w ( .clk(w_clk), .rst(n1), .IN(
        gray_rptr), .OUT(gray_rptr_afterSYNC) );
  NOR2BX2M U1 ( .AN(winc), .B(wfull), .Y(wclken) );
  INVX2M U2 ( .A(n2), .Y(n1) );
  INVX2M U3 ( .A(wrst_n), .Y(n2) );
endmodule


module RegFile ( CLK, RST, WrEn, RdEn, Address, WrData, RdData, RdData_VLD, 
        REG0, REG1, REG2, REG3 );
  input [3:0] Address;
  input [7:0] WrData;
  output [7:0] RdData;
  output [7:0] REG0;
  output [7:0] REG1;
  output [7:0] REG2;
  output [7:0] REG3;
  input CLK, RST, WrEn, RdEn;
  output RdData_VLD;
  wire   N11, N12, N13, N14, \regArr[15][7] , \regArr[15][6] , \regArr[15][5] ,
         \regArr[15][4] , \regArr[15][3] , \regArr[15][2] , \regArr[15][1] ,
         \regArr[15][0] , \regArr[14][7] , \regArr[14][6] , \regArr[14][5] ,
         \regArr[14][4] , \regArr[14][3] , \regArr[14][2] , \regArr[14][1] ,
         \regArr[14][0] , \regArr[13][7] , \regArr[13][6] , \regArr[13][5] ,
         \regArr[13][4] , \regArr[13][3] , \regArr[13][2] , \regArr[13][1] ,
         \regArr[13][0] , \regArr[12][7] , \regArr[12][6] , \regArr[12][5] ,
         \regArr[12][4] , \regArr[12][3] , \regArr[12][2] , \regArr[12][1] ,
         \regArr[12][0] , \regArr[11][7] , \regArr[11][6] , \regArr[11][5] ,
         \regArr[11][4] , \regArr[11][3] , \regArr[11][2] , \regArr[11][1] ,
         \regArr[11][0] , \regArr[10][7] , \regArr[10][6] , \regArr[10][5] ,
         \regArr[10][4] , \regArr[10][3] , \regArr[10][2] , \regArr[10][1] ,
         \regArr[10][0] , \regArr[9][7] , \regArr[9][6] , \regArr[9][5] ,
         \regArr[9][4] , \regArr[9][3] , \regArr[9][2] , \regArr[9][1] ,
         \regArr[9][0] , \regArr[8][7] , \regArr[8][6] , \regArr[8][5] ,
         \regArr[8][4] , \regArr[8][3] , \regArr[8][2] , \regArr[8][1] ,
         \regArr[8][0] , \regArr[7][7] , \regArr[7][6] , \regArr[7][5] ,
         \regArr[7][4] , \regArr[7][3] , \regArr[7][2] , \regArr[7][1] ,
         \regArr[7][0] , \regArr[6][7] , \regArr[6][6] , \regArr[6][5] ,
         \regArr[6][4] , \regArr[6][3] , \regArr[6][2] , \regArr[6][1] ,
         \regArr[6][0] , \regArr[5][7] , \regArr[5][6] , \regArr[5][5] ,
         \regArr[5][4] , \regArr[5][3] , \regArr[5][2] , \regArr[5][1] ,
         \regArr[5][0] , \regArr[4][7] , \regArr[4][6] , \regArr[4][5] ,
         \regArr[4][4] , \regArr[4][3] , \regArr[4][2] , \regArr[4][1] ,
         \regArr[4][0] , N36, N37, N38, N39, N40, N41, N42, N43, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70,
         n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98,
         n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126, n127, n128, n129, n130, n131, n132,
         n133, n134, n135, n136, n137, n138, n139, n140, n141, n142, n143,
         n144, n145, n146, n147, n148, n149, n150, n151, n152, n153, n154,
         n155, n156, n157, n158, n159, n160, n161, n162, n163, n164, n165,
         n166, n167, n168, n169, n170, n171, n172, n173, n174, n175, n176, n1,
         n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n177, n178, n179, n180,
         n181, n182, n183, n184, n185, n186, n187, n188, n189, n190, n191,
         n192, n193, n194, n195, n196, n197, n198, n199, n200, n201, n202,
         n203, n204, n205, n206, n207, n208, n209, n210, n211, n212, n213,
         n214, n215, n216, n217, n218, n219, n220, n221, n222, n223, n224,
         n225, n226, n227;
  assign N11 = Address[0];
  assign N12 = Address[1];
  assign N13 = Address[2];
  assign N14 = Address[3];

  DFFSQX2M \regArr_reg[3][5]  ( .D(n78), .CK(CLK), .SN(n204), .Q(REG3[5]) );
  DFFRQX2M \regArr_reg[13][7]  ( .D(n160), .CK(CLK), .RN(n212), .Q(
        \regArr[13][7] ) );
  DFFRQX2M \regArr_reg[13][6]  ( .D(n159), .CK(CLK), .RN(n212), .Q(
        \regArr[13][6] ) );
  DFFRQX2M \regArr_reg[13][5]  ( .D(n158), .CK(CLK), .RN(n211), .Q(
        \regArr[13][5] ) );
  DFFRQX2M \regArr_reg[13][4]  ( .D(n157), .CK(CLK), .RN(n211), .Q(
        \regArr[13][4] ) );
  DFFRQX2M \regArr_reg[13][3]  ( .D(n156), .CK(CLK), .RN(n211), .Q(
        \regArr[13][3] ) );
  DFFRQX2M \regArr_reg[13][2]  ( .D(n155), .CK(CLK), .RN(n211), .Q(
        \regArr[13][2] ) );
  DFFRQX2M \regArr_reg[13][1]  ( .D(n154), .CK(CLK), .RN(n211), .Q(
        \regArr[13][1] ) );
  DFFRQX2M \regArr_reg[13][0]  ( .D(n153), .CK(CLK), .RN(n211), .Q(
        \regArr[13][0] ) );
  DFFRQX2M \regArr_reg[9][7]  ( .D(n128), .CK(CLK), .RN(n209), .Q(
        \regArr[9][7] ) );
  DFFRQX2M \regArr_reg[9][6]  ( .D(n127), .CK(CLK), .RN(n209), .Q(
        \regArr[9][6] ) );
  DFFRQX2M \regArr_reg[9][5]  ( .D(n126), .CK(CLK), .RN(n209), .Q(
        \regArr[9][5] ) );
  DFFRQX2M \regArr_reg[9][4]  ( .D(n125), .CK(CLK), .RN(n209), .Q(
        \regArr[9][4] ) );
  DFFRQX2M \regArr_reg[9][3]  ( .D(n124), .CK(CLK), .RN(n209), .Q(
        \regArr[9][3] ) );
  DFFRQX2M \regArr_reg[9][2]  ( .D(n123), .CK(CLK), .RN(n209), .Q(
        \regArr[9][2] ) );
  DFFRQX2M \regArr_reg[9][1]  ( .D(n122), .CK(CLK), .RN(n209), .Q(
        \regArr[9][1] ) );
  DFFRQX2M \regArr_reg[9][0]  ( .D(n121), .CK(CLK), .RN(n209), .Q(
        \regArr[9][0] ) );
  DFFRQX2M \regArr_reg[5][7]  ( .D(n96), .CK(CLK), .RN(n207), .Q(
        \regArr[5][7] ) );
  DFFRQX2M \regArr_reg[5][6]  ( .D(n95), .CK(CLK), .RN(n207), .Q(
        \regArr[5][6] ) );
  DFFRQX2M \regArr_reg[5][5]  ( .D(n94), .CK(CLK), .RN(n207), .Q(
        \regArr[5][5] ) );
  DFFRQX2M \regArr_reg[5][4]  ( .D(n93), .CK(CLK), .RN(n207), .Q(
        \regArr[5][4] ) );
  DFFRQX2M \regArr_reg[5][3]  ( .D(n92), .CK(CLK), .RN(n207), .Q(
        \regArr[5][3] ) );
  DFFRQX2M \regArr_reg[5][2]  ( .D(n91), .CK(CLK), .RN(n207), .Q(
        \regArr[5][2] ) );
  DFFRQX2M \regArr_reg[5][1]  ( .D(n90), .CK(CLK), .RN(n207), .Q(
        \regArr[5][1] ) );
  DFFRQX2M \regArr_reg[5][0]  ( .D(n89), .CK(CLK), .RN(n207), .Q(
        \regArr[5][0] ) );
  DFFRQX2M \regArr_reg[15][7]  ( .D(n176), .CK(CLK), .RN(n204), .Q(
        \regArr[15][7] ) );
  DFFRQX2M \regArr_reg[15][6]  ( .D(n175), .CK(CLK), .RN(n213), .Q(
        \regArr[15][6] ) );
  DFFRQX2M \regArr_reg[15][5]  ( .D(n174), .CK(CLK), .RN(n213), .Q(
        \regArr[15][5] ) );
  DFFRQX2M \regArr_reg[15][4]  ( .D(n173), .CK(CLK), .RN(n212), .Q(
        \regArr[15][4] ) );
  DFFRQX2M \regArr_reg[15][3]  ( .D(n172), .CK(CLK), .RN(n212), .Q(
        \regArr[15][3] ) );
  DFFRQX2M \regArr_reg[15][2]  ( .D(n171), .CK(CLK), .RN(n212), .Q(
        \regArr[15][2] ) );
  DFFRQX2M \regArr_reg[15][1]  ( .D(n170), .CK(CLK), .RN(n212), .Q(
        \regArr[15][1] ) );
  DFFRQX2M \regArr_reg[15][0]  ( .D(n169), .CK(CLK), .RN(n212), .Q(
        \regArr[15][0] ) );
  DFFRQX2M \regArr_reg[11][7]  ( .D(n144), .CK(CLK), .RN(n211), .Q(
        \regArr[11][7] ) );
  DFFRQX2M \regArr_reg[11][6]  ( .D(n143), .CK(CLK), .RN(n210), .Q(
        \regArr[11][6] ) );
  DFFRQX2M \regArr_reg[11][5]  ( .D(n142), .CK(CLK), .RN(n210), .Q(
        \regArr[11][5] ) );
  DFFRQX2M \regArr_reg[11][4]  ( .D(n141), .CK(CLK), .RN(n210), .Q(
        \regArr[11][4] ) );
  DFFRQX2M \regArr_reg[11][3]  ( .D(n140), .CK(CLK), .RN(n210), .Q(
        \regArr[11][3] ) );
  DFFRQX2M \regArr_reg[11][2]  ( .D(n139), .CK(CLK), .RN(n210), .Q(
        \regArr[11][2] ) );
  DFFRQX2M \regArr_reg[11][1]  ( .D(n138), .CK(CLK), .RN(n210), .Q(
        \regArr[11][1] ) );
  DFFRQX2M \regArr_reg[11][0]  ( .D(n137), .CK(CLK), .RN(n210), .Q(
        \regArr[11][0] ) );
  DFFRQX2M \regArr_reg[7][7]  ( .D(n112), .CK(CLK), .RN(n208), .Q(
        \regArr[7][7] ) );
  DFFRQX2M \regArr_reg[7][6]  ( .D(n111), .CK(CLK), .RN(n208), .Q(
        \regArr[7][6] ) );
  DFFRQX2M \regArr_reg[7][5]  ( .D(n110), .CK(CLK), .RN(n208), .Q(
        \regArr[7][5] ) );
  DFFRQX2M \regArr_reg[7][4]  ( .D(n109), .CK(CLK), .RN(n208), .Q(
        \regArr[7][4] ) );
  DFFRQX2M \regArr_reg[7][3]  ( .D(n108), .CK(CLK), .RN(n208), .Q(
        \regArr[7][3] ) );
  DFFRQX2M \regArr_reg[7][2]  ( .D(n107), .CK(CLK), .RN(n208), .Q(
        \regArr[7][2] ) );
  DFFRQX2M \regArr_reg[7][1]  ( .D(n106), .CK(CLK), .RN(n208), .Q(
        \regArr[7][1] ) );
  DFFRQX2M \regArr_reg[7][0]  ( .D(n105), .CK(CLK), .RN(n208), .Q(
        \regArr[7][0] ) );
  DFFRQX2M \regArr_reg[14][7]  ( .D(n168), .CK(CLK), .RN(n212), .Q(
        \regArr[14][7] ) );
  DFFRQX2M \regArr_reg[14][6]  ( .D(n167), .CK(CLK), .RN(n212), .Q(
        \regArr[14][6] ) );
  DFFRQX2M \regArr_reg[14][5]  ( .D(n166), .CK(CLK), .RN(n212), .Q(
        \regArr[14][5] ) );
  DFFRQX2M \regArr_reg[14][4]  ( .D(n165), .CK(CLK), .RN(n212), .Q(
        \regArr[14][4] ) );
  DFFRQX2M \regArr_reg[14][3]  ( .D(n164), .CK(CLK), .RN(n212), .Q(
        \regArr[14][3] ) );
  DFFRQX2M \regArr_reg[14][2]  ( .D(n163), .CK(CLK), .RN(n212), .Q(
        \regArr[14][2] ) );
  DFFRQX2M \regArr_reg[14][1]  ( .D(n162), .CK(CLK), .RN(n212), .Q(
        \regArr[14][1] ) );
  DFFRQX2M \regArr_reg[14][0]  ( .D(n161), .CK(CLK), .RN(n212), .Q(
        \regArr[14][0] ) );
  DFFRQX2M \regArr_reg[10][7]  ( .D(n136), .CK(CLK), .RN(n210), .Q(
        \regArr[10][7] ) );
  DFFRQX2M \regArr_reg[10][6]  ( .D(n135), .CK(CLK), .RN(n210), .Q(
        \regArr[10][6] ) );
  DFFRQX2M \regArr_reg[10][5]  ( .D(n134), .CK(CLK), .RN(n210), .Q(
        \regArr[10][5] ) );
  DFFRQX2M \regArr_reg[10][4]  ( .D(n133), .CK(CLK), .RN(n210), .Q(
        \regArr[10][4] ) );
  DFFRQX2M \regArr_reg[10][3]  ( .D(n132), .CK(CLK), .RN(n210), .Q(
        \regArr[10][3] ) );
  DFFRQX2M \regArr_reg[10][2]  ( .D(n131), .CK(CLK), .RN(n210), .Q(
        \regArr[10][2] ) );
  DFFRQX2M \regArr_reg[10][1]  ( .D(n130), .CK(CLK), .RN(n210), .Q(
        \regArr[10][1] ) );
  DFFRQX2M \regArr_reg[10][0]  ( .D(n129), .CK(CLK), .RN(n210), .Q(
        \regArr[10][0] ) );
  DFFRQX2M \regArr_reg[6][7]  ( .D(n104), .CK(CLK), .RN(n208), .Q(
        \regArr[6][7] ) );
  DFFRQX2M \regArr_reg[6][6]  ( .D(n103), .CK(CLK), .RN(n208), .Q(
        \regArr[6][6] ) );
  DFFRQX2M \regArr_reg[6][5]  ( .D(n102), .CK(CLK), .RN(n208), .Q(
        \regArr[6][5] ) );
  DFFRQX2M \regArr_reg[6][4]  ( .D(n101), .CK(CLK), .RN(n208), .Q(
        \regArr[6][4] ) );
  DFFRQX2M \regArr_reg[6][3]  ( .D(n100), .CK(CLK), .RN(n208), .Q(
        \regArr[6][3] ) );
  DFFRQX2M \regArr_reg[6][2]  ( .D(n99), .CK(CLK), .RN(n207), .Q(
        \regArr[6][2] ) );
  DFFRQX2M \regArr_reg[6][1]  ( .D(n98), .CK(CLK), .RN(n207), .Q(
        \regArr[6][1] ) );
  DFFRQX2M \regArr_reg[6][0]  ( .D(n97), .CK(CLK), .RN(n207), .Q(
        \regArr[6][0] ) );
  DFFRQX2M \regArr_reg[12][7]  ( .D(n152), .CK(CLK), .RN(n211), .Q(
        \regArr[12][7] ) );
  DFFRQX2M \regArr_reg[12][6]  ( .D(n151), .CK(CLK), .RN(n211), .Q(
        \regArr[12][6] ) );
  DFFRQX2M \regArr_reg[12][5]  ( .D(n150), .CK(CLK), .RN(n211), .Q(
        \regArr[12][5] ) );
  DFFRQX2M \regArr_reg[12][4]  ( .D(n149), .CK(CLK), .RN(n211), .Q(
        \regArr[12][4] ) );
  DFFRQX2M \regArr_reg[12][3]  ( .D(n148), .CK(CLK), .RN(n211), .Q(
        \regArr[12][3] ) );
  DFFRQX2M \regArr_reg[12][2]  ( .D(n147), .CK(CLK), .RN(n211), .Q(
        \regArr[12][2] ) );
  DFFRQX2M \regArr_reg[12][1]  ( .D(n146), .CK(CLK), .RN(n211), .Q(
        \regArr[12][1] ) );
  DFFRQX2M \regArr_reg[12][0]  ( .D(n145), .CK(CLK), .RN(n211), .Q(
        \regArr[12][0] ) );
  DFFRQX2M \regArr_reg[8][7]  ( .D(n120), .CK(CLK), .RN(n209), .Q(
        \regArr[8][7] ) );
  DFFRQX2M \regArr_reg[8][6]  ( .D(n119), .CK(CLK), .RN(n209), .Q(
        \regArr[8][6] ) );
  DFFRQX2M \regArr_reg[8][5]  ( .D(n118), .CK(CLK), .RN(n209), .Q(
        \regArr[8][5] ) );
  DFFRQX2M \regArr_reg[8][4]  ( .D(n117), .CK(CLK), .RN(n209), .Q(
        \regArr[8][4] ) );
  DFFRQX2M \regArr_reg[8][3]  ( .D(n116), .CK(CLK), .RN(n209), .Q(
        \regArr[8][3] ) );
  DFFRQX2M \regArr_reg[8][2]  ( .D(n115), .CK(CLK), .RN(n209), .Q(
        \regArr[8][2] ) );
  DFFRQX2M \regArr_reg[8][1]  ( .D(n114), .CK(CLK), .RN(n209), .Q(
        \regArr[8][1] ) );
  DFFRQX2M \regArr_reg[8][0]  ( .D(n113), .CK(CLK), .RN(n208), .Q(
        \regArr[8][0] ) );
  DFFRQX2M \regArr_reg[4][7]  ( .D(n88), .CK(CLK), .RN(n207), .Q(
        \regArr[4][7] ) );
  DFFRQX2M \regArr_reg[4][6]  ( .D(n87), .CK(CLK), .RN(n207), .Q(
        \regArr[4][6] ) );
  DFFRQX2M \regArr_reg[4][5]  ( .D(n86), .CK(CLK), .RN(n207), .Q(
        \regArr[4][5] ) );
  DFFRQX2M \regArr_reg[4][4]  ( .D(n85), .CK(CLK), .RN(n207), .Q(
        \regArr[4][4] ) );
  DFFRQX2M \regArr_reg[4][3]  ( .D(n84), .CK(CLK), .RN(n206), .Q(
        \regArr[4][3] ) );
  DFFRQX2M \regArr_reg[4][2]  ( .D(n83), .CK(CLK), .RN(n206), .Q(
        \regArr[4][2] ) );
  DFFRQX2M \regArr_reg[4][1]  ( .D(n82), .CK(CLK), .RN(n206), .Q(
        \regArr[4][1] ) );
  DFFRQX2M \regArr_reg[4][0]  ( .D(n81), .CK(CLK), .RN(n206), .Q(
        \regArr[4][0] ) );
  DFFRQX2M \regArr_reg[3][6]  ( .D(n79), .CK(CLK), .RN(n206), .Q(REG3[6]) );
  DFFRQX2M \regArr_reg[3][7]  ( .D(n80), .CK(CLK), .RN(n206), .Q(REG3[7]) );
  DFFRQX2M \RdData_reg[7]  ( .D(n47), .CK(CLK), .RN(n204), .Q(RdData[7]) );
  DFFRQX2M \RdData_reg[6]  ( .D(n46), .CK(CLK), .RN(n204), .Q(RdData[6]) );
  DFFRQX2M \RdData_reg[5]  ( .D(n45), .CK(CLK), .RN(n204), .Q(RdData[5]) );
  DFFRQX2M \RdData_reg[4]  ( .D(n44), .CK(CLK), .RN(n204), .Q(RdData[4]) );
  DFFRQX2M \RdData_reg[3]  ( .D(n43), .CK(CLK), .RN(n204), .Q(RdData[3]) );
  DFFRQX2M \RdData_reg[2]  ( .D(n42), .CK(CLK), .RN(n204), .Q(RdData[2]) );
  DFFRQX2M \RdData_reg[1]  ( .D(n41), .CK(CLK), .RN(n204), .Q(RdData[1]) );
  DFFRQX2M \RdData_reg[0]  ( .D(n40), .CK(CLK), .RN(n208), .Q(RdData[0]) );
  DFFRQX2M \regArr_reg[3][0]  ( .D(n73), .CK(CLK), .RN(n206), .Q(REG3[0]) );
  DFFRQX2M \regArr_reg[3][2]  ( .D(n75), .CK(CLK), .RN(n206), .Q(REG3[2]) );
  DFFRQX2M \regArr_reg[3][4]  ( .D(n77), .CK(CLK), .RN(n206), .Q(REG3[4]) );
  DFFSQX2M \regArr_reg[2][7]  ( .D(n72), .CK(CLK), .SN(n204), .Q(REG2[7]) );
  DFFRQX2M \regArr_reg[2][1]  ( .D(n66), .CK(CLK), .RN(n205), .Q(REG2[1]) );
  DFFRQX2M RdData_VLD_reg ( .D(n48), .CK(CLK), .RN(n204), .Q(RdData_VLD) );
  DFFRQX2M \regArr_reg[3][3]  ( .D(n76), .CK(CLK), .RN(n206), .Q(REG3[3]) );
  DFFRQX2M \regArr_reg[3][1]  ( .D(n74), .CK(CLK), .RN(n206), .Q(REG3[1]) );
  DFFRQX2M \regArr_reg[2][2]  ( .D(n67), .CK(CLK), .RN(n206), .Q(REG2[2]) );
  DFFRQX2M \regArr_reg[2][6]  ( .D(n71), .CK(CLK), .RN(n206), .Q(REG2[6]) );
  DFFSQX2M \regArr_reg[2][0]  ( .D(n65), .CK(CLK), .SN(n204), .Q(REG2[0]) );
  DFFRQX2M \regArr_reg[2][5]  ( .D(n70), .CK(CLK), .RN(n206), .Q(REG2[5]) );
  DFFRQX2M \regArr_reg[2][4]  ( .D(n69), .CK(CLK), .RN(n206), .Q(REG2[4]) );
  DFFRQX2M \regArr_reg[2][3]  ( .D(n68), .CK(CLK), .RN(n205), .Q(REG2[3]) );
  DFFRQX2M \regArr_reg[0][1]  ( .D(n50), .CK(CLK), .RN(n204), .Q(REG0[1]) );
  DFFRQX2M \regArr_reg[0][0]  ( .D(n49), .CK(CLK), .RN(n204), .Q(REG0[0]) );
  DFFRQX2M \regArr_reg[0][2]  ( .D(n51), .CK(CLK), .RN(n204), .Q(REG0[2]) );
  DFFRQX2M \regArr_reg[0][3]  ( .D(n52), .CK(CLK), .RN(n205), .Q(REG0[3]) );
  DFFRQX2M \regArr_reg[0][4]  ( .D(n53), .CK(CLK), .RN(n205), .Q(REG0[4]) );
  DFFRQX2M \regArr_reg[0][5]  ( .D(n54), .CK(CLK), .RN(n205), .Q(REG0[5]) );
  DFFRQX2M \regArr_reg[0][7]  ( .D(n56), .CK(CLK), .RN(n205), .Q(REG0[7]) );
  DFFRQX2M \regArr_reg[0][6]  ( .D(n55), .CK(CLK), .RN(n205), .Q(REG0[6]) );
  DFFRQX2M \regArr_reg[1][6]  ( .D(n63), .CK(CLK), .RN(n205), .Q(REG1[6]) );
  DFFRQX2M \regArr_reg[1][1]  ( .D(n58), .CK(CLK), .RN(n205), .Q(REG1[1]) );
  DFFRQX2M \regArr_reg[1][5]  ( .D(n62), .CK(CLK), .RN(n205), .Q(REG1[5]) );
  DFFRQX2M \regArr_reg[1][4]  ( .D(n61), .CK(CLK), .RN(n205), .Q(REG1[4]) );
  DFFRQX2M \regArr_reg[1][7]  ( .D(n64), .CK(CLK), .RN(n205), .Q(REG1[7]) );
  DFFRQX2M \regArr_reg[1][3]  ( .D(n60), .CK(CLK), .RN(n205), .Q(REG1[3]) );
  DFFRQX2M \regArr_reg[1][2]  ( .D(n59), .CK(CLK), .RN(n205), .Q(REG1[2]) );
  DFFRQX2M \regArr_reg[1][0]  ( .D(n57), .CK(CLK), .RN(n205), .Q(REG1[0]) );
  NOR2BX2M U3 ( .AN(n38), .B(n202), .Y(n32) );
  NOR2BX2M U4 ( .AN(n27), .B(n202), .Y(n18) );
  NOR2BX2M U5 ( .AN(N13), .B(n199), .Y(n23) );
  NOR2BX2M U6 ( .AN(N13), .B(n203), .Y(n26) );
  NOR2X2M U7 ( .A(n203), .B(N13), .Y(n20) );
  NOR2X2M U8 ( .A(n199), .B(N13), .Y(n15) );
  INVX2M U9 ( .A(n202), .Y(n200) );
  INVX2M U10 ( .A(n198), .Y(n199) );
  BUFX2M U11 ( .A(n203), .Y(n198) );
  NOR2BX2M U12 ( .AN(n38), .B(n201), .Y(n30) );
  NAND2X2M U13 ( .A(n30), .B(n15), .Y(n29) );
  NAND2X2M U14 ( .A(n32), .B(n15), .Y(n31) );
  NAND2X2M U15 ( .A(n30), .B(n20), .Y(n33) );
  NAND2X2M U16 ( .A(n32), .B(n20), .Y(n34) );
  NAND2X2M U17 ( .A(n30), .B(n23), .Y(n35) );
  NAND2X2M U18 ( .A(n32), .B(n23), .Y(n36) );
  NAND2X2M U19 ( .A(n30), .B(n26), .Y(n37) );
  NAND2X2M U20 ( .A(n32), .B(n26), .Y(n39) );
  NOR2BX2M U21 ( .AN(n27), .B(n201), .Y(n16) );
  NAND2X2M U22 ( .A(n18), .B(n15), .Y(n17) );
  NAND2X2M U23 ( .A(n20), .B(n16), .Y(n19) );
  NAND2X2M U24 ( .A(n20), .B(n18), .Y(n21) );
  NAND2X2M U25 ( .A(n23), .B(n16), .Y(n22) );
  NAND2X2M U26 ( .A(n23), .B(n18), .Y(n24) );
  NAND2X2M U27 ( .A(n26), .B(n16), .Y(n25) );
  NAND2X2M U28 ( .A(n26), .B(n18), .Y(n28) );
  NAND2X2M U29 ( .A(n15), .B(n16), .Y(n14) );
  INVX2M U30 ( .A(n12), .Y(n219) );
  AND2X2M U31 ( .A(N14), .B(n13), .Y(n38) );
  INVX2M U32 ( .A(n202), .Y(n201) );
  NAND2BX2M U33 ( .AN(WrEn), .B(RdEn), .Y(n12) );
  NOR2BX2M U34 ( .AN(n13), .B(N14), .Y(n27) );
  NOR2BX2M U35 ( .AN(WrEn), .B(RdEn), .Y(n13) );
  BUFX2M U36 ( .A(n218), .Y(n204) );
  BUFX2M U37 ( .A(n218), .Y(n205) );
  BUFX2M U38 ( .A(n217), .Y(n206) );
  BUFX2M U39 ( .A(n217), .Y(n207) );
  BUFX2M U40 ( .A(n216), .Y(n208) );
  BUFX2M U41 ( .A(n216), .Y(n209) );
  BUFX2M U42 ( .A(n215), .Y(n210) );
  BUFX2M U43 ( .A(n215), .Y(n211) );
  BUFX2M U44 ( .A(n214), .Y(n212) );
  BUFX2M U45 ( .A(n214), .Y(n213) );
  INVX2M U46 ( .A(N12), .Y(n203) );
  INVX2M U47 ( .A(N11), .Y(n202) );
  INVX2M U48 ( .A(WrData[0]), .Y(n220) );
  INVX2M U49 ( .A(WrData[1]), .Y(n221) );
  INVX2M U50 ( .A(WrData[2]), .Y(n222) );
  INVX2M U51 ( .A(WrData[3]), .Y(n223) );
  INVX2M U52 ( .A(WrData[4]), .Y(n224) );
  INVX2M U53 ( .A(WrData[5]), .Y(n225) );
  INVX2M U54 ( .A(WrData[6]), .Y(n226) );
  INVX2M U55 ( .A(WrData[7]), .Y(n227) );
  BUFX2M U56 ( .A(RST), .Y(n217) );
  BUFX2M U57 ( .A(RST), .Y(n216) );
  BUFX2M U58 ( .A(RST), .Y(n215) );
  BUFX2M U59 ( .A(RST), .Y(n214) );
  BUFX2M U60 ( .A(RST), .Y(n218) );
  OAI2BB2X1M U61 ( .B0(n220), .B1(n29), .A0N(\regArr[8][0] ), .A1N(n29), .Y(
        n113) );
  OAI2BB2X1M U62 ( .B0(n221), .B1(n29), .A0N(\regArr[8][1] ), .A1N(n29), .Y(
        n114) );
  OAI2BB2X1M U63 ( .B0(n222), .B1(n29), .A0N(\regArr[8][2] ), .A1N(n29), .Y(
        n115) );
  OAI2BB2X1M U64 ( .B0(n223), .B1(n29), .A0N(\regArr[8][3] ), .A1N(n29), .Y(
        n116) );
  OAI2BB2X1M U65 ( .B0(n224), .B1(n29), .A0N(\regArr[8][4] ), .A1N(n29), .Y(
        n117) );
  OAI2BB2X1M U66 ( .B0(n225), .B1(n29), .A0N(\regArr[8][5] ), .A1N(n29), .Y(
        n118) );
  OAI2BB2X1M U67 ( .B0(n226), .B1(n29), .A0N(\regArr[8][6] ), .A1N(n29), .Y(
        n119) );
  OAI2BB2X1M U68 ( .B0(n227), .B1(n29), .A0N(\regArr[8][7] ), .A1N(n29), .Y(
        n120) );
  OAI2BB2X1M U69 ( .B0(n220), .B1(n31), .A0N(\regArr[9][0] ), .A1N(n31), .Y(
        n121) );
  OAI2BB2X1M U70 ( .B0(n221), .B1(n31), .A0N(\regArr[9][1] ), .A1N(n31), .Y(
        n122) );
  OAI2BB2X1M U71 ( .B0(n222), .B1(n31), .A0N(\regArr[9][2] ), .A1N(n31), .Y(
        n123) );
  OAI2BB2X1M U72 ( .B0(n223), .B1(n31), .A0N(\regArr[9][3] ), .A1N(n31), .Y(
        n124) );
  OAI2BB2X1M U73 ( .B0(n224), .B1(n31), .A0N(\regArr[9][4] ), .A1N(n31), .Y(
        n125) );
  OAI2BB2X1M U74 ( .B0(n225), .B1(n31), .A0N(\regArr[9][5] ), .A1N(n31), .Y(
        n126) );
  OAI2BB2X1M U75 ( .B0(n226), .B1(n31), .A0N(\regArr[9][6] ), .A1N(n31), .Y(
        n127) );
  OAI2BB2X1M U76 ( .B0(n227), .B1(n31), .A0N(\regArr[9][7] ), .A1N(n31), .Y(
        n128) );
  OAI2BB2X1M U77 ( .B0(n220), .B1(n33), .A0N(\regArr[10][0] ), .A1N(n33), .Y(
        n129) );
  OAI2BB2X1M U78 ( .B0(n221), .B1(n33), .A0N(\regArr[10][1] ), .A1N(n33), .Y(
        n130) );
  OAI2BB2X1M U79 ( .B0(n222), .B1(n33), .A0N(\regArr[10][2] ), .A1N(n33), .Y(
        n131) );
  OAI2BB2X1M U80 ( .B0(n223), .B1(n33), .A0N(\regArr[10][3] ), .A1N(n33), .Y(
        n132) );
  OAI2BB2X1M U81 ( .B0(n224), .B1(n33), .A0N(\regArr[10][4] ), .A1N(n33), .Y(
        n133) );
  OAI2BB2X1M U82 ( .B0(n225), .B1(n33), .A0N(\regArr[10][5] ), .A1N(n33), .Y(
        n134) );
  OAI2BB2X1M U83 ( .B0(n226), .B1(n33), .A0N(\regArr[10][6] ), .A1N(n33), .Y(
        n135) );
  OAI2BB2X1M U84 ( .B0(n227), .B1(n33), .A0N(\regArr[10][7] ), .A1N(n33), .Y(
        n136) );
  OAI2BB2X1M U85 ( .B0(n220), .B1(n34), .A0N(\regArr[11][0] ), .A1N(n34), .Y(
        n137) );
  OAI2BB2X1M U86 ( .B0(n221), .B1(n34), .A0N(\regArr[11][1] ), .A1N(n34), .Y(
        n138) );
  OAI2BB2X1M U87 ( .B0(n222), .B1(n34), .A0N(\regArr[11][2] ), .A1N(n34), .Y(
        n139) );
  OAI2BB2X1M U88 ( .B0(n223), .B1(n34), .A0N(\regArr[11][3] ), .A1N(n34), .Y(
        n140) );
  OAI2BB2X1M U89 ( .B0(n224), .B1(n34), .A0N(\regArr[11][4] ), .A1N(n34), .Y(
        n141) );
  OAI2BB2X1M U90 ( .B0(n225), .B1(n34), .A0N(\regArr[11][5] ), .A1N(n34), .Y(
        n142) );
  OAI2BB2X1M U91 ( .B0(n226), .B1(n34), .A0N(\regArr[11][6] ), .A1N(n34), .Y(
        n143) );
  OAI2BB2X1M U92 ( .B0(n227), .B1(n34), .A0N(\regArr[11][7] ), .A1N(n34), .Y(
        n144) );
  OAI2BB2X1M U93 ( .B0(n220), .B1(n35), .A0N(\regArr[12][0] ), .A1N(n35), .Y(
        n145) );
  OAI2BB2X1M U94 ( .B0(n221), .B1(n35), .A0N(\regArr[12][1] ), .A1N(n35), .Y(
        n146) );
  OAI2BB2X1M U95 ( .B0(n222), .B1(n35), .A0N(\regArr[12][2] ), .A1N(n35), .Y(
        n147) );
  OAI2BB2X1M U96 ( .B0(n223), .B1(n35), .A0N(\regArr[12][3] ), .A1N(n35), .Y(
        n148) );
  OAI2BB2X1M U97 ( .B0(n224), .B1(n35), .A0N(\regArr[12][4] ), .A1N(n35), .Y(
        n149) );
  OAI2BB2X1M U98 ( .B0(n225), .B1(n35), .A0N(\regArr[12][5] ), .A1N(n35), .Y(
        n150) );
  OAI2BB2X1M U99 ( .B0(n226), .B1(n35), .A0N(\regArr[12][6] ), .A1N(n35), .Y(
        n151) );
  OAI2BB2X1M U100 ( .B0(n227), .B1(n35), .A0N(\regArr[12][7] ), .A1N(n35), .Y(
        n152) );
  OAI2BB2X1M U101 ( .B0(n220), .B1(n36), .A0N(\regArr[13][0] ), .A1N(n36), .Y(
        n153) );
  OAI2BB2X1M U102 ( .B0(n221), .B1(n36), .A0N(\regArr[13][1] ), .A1N(n36), .Y(
        n154) );
  OAI2BB2X1M U103 ( .B0(n222), .B1(n36), .A0N(\regArr[13][2] ), .A1N(n36), .Y(
        n155) );
  OAI2BB2X1M U104 ( .B0(n223), .B1(n36), .A0N(\regArr[13][3] ), .A1N(n36), .Y(
        n156) );
  OAI2BB2X1M U105 ( .B0(n224), .B1(n36), .A0N(\regArr[13][4] ), .A1N(n36), .Y(
        n157) );
  OAI2BB2X1M U106 ( .B0(n225), .B1(n36), .A0N(\regArr[13][5] ), .A1N(n36), .Y(
        n158) );
  OAI2BB2X1M U107 ( .B0(n226), .B1(n36), .A0N(\regArr[13][6] ), .A1N(n36), .Y(
        n159) );
  OAI2BB2X1M U108 ( .B0(n227), .B1(n36), .A0N(\regArr[13][7] ), .A1N(n36), .Y(
        n160) );
  OAI2BB2X1M U109 ( .B0(n220), .B1(n37), .A0N(\regArr[14][0] ), .A1N(n37), .Y(
        n161) );
  OAI2BB2X1M U110 ( .B0(n221), .B1(n37), .A0N(\regArr[14][1] ), .A1N(n37), .Y(
        n162) );
  OAI2BB2X1M U111 ( .B0(n222), .B1(n37), .A0N(\regArr[14][2] ), .A1N(n37), .Y(
        n163) );
  OAI2BB2X1M U112 ( .B0(n223), .B1(n37), .A0N(\regArr[14][3] ), .A1N(n37), .Y(
        n164) );
  OAI2BB2X1M U113 ( .B0(n224), .B1(n37), .A0N(\regArr[14][4] ), .A1N(n37), .Y(
        n165) );
  OAI2BB2X1M U114 ( .B0(n225), .B1(n37), .A0N(\regArr[14][5] ), .A1N(n37), .Y(
        n166) );
  OAI2BB2X1M U115 ( .B0(n226), .B1(n37), .A0N(\regArr[14][6] ), .A1N(n37), .Y(
        n167) );
  OAI2BB2X1M U116 ( .B0(n227), .B1(n37), .A0N(\regArr[14][7] ), .A1N(n37), .Y(
        n168) );
  OAI2BB2X1M U117 ( .B0(n220), .B1(n39), .A0N(\regArr[15][0] ), .A1N(n39), .Y(
        n169) );
  OAI2BB2X1M U118 ( .B0(n221), .B1(n39), .A0N(\regArr[15][1] ), .A1N(n39), .Y(
        n170) );
  OAI2BB2X1M U119 ( .B0(n222), .B1(n39), .A0N(\regArr[15][2] ), .A1N(n39), .Y(
        n171) );
  OAI2BB2X1M U120 ( .B0(n223), .B1(n39), .A0N(\regArr[15][3] ), .A1N(n39), .Y(
        n172) );
  OAI2BB2X1M U121 ( .B0(n224), .B1(n39), .A0N(\regArr[15][4] ), .A1N(n39), .Y(
        n173) );
  OAI2BB2X1M U122 ( .B0(n225), .B1(n39), .A0N(\regArr[15][5] ), .A1N(n39), .Y(
        n174) );
  OAI2BB2X1M U123 ( .B0(n226), .B1(n39), .A0N(\regArr[15][6] ), .A1N(n39), .Y(
        n175) );
  OAI2BB2X1M U124 ( .B0(n227), .B1(n39), .A0N(\regArr[15][7] ), .A1N(n39), .Y(
        n176) );
  AO22X1M U125 ( .A0(N43), .A1(n219), .B0(RdData[0]), .B1(n12), .Y(n40) );
  MX4X1M U126 ( .A(n4), .B(n2), .C(n3), .D(n1), .S0(N14), .S1(N13), .Y(N43) );
  MX4X1M U127 ( .A(REG0[0]), .B(REG1[0]), .C(REG2[0]), .D(REG3[0]), .S0(N11), 
        .S1(n199), .Y(n4) );
  MX4X1M U128 ( .A(\regArr[8][0] ), .B(\regArr[9][0] ), .C(\regArr[10][0] ), 
        .D(\regArr[11][0] ), .S0(N11), .S1(n199), .Y(n2) );
  AO22X1M U129 ( .A0(N42), .A1(n219), .B0(RdData[1]), .B1(n12), .Y(n41) );
  MX4X1M U130 ( .A(n8), .B(n6), .C(n7), .D(n5), .S0(N14), .S1(N13), .Y(N42) );
  MX4X1M U131 ( .A(\regArr[8][1] ), .B(\regArr[9][1] ), .C(\regArr[10][1] ), 
        .D(\regArr[11][1] ), .S0(N11), .S1(n199), .Y(n6) );
  MX4X1M U132 ( .A(\regArr[12][1] ), .B(\regArr[13][1] ), .C(\regArr[14][1] ), 
        .D(\regArr[15][1] ), .S0(n200), .S1(n199), .Y(n5) );
  AO22X1M U133 ( .A0(N41), .A1(n219), .B0(RdData[2]), .B1(n12), .Y(n42) );
  MX4X1M U134 ( .A(n177), .B(n10), .C(n11), .D(n9), .S0(N14), .S1(N13), .Y(N41) );
  MX4X1M U135 ( .A(REG0[2]), .B(REG1[2]), .C(REG2[2]), .D(REG3[2]), .S0(n200), 
        .S1(n199), .Y(n177) );
  MX4X1M U136 ( .A(\regArr[8][2] ), .B(\regArr[9][2] ), .C(\regArr[10][2] ), 
        .D(\regArr[11][2] ), .S0(n200), .S1(n199), .Y(n10) );
  AO22X1M U137 ( .A0(N40), .A1(n219), .B0(RdData[3]), .B1(n12), .Y(n43) );
  MX4X1M U138 ( .A(n181), .B(n179), .C(n180), .D(n178), .S0(N14), .S1(N13), 
        .Y(N40) );
  MX4X1M U139 ( .A(REG0[3]), .B(REG1[3]), .C(REG2[3]), .D(REG3[3]), .S0(n200), 
        .S1(n199), .Y(n181) );
  MX4X1M U140 ( .A(\regArr[8][3] ), .B(\regArr[9][3] ), .C(\regArr[10][3] ), 
        .D(\regArr[11][3] ), .S0(n200), .S1(n199), .Y(n179) );
  AO22X1M U141 ( .A0(N39), .A1(n219), .B0(RdData[4]), .B1(n12), .Y(n44) );
  MX4X1M U142 ( .A(n185), .B(n183), .C(n184), .D(n182), .S0(N14), .S1(N13), 
        .Y(N39) );
  MX4X1M U143 ( .A(REG0[4]), .B(REG1[4]), .C(REG2[4]), .D(REG3[4]), .S0(N11), 
        .S1(n199), .Y(n185) );
  MX4X1M U144 ( .A(\regArr[8][4] ), .B(\regArr[9][4] ), .C(\regArr[10][4] ), 
        .D(\regArr[11][4] ), .S0(n200), .S1(n199), .Y(n183) );
  AO22X1M U145 ( .A0(N38), .A1(n219), .B0(RdData[5]), .B1(n12), .Y(n45) );
  MX4X1M U146 ( .A(n189), .B(n187), .C(n188), .D(n186), .S0(N14), .S1(N13), 
        .Y(N38) );
  MX4X1M U147 ( .A(REG0[5]), .B(REG1[5]), .C(REG2[5]), .D(REG3[5]), .S0(N11), 
        .S1(N12), .Y(n189) );
  MX4X1M U148 ( .A(\regArr[8][5] ), .B(\regArr[9][5] ), .C(\regArr[10][5] ), 
        .D(\regArr[11][5] ), .S0(N11), .S1(N12), .Y(n187) );
  AO22X1M U149 ( .A0(N37), .A1(n219), .B0(RdData[6]), .B1(n12), .Y(n46) );
  MX4X1M U150 ( .A(n193), .B(n191), .C(n192), .D(n190), .S0(N14), .S1(N13), 
        .Y(N37) );
  MX4X1M U151 ( .A(REG0[6]), .B(REG1[6]), .C(REG2[6]), .D(REG3[6]), .S0(n201), 
        .S1(N12), .Y(n193) );
  MX4X1M U152 ( .A(\regArr[8][6] ), .B(\regArr[9][6] ), .C(\regArr[10][6] ), 
        .D(\regArr[11][6] ), .S0(N11), .S1(N12), .Y(n191) );
  AO22X1M U153 ( .A0(N36), .A1(n219), .B0(RdData[7]), .B1(n12), .Y(n47) );
  MX4X1M U154 ( .A(n197), .B(n195), .C(n196), .D(n194), .S0(N14), .S1(N13), 
        .Y(N36) );
  MX4X1M U155 ( .A(REG0[7]), .B(REG1[7]), .C(REG2[7]), .D(REG3[7]), .S0(n201), 
        .S1(N12), .Y(n197) );
  MX4X1M U156 ( .A(\regArr[8][7] ), .B(\regArr[9][7] ), .C(\regArr[10][7] ), 
        .D(\regArr[11][7] ), .S0(N11), .S1(N12), .Y(n195) );
  MX4X1M U157 ( .A(REG0[1]), .B(REG1[1]), .C(REG2[1]), .D(REG3[1]), .S0(n200), 
        .S1(n199), .Y(n8) );
  MX4X1M U158 ( .A(\regArr[4][0] ), .B(\regArr[5][0] ), .C(\regArr[6][0] ), 
        .D(\regArr[7][0] ), .S0(n201), .S1(n199), .Y(n3) );
  MX4X1M U159 ( .A(\regArr[4][1] ), .B(\regArr[5][1] ), .C(\regArr[6][1] ), 
        .D(\regArr[7][1] ), .S0(n200), .S1(n199), .Y(n7) );
  MX4X1M U160 ( .A(\regArr[4][2] ), .B(\regArr[5][2] ), .C(\regArr[6][2] ), 
        .D(\regArr[7][2] ), .S0(n200), .S1(n199), .Y(n11) );
  MX4X1M U161 ( .A(\regArr[4][3] ), .B(\regArr[5][3] ), .C(\regArr[6][3] ), 
        .D(\regArr[7][3] ), .S0(n200), .S1(n199), .Y(n180) );
  MX4X1M U162 ( .A(\regArr[4][4] ), .B(\regArr[5][4] ), .C(\regArr[6][4] ), 
        .D(\regArr[7][4] ), .S0(n200), .S1(n199), .Y(n184) );
  MX4X1M U163 ( .A(\regArr[4][5] ), .B(\regArr[5][5] ), .C(\regArr[6][5] ), 
        .D(\regArr[7][5] ), .S0(N11), .S1(n199), .Y(n188) );
  MX4X1M U164 ( .A(\regArr[4][6] ), .B(\regArr[5][6] ), .C(\regArr[6][6] ), 
        .D(\regArr[7][6] ), .S0(N11), .S1(N12), .Y(n192) );
  MX4X1M U165 ( .A(\regArr[4][7] ), .B(\regArr[5][7] ), .C(\regArr[6][7] ), 
        .D(\regArr[7][7] ), .S0(N11), .S1(N12), .Y(n196) );
  MX4X1M U166 ( .A(\regArr[12][0] ), .B(\regArr[13][0] ), .C(\regArr[14][0] ), 
        .D(\regArr[15][0] ), .S0(n201), .S1(n199), .Y(n1) );
  MX4X1M U167 ( .A(\regArr[12][2] ), .B(\regArr[13][2] ), .C(\regArr[14][2] ), 
        .D(\regArr[15][2] ), .S0(n200), .S1(n199), .Y(n9) );
  MX4X1M U168 ( .A(\regArr[12][3] ), .B(\regArr[13][3] ), .C(\regArr[14][3] ), 
        .D(\regArr[15][3] ), .S0(n200), .S1(n199), .Y(n178) );
  MX4X1M U169 ( .A(\regArr[12][4] ), .B(\regArr[13][4] ), .C(\regArr[14][4] ), 
        .D(\regArr[15][4] ), .S0(n200), .S1(n199), .Y(n182) );
  MX4X1M U170 ( .A(\regArr[12][5] ), .B(\regArr[13][5] ), .C(\regArr[14][5] ), 
        .D(\regArr[15][5] ), .S0(N11), .S1(n199), .Y(n186) );
  MX4X1M U171 ( .A(\regArr[12][6] ), .B(\regArr[13][6] ), .C(\regArr[14][6] ), 
        .D(\regArr[15][6] ), .S0(N11), .S1(n199), .Y(n190) );
  MX4X1M U172 ( .A(\regArr[12][7] ), .B(\regArr[13][7] ), .C(\regArr[14][7] ), 
        .D(\regArr[15][7] ), .S0(N11), .S1(n199), .Y(n194) );
  OAI2BB2X1M U173 ( .B0(n14), .B1(n220), .A0N(REG0[0]), .A1N(n14), .Y(n49) );
  OAI2BB2X1M U174 ( .B0(n14), .B1(n221), .A0N(REG0[1]), .A1N(n14), .Y(n50) );
  OAI2BB2X1M U175 ( .B0(n14), .B1(n222), .A0N(REG0[2]), .A1N(n14), .Y(n51) );
  OAI2BB2X1M U176 ( .B0(n14), .B1(n223), .A0N(REG0[3]), .A1N(n14), .Y(n52) );
  OAI2BB2X1M U177 ( .B0(n14), .B1(n224), .A0N(REG0[4]), .A1N(n14), .Y(n53) );
  OAI2BB2X1M U178 ( .B0(n14), .B1(n225), .A0N(REG0[5]), .A1N(n14), .Y(n54) );
  OAI2BB2X1M U179 ( .B0(n14), .B1(n226), .A0N(REG0[6]), .A1N(n14), .Y(n55) );
  OAI2BB2X1M U180 ( .B0(n14), .B1(n227), .A0N(REG0[7]), .A1N(n14), .Y(n56) );
  OAI2BB2X1M U181 ( .B0(n220), .B1(n17), .A0N(REG1[0]), .A1N(n17), .Y(n57) );
  OAI2BB2X1M U182 ( .B0(n221), .B1(n17), .A0N(REG1[1]), .A1N(n17), .Y(n58) );
  OAI2BB2X1M U183 ( .B0(n222), .B1(n17), .A0N(REG1[2]), .A1N(n17), .Y(n59) );
  OAI2BB2X1M U184 ( .B0(n223), .B1(n17), .A0N(REG1[3]), .A1N(n17), .Y(n60) );
  OAI2BB2X1M U185 ( .B0(n224), .B1(n17), .A0N(REG1[4]), .A1N(n17), .Y(n61) );
  OAI2BB2X1M U186 ( .B0(n225), .B1(n17), .A0N(REG1[5]), .A1N(n17), .Y(n62) );
  OAI2BB2X1M U187 ( .B0(n226), .B1(n17), .A0N(REG1[6]), .A1N(n17), .Y(n63) );
  OAI2BB2X1M U188 ( .B0(n227), .B1(n17), .A0N(REG1[7]), .A1N(n17), .Y(n64) );
  OAI2BB2X1M U189 ( .B0(n220), .B1(n22), .A0N(\regArr[4][0] ), .A1N(n22), .Y(
        n81) );
  OAI2BB2X1M U190 ( .B0(n221), .B1(n22), .A0N(\regArr[4][1] ), .A1N(n22), .Y(
        n82) );
  OAI2BB2X1M U191 ( .B0(n222), .B1(n22), .A0N(\regArr[4][2] ), .A1N(n22), .Y(
        n83) );
  OAI2BB2X1M U192 ( .B0(n223), .B1(n22), .A0N(\regArr[4][3] ), .A1N(n22), .Y(
        n84) );
  OAI2BB2X1M U193 ( .B0(n224), .B1(n22), .A0N(\regArr[4][4] ), .A1N(n22), .Y(
        n85) );
  OAI2BB2X1M U194 ( .B0(n225), .B1(n22), .A0N(\regArr[4][5] ), .A1N(n22), .Y(
        n86) );
  OAI2BB2X1M U195 ( .B0(n226), .B1(n22), .A0N(\regArr[4][6] ), .A1N(n22), .Y(
        n87) );
  OAI2BB2X1M U196 ( .B0(n227), .B1(n22), .A0N(\regArr[4][7] ), .A1N(n22), .Y(
        n88) );
  OAI2BB2X1M U197 ( .B0(n220), .B1(n24), .A0N(\regArr[5][0] ), .A1N(n24), .Y(
        n89) );
  OAI2BB2X1M U198 ( .B0(n221), .B1(n24), .A0N(\regArr[5][1] ), .A1N(n24), .Y(
        n90) );
  OAI2BB2X1M U199 ( .B0(n222), .B1(n24), .A0N(\regArr[5][2] ), .A1N(n24), .Y(
        n91) );
  OAI2BB2X1M U200 ( .B0(n223), .B1(n24), .A0N(\regArr[5][3] ), .A1N(n24), .Y(
        n92) );
  OAI2BB2X1M U201 ( .B0(n224), .B1(n24), .A0N(\regArr[5][4] ), .A1N(n24), .Y(
        n93) );
  OAI2BB2X1M U202 ( .B0(n225), .B1(n24), .A0N(\regArr[5][5] ), .A1N(n24), .Y(
        n94) );
  OAI2BB2X1M U203 ( .B0(n226), .B1(n24), .A0N(\regArr[5][6] ), .A1N(n24), .Y(
        n95) );
  OAI2BB2X1M U204 ( .B0(n227), .B1(n24), .A0N(\regArr[5][7] ), .A1N(n24), .Y(
        n96) );
  OAI2BB2X1M U205 ( .B0(n220), .B1(n25), .A0N(\regArr[6][0] ), .A1N(n25), .Y(
        n97) );
  OAI2BB2X1M U206 ( .B0(n221), .B1(n25), .A0N(\regArr[6][1] ), .A1N(n25), .Y(
        n98) );
  OAI2BB2X1M U207 ( .B0(n222), .B1(n25), .A0N(\regArr[6][2] ), .A1N(n25), .Y(
        n99) );
  OAI2BB2X1M U208 ( .B0(n223), .B1(n25), .A0N(\regArr[6][3] ), .A1N(n25), .Y(
        n100) );
  OAI2BB2X1M U209 ( .B0(n224), .B1(n25), .A0N(\regArr[6][4] ), .A1N(n25), .Y(
        n101) );
  OAI2BB2X1M U210 ( .B0(n225), .B1(n25), .A0N(\regArr[6][5] ), .A1N(n25), .Y(
        n102) );
  OAI2BB2X1M U211 ( .B0(n226), .B1(n25), .A0N(\regArr[6][6] ), .A1N(n25), .Y(
        n103) );
  OAI2BB2X1M U212 ( .B0(n227), .B1(n25), .A0N(\regArr[6][7] ), .A1N(n25), .Y(
        n104) );
  OAI2BB2X1M U213 ( .B0(n220), .B1(n28), .A0N(\regArr[7][0] ), .A1N(n28), .Y(
        n105) );
  OAI2BB2X1M U214 ( .B0(n221), .B1(n28), .A0N(\regArr[7][1] ), .A1N(n28), .Y(
        n106) );
  OAI2BB2X1M U215 ( .B0(n222), .B1(n28), .A0N(\regArr[7][2] ), .A1N(n28), .Y(
        n107) );
  OAI2BB2X1M U216 ( .B0(n223), .B1(n28), .A0N(\regArr[7][3] ), .A1N(n28), .Y(
        n108) );
  OAI2BB2X1M U217 ( .B0(n224), .B1(n28), .A0N(\regArr[7][4] ), .A1N(n28), .Y(
        n109) );
  OAI2BB2X1M U218 ( .B0(n225), .B1(n28), .A0N(\regArr[7][5] ), .A1N(n28), .Y(
        n110) );
  OAI2BB2X1M U219 ( .B0(n226), .B1(n28), .A0N(\regArr[7][6] ), .A1N(n28), .Y(
        n111) );
  OAI2BB2X1M U220 ( .B0(n227), .B1(n28), .A0N(\regArr[7][7] ), .A1N(n28), .Y(
        n112) );
  OAI2BB2X1M U221 ( .B0(n221), .B1(n19), .A0N(REG2[1]), .A1N(n19), .Y(n66) );
  OAI2BB2X1M U222 ( .B0(n222), .B1(n19), .A0N(REG2[2]), .A1N(n19), .Y(n67) );
  OAI2BB2X1M U223 ( .B0(n223), .B1(n19), .A0N(REG2[3]), .A1N(n19), .Y(n68) );
  OAI2BB2X1M U224 ( .B0(n224), .B1(n19), .A0N(REG2[4]), .A1N(n19), .Y(n69) );
  OAI2BB2X1M U225 ( .B0(n225), .B1(n19), .A0N(REG2[5]), .A1N(n19), .Y(n70) );
  OAI2BB2X1M U226 ( .B0(n226), .B1(n19), .A0N(REG2[6]), .A1N(n19), .Y(n71) );
  OAI2BB2X1M U227 ( .B0(n220), .B1(n21), .A0N(REG3[0]), .A1N(n21), .Y(n73) );
  OAI2BB2X1M U228 ( .B0(n221), .B1(n21), .A0N(REG3[1]), .A1N(n21), .Y(n74) );
  OAI2BB2X1M U229 ( .B0(n222), .B1(n21), .A0N(REG3[2]), .A1N(n21), .Y(n75) );
  OAI2BB2X1M U230 ( .B0(n223), .B1(n21), .A0N(REG3[3]), .A1N(n21), .Y(n76) );
  OAI2BB2X1M U231 ( .B0(n224), .B1(n21), .A0N(REG3[4]), .A1N(n21), .Y(n77) );
  OAI2BB2X1M U232 ( .B0(n226), .B1(n21), .A0N(REG3[6]), .A1N(n21), .Y(n79) );
  OAI2BB2X1M U233 ( .B0(n227), .B1(n21), .A0N(REG3[7]), .A1N(n21), .Y(n80) );
  OAI2BB2X1M U234 ( .B0(n220), .B1(n19), .A0N(REG2[0]), .A1N(n19), .Y(n65) );
  OAI2BB2X1M U235 ( .B0(n227), .B1(n19), .A0N(REG2[7]), .A1N(n19), .Y(n72) );
  OAI2BB2X1M U236 ( .B0(n225), .B1(n21), .A0N(REG3[5]), .A1N(n21), .Y(n78) );
  OAI2BB1X2M U237 ( .A0N(RdData_VLD), .A1N(n13), .B0(n12), .Y(n48) );
endmodule


module ALU_DW_div_uns_0 ( a, b, quotient, remainder, divide_by_0 );
  input [7:0] a;
  input [7:0] b;
  output [7:0] quotient;
  output [7:0] remainder;
  output divide_by_0;
  wire   \u_div/SumTmp[1][0] , \u_div/SumTmp[1][1] , \u_div/SumTmp[1][2] ,
         \u_div/SumTmp[1][3] , \u_div/SumTmp[1][4] , \u_div/SumTmp[1][5] ,
         \u_div/SumTmp[1][6] , \u_div/SumTmp[2][0] , \u_div/SumTmp[2][1] ,
         \u_div/SumTmp[2][2] , \u_div/SumTmp[2][3] , \u_div/SumTmp[2][4] ,
         \u_div/SumTmp[2][5] , \u_div/SumTmp[3][0] , \u_div/SumTmp[3][1] ,
         \u_div/SumTmp[3][2] , \u_div/SumTmp[3][3] , \u_div/SumTmp[3][4] ,
         \u_div/SumTmp[4][0] , \u_div/SumTmp[4][1] , \u_div/SumTmp[4][2] ,
         \u_div/SumTmp[4][3] , \u_div/SumTmp[5][0] , \u_div/SumTmp[5][1] ,
         \u_div/SumTmp[5][2] , \u_div/SumTmp[6][0] , \u_div/SumTmp[6][1] ,
         \u_div/SumTmp[7][0] , \u_div/CryTmp[0][1] , \u_div/CryTmp[0][2] ,
         \u_div/CryTmp[0][3] , \u_div/CryTmp[0][4] , \u_div/CryTmp[0][5] ,
         \u_div/CryTmp[0][6] , \u_div/CryTmp[0][7] , \u_div/CryTmp[1][1] ,
         \u_div/CryTmp[1][2] , \u_div/CryTmp[1][3] , \u_div/CryTmp[1][4] ,
         \u_div/CryTmp[1][5] , \u_div/CryTmp[1][6] , \u_div/CryTmp[1][7] ,
         \u_div/CryTmp[2][1] , \u_div/CryTmp[2][2] , \u_div/CryTmp[2][3] ,
         \u_div/CryTmp[2][4] , \u_div/CryTmp[2][5] , \u_div/CryTmp[2][6] ,
         \u_div/CryTmp[3][1] , \u_div/CryTmp[3][2] , \u_div/CryTmp[3][3] ,
         \u_div/CryTmp[3][4] , \u_div/CryTmp[3][5] , \u_div/CryTmp[4][1] ,
         \u_div/CryTmp[4][2] , \u_div/CryTmp[4][3] , \u_div/CryTmp[4][4] ,
         \u_div/CryTmp[5][1] , \u_div/CryTmp[5][2] , \u_div/CryTmp[5][3] ,
         \u_div/CryTmp[6][1] , \u_div/CryTmp[6][2] , \u_div/CryTmp[7][1] ,
         \u_div/PartRem[1][1] , \u_div/PartRem[1][2] , \u_div/PartRem[1][3] ,
         \u_div/PartRem[1][4] , \u_div/PartRem[1][5] , \u_div/PartRem[1][6] ,
         \u_div/PartRem[1][7] , \u_div/PartRem[2][1] , \u_div/PartRem[2][2] ,
         \u_div/PartRem[2][3] , \u_div/PartRem[2][4] , \u_div/PartRem[2][5] ,
         \u_div/PartRem[2][6] , \u_div/PartRem[3][1] , \u_div/PartRem[3][2] ,
         \u_div/PartRem[3][3] , \u_div/PartRem[3][4] , \u_div/PartRem[3][5] ,
         \u_div/PartRem[4][1] , \u_div/PartRem[4][2] , \u_div/PartRem[4][3] ,
         \u_div/PartRem[4][4] , \u_div/PartRem[5][1] , \u_div/PartRem[5][2] ,
         \u_div/PartRem[5][3] , \u_div/PartRem[6][1] , \u_div/PartRem[6][2] ,
         \u_div/PartRem[7][1] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21;

  ADDFX2M \u_div/u_fa_PartRem_0_2_5  ( .A(\u_div/PartRem[3][5] ), .B(n13), 
        .CI(\u_div/CryTmp[2][5] ), .CO(\u_div/CryTmp[2][6] ), .S(
        \u_div/SumTmp[2][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_3  ( .A(\u_div/PartRem[5][3] ), .B(n15), 
        .CI(\u_div/CryTmp[4][3] ), .CO(\u_div/CryTmp[4][4] ), .S(
        \u_div/SumTmp[4][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_5_2  ( .A(\u_div/PartRem[6][2] ), .B(n16), 
        .CI(\u_div/CryTmp[5][2] ), .CO(\u_div/CryTmp[5][3] ), .S(
        \u_div/SumTmp[5][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_6_1  ( .A(\u_div/PartRem[7][1] ), .B(n17), 
        .CI(\u_div/CryTmp[6][1] ), .CO(\u_div/CryTmp[6][2] ), .S(
        \u_div/SumTmp[6][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_4  ( .A(\u_div/PartRem[4][4] ), .B(n14), 
        .CI(\u_div/CryTmp[3][4] ), .CO(\u_div/CryTmp[3][5] ), .S(
        \u_div/SumTmp[3][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_6  ( .A(\u_div/PartRem[1][6] ), .B(n12), 
        .CI(\u_div/CryTmp[0][6] ), .CO(\u_div/CryTmp[0][7] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_7  ( .A(\u_div/PartRem[1][7] ), .B(n11), 
        .CI(\u_div/CryTmp[0][7] ), .CO(quotient[0]) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_1  ( .A(\u_div/PartRem[1][1] ), .B(n17), 
        .CI(\u_div/CryTmp[0][1] ), .CO(\u_div/CryTmp[0][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_1  ( .A(\u_div/PartRem[2][1] ), .B(n17), 
        .CI(\u_div/CryTmp[1][1] ), .CO(\u_div/CryTmp[1][2] ), .S(
        \u_div/SumTmp[1][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_1  ( .A(\u_div/PartRem[3][1] ), .B(n17), 
        .CI(\u_div/CryTmp[2][1] ), .CO(\u_div/CryTmp[2][2] ), .S(
        \u_div/SumTmp[2][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_1  ( .A(\u_div/PartRem[4][1] ), .B(n17), 
        .CI(\u_div/CryTmp[3][1] ), .CO(\u_div/CryTmp[3][2] ), .S(
        \u_div/SumTmp[3][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_1  ( .A(\u_div/PartRem[5][1] ), .B(n17), 
        .CI(\u_div/CryTmp[4][1] ), .CO(\u_div/CryTmp[4][2] ), .S(
        \u_div/SumTmp[4][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_5_1  ( .A(\u_div/PartRem[6][1] ), .B(n17), 
        .CI(\u_div/CryTmp[5][1] ), .CO(\u_div/CryTmp[5][2] ), .S(
        \u_div/SumTmp[5][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_4  ( .A(\u_div/PartRem[1][4] ), .B(n14), 
        .CI(\u_div/CryTmp[0][4] ), .CO(\u_div/CryTmp[0][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_5  ( .A(\u_div/PartRem[1][5] ), .B(n13), 
        .CI(\u_div/CryTmp[0][5] ), .CO(\u_div/CryTmp[0][6] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_5  ( .A(\u_div/PartRem[2][5] ), .B(n13), 
        .CI(\u_div/CryTmp[1][5] ), .CO(\u_div/CryTmp[1][6] ), .S(
        \u_div/SumTmp[1][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_4  ( .A(\u_div/PartRem[2][4] ), .B(n14), 
        .CI(\u_div/CryTmp[1][4] ), .CO(\u_div/CryTmp[1][5] ), .S(
        \u_div/SumTmp[1][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_2  ( .A(\u_div/PartRem[1][2] ), .B(n16), 
        .CI(\u_div/CryTmp[0][2] ), .CO(\u_div/CryTmp[0][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_3  ( .A(\u_div/PartRem[1][3] ), .B(n15), 
        .CI(\u_div/CryTmp[0][3] ), .CO(\u_div/CryTmp[0][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_4  ( .A(\u_div/PartRem[3][4] ), .B(n14), 
        .CI(\u_div/CryTmp[2][4] ), .CO(\u_div/CryTmp[2][5] ), .S(
        \u_div/SumTmp[2][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_3  ( .A(\u_div/PartRem[2][3] ), .B(n15), 
        .CI(\u_div/CryTmp[1][3] ), .CO(\u_div/CryTmp[1][4] ), .S(
        \u_div/SumTmp[1][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_3  ( .A(\u_div/PartRem[3][3] ), .B(n15), 
        .CI(\u_div/CryTmp[2][3] ), .CO(\u_div/CryTmp[2][4] ), .S(
        \u_div/SumTmp[2][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_2  ( .A(\u_div/PartRem[2][2] ), .B(n16), 
        .CI(\u_div/CryTmp[1][2] ), .CO(\u_div/CryTmp[1][3] ), .S(
        \u_div/SumTmp[1][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_3  ( .A(\u_div/PartRem[4][3] ), .B(n15), 
        .CI(\u_div/CryTmp[3][3] ), .CO(\u_div/CryTmp[3][4] ), .S(
        \u_div/SumTmp[3][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_2  ( .A(\u_div/PartRem[3][2] ), .B(n16), 
        .CI(\u_div/CryTmp[2][2] ), .CO(\u_div/CryTmp[2][3] ), .S(
        \u_div/SumTmp[2][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_2  ( .A(\u_div/PartRem[4][2] ), .B(n16), 
        .CI(\u_div/CryTmp[3][2] ), .CO(\u_div/CryTmp[3][3] ), .S(
        \u_div/SumTmp[3][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_2  ( .A(\u_div/PartRem[5][2] ), .B(n16), 
        .CI(\u_div/CryTmp[4][2] ), .CO(\u_div/CryTmp[4][3] ), .S(
        \u_div/SumTmp[4][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_6  ( .A(\u_div/PartRem[2][6] ), .B(n12), 
        .CI(\u_div/CryTmp[1][6] ), .CO(\u_div/CryTmp[1][7] ), .S(
        \u_div/SumTmp[1][6] ) );
  INVX2M U1 ( .A(b[0]), .Y(n18) );
  XNOR2X2M U2 ( .A(n18), .B(a[7]), .Y(\u_div/SumTmp[7][0] ) );
  XNOR2X2M U3 ( .A(n18), .B(a[6]), .Y(\u_div/SumTmp[6][0] ) );
  XNOR2X2M U4 ( .A(n18), .B(a[5]), .Y(\u_div/SumTmp[5][0] ) );
  XNOR2X2M U5 ( .A(n18), .B(a[4]), .Y(\u_div/SumTmp[4][0] ) );
  XNOR2X2M U6 ( .A(n18), .B(a[3]), .Y(\u_div/SumTmp[3][0] ) );
  XNOR2X2M U7 ( .A(n18), .B(a[2]), .Y(\u_div/SumTmp[2][0] ) );
  OR2X2M U8 ( .A(n18), .B(a[7]), .Y(\u_div/CryTmp[7][1] ) );
  NAND2X2M U9 ( .A(n3), .B(n4), .Y(\u_div/CryTmp[5][1] ) );
  INVX2M U10 ( .A(a[5]), .Y(n4) );
  INVX2M U11 ( .A(n18), .Y(n3) );
  NAND2X2M U12 ( .A(n5), .B(n6), .Y(\u_div/CryTmp[4][1] ) );
  INVX2M U13 ( .A(a[4]), .Y(n6) );
  INVX2M U14 ( .A(n18), .Y(n5) );
  NAND2X2M U15 ( .A(n5), .B(n7), .Y(\u_div/CryTmp[3][1] ) );
  INVX2M U16 ( .A(a[3]), .Y(n7) );
  NAND2X2M U17 ( .A(n5), .B(n8), .Y(\u_div/CryTmp[2][1] ) );
  INVX2M U18 ( .A(a[2]), .Y(n8) );
  NAND2X2M U19 ( .A(n5), .B(n9), .Y(\u_div/CryTmp[1][1] ) );
  INVX2M U20 ( .A(a[1]), .Y(n9) );
  NAND2X2M U21 ( .A(n5), .B(n10), .Y(\u_div/CryTmp[0][1] ) );
  INVX2M U22 ( .A(a[0]), .Y(n10) );
  NAND2X2M U23 ( .A(n1), .B(n2), .Y(\u_div/CryTmp[6][1] ) );
  INVX2M U24 ( .A(a[6]), .Y(n2) );
  INVX2M U25 ( .A(n18), .Y(n1) );
  XNOR2X2M U26 ( .A(n18), .B(a[1]), .Y(\u_div/SumTmp[1][0] ) );
  INVX2M U27 ( .A(b[6]), .Y(n12) );
  INVX2M U28 ( .A(b[1]), .Y(n17) );
  INVX2M U29 ( .A(b[2]), .Y(n16) );
  INVX2M U30 ( .A(b[3]), .Y(n15) );
  INVX2M U31 ( .A(b[4]), .Y(n14) );
  INVX2M U32 ( .A(b[5]), .Y(n13) );
  INVX2M U33 ( .A(b[7]), .Y(n11) );
  CLKMX2X2M U34 ( .A(\u_div/PartRem[2][6] ), .B(\u_div/SumTmp[1][6] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][7] ) );
  CLKMX2X2M U35 ( .A(\u_div/PartRem[3][5] ), .B(\u_div/SumTmp[2][5] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][6] ) );
  CLKMX2X2M U36 ( .A(\u_div/PartRem[4][4] ), .B(\u_div/SumTmp[3][4] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][5] ) );
  CLKMX2X2M U37 ( .A(\u_div/PartRem[5][3] ), .B(\u_div/SumTmp[4][3] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][4] ) );
  CLKMX2X2M U38 ( .A(\u_div/PartRem[6][2] ), .B(\u_div/SumTmp[5][2] ), .S0(
        quotient[5]), .Y(\u_div/PartRem[5][3] ) );
  CLKMX2X2M U39 ( .A(\u_div/PartRem[7][1] ), .B(\u_div/SumTmp[6][1] ), .S0(
        quotient[6]), .Y(\u_div/PartRem[6][2] ) );
  CLKMX2X2M U40 ( .A(a[7]), .B(\u_div/SumTmp[7][0] ), .S0(quotient[7]), .Y(
        \u_div/PartRem[7][1] ) );
  CLKMX2X2M U41 ( .A(\u_div/PartRem[2][5] ), .B(\u_div/SumTmp[1][5] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][6] ) );
  CLKMX2X2M U42 ( .A(\u_div/PartRem[3][4] ), .B(\u_div/SumTmp[2][4] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][5] ) );
  CLKMX2X2M U43 ( .A(\u_div/PartRem[4][3] ), .B(\u_div/SumTmp[3][3] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][4] ) );
  CLKMX2X2M U44 ( .A(\u_div/PartRem[5][2] ), .B(\u_div/SumTmp[4][2] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][3] ) );
  CLKMX2X2M U45 ( .A(\u_div/PartRem[6][1] ), .B(\u_div/SumTmp[5][1] ), .S0(
        quotient[5]), .Y(\u_div/PartRem[5][2] ) );
  CLKMX2X2M U46 ( .A(a[6]), .B(\u_div/SumTmp[6][0] ), .S0(quotient[6]), .Y(
        \u_div/PartRem[6][1] ) );
  CLKMX2X2M U47 ( .A(\u_div/PartRem[2][4] ), .B(\u_div/SumTmp[1][4] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][5] ) );
  CLKMX2X2M U48 ( .A(\u_div/PartRem[3][3] ), .B(\u_div/SumTmp[2][3] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][4] ) );
  CLKMX2X2M U49 ( .A(\u_div/PartRem[4][2] ), .B(\u_div/SumTmp[3][2] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][3] ) );
  CLKMX2X2M U50 ( .A(\u_div/PartRem[5][1] ), .B(\u_div/SumTmp[4][1] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][2] ) );
  CLKMX2X2M U51 ( .A(a[5]), .B(\u_div/SumTmp[5][0] ), .S0(quotient[5]), .Y(
        \u_div/PartRem[5][1] ) );
  CLKMX2X2M U52 ( .A(\u_div/PartRem[2][3] ), .B(\u_div/SumTmp[1][3] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][4] ) );
  CLKMX2X2M U53 ( .A(\u_div/PartRem[3][2] ), .B(\u_div/SumTmp[2][2] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][3] ) );
  CLKMX2X2M U54 ( .A(\u_div/PartRem[4][1] ), .B(\u_div/SumTmp[3][1] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][2] ) );
  CLKMX2X2M U55 ( .A(a[4]), .B(\u_div/SumTmp[4][0] ), .S0(quotient[4]), .Y(
        \u_div/PartRem[4][1] ) );
  CLKMX2X2M U56 ( .A(\u_div/PartRem[2][2] ), .B(\u_div/SumTmp[1][2] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][3] ) );
  CLKMX2X2M U57 ( .A(\u_div/PartRem[3][1] ), .B(\u_div/SumTmp[2][1] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][2] ) );
  CLKMX2X2M U58 ( .A(a[3]), .B(\u_div/SumTmp[3][0] ), .S0(quotient[3]), .Y(
        \u_div/PartRem[3][1] ) );
  CLKMX2X2M U59 ( .A(\u_div/PartRem[2][1] ), .B(\u_div/SumTmp[1][1] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][2] ) );
  CLKMX2X2M U60 ( .A(a[2]), .B(\u_div/SumTmp[2][0] ), .S0(quotient[2]), .Y(
        \u_div/PartRem[2][1] ) );
  CLKMX2X2M U61 ( .A(a[1]), .B(\u_div/SumTmp[1][0] ), .S0(quotient[1]), .Y(
        \u_div/PartRem[1][1] ) );
  AND4X1M U62 ( .A(\u_div/CryTmp[7][1] ), .B(n19), .C(n17), .D(n16), .Y(
        quotient[7]) );
  AND3X1M U63 ( .A(n19), .B(n16), .C(\u_div/CryTmp[6][2] ), .Y(quotient[6]) );
  AND2X1M U64 ( .A(\u_div/CryTmp[5][3] ), .B(n19), .Y(quotient[5]) );
  AND2X1M U65 ( .A(n20), .B(n15), .Y(n19) );
  AND2X1M U66 ( .A(\u_div/CryTmp[4][4] ), .B(n20), .Y(quotient[4]) );
  AND3X1M U67 ( .A(n21), .B(n14), .C(n13), .Y(n20) );
  AND3X1M U68 ( .A(n21), .B(n13), .C(\u_div/CryTmp[3][5] ), .Y(quotient[3]) );
  AND2X1M U69 ( .A(\u_div/CryTmp[2][6] ), .B(n21), .Y(quotient[2]) );
  NOR2X1M U70 ( .A(b[6]), .B(b[7]), .Y(n21) );
  AND2X1M U71 ( .A(\u_div/CryTmp[1][7] ), .B(n11), .Y(quotient[1]) );
endmodule


module ALU_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] DIFF;
  input CI;
  output CO;
  wire   n1, n3, n4, n5, n6, n7, n8, n9, n10;
  wire   [9:0] carry;

  ADDFX2M U2_1 ( .A(A[1]), .B(n9), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1])
         );
  ADDFX2M U2_5 ( .A(A[5]), .B(n5), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5])
         );
  ADDFX2M U2_4 ( .A(A[4]), .B(n6), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4])
         );
  ADDFX2M U2_3 ( .A(A[3]), .B(n7), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3])
         );
  ADDFX2M U2_2 ( .A(A[2]), .B(n8), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2])
         );
  ADDFX2M U2_7 ( .A(A[7]), .B(n3), .CI(carry[7]), .CO(carry[8]), .S(DIFF[7])
         );
  ADDFX2M U2_6 ( .A(A[6]), .B(n4), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6])
         );
  INVX2M U1 ( .A(carry[8]), .Y(DIFF[8]) );
  INVX2M U2 ( .A(B[6]), .Y(n4) );
  XNOR2X2M U3 ( .A(n10), .B(A[0]), .Y(DIFF[0]) );
  INVX2M U4 ( .A(B[0]), .Y(n10) );
  INVX2M U5 ( .A(B[7]), .Y(n3) );
  INVX2M U6 ( .A(B[2]), .Y(n8) );
  INVX2M U7 ( .A(B[3]), .Y(n7) );
  INVX2M U8 ( .A(B[4]), .Y(n6) );
  INVX2M U9 ( .A(B[5]), .Y(n5) );
  INVX2M U10 ( .A(B[1]), .Y(n9) );
  NAND2X2M U11 ( .A(B[0]), .B(n1), .Y(carry[1]) );
  INVX2M U12 ( .A(A[0]), .Y(n1) );
endmodule


module ALU_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  ADDFX2M U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  ADDFX2M U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFX2M U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFX2M U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFX2M U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFX2M U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFX2M U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  AND2X2M U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  CLKXOR2X2M U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_DW01_add_1 ( A, B, CI, SUM, CO );
  input [13:0] A;
  input [13:0] B;
  output [13:0] SUM;
  input CI;
  output CO;
  wire   \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20
;
  assign SUM[6] = A[6];
  assign SUM[5] = \A[5] ;
  assign \A[5]  = A[5];
  assign SUM[4] = \A[4] ;
  assign \A[4]  = A[4];
  assign SUM[3] = \A[3] ;
  assign \A[3]  = A[3];
  assign SUM[2] = \A[2] ;
  assign \A[2]  = A[2];
  assign SUM[1] = \A[1] ;
  assign \A[1]  = A[1];
  assign SUM[0] = \A[0] ;
  assign \A[0]  = A[0];

  AOI21BX2M U2 ( .A0(n11), .A1(A[12]), .B0N(n12), .Y(n1) );
  NAND2X2M U3 ( .A(A[7]), .B(B[7]), .Y(n8) );
  XNOR2X2M U4 ( .A(B[13]), .B(n1), .Y(SUM[13]) );
  XNOR2X2M U5 ( .A(A[7]), .B(n2), .Y(SUM[7]) );
  INVX2M U6 ( .A(B[7]), .Y(n2) );
  XNOR2X1M U7 ( .A(n3), .B(n4), .Y(SUM[9]) );
  NOR2X1M U8 ( .A(n5), .B(n6), .Y(n4) );
  CLKXOR2X2M U9 ( .A(n7), .B(n8), .Y(SUM[8]) );
  NAND2BX1M U10 ( .AN(n9), .B(n10), .Y(n7) );
  OAI21X1M U11 ( .A0(A[12]), .A1(n11), .B0(B[12]), .Y(n12) );
  XOR3XLM U12 ( .A(B[12]), .B(A[12]), .C(n11), .Y(SUM[12]) );
  OAI21BX1M U13 ( .A0(n13), .A1(n14), .B0N(n15), .Y(n11) );
  XNOR2X1M U14 ( .A(n14), .B(n16), .Y(SUM[11]) );
  NOR2X1M U15 ( .A(n15), .B(n13), .Y(n16) );
  NOR2X1M U16 ( .A(B[11]), .B(A[11]), .Y(n13) );
  AND2X1M U17 ( .A(B[11]), .B(A[11]), .Y(n15) );
  OA21X1M U18 ( .A0(n17), .A1(n18), .B0(n19), .Y(n14) );
  CLKXOR2X2M U19 ( .A(n20), .B(n18), .Y(SUM[10]) );
  AOI2BB1X1M U20 ( .A0N(n3), .A1N(n6), .B0(n5), .Y(n18) );
  AND2X1M U21 ( .A(B[9]), .B(A[9]), .Y(n5) );
  NOR2X1M U22 ( .A(B[9]), .B(A[9]), .Y(n6) );
  OA21X1M U23 ( .A0(n8), .A1(n9), .B0(n10), .Y(n3) );
  CLKNAND2X2M U24 ( .A(B[8]), .B(A[8]), .Y(n10) );
  NOR2X1M U25 ( .A(B[8]), .B(A[8]), .Y(n9) );
  NAND2BX1M U26 ( .AN(n17), .B(n19), .Y(n20) );
  CLKNAND2X2M U27 ( .A(B[10]), .B(A[10]), .Y(n19) );
  NOR2X1M U28 ( .A(B[10]), .B(A[10]), .Y(n17) );
endmodule


module ALU_DW02_mult_0 ( A, B, TC, PRODUCT );
  input [7:0] A;
  input [7:0] B;
  output [15:0] PRODUCT;
  input TC;
  wire   \ab[7][7] , \ab[7][6] , \ab[7][5] , \ab[7][4] , \ab[7][3] ,
         \ab[7][2] , \ab[7][1] , \ab[7][0] , \ab[6][7] , \ab[6][6] ,
         \ab[6][5] , \ab[6][4] , \ab[6][3] , \ab[6][2] , \ab[6][1] ,
         \ab[6][0] , \ab[5][7] , \ab[5][6] , \ab[5][5] , \ab[5][4] ,
         \ab[5][3] , \ab[5][2] , \ab[5][1] , \ab[5][0] , \ab[4][7] ,
         \ab[4][6] , \ab[4][5] , \ab[4][4] , \ab[4][3] , \ab[4][2] ,
         \ab[4][1] , \ab[4][0] , \ab[3][7] , \ab[3][6] , \ab[3][5] ,
         \ab[3][4] , \ab[3][3] , \ab[3][2] , \ab[3][1] , \ab[3][0] ,
         \ab[2][7] , \ab[2][6] , \ab[2][5] , \ab[2][4] , \ab[2][3] ,
         \ab[2][2] , \ab[2][1] , \ab[2][0] , \ab[1][7] , \ab[1][6] ,
         \ab[1][5] , \ab[1][4] , \ab[1][3] , \ab[1][2] , \ab[1][1] ,
         \ab[1][0] , \ab[0][7] , \ab[0][6] , \ab[0][5] , \ab[0][4] ,
         \ab[0][3] , \ab[0][2] , \ab[0][1] , \CARRYB[7][6] , \CARRYB[7][5] ,
         \CARRYB[7][4] , \CARRYB[7][3] , \CARRYB[7][2] , \CARRYB[7][1] ,
         \CARRYB[7][0] , \CARRYB[6][6] , \CARRYB[6][5] , \CARRYB[6][4] ,
         \CARRYB[6][3] , \CARRYB[6][2] , \CARRYB[6][1] , \CARRYB[6][0] ,
         \CARRYB[5][6] , \CARRYB[5][5] , \CARRYB[5][4] , \CARRYB[5][3] ,
         \CARRYB[5][2] , \CARRYB[5][1] , \CARRYB[5][0] , \CARRYB[4][6] ,
         \CARRYB[4][5] , \CARRYB[4][4] , \CARRYB[4][3] , \CARRYB[4][2] ,
         \CARRYB[4][1] , \CARRYB[4][0] , \CARRYB[3][6] , \CARRYB[3][5] ,
         \CARRYB[3][4] , \CARRYB[3][3] , \CARRYB[3][2] , \CARRYB[3][1] ,
         \CARRYB[3][0] , \CARRYB[2][6] , \CARRYB[2][5] , \CARRYB[2][4] ,
         \CARRYB[2][3] , \CARRYB[2][2] , \CARRYB[2][1] , \CARRYB[2][0] ,
         \SUMB[7][6] , \SUMB[7][5] , \SUMB[7][4] , \SUMB[7][3] , \SUMB[7][2] ,
         \SUMB[7][1] , \SUMB[7][0] , \SUMB[6][6] , \SUMB[6][5] , \SUMB[6][4] ,
         \SUMB[6][3] , \SUMB[6][2] , \SUMB[6][1] , \SUMB[5][6] , \SUMB[5][5] ,
         \SUMB[5][4] , \SUMB[5][3] , \SUMB[5][2] , \SUMB[5][1] , \SUMB[4][6] ,
         \SUMB[4][5] , \SUMB[4][4] , \SUMB[4][3] , \SUMB[4][2] , \SUMB[4][1] ,
         \SUMB[3][6] , \SUMB[3][5] , \SUMB[3][4] , \SUMB[3][3] , \SUMB[3][2] ,
         \SUMB[3][1] , \SUMB[2][6] , \SUMB[2][5] , \SUMB[2][4] , \SUMB[2][3] ,
         \SUMB[2][2] , \SUMB[2][1] , \SUMB[1][6] , \SUMB[1][5] , \SUMB[1][4] ,
         \SUMB[1][3] , \SUMB[1][2] , \SUMB[1][1] , \A1[12] , \A1[11] ,
         \A1[10] , \A1[9] , \A1[8] , \A1[7] , \A1[6] , \A1[4] , \A1[3] ,
         \A1[2] , \A1[1] , \A1[0] , n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39;

  ALU_DW01_add_1 FS_1 ( .A({1'b0, \A1[12] , \A1[11] , \A1[10] , \A1[9] , 
        \A1[8] , \A1[7] , \A1[6] , \SUMB[7][0] , \A1[4] , \A1[3] , \A1[2] , 
        \A1[1] , \A1[0] }), .B({n10, n16, n15, n13, n14, n11, n12, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .CI(1'b0), .SUM(PRODUCT[15:2]) );
  ADDFX2M S5_6 ( .A(\ab[7][6] ), .B(\CARRYB[6][6] ), .CI(\ab[6][7] ), .CO(
        \CARRYB[7][6] ), .S(\SUMB[7][6] ) );
  ADDFX2M S1_6_0 ( .A(\ab[6][0] ), .B(\CARRYB[5][0] ), .CI(\SUMB[5][1] ), .CO(
        \CARRYB[6][0] ), .S(\A1[4] ) );
  ADDFX2M S1_5_0 ( .A(\ab[5][0] ), .B(\CARRYB[4][0] ), .CI(\SUMB[4][1] ), .CO(
        \CARRYB[5][0] ), .S(\A1[3] ) );
  ADDFX2M S1_4_0 ( .A(\ab[4][0] ), .B(\CARRYB[3][0] ), .CI(\SUMB[3][1] ), .CO(
        \CARRYB[4][0] ), .S(\A1[2] ) );
  ADDFX2M S1_3_0 ( .A(\ab[3][0] ), .B(\CARRYB[2][0] ), .CI(\SUMB[2][1] ), .CO(
        \CARRYB[3][0] ), .S(\A1[1] ) );
  ADDFX2M S1_2_0 ( .A(\ab[2][0] ), .B(n9), .CI(\SUMB[1][1] ), .CO(
        \CARRYB[2][0] ), .S(\A1[0] ) );
  ADDFX2M S3_6_6 ( .A(\ab[6][6] ), .B(\CARRYB[5][6] ), .CI(\ab[5][7] ), .CO(
        \CARRYB[6][6] ), .S(\SUMB[6][6] ) );
  ADDFX2M S2_6_5 ( .A(\ab[6][5] ), .B(\CARRYB[5][5] ), .CI(\SUMB[5][6] ), .CO(
        \CARRYB[6][5] ), .S(\SUMB[6][5] ) );
  ADDFX2M S3_5_6 ( .A(\ab[5][6] ), .B(\CARRYB[4][6] ), .CI(\ab[4][7] ), .CO(
        \CARRYB[5][6] ), .S(\SUMB[5][6] ) );
  ADDFX2M S3_4_6 ( .A(\ab[4][6] ), .B(\CARRYB[3][6] ), .CI(\ab[3][7] ), .CO(
        \CARRYB[4][6] ), .S(\SUMB[4][6] ) );
  ADDFX2M S4_0 ( .A(\ab[7][0] ), .B(\CARRYB[6][0] ), .CI(\SUMB[6][1] ), .CO(
        \CARRYB[7][0] ), .S(\SUMB[7][0] ) );
  ADDFX2M S4_5 ( .A(\ab[7][5] ), .B(\CARRYB[6][5] ), .CI(\SUMB[6][6] ), .CO(
        \CARRYB[7][5] ), .S(\SUMB[7][5] ) );
  ADDFX2M S4_4 ( .A(\ab[7][4] ), .B(\CARRYB[6][4] ), .CI(\SUMB[6][5] ), .CO(
        \CARRYB[7][4] ), .S(\SUMB[7][4] ) );
  ADDFX2M S2_6_2 ( .A(\ab[6][2] ), .B(\CARRYB[5][2] ), .CI(\SUMB[5][3] ), .CO(
        \CARRYB[6][2] ), .S(\SUMB[6][2] ) );
  ADDFX2M S2_6_1 ( .A(\ab[6][1] ), .B(\CARRYB[5][1] ), .CI(\SUMB[5][2] ), .CO(
        \CARRYB[6][1] ), .S(\SUMB[6][1] ) );
  ADDFX2M S2_5_3 ( .A(\ab[5][3] ), .B(\CARRYB[4][3] ), .CI(\SUMB[4][4] ), .CO(
        \CARRYB[5][3] ), .S(\SUMB[5][3] ) );
  ADDFX2M S2_5_2 ( .A(\ab[5][2] ), .B(\CARRYB[4][2] ), .CI(\SUMB[4][3] ), .CO(
        \CARRYB[5][2] ), .S(\SUMB[5][2] ) );
  ADDFX2M S2_5_1 ( .A(\ab[5][1] ), .B(\CARRYB[4][1] ), .CI(\SUMB[4][2] ), .CO(
        \CARRYB[5][1] ), .S(\SUMB[5][1] ) );
  ADDFX2M S2_4_4 ( .A(\ab[4][4] ), .B(\CARRYB[3][4] ), .CI(\SUMB[3][5] ), .CO(
        \CARRYB[4][4] ), .S(\SUMB[4][4] ) );
  ADDFX2M S2_4_2 ( .A(\ab[4][2] ), .B(\CARRYB[3][2] ), .CI(\SUMB[3][3] ), .CO(
        \CARRYB[4][2] ), .S(\SUMB[4][2] ) );
  ADDFX2M S2_4_1 ( .A(\ab[4][1] ), .B(\CARRYB[3][1] ), .CI(\SUMB[3][2] ), .CO(
        \CARRYB[4][1] ), .S(\SUMB[4][1] ) );
  ADDFX2M S2_3_5 ( .A(\ab[3][5] ), .B(\CARRYB[2][5] ), .CI(\SUMB[2][6] ), .CO(
        \CARRYB[3][5] ), .S(\SUMB[3][5] ) );
  ADDFX2M S2_3_4 ( .A(\ab[3][4] ), .B(\CARRYB[2][4] ), .CI(\SUMB[2][5] ), .CO(
        \CARRYB[3][4] ), .S(\SUMB[3][4] ) );
  ADDFX2M S2_3_2 ( .A(\ab[3][2] ), .B(\CARRYB[2][2] ), .CI(\SUMB[2][3] ), .CO(
        \CARRYB[3][2] ), .S(\SUMB[3][2] ) );
  ADDFX2M S2_3_1 ( .A(\ab[3][1] ), .B(\CARRYB[2][1] ), .CI(\SUMB[2][2] ), .CO(
        \CARRYB[3][1] ), .S(\SUMB[3][1] ) );
  ADDFX2M S2_2_2 ( .A(\ab[2][2] ), .B(n5), .CI(\SUMB[1][3] ), .CO(
        \CARRYB[2][2] ), .S(\SUMB[2][2] ) );
  ADDFX2M S2_2_1 ( .A(\ab[2][1] ), .B(n4), .CI(\SUMB[1][2] ), .CO(
        \CARRYB[2][1] ), .S(\SUMB[2][1] ) );
  ADDFX2M S2_6_4 ( .A(\ab[6][4] ), .B(\CARRYB[5][4] ), .CI(\SUMB[5][5] ), .CO(
        \CARRYB[6][4] ), .S(\SUMB[6][4] ) );
  ADDFX2M S2_5_5 ( .A(\ab[5][5] ), .B(\CARRYB[4][5] ), .CI(\SUMB[4][6] ), .CO(
        \CARRYB[5][5] ), .S(\SUMB[5][5] ) );
  ADDFX2M S2_6_3 ( .A(\ab[6][3] ), .B(\CARRYB[5][3] ), .CI(\SUMB[5][4] ), .CO(
        \CARRYB[6][3] ), .S(\SUMB[6][3] ) );
  ADDFX2M S2_5_4 ( .A(\ab[5][4] ), .B(\CARRYB[4][4] ), .CI(\SUMB[4][5] ), .CO(
        \CARRYB[5][4] ), .S(\SUMB[5][4] ) );
  ADDFX2M S2_4_3 ( .A(\ab[4][3] ), .B(\CARRYB[3][3] ), .CI(\SUMB[3][4] ), .CO(
        \CARRYB[4][3] ), .S(\SUMB[4][3] ) );
  ADDFX2M S2_4_5 ( .A(\ab[4][5] ), .B(\CARRYB[3][5] ), .CI(\SUMB[3][6] ), .CO(
        \CARRYB[4][5] ), .S(\SUMB[4][5] ) );
  ADDFX2M S2_3_3 ( .A(\ab[3][3] ), .B(\CARRYB[2][3] ), .CI(\SUMB[2][4] ), .CO(
        \CARRYB[3][3] ), .S(\SUMB[3][3] ) );
  ADDFX2M S3_3_6 ( .A(\ab[3][6] ), .B(\CARRYB[2][6] ), .CI(\ab[2][7] ), .CO(
        \CARRYB[3][6] ), .S(\SUMB[3][6] ) );
  ADDFX2M S3_2_6 ( .A(\ab[2][6] ), .B(n8), .CI(\ab[1][7] ), .CO(\CARRYB[2][6] ), .S(\SUMB[2][6] ) );
  ADDFX2M S2_2_5 ( .A(\ab[2][5] ), .B(n7), .CI(\SUMB[1][6] ), .CO(
        \CARRYB[2][5] ), .S(\SUMB[2][5] ) );
  ADDFX2M S2_2_4 ( .A(\ab[2][4] ), .B(n6), .CI(\SUMB[1][5] ), .CO(
        \CARRYB[2][4] ), .S(\SUMB[2][4] ) );
  ADDFX2M S2_2_3 ( .A(\ab[2][3] ), .B(n3), .CI(\SUMB[1][4] ), .CO(
        \CARRYB[2][3] ), .S(\SUMB[2][3] ) );
  ADDFX2M S4_1 ( .A(\ab[7][1] ), .B(\CARRYB[6][1] ), .CI(\SUMB[6][2] ), .CO(
        \CARRYB[7][1] ), .S(\SUMB[7][1] ) );
  ADDFX2M S4_3 ( .A(\ab[7][3] ), .B(\CARRYB[6][3] ), .CI(\SUMB[6][4] ), .CO(
        \CARRYB[7][3] ), .S(\SUMB[7][3] ) );
  ADDFX2M S4_2 ( .A(\ab[7][2] ), .B(\CARRYB[6][2] ), .CI(\SUMB[6][3] ), .CO(
        \CARRYB[7][2] ), .S(\SUMB[7][2] ) );
  AND2X2M U2 ( .A(\ab[0][4] ), .B(\ab[1][3] ), .Y(n3) );
  AND2X2M U3 ( .A(\ab[0][2] ), .B(\ab[1][1] ), .Y(n4) );
  AND2X2M U4 ( .A(\ab[0][3] ), .B(\ab[1][2] ), .Y(n5) );
  AND2X2M U5 ( .A(\ab[0][5] ), .B(\ab[1][4] ), .Y(n6) );
  AND2X2M U6 ( .A(\ab[0][6] ), .B(\ab[1][5] ), .Y(n7) );
  AND2X2M U7 ( .A(\ab[0][7] ), .B(\ab[1][6] ), .Y(n8) );
  AND2X2M U8 ( .A(\ab[0][1] ), .B(\ab[1][0] ), .Y(n9) );
  AND2X2M U9 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(n10) );
  INVX2M U10 ( .A(\ab[0][6] ), .Y(n22) );
  CLKXOR2X2M U11 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(\A1[7] ) );
  CLKXOR2X2M U12 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(\A1[8] ) );
  INVX2M U13 ( .A(\ab[0][4] ), .Y(n20) );
  INVX2M U14 ( .A(\ab[0][5] ), .Y(n21) );
  INVX2M U15 ( .A(\ab[0][3] ), .Y(n19) );
  INVX2M U16 ( .A(\ab[0][7] ), .Y(n23) );
  AND2X2M U17 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(n11) );
  AND2X2M U18 ( .A(\CARRYB[7][0] ), .B(\SUMB[7][1] ), .Y(n12) );
  CLKXOR2X2M U19 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(\A1[10] ) );
  CLKXOR2X2M U20 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(\A1[11] ) );
  INVX2M U21 ( .A(\ab[0][2] ), .Y(n18) );
  AND2X2M U22 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(n13) );
  CLKXOR2X2M U23 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(\A1[9] ) );
  AND2X2M U24 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(n14) );
  AND2X2M U25 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(n15) );
  CLKXOR2X2M U26 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(\A1[12] ) );
  INVX2M U27 ( .A(\SUMB[7][1] ), .Y(n17) );
  AND2X2M U28 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(n16) );
  CLKXOR2X2M U29 ( .A(\ab[1][0] ), .B(\ab[0][1] ), .Y(PRODUCT[1]) );
  XNOR2X2M U30 ( .A(\ab[1][4] ), .B(n21), .Y(\SUMB[1][4] ) );
  XNOR2X2M U31 ( .A(\ab[1][5] ), .B(n22), .Y(\SUMB[1][5] ) );
  XNOR2X2M U32 ( .A(\ab[1][6] ), .B(n23), .Y(\SUMB[1][6] ) );
  XNOR2X2M U33 ( .A(\ab[1][2] ), .B(n19), .Y(\SUMB[1][2] ) );
  XNOR2X2M U34 ( .A(\ab[1][3] ), .B(n20), .Y(\SUMB[1][3] ) );
  INVX2M U35 ( .A(A[1]), .Y(n38) );
  INVX2M U36 ( .A(A[0]), .Y(n39) );
  INVX2M U37 ( .A(B[6]), .Y(n25) );
  XNOR2X2M U38 ( .A(\ab[1][1] ), .B(n18), .Y(\SUMB[1][1] ) );
  INVX2M U39 ( .A(A[3]), .Y(n36) );
  INVX2M U40 ( .A(A[2]), .Y(n37) );
  INVX2M U41 ( .A(A[4]), .Y(n35) );
  XNOR2X2M U42 ( .A(\CARRYB[7][0] ), .B(n17), .Y(\A1[6] ) );
  INVX2M U43 ( .A(A[7]), .Y(n32) );
  INVX2M U44 ( .A(A[6]), .Y(n33) );
  INVX2M U45 ( .A(A[5]), .Y(n34) );
  INVX2M U46 ( .A(B[3]), .Y(n28) );
  INVX2M U47 ( .A(B[7]), .Y(n24) );
  INVX2M U48 ( .A(B[4]), .Y(n27) );
  INVX2M U49 ( .A(B[5]), .Y(n26) );
  INVX2M U50 ( .A(B[0]), .Y(n31) );
  INVX2M U51 ( .A(B[2]), .Y(n29) );
  INVX2M U52 ( .A(B[1]), .Y(n30) );
  NOR2X1M U54 ( .A(n32), .B(n24), .Y(\ab[7][7] ) );
  NOR2X1M U55 ( .A(n32), .B(n25), .Y(\ab[7][6] ) );
  NOR2X1M U56 ( .A(n32), .B(n26), .Y(\ab[7][5] ) );
  NOR2X1M U57 ( .A(n32), .B(n27), .Y(\ab[7][4] ) );
  NOR2X1M U58 ( .A(n32), .B(n28), .Y(\ab[7][3] ) );
  NOR2X1M U59 ( .A(n32), .B(n29), .Y(\ab[7][2] ) );
  NOR2X1M U60 ( .A(n32), .B(n30), .Y(\ab[7][1] ) );
  NOR2X1M U61 ( .A(n32), .B(n31), .Y(\ab[7][0] ) );
  NOR2X1M U62 ( .A(n24), .B(n33), .Y(\ab[6][7] ) );
  NOR2X1M U63 ( .A(n25), .B(n33), .Y(\ab[6][6] ) );
  NOR2X1M U64 ( .A(n26), .B(n33), .Y(\ab[6][5] ) );
  NOR2X1M U65 ( .A(n27), .B(n33), .Y(\ab[6][4] ) );
  NOR2X1M U66 ( .A(n28), .B(n33), .Y(\ab[6][3] ) );
  NOR2X1M U67 ( .A(n29), .B(n33), .Y(\ab[6][2] ) );
  NOR2X1M U68 ( .A(n30), .B(n33), .Y(\ab[6][1] ) );
  NOR2X1M U69 ( .A(n31), .B(n33), .Y(\ab[6][0] ) );
  NOR2X1M U70 ( .A(n24), .B(n34), .Y(\ab[5][7] ) );
  NOR2X1M U71 ( .A(n25), .B(n34), .Y(\ab[5][6] ) );
  NOR2X1M U72 ( .A(n26), .B(n34), .Y(\ab[5][5] ) );
  NOR2X1M U73 ( .A(n27), .B(n34), .Y(\ab[5][4] ) );
  NOR2X1M U74 ( .A(n28), .B(n34), .Y(\ab[5][3] ) );
  NOR2X1M U75 ( .A(n29), .B(n34), .Y(\ab[5][2] ) );
  NOR2X1M U76 ( .A(n30), .B(n34), .Y(\ab[5][1] ) );
  NOR2X1M U77 ( .A(n31), .B(n34), .Y(\ab[5][0] ) );
  NOR2X1M U78 ( .A(n24), .B(n35), .Y(\ab[4][7] ) );
  NOR2X1M U79 ( .A(n25), .B(n35), .Y(\ab[4][6] ) );
  NOR2X1M U80 ( .A(n26), .B(n35), .Y(\ab[4][5] ) );
  NOR2X1M U81 ( .A(n27), .B(n35), .Y(\ab[4][4] ) );
  NOR2X1M U82 ( .A(n28), .B(n35), .Y(\ab[4][3] ) );
  NOR2X1M U83 ( .A(n29), .B(n35), .Y(\ab[4][2] ) );
  NOR2X1M U84 ( .A(n30), .B(n35), .Y(\ab[4][1] ) );
  NOR2X1M U85 ( .A(n31), .B(n35), .Y(\ab[4][0] ) );
  NOR2X1M U86 ( .A(n24), .B(n36), .Y(\ab[3][7] ) );
  NOR2X1M U87 ( .A(n25), .B(n36), .Y(\ab[3][6] ) );
  NOR2X1M U88 ( .A(n26), .B(n36), .Y(\ab[3][5] ) );
  NOR2X1M U89 ( .A(n27), .B(n36), .Y(\ab[3][4] ) );
  NOR2X1M U90 ( .A(n28), .B(n36), .Y(\ab[3][3] ) );
  NOR2X1M U91 ( .A(n29), .B(n36), .Y(\ab[3][2] ) );
  NOR2X1M U92 ( .A(n30), .B(n36), .Y(\ab[3][1] ) );
  NOR2X1M U93 ( .A(n31), .B(n36), .Y(\ab[3][0] ) );
  NOR2X1M U94 ( .A(n24), .B(n37), .Y(\ab[2][7] ) );
  NOR2X1M U95 ( .A(n25), .B(n37), .Y(\ab[2][6] ) );
  NOR2X1M U96 ( .A(n26), .B(n37), .Y(\ab[2][5] ) );
  NOR2X1M U97 ( .A(n27), .B(n37), .Y(\ab[2][4] ) );
  NOR2X1M U98 ( .A(n28), .B(n37), .Y(\ab[2][3] ) );
  NOR2X1M U99 ( .A(n29), .B(n37), .Y(\ab[2][2] ) );
  NOR2X1M U100 ( .A(n30), .B(n37), .Y(\ab[2][1] ) );
  NOR2X1M U101 ( .A(n31), .B(n37), .Y(\ab[2][0] ) );
  NOR2X1M U102 ( .A(n24), .B(n38), .Y(\ab[1][7] ) );
  NOR2X1M U103 ( .A(n25), .B(n38), .Y(\ab[1][6] ) );
  NOR2X1M U104 ( .A(n26), .B(n38), .Y(\ab[1][5] ) );
  NOR2X1M U105 ( .A(n27), .B(n38), .Y(\ab[1][4] ) );
  NOR2X1M U106 ( .A(n28), .B(n38), .Y(\ab[1][3] ) );
  NOR2X1M U107 ( .A(n29), .B(n38), .Y(\ab[1][2] ) );
  NOR2X1M U108 ( .A(n30), .B(n38), .Y(\ab[1][1] ) );
  NOR2X1M U109 ( .A(n31), .B(n38), .Y(\ab[1][0] ) );
  NOR2X1M U110 ( .A(n24), .B(n39), .Y(\ab[0][7] ) );
  NOR2X1M U111 ( .A(n25), .B(n39), .Y(\ab[0][6] ) );
  NOR2X1M U112 ( .A(n26), .B(n39), .Y(\ab[0][5] ) );
  NOR2X1M U113 ( .A(n27), .B(n39), .Y(\ab[0][4] ) );
  NOR2X1M U114 ( .A(n28), .B(n39), .Y(\ab[0][3] ) );
  NOR2X1M U115 ( .A(n29), .B(n39), .Y(\ab[0][2] ) );
  NOR2X1M U116 ( .A(n30), .B(n39), .Y(\ab[0][1] ) );
  NOR2X1M U117 ( .A(n31), .B(n39), .Y(PRODUCT[0]) );
endmodule


module ALU ( A, B, EN, ALU_FUN, CLK, RST, ALU_OUT, OUT_VALID );
  input [7:0] A;
  input [7:0] B;
  input [3:0] ALU_FUN;
  output [15:0] ALU_OUT;
  input EN, CLK, RST;
  output OUT_VALID;
  wire   N91, N92, N93, N94, N95, N96, N97, N98, N99, N100, N101, N102, N103,
         N104, N105, N106, N107, N108, N109, N110, N111, N112, N113, N114,
         N115, N116, N117, N118, N119, N120, N121, N122, N123, N124, N125,
         N126, N127, N128, N129, N130, N131, N132, N157, N158, N159, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101,
         n102, n103, n104, n105, n106, n107, n3, n4, n5, n6, n7, n8, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n108, n109, n110, n111, n112, n113,
         n114, n115, n116, n117, n118, n119, n120, n121, n122, n123, n124,
         n125, n126, n127, n128, n129, n130, n131, n132, n133, n134, n135,
         n136, n137, n138, n139, n140;
  wire   [15:0] ALU_OUT_Comb;

  ALU_DW_div_uns_0 div_52 ( .a({n12, n11, n10, n9, n8, n7, n6, n5}), .b({B[7], 
        n4, B[5:0]}), .quotient({N132, N131, N130, N129, N128, N127, N126, 
        N125}) );
  ALU_DW01_sub_0 sub_46 ( .A({1'b0, n12, n11, n10, n9, n8, n7, n6, n5}), .B({
        1'b0, B[7], n4, B[5:0]}), .CI(1'b0), .DIFF({N108, N107, N106, N105, 
        N104, N103, N102, N101, N100}) );
  ALU_DW01_add_0 add_43 ( .A({1'b0, n12, n11, n10, n9, n8, n7, n6, n5}), .B({
        1'b0, B[7], n4, B[5:0]}), .CI(1'b0), .SUM({N99, N98, N97, N96, N95, 
        N94, N93, N92, N91}) );
  ALU_DW02_mult_0 mult_49 ( .A({n12, n11, n10, n9, n8, n7, n6, n5}), .B({B[7], 
        n4, B[5:0]}), .TC(1'b0), .PRODUCT({N124, N123, N122, N121, N120, N119, 
        N118, N117, N116, N115, N114, N113, N112, N111, N110, N109}) );
  DFFRQX2M \ALU_OUT_reg[15]  ( .D(ALU_OUT_Comb[15]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[15]) );
  DFFRQX2M \ALU_OUT_reg[14]  ( .D(ALU_OUT_Comb[14]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[14]) );
  DFFRQX2M \ALU_OUT_reg[13]  ( .D(ALU_OUT_Comb[13]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[13]) );
  DFFRQX2M \ALU_OUT_reg[12]  ( .D(ALU_OUT_Comb[12]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[12]) );
  DFFRQX2M \ALU_OUT_reg[11]  ( .D(ALU_OUT_Comb[11]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[11]) );
  DFFRQX2M \ALU_OUT_reg[10]  ( .D(ALU_OUT_Comb[10]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[10]) );
  DFFRQX2M \ALU_OUT_reg[9]  ( .D(ALU_OUT_Comb[9]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[9]) );
  DFFRQX2M \ALU_OUT_reg[8]  ( .D(ALU_OUT_Comb[8]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[8]) );
  DFFRQX2M \ALU_OUT_reg[7]  ( .D(ALU_OUT_Comb[7]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[7]) );
  DFFRQX2M \ALU_OUT_reg[6]  ( .D(ALU_OUT_Comb[6]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[6]) );
  DFFRQX2M \ALU_OUT_reg[5]  ( .D(ALU_OUT_Comb[5]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[5]) );
  DFFRQX2M \ALU_OUT_reg[4]  ( .D(ALU_OUT_Comb[4]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[4]) );
  DFFRQX2M \ALU_OUT_reg[3]  ( .D(ALU_OUT_Comb[3]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[3]) );
  DFFRQX2M \ALU_OUT_reg[2]  ( .D(ALU_OUT_Comb[2]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[2]) );
  DFFRQX2M \ALU_OUT_reg[1]  ( .D(ALU_OUT_Comb[1]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[1]) );
  DFFRQX2M \ALU_OUT_reg[0]  ( .D(ALU_OUT_Comb[0]), .CK(CLK), .RN(RST), .Q(
        ALU_OUT[0]) );
  DFFRQX2M OUT_VALID_reg ( .D(EN), .CK(CLK), .RN(RST), .Q(OUT_VALID) );
  BUFX2M U3 ( .A(A[6]), .Y(n11) );
  OAI2BB1X2M U4 ( .A0N(N124), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[15]) );
  OAI2BB1X2M U7 ( .A0N(N123), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[14]) );
  OAI2BB1X2M U8 ( .A0N(N121), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[12]) );
  OAI2BB1X2M U9 ( .A0N(N122), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[13]) );
  OAI2BB1X2M U10 ( .A0N(N118), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[9]) );
  OAI2BB1X2M U11 ( .A0N(N119), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[10]) );
  OAI2BB1X2M U12 ( .A0N(N120), .A1N(n31), .B0(n32), .Y(ALU_OUT_Comb[11]) );
  OAI2BB1X2M U13 ( .A0N(n140), .A1N(n105), .B0(n101), .Y(n47) );
  OAI2BB1X2M U14 ( .A0N(n100), .A1N(n99), .B0(n101), .Y(n48) );
  AND2X2M U15 ( .A(n99), .B(n105), .Y(n42) );
  AND2X2M U16 ( .A(n106), .B(n105), .Y(n50) );
  BUFX2M U17 ( .A(n41), .Y(n13) );
  NOR2X2M U18 ( .A(n107), .B(n137), .Y(n41) );
  INVX2M U19 ( .A(n100), .Y(n137) );
  INVX2M U20 ( .A(n107), .Y(n140) );
  NOR2BX2M U21 ( .AN(n106), .B(n137), .Y(n37) );
  NOR2BX2M U22 ( .AN(n35), .B(n135), .Y(n31) );
  INVX2M U23 ( .A(n91), .Y(n138) );
  NOR3BX2M U24 ( .AN(n105), .B(n139), .C(ALU_FUN[2]), .Y(n49) );
  NOR2X2M U25 ( .A(ALU_FUN[2]), .B(ALU_FUN[1]), .Y(n106) );
  AND3X2M U26 ( .A(n106), .B(n136), .C(n3), .Y(n46) );
  NAND2X2M U27 ( .A(ALU_FUN[2]), .B(ALU_FUN[1]), .Y(n107) );
  INVX2M U28 ( .A(ALU_FUN[0]), .Y(n136) );
  NOR2X2M U29 ( .A(n136), .B(n3), .Y(n105) );
  NOR2X2M U30 ( .A(n3), .B(ALU_FUN[0]), .Y(n100) );
  INVX2M U31 ( .A(ALU_FUN[1]), .Y(n139) );
  NAND3X2M U32 ( .A(n106), .B(ALU_FUN[0]), .C(n3), .Y(n101) );
  NAND2X2M U33 ( .A(EN), .B(n123), .Y(n32) );
  AND2X2M U34 ( .A(ALU_FUN[2]), .B(n139), .Y(n99) );
  AND4X2M U35 ( .A(N159), .B(n99), .C(n3), .D(n136), .Y(n90) );
  NOR3X2M U36 ( .A(n137), .B(ALU_FUN[2]), .C(n139), .Y(n35) );
  NAND3X2M U37 ( .A(n140), .B(n136), .C(n3), .Y(n36) );
  NAND3X2M U38 ( .A(n3), .B(ALU_FUN[0]), .C(n99), .Y(n91) );
  INVX2M U39 ( .A(EN), .Y(n135) );
  AOI31X2M U40 ( .A0(n93), .A1(n94), .A2(n95), .B0(n135), .Y(ALU_OUT_Comb[0])
         );
  AOI22X1M U41 ( .A0(N100), .A1(n50), .B0(N91), .B1(n37), .Y(n93) );
  AOI211X2M U42 ( .A0(n13), .A1(n134), .B0(n96), .C0(n97), .Y(n95) );
  AOI222X1M U43 ( .A0(N109), .A1(n35), .B0(n5), .B1(n42), .C0(N125), .C1(n49), 
        .Y(n94) );
  AOI31X2M U44 ( .A0(n81), .A1(n82), .A2(n83), .B0(n135), .Y(ALU_OUT_Comb[1])
         );
  AOI222X1M U45 ( .A0(N92), .A1(n37), .B0(N110), .B1(n35), .C0(N101), .C1(n50), 
        .Y(n81) );
  AOI211X2M U46 ( .A0(n7), .A1(n138), .B0(n84), .C0(n85), .Y(n83) );
  AOI222X1M U47 ( .A0(N126), .A1(n49), .B0(n13), .B1(n133), .C0(n6), .C1(n42), 
        .Y(n82) );
  AOI31X2M U48 ( .A0(n75), .A1(n76), .A2(n77), .B0(n135), .Y(ALU_OUT_Comb[2])
         );
  AOI22X1M U49 ( .A0(N102), .A1(n50), .B0(N93), .B1(n37), .Y(n75) );
  AOI221XLM U50 ( .A0(n8), .A1(n138), .B0(n13), .B1(n132), .C0(n78), .Y(n77)
         );
  AOI222X1M U51 ( .A0(N111), .A1(n35), .B0(n7), .B1(n42), .C0(N127), .C1(n49), 
        .Y(n76) );
  AOI31X2M U52 ( .A0(n69), .A1(n70), .A2(n71), .B0(n135), .Y(ALU_OUT_Comb[3])
         );
  AOI22X1M U53 ( .A0(N103), .A1(n50), .B0(N94), .B1(n37), .Y(n69) );
  AOI221XLM U54 ( .A0(n9), .A1(n138), .B0(n13), .B1(n131), .C0(n72), .Y(n71)
         );
  AOI222X1M U55 ( .A0(N112), .A1(n35), .B0(n8), .B1(n42), .C0(N128), .C1(n49), 
        .Y(n70) );
  AOI31X2M U56 ( .A0(n63), .A1(n64), .A2(n65), .B0(n135), .Y(ALU_OUT_Comb[4])
         );
  AOI22X1M U57 ( .A0(N104), .A1(n50), .B0(N95), .B1(n37), .Y(n63) );
  AOI221XLM U58 ( .A0(n138), .A1(n10), .B0(n13), .B1(n130), .C0(n66), .Y(n65)
         );
  AOI222X1M U59 ( .A0(N113), .A1(n35), .B0(n9), .B1(n42), .C0(N129), .C1(n49), 
        .Y(n64) );
  AOI31X2M U60 ( .A0(n38), .A1(n39), .A2(n40), .B0(n135), .Y(ALU_OUT_Comb[7])
         );
  AOI22X1M U61 ( .A0(N107), .A1(n50), .B0(N98), .B1(n37), .Y(n38) );
  AOI221XLM U62 ( .A0(n13), .A1(n127), .B0(n42), .B1(n12), .C0(n43), .Y(n40)
         );
  AOI22X1M U63 ( .A0(N132), .A1(n49), .B0(N116), .B1(n35), .Y(n39) );
  AOI31X2M U64 ( .A0(n57), .A1(n58), .A2(n59), .B0(n135), .Y(ALU_OUT_Comb[5])
         );
  AOI22X1M U65 ( .A0(N105), .A1(n50), .B0(N96), .B1(n37), .Y(n57) );
  AOI221XLM U66 ( .A0(n138), .A1(n11), .B0(n13), .B1(n129), .C0(n60), .Y(n59)
         );
  AOI222X1M U67 ( .A0(N114), .A1(n35), .B0(n10), .B1(n42), .C0(N130), .C1(n49), 
        .Y(n58) );
  AOI21X2M U68 ( .A0(n33), .A1(n34), .B0(n135), .Y(ALU_OUT_Comb[8]) );
  AOI21X2M U69 ( .A0(N99), .A1(n37), .B0(n123), .Y(n33) );
  AOI2BB2XLM U70 ( .B0(N117), .B1(n35), .A0N(n127), .A1N(n36), .Y(n34) );
  OAI222X1M U71 ( .A0(n55), .A1(n122), .B0(n4), .B1(n56), .C0(n36), .C1(n129), 
        .Y(n54) );
  AOI221XLM U72 ( .A0(n11), .A1(n46), .B0(n47), .B1(n128), .C0(n13), .Y(n56)
         );
  AOI221XLM U73 ( .A0(n46), .A1(n128), .B0(n11), .B1(n48), .C0(n42), .Y(n55)
         );
  INVX2M U74 ( .A(n25), .Y(n120) );
  AOI31X2M U75 ( .A0(n51), .A1(n52), .A2(n53), .B0(n135), .Y(ALU_OUT_Comb[6])
         );
  AOI22X1M U76 ( .A0(N106), .A1(n50), .B0(N97), .B1(n37), .Y(n51) );
  AOI221XLM U77 ( .A0(n138), .A1(n12), .B0(n13), .B1(n128), .C0(n54), .Y(n53)
         );
  AOI222X1M U78 ( .A0(N115), .A1(n35), .B0(n42), .B1(n11), .C0(N131), .C1(n49), 
        .Y(n52) );
  INVX2M U79 ( .A(n92), .Y(n123) );
  AOI211X2M U80 ( .A0(N108), .A1(n50), .B0(n13), .C0(n47), .Y(n92) );
  INVX2M U81 ( .A(n116), .Y(N158) );
  INVX2M U82 ( .A(n4), .Y(n122) );
  BUFX2M U83 ( .A(ALU_FUN[3]), .Y(n3) );
  INVX2M U84 ( .A(n6), .Y(n133) );
  INVX2M U85 ( .A(n5), .Y(n134) );
  INVX2M U86 ( .A(n11), .Y(n128) );
  INVX2M U87 ( .A(n12), .Y(n127) );
  INVX2M U88 ( .A(n8), .Y(n131) );
  INVX2M U89 ( .A(n7), .Y(n132) );
  INVX2M U90 ( .A(n10), .Y(n129) );
  INVX2M U91 ( .A(n9), .Y(n130) );
  BUFX2M U92 ( .A(B[6]), .Y(n4) );
  BUFX2M U93 ( .A(A[7]), .Y(n12) );
  BUFX2M U94 ( .A(A[5]), .Y(n10) );
  BUFX2M U95 ( .A(A[4]), .Y(n9) );
  BUFX2M U96 ( .A(A[3]), .Y(n8) );
  BUFX2M U97 ( .A(A[2]), .Y(n7) );
  BUFX2M U98 ( .A(A[1]), .Y(n6) );
  BUFX2M U99 ( .A(A[0]), .Y(n5) );
  OAI2B2X1M U100 ( .A1N(B[0]), .A0(n98), .B0(n91), .B1(n133), .Y(n97) );
  AOI221XLM U101 ( .A0(n46), .A1(n134), .B0(n5), .B1(n48), .C0(n42), .Y(n98)
         );
  OAI222X1M U102 ( .A0(n79), .A1(n119), .B0(B[2]), .B1(n80), .C0(n36), .C1(
        n133), .Y(n78) );
  AOI221XLM U103 ( .A0(n7), .A1(n46), .B0(n47), .B1(n132), .C0(n13), .Y(n80)
         );
  AOI221XLM U104 ( .A0(n46), .A1(n132), .B0(n7), .B1(n48), .C0(n42), .Y(n79)
         );
  OAI222X1M U105 ( .A0(n73), .A1(n121), .B0(B[3]), .B1(n74), .C0(n36), .C1(
        n132), .Y(n72) );
  AOI221XLM U106 ( .A0(n8), .A1(n46), .B0(n47), .B1(n131), .C0(n13), .Y(n74)
         );
  AOI221XLM U107 ( .A0(n46), .A1(n131), .B0(n8), .B1(n48), .C0(n42), .Y(n73)
         );
  OAI222X1M U108 ( .A0(n67), .A1(n126), .B0(B[4]), .B1(n68), .C0(n36), .C1(
        n131), .Y(n66) );
  INVX2M U109 ( .A(B[4]), .Y(n126) );
  AOI221XLM U110 ( .A0(n9), .A1(n46), .B0(n47), .B1(n130), .C0(n13), .Y(n68)
         );
  AOI221XLM U111 ( .A0(n46), .A1(n130), .B0(n9), .B1(n48), .C0(n42), .Y(n67)
         );
  OAI222X1M U112 ( .A0(n61), .A1(n125), .B0(B[5]), .B1(n62), .C0(n36), .C1(
        n130), .Y(n60) );
  INVX2M U113 ( .A(B[5]), .Y(n125) );
  AOI221XLM U114 ( .A0(n10), .A1(n46), .B0(n47), .B1(n129), .C0(n13), .Y(n62)
         );
  AOI221XLM U115 ( .A0(n46), .A1(n129), .B0(n10), .B1(n48), .C0(n42), .Y(n61)
         );
  OAI222X1M U116 ( .A0(n44), .A1(n124), .B0(B[7]), .B1(n45), .C0(n36), .C1(
        n128), .Y(n43) );
  INVX2M U117 ( .A(B[7]), .Y(n124) );
  AOI221XLM U118 ( .A0(n46), .A1(n12), .B0(n47), .B1(n127), .C0(n13), .Y(n45)
         );
  AOI221XLM U119 ( .A0(n46), .A1(n127), .B0(n12), .B1(n48), .C0(n42), .Y(n44)
         );
  INVX2M U120 ( .A(n14), .Y(n118) );
  OAI21X2M U121 ( .A0(B[0]), .A1(n102), .B0(n103), .Y(n96) );
  AOI221XLM U122 ( .A0(n5), .A1(n46), .B0(n47), .B1(n134), .C0(n13), .Y(n102)
         );
  AOI31X2M U123 ( .A0(N157), .A1(n3), .A2(n104), .B0(n90), .Y(n103) );
  NOR3X2M U124 ( .A(n139), .B(ALU_FUN[2]), .C(ALU_FUN[0]), .Y(n104) );
  OAI21X2M U125 ( .A0(B[1]), .A1(n87), .B0(n88), .Y(n84) );
  AOI221XLM U126 ( .A0(n6), .A1(n46), .B0(n47), .B1(n133), .C0(n13), .Y(n87)
         );
  AOI31X2M U127 ( .A0(N158), .A1(n3), .A2(n89), .B0(n90), .Y(n88) );
  NOR3X2M U128 ( .A(n136), .B(ALU_FUN[2]), .C(n139), .Y(n89) );
  OAI2B2X1M U129 ( .A1N(B[1]), .A0(n86), .B0(n36), .B1(n134), .Y(n85) );
  AOI221XLM U130 ( .A0(n46), .A1(n133), .B0(n6), .B1(n48), .C0(n42), .Y(n86)
         );
  INVX2M U131 ( .A(B[0]), .Y(n117) );
  INVX2M U132 ( .A(B[2]), .Y(n119) );
  INVX2M U133 ( .A(B[3]), .Y(n121) );
  NOR2X1M U134 ( .A(n127), .B(B[7]), .Y(n113) );
  NAND2BX1M U135 ( .AN(B[4]), .B(n9), .Y(n29) );
  NAND2BX1M U136 ( .AN(n9), .B(B[4]), .Y(n18) );
  CLKNAND2X2M U137 ( .A(n29), .B(n18), .Y(n108) );
  NOR2X1M U138 ( .A(n121), .B(n8), .Y(n26) );
  NOR2X1M U139 ( .A(n119), .B(n7), .Y(n17) );
  NOR2X1M U140 ( .A(n117), .B(n5), .Y(n14) );
  CLKNAND2X2M U141 ( .A(n7), .B(n119), .Y(n28) );
  NAND2BX1M U142 ( .AN(n17), .B(n28), .Y(n23) );
  AOI21X1M U143 ( .A0(n14), .A1(n133), .B0(B[1]), .Y(n15) );
  AOI211X1M U144 ( .A0(n6), .A1(n118), .B0(n23), .C0(n15), .Y(n16) );
  CLKNAND2X2M U145 ( .A(n8), .B(n121), .Y(n27) );
  OAI31X1M U146 ( .A0(n26), .A1(n17), .A2(n16), .B0(n27), .Y(n19) );
  NAND2BX1M U147 ( .AN(n10), .B(B[5]), .Y(n111) );
  OAI211X1M U148 ( .A0(n108), .A1(n19), .B0(n18), .C0(n111), .Y(n20) );
  NAND2BX1M U149 ( .AN(B[5]), .B(n10), .Y(n30) );
  XNOR2X1M U150 ( .A(n11), .B(n4), .Y(n110) );
  AOI32X1M U151 ( .A0(n20), .A1(n30), .A2(n110), .B0(n4), .B1(n128), .Y(n21)
         );
  CLKNAND2X2M U152 ( .A(B[7]), .B(n127), .Y(n114) );
  OAI21X1M U153 ( .A0(n113), .A1(n21), .B0(n114), .Y(N159) );
  CLKNAND2X2M U154 ( .A(n5), .B(n117), .Y(n24) );
  OA21X1M U155 ( .A0(n24), .A1(n133), .B0(B[1]), .Y(n22) );
  AOI211X1M U156 ( .A0(n24), .A1(n133), .B0(n23), .C0(n22), .Y(n25) );
  AOI31X1M U157 ( .A0(n120), .A1(n28), .A2(n27), .B0(n26), .Y(n109) );
  OAI2B11X1M U158 ( .A1N(n109), .A0(n108), .B0(n30), .C0(n29), .Y(n112) );
  AOI32X1M U159 ( .A0(n112), .A1(n111), .A2(n110), .B0(n11), .B1(n122), .Y(
        n115) );
  AOI2B1X1M U160 ( .A1N(n115), .A0(n114), .B0(n113), .Y(n116) );
  NOR2X1M U161 ( .A(N159), .B(N158), .Y(N157) );
endmodule


module SYS_TOP ( REF_CLK, RST, UART_CLK, RX_IN, par_err_reg, stp_error_reg, 
        TX_OUT );
  input REF_CLK, RST, UART_CLK, RX_IN;
  output par_err_reg, stp_error_reg, TX_OUT;
  wire   RX_CLK, SYNC_RST_UART, data_valid_reg_RX, busy, TX_CLK, rempty,
         SYNC_RST_sys, RX_D_VLD, OUT_Valid, RdData_Valid, ALU_EN,
         CLK_GATING_EN, Wr_En, Rd_En, TX_D_VLD, wfull, ALU_CLK, rinc,
         \Div_Ratio_RX[1] , n4, n5, n6, n7, n8, n9, n10, n11, n12;
  wire   [5:0] prescale;
  wire   [1:0] REG2;
  wire   [7:0] P_DATA_reg_RX;
  wire   [7:0] r_data;
  wire   [7:0] RX_P_Data;
  wire   [15:0] ALU_OUT;
  wire   [7:0] RdData;
  wire   [3:0] ALU_FUN;
  wire   [3:0] Address;
  wire   [7:0] Wr_Data;
  wire   [7:0] TX_P_Data;
  wire   [7:0] REG3;
  wire   [7:0] REG0;
  wire   [7:0] REG1;

  UART_RX RX ( .clk(RX_CLK), .rst(SYNC_RST_UART), .RX_IN(RX_IN), .prescale(
        prescale), .PAR_EN(REG2[0]), .PAR_TYP(REG2[1]), .data_valid_reg(
        data_valid_reg_RX), .par_err_reg(par_err_reg), .stp_error_reg(
        stp_error_reg), .P_DATA_reg(P_DATA_reg_RX) );
  UART_TX TX ( .P_DATA(r_data), .Data_Valid(n10), .PAR_TYP(REG2[1]), .PAR_EN(
        REG2[0]), .TX_OUT(TX_OUT), .busy(busy), .clk(TX_CLK), .rst(
        SYNC_RST_UART) );
  RST_SYNC_0 RST_SYNC_REF_CLK ( .RST(RST), .CLK(REF_CLK), .SYNC_RST(
        SYNC_RST_sys) );
  RST_SYNC_1 RST_SYNC_UART_CLK ( .RST(RST), .CLK(UART_CLK), .SYNC_RST(
        SYNC_RST_UART) );
  DATA_SYNC DATA_SYNC ( .unsync_bus(P_DATA_reg_RX), .bus_enable(
        data_valid_reg_RX), .clk(REF_CLK), .rst(n8), .sync_bus(RX_P_Data), 
        .enable_pulse(RX_D_VLD) );
  SYS_CTRL SYS_CTRL ( .CLK(REF_CLK), .RST(n8), .ALU_OUT(ALU_OUT), .OUT_Valid(
        OUT_Valid), .RX_P_Data(RX_P_Data), .RX_D_VLD(RX_D_VLD), .RdData(RdData), .RdData_Valid(RdData_Valid), .ALU_EN(ALU_EN), .ALU_FUN(ALU_FUN), 
        .CLK_GATING_EN(CLK_GATING_EN), .Address(Address), .Wr_En(Wr_En), 
        .Rd_En(Rd_En), .Wr_Data(Wr_Data), .TX_P_Data(TX_P_Data), .TX_D_VLD(
        TX_D_VLD), .wfull(wfull) );
  clock_gating clk_gating ( .CLK_EN(CLK_GATING_EN), .CLK(REF_CLK), .GATED_CLK(
        ALU_CLK) );
  Pulse_Gen_0 PULSE_GEN ( .clk(TX_CLK), .rst(SYNC_RST_UART), .in(busy), .out(
        rinc) );
  ClkDiv_Range_for_division8 CLK_DIV_TX ( .i_ref_clk(UART_CLK), .i_rst_n(
        SYNC_RST_UART), .i_clk_en(1'b1), .i_div_ratio(REG3), .o_div_clk(TX_CLK) );
  ClkDiv_Range_for_division2 CLK_DIV_RX ( .i_ref_clk(UART_CLK), .i_rst_n(
        SYNC_RST_UART), .i_clk_en(1'b1), .i_div_ratio({\Div_Ratio_RX[1] , n11}), .o_div_clk(RX_CLK) );
  FIFO_TOP FIFO ( .w_data(TX_P_Data), .winc(TX_D_VLD), .w_clk(REF_CLK), 
        .wrst_n(n8), .wfull(wfull), .r_data(r_data), .rinc(rinc), .rempty(
        rempty), .r_clk(TX_CLK), .rrst_n(SYNC_RST_UART) );
  RegFile REG ( .CLK(REF_CLK), .RST(n8), .WrEn(Wr_En), .RdEn(Rd_En), .Address(
        {Address[3:1], n7}), .WrData(Wr_Data), .RdData(RdData), .RdData_VLD(
        RdData_Valid), .REG0(REG0), .REG1(REG1), .REG2({prescale, REG2}), 
        .REG3(REG3) );
  ALU ALU ( .A(REG0), .B(REG1), .EN(ALU_EN), .ALU_FUN(ALU_FUN), .CLK(ALU_CLK), 
        .RST(n8), .ALU_OUT(ALU_OUT), .OUT_VALID(OUT_Valid) );
  INVX4M U10 ( .A(n9), .Y(n8) );
  BUFX2M U11 ( .A(Address[0]), .Y(n7) );
  INVX2M U12 ( .A(rempty), .Y(n10) );
  NAND3BX2M U13 ( .AN(prescale[5]), .B(n12), .C(prescale[4]), .Y(n4) );
  NOR4X1M U14 ( .A(prescale[2]), .B(prescale[1]), .C(prescale[0]), .D(n4), .Y(
        \Div_Ratio_RX[1] ) );
  INVX2M U15 ( .A(SYNC_RST_sys), .Y(n9) );
  INVX2M U16 ( .A(n5), .Y(n11) );
  NOR4BX1M U17 ( .AN(n6), .B(prescale[0]), .C(prescale[1]), .D(prescale[2]), 
        .Y(n5) );
  OAI31X1M U18 ( .A0(n12), .A1(prescale[5]), .A2(prescale[4]), .B0(n4), .Y(n6)
         );
  INVX2M U19 ( .A(prescale[3]), .Y(n12) );
endmodule

