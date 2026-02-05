/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Sun Aug 18 02:45:35 2024
/////////////////////////////////////////////////////////////


module FSM_test_1 ( clk, rst, system_outputs_flag, edge_cnt_flag, RX_IN, 
        PAR_EN, bit_cnt, par_err, strt_glitch, stp_error, enable, 
        dat_sample_en, deser_en, data_valid, par_chk_en, strt_chk_en, 
        stp_chk_en, new_op_flag, test_si, test_so, test_se );
  input [3:0] bit_cnt;
  input clk, rst, system_outputs_flag, edge_cnt_flag, RX_IN, PAR_EN, par_err,
         strt_glitch, stp_error, test_si, test_se;
  output enable, dat_sample_en, deser_en, data_valid, par_chk_en, strt_chk_en,
         stp_chk_en, new_op_flag, test_so;
  wire   n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n6, n7, n8, n9, n10, n25, n26;
  wire   [2:0] cs;
  wire   [2:0] ns;
  assign test_so = cs[2];

  SDFFRQX2M \cs_reg[1]  ( .D(ns[1]), .SI(cs[0]), .SE(test_se), .CK(clk), .RN(
        rst), .Q(cs[1]) );
  SDFFRQX2M \cs_reg[2]  ( .D(ns[2]), .SI(n26), .SE(test_se), .CK(clk), .RN(rst), .Q(cs[2]) );
  SDFFRX1M \cs_reg[0]  ( .D(ns[0]), .SI(test_si), .SE(test_se), .CK(clk), .RN(
        rst), .Q(cs[0]), .QN(n10) );
  NOR3X2M U7 ( .A(cs[1]), .B(cs[2]), .C(n10), .Y(new_op_flag) );
  NOR2BX2M U8 ( .AN(stp_chk_en), .B(stp_error), .Y(data_valid) );
  INVXLM U9 ( .A(edge_cnt_flag), .Y(n8) );
  OAI221X1M U10 ( .A0(n13), .A1(n25), .B0(strt_glitch), .B1(n11), .C0(n18), 
        .Y(ns[1]) );
  INVX2M U11 ( .A(n11), .Y(strt_chk_en) );
  NAND2XLM U12 ( .A(edge_cnt_flag), .B(new_op_flag), .Y(n11) );
  NOR2X2M U13 ( .A(n8), .B(n25), .Y(deser_en) );
  OAI2BB1X2M U14 ( .A0N(n13), .A1N(n14), .B0(n15), .Y(ns[2]) );
  AOI33XLM U15 ( .A0(n16), .A1(n8), .A2(n9), .B0(edge_cnt_flag), .B1(n17), 
        .B2(n12), .Y(n15) );
  NAND2X2M U16 ( .A(stp_error), .B(system_outputs_flag), .Y(n16) );
  NAND2X2M U17 ( .A(par_err), .B(system_outputs_flag), .Y(n17) );
  AND2X1M U18 ( .A(system_outputs_flag), .B(n9), .Y(stp_chk_en) );
  INVX2M U19 ( .A(n14), .Y(n25) );
  INVX2M U20 ( .A(n23), .Y(n9) );
  NAND2X2M U21 ( .A(n20), .B(n18), .Y(ns[0]) );
  AOI32X1M U22 ( .A0(n10), .A1(n26), .A2(n22), .B0(new_op_flag), .B1(n8), .Y(
        n20) );
  OAI32X1M U23 ( .A0(n8), .A1(RX_IN), .A2(n6), .B0(cs[2]), .B1(RX_IN), .Y(n22)
         );
  INVX2M U24 ( .A(n16), .Y(n6) );
  NAND3XLM U25 ( .A(bit_cnt[3]), .B(edge_cnt_flag), .C(n21), .Y(n19) );
  NOR3X2M U26 ( .A(bit_cnt[0]), .B(bit_cnt[2]), .C(bit_cnt[1]), .Y(n21) );
  AOI33X2M U27 ( .A0(n12), .A1(n8), .A2(n17), .B0(PAR_EN), .B1(n7), .B2(n14), 
        .Y(n18) );
  INVX2M U28 ( .A(n19), .Y(n7) );
  NOR2X2M U29 ( .A(n19), .B(PAR_EN), .Y(n13) );
  AND2X1M U30 ( .A(system_outputs_flag), .B(n12), .Y(par_chk_en) );
  OAI21BX1M U31 ( .A0(cs[0]), .A1(cs[1]), .B0N(cs[2]), .Y(n24) );
  NOR3X2M U32 ( .A(cs[0]), .B(cs[2]), .C(n26), .Y(n14) );
  NOR3X2M U33 ( .A(n10), .B(cs[2]), .C(n26), .Y(n12) );
  NAND3X2M U34 ( .A(n10), .B(n26), .C(cs[2]), .Y(n23) );
  INVX2M U35 ( .A(cs[1]), .Y(n26) );
  BUFX2M U36 ( .A(enable), .Y(dat_sample_en) );
  NAND2X2M U37 ( .A(n23), .B(n24), .Y(enable) );
endmodule


module edge_bit_counter_test_1 ( clk, rst, PAR_EN, enable, prescale, edge_cnt, 
        bit_cnt, edge_cnt_flag, system_outputs_flag, test_si, test_so, test_se
 );
  input [5:0] prescale;
  output [4:0] edge_cnt;
  output [3:0] bit_cnt;
  input clk, rst, PAR_EN, enable, test_si, test_se;
  output edge_cnt_flag, system_outputs_flag, test_so;
  wire   N10, N11, N12, N13, N14, N21, N22, N23, N24, N25, bit_cnt_flag, N48,
         N51, N52, N53, N54, N55, N56, N57, N58, N59, N60, N61, N62, n7, n13,
         n14, n15, n16, n17, n18, n21, n22, n23, n34, n36, n38, n40, n42, n44,
         n47, n48, n49, n50, \sub_85/carry[5] , \sub_85/carry[4] ,
         \sub_85/carry[3] , \add_24/carry[4] , \add_24/carry[3] ,
         \add_24/carry[2] , n1, n3, n4, n5, n6, n8, n9, n10, n11, n12, n19,
         n20, n24, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n70, n71;
  wire   [5:0] prescale_sampled;
  assign test_so = prescale_sampled[5];

  SDFFRQX2M \bit_cnt_reg[3]  ( .D(n50), .SI(n65), .SE(n71), .CK(clk), .RN(rst), 
        .Q(bit_cnt[3]) );
  SDFFRQX2M \bit_cnt_reg[2]  ( .D(n47), .SI(n64), .SE(n71), .CK(clk), .RN(rst), 
        .Q(bit_cnt[2]) );
  SDFFRQX2M \bit_cnt_reg[1]  ( .D(n48), .SI(n63), .SE(n71), .CK(clk), .RN(rst), 
        .Q(bit_cnt[1]) );
  SDFFRQX2M \bit_cnt_reg[0]  ( .D(n49), .SI(bit_cnt_flag), .SE(n71), .CK(clk), 
        .RN(rst), .Q(bit_cnt[0]) );
  SDFFRQX2M \edge_cnt_reg[4]  ( .D(N25), .SI(edge_cnt[3]), .SE(n71), .CK(clk), 
        .RN(rst), .Q(edge_cnt[4]) );
  SDFFRQX2M \prescale_sampled_reg[5]  ( .D(n44), .SI(prescale_sampled[4]), 
        .SE(n71), .CK(clk), .RN(rst), .Q(prescale_sampled[5]) );
  SDFFRQX2M \prescale_sampled_reg[4]  ( .D(n42), .SI(prescale_sampled[3]), 
        .SE(n71), .CK(clk), .RN(rst), .Q(prescale_sampled[4]) );
  SDFFRQX2M \edge_cnt_reg[0]  ( .D(N21), .SI(n62), .SE(n71), .CK(clk), .RN(rst), .Q(edge_cnt[0]) );
  SDFFRQX2M \edge_cnt_reg[3]  ( .D(N24), .SI(edge_cnt[2]), .SE(n71), .CK(clk), 
        .RN(rst), .Q(edge_cnt[3]) );
  SDFFRQX2M \edge_cnt_reg[2]  ( .D(N23), .SI(edge_cnt[1]), .SE(n71), .CK(clk), 
        .RN(rst), .Q(edge_cnt[2]) );
  SDFFRQX2M \edge_cnt_reg[1]  ( .D(N22), .SI(N10), .SE(n71), .CK(clk), .RN(rst), .Q(edge_cnt[1]) );
  SDFFRQX2M \prescale_sampled_reg[2]  ( .D(n38), .SI(N58), .SE(n71), .CK(clk), 
        .RN(rst), .Q(prescale_sampled[2]) );
  SDFFRQX2M \prescale_sampled_reg[3]  ( .D(n40), .SI(prescale_sampled[2]), 
        .SE(n71), .CK(clk), .RN(rst), .Q(prescale_sampled[3]) );
  SDFFRQX2M \prescale_sampled_reg[1]  ( .D(n36), .SI(N51), .SE(n71), .CK(clk), 
        .RN(rst), .Q(prescale_sampled[1]) );
  SDFFRQX2M \prescale_sampled_reg[0]  ( .D(n34), .SI(edge_cnt[4]), .SE(n71), 
        .CK(clk), .RN(rst), .Q(N57) );
  SDFFRX1M bit_cnt_flag_reg ( .D(N48), .SI(test_si), .SE(n71), .CK(clk), .RN(
        rst), .Q(bit_cnt_flag), .QN(n60) );
  NOR2X2M U3 ( .A(prescale_sampled[5]), .B(\sub_85/carry[5] ), .Y(n1) );
  INVX2M U5 ( .A(n7), .Y(n61) );
  NOR2X2M U6 ( .A(n66), .B(edge_cnt_flag), .Y(n18) );
  NAND3X2M U7 ( .A(edge_cnt_flag), .B(n60), .C(enable), .Y(n13) );
  AOI31X2M U8 ( .A0(enable), .A1(n60), .A2(n14), .B0(n18), .Y(n15) );
  AND2X2M U9 ( .A(N13), .B(n18), .Y(N24) );
  AND2X2M U10 ( .A(N12), .B(n18), .Y(N23) );
  AND2X2M U11 ( .A(N11), .B(n18), .Y(N22) );
  NAND4X2M U12 ( .A(n63), .B(n64), .C(n65), .D(n62), .Y(n7) );
  INVX2M U13 ( .A(enable), .Y(n66) );
  OAI32X1M U14 ( .A0(n66), .A1(bit_cnt_flag), .A2(n21), .B0(n15), .B1(n62), 
        .Y(n50) );
  AOI32XLM U15 ( .A0(edge_cnt_flag), .A1(n62), .A2(n22), .B0(bit_cnt[3]), .B1(
        n65), .Y(n21) );
  NOR2X2M U16 ( .A(n14), .B(n65), .Y(n22) );
  OAI32X1M U17 ( .A0(n13), .A1(bit_cnt[2]), .A2(n14), .B0(n15), .B1(n65), .Y(
        n47) );
  OAI31X1M U18 ( .A0(n13), .A1(bit_cnt[1]), .A2(n63), .B0(n16), .Y(n48) );
  OAI21X2M U19 ( .A0(n17), .A1(n18), .B0(bit_cnt[1]), .Y(n16) );
  NOR2X2M U20 ( .A(n13), .B(bit_cnt[0]), .Y(n17) );
  OR2X2M U21 ( .A(prescale_sampled[1]), .B(N57), .Y(n3) );
  AO21XLM U22 ( .A0(bit_cnt[0]), .A1(n18), .B0(n17), .Y(n49) );
  INVX2M U23 ( .A(prescale_sampled[3]), .Y(n8) );
  AND2X2M U24 ( .A(N14), .B(n18), .Y(N25) );
  AND2X2M U25 ( .A(N10), .B(n18), .Y(N21) );
  INVX2M U26 ( .A(prescale_sampled[1]), .Y(N58) );
  NOR3X2M U27 ( .A(n62), .B(bit_cnt[2]), .C(n23), .Y(N48) );
  AOI33X2M U28 ( .A0(n67), .A1(n64), .A2(bit_cnt[0]), .B0(bit_cnt[1]), .B1(n63), .B2(PAR_EN), .Y(n23) );
  INVX2M U29 ( .A(PAR_EN), .Y(n67) );
  NAND2X2M U30 ( .A(bit_cnt[1]), .B(bit_cnt[0]), .Y(n14) );
  INVX2M U31 ( .A(bit_cnt[2]), .Y(n65) );
  INVX2M U32 ( .A(bit_cnt[0]), .Y(n63) );
  INVX2M U33 ( .A(bit_cnt[3]), .Y(n62) );
  INVX2M U34 ( .A(bit_cnt[1]), .Y(n64) );
  ADDHX1M U35 ( .A(edge_cnt[1]), .B(edge_cnt[0]), .CO(\add_24/carry[2] ), .S(
        N11) );
  ADDHX1M U36 ( .A(edge_cnt[2]), .B(\add_24/carry[2] ), .CO(\add_24/carry[3] ), 
        .S(N12) );
  AO22X1M U37 ( .A0(N57), .A1(n7), .B0(prescale[0]), .B1(n61), .Y(n34) );
  AO22X1M U38 ( .A0(prescale_sampled[1]), .A1(n7), .B0(prescale[1]), .B1(n61), 
        .Y(n36) );
  AO22X1M U39 ( .A0(prescale_sampled[2]), .A1(n7), .B0(prescale[2]), .B1(n61), 
        .Y(n38) );
  AO22X1M U56 ( .A0(prescale_sampled[3]), .A1(n7), .B0(prescale[3]), .B1(n61), 
        .Y(n40) );
  AO22X1M U57 ( .A0(prescale_sampled[4]), .A1(n7), .B0(prescale[4]), .B1(n61), 
        .Y(n42) );
  AO22X1M U58 ( .A0(prescale_sampled[5]), .A1(n7), .B0(prescale[5]), .B1(n61), 
        .Y(n44) );
  ADDHX1M U59 ( .A(edge_cnt[3]), .B(\add_24/carry[3] ), .CO(\add_24/carry[4] ), 
        .S(N13) );
  XNOR2X1M U60 ( .A(\sub_85/carry[5] ), .B(prescale_sampled[5]), .Y(N62) );
  OR2X1M U61 ( .A(prescale_sampled[4]), .B(\sub_85/carry[4] ), .Y(
        \sub_85/carry[5] ) );
  XNOR2X1M U62 ( .A(\sub_85/carry[4] ), .B(prescale_sampled[4]), .Y(N61) );
  OR2X1M U63 ( .A(prescale_sampled[3]), .B(\sub_85/carry[3] ), .Y(
        \sub_85/carry[4] ) );
  XNOR2X1M U64 ( .A(\sub_85/carry[3] ), .B(prescale_sampled[3]), .Y(N60) );
  OR2X1M U65 ( .A(prescale_sampled[2]), .B(prescale_sampled[1]), .Y(
        \sub_85/carry[3] ) );
  XNOR2X1M U66 ( .A(prescale_sampled[1]), .B(prescale_sampled[2]), .Y(N59) );
  CLKINVX1M U67 ( .A(edge_cnt[0]), .Y(N10) );
  CLKXOR2X2M U68 ( .A(\add_24/carry[4] ), .B(edge_cnt[4]), .Y(N14) );
  CLKINVX1M U69 ( .A(N57), .Y(N51) );
  OAI2BB1X1M U70 ( .A0N(N57), .A1N(prescale_sampled[1]), .B0(n3), .Y(N52) );
  NOR2X1M U71 ( .A(n3), .B(prescale_sampled[2]), .Y(n4) );
  AO21XLM U72 ( .A0(n3), .A1(prescale_sampled[2]), .B0(n4), .Y(N53) );
  CLKNAND2X2M U73 ( .A(n4), .B(n8), .Y(n5) );
  OAI21X1M U74 ( .A0(n4), .A1(n8), .B0(n5), .Y(N54) );
  XNOR2X1M U75 ( .A(prescale_sampled[4]), .B(n5), .Y(N55) );
  NOR2X1M U76 ( .A(prescale_sampled[4]), .B(n5), .Y(n6) );
  CLKXOR2X2M U77 ( .A(prescale_sampled[5]), .B(n6), .Y(N56) );
  NOR2BX1M U78 ( .AN(N51), .B(edge_cnt[0]), .Y(n9) );
  OAI2B2X1M U79 ( .A1N(edge_cnt[1]), .A0(n9), .B0(N52), .B1(n9), .Y(n12) );
  NOR2BX1M U80 ( .AN(edge_cnt[0]), .B(N51), .Y(n10) );
  OAI2B2X1M U81 ( .A1N(N52), .A0(n10), .B0(edge_cnt[1]), .B1(n10), .Y(n11) );
  NAND3BX1M U82 ( .AN(N56), .B(n12), .C(n11), .Y(n51) );
  CLKXOR2X2M U83 ( .A(N55), .B(edge_cnt[4]), .Y(n24) );
  CLKXOR2X2M U84 ( .A(N53), .B(edge_cnt[2]), .Y(n20) );
  CLKXOR2X2M U85 ( .A(N54), .B(edge_cnt[3]), .Y(n19) );
  NOR4X1M U86 ( .A(n51), .B(n24), .C(n20), .D(n19), .Y(edge_cnt_flag) );
  NOR2BX1M U87 ( .AN(edge_cnt[0]), .B(N57), .Y(n52) );
  OAI2B2X1M U88 ( .A1N(N58), .A0(n52), .B0(edge_cnt[1]), .B1(n52), .Y(n55) );
  NOR2BX1M U89 ( .AN(N57), .B(edge_cnt[0]), .Y(n53) );
  OAI2B2X1M U90 ( .A1N(edge_cnt[1]), .A0(n53), .B0(N58), .B1(n53), .Y(n54) );
  NAND4BBX1M U91 ( .AN(n1), .BN(N62), .C(n55), .D(n54), .Y(n59) );
  CLKXOR2X2M U92 ( .A(N61), .B(edge_cnt[4]), .Y(n58) );
  CLKXOR2X2M U93 ( .A(N59), .B(edge_cnt[2]), .Y(n57) );
  CLKXOR2X2M U94 ( .A(N60), .B(edge_cnt[3]), .Y(n56) );
  NOR4X1M U95 ( .A(n59), .B(n58), .C(n57), .D(n56), .Y(system_outputs_flag) );
  INVXLM U96 ( .A(test_se), .Y(n70) );
  INVXLM U97 ( .A(n70), .Y(n71) );
endmodule


module deserializer_test_1 ( clk, rst, new_op_flag, deser_en, sampled_bit, 
        P_DATA, test_si, test_so, test_se );
  output [7:0] P_DATA;
  input clk, rst, new_op_flag, deser_en, sampled_bit, test_si, test_se;
  output test_so;
  wire   n9, n10, n11, n12, n13, n14, n15, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n16, n17;
  assign test_so = n9;

  SDFFRX1M \P_DATA_reg[5]  ( .D(n23), .SI(n12), .SE(test_se), .CK(clk), .RN(
        rst), .Q(P_DATA[5]), .QN(n11) );
  SDFFRX1M \P_DATA_reg[1]  ( .D(n27), .SI(P_DATA[0]), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(P_DATA[1]), .QN(n15) );
  SDFFRX1M \P_DATA_reg[4]  ( .D(n24), .SI(n13), .SE(test_se), .CK(clk), .RN(
        rst), .Q(P_DATA[4]), .QN(n12) );
  SDFFRQX2M \P_DATA_reg[0]  ( .D(n20), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(P_DATA[0]) );
  SDFFRX1M \P_DATA_reg[7]  ( .D(n21), .SI(n10), .SE(test_se), .CK(clk), .RN(
        rst), .Q(P_DATA[7]), .QN(n9) );
  SDFFRX1M \P_DATA_reg[3]  ( .D(n25), .SI(n14), .SE(test_se), .CK(clk), .RN(
        rst), .Q(P_DATA[3]), .QN(n13) );
  SDFFRX1M \P_DATA_reg[6]  ( .D(n22), .SI(n11), .SE(test_se), .CK(clk), .RN(
        rst), .Q(P_DATA[6]), .QN(n10) );
  SDFFRX1M \P_DATA_reg[2]  ( .D(n26), .SI(n15), .SE(test_se), .CK(clk), .RN(
        rst), .Q(P_DATA[2]), .QN(n14) );
  INVX2M U11 ( .A(n19), .Y(n16) );
  INVX2M U12 ( .A(n18), .Y(n17) );
  NAND2BX2M U13 ( .AN(new_op_flag), .B(deser_en), .Y(n18) );
  NOR2X2M U14 ( .A(new_op_flag), .B(n17), .Y(n19) );
  OAI22X1M U15 ( .A0(n15), .A1(n16), .B0(n18), .B1(n14), .Y(n27) );
  OAI22X1M U16 ( .A0(n16), .A1(n14), .B0(n18), .B1(n13), .Y(n26) );
  OAI22X1M U17 ( .A0(n16), .A1(n13), .B0(n18), .B1(n12), .Y(n25) );
  OAI22X1M U18 ( .A0(n16), .A1(n12), .B0(n18), .B1(n11), .Y(n24) );
  OAI22X1M U19 ( .A0(n16), .A1(n11), .B0(n18), .B1(n10), .Y(n23) );
  OAI22X1M U20 ( .A0(n16), .A1(n10), .B0(n18), .B1(n9), .Y(n22) );
  OAI2BB2X1M U21 ( .B0(n18), .B1(n15), .A0N(P_DATA[0]), .A1N(n19), .Y(n20) );
  OAI2BB2X1M U22 ( .B0(n16), .B1(n9), .A0N(sampled_bit), .A1N(n17), .Y(n21) );
endmodule


module data_sampling_test_1 ( clk, rst, prescale, edge_cnt, dat_sample_en, 
        RX_IN, sampled_bit, test_si, test_so, test_se );
  input [5:0] prescale;
  input [4:0] edge_cnt;
  input clk, rst, dat_sample_en, RX_IN, test_si, test_se;
  output sampled_bit, test_so;
  wire   s3, s2, s1, n21, n22, n23, \add_14/carry[4] , \add_14/carry[3] ,
         \add_14/carry[2] , n4, n5, n6, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n40, n41, n42;
  wire   [4:0] No2;
  wire   [4:0] No3;
  assign test_so = s3;

  SDFFRX1M s1_reg ( .D(n21), .SI(test_si), .SE(test_se), .CK(clk), .RN(rst), 
        .Q(s1), .QN(n11) );
  SDFFRX1M s2_reg ( .D(n23), .SI(n11), .SE(test_se), .CK(clk), .RN(rst), .Q(s2), .QN(n12) );
  SDFFRQX1M s3_reg ( .D(n22), .SI(n12), .SE(test_se), .CK(clk), .RN(rst), .Q(
        s3) );
  ADDHX1M U9 ( .A(prescale[2]), .B(prescale[1]), .CO(\add_14/carry[2] ), .S(
        No3[1]) );
  ADDHX1M U10 ( .A(prescale[3]), .B(\add_14/carry[2] ), .CO(\add_14/carry[3] ), 
        .S(No3[2]) );
  INVX2M U11 ( .A(prescale[3]), .Y(n10) );
  ADDHX1M U12 ( .A(prescale[4]), .B(\add_14/carry[3] ), .CO(\add_14/carry[4] ), 
        .S(No3[3]) );
  CLKINVX1M U13 ( .A(prescale[1]), .Y(No2[0]) );
  NOR2X1M U14 ( .A(prescale[2]), .B(prescale[1]), .Y(n4) );
  AO21XLM U15 ( .A0(prescale[1]), .A1(prescale[2]), .B0(n4), .Y(No2[1]) );
  CLKNAND2X2M U16 ( .A(n4), .B(n10), .Y(n5) );
  OAI21X1M U17 ( .A0(n4), .A1(n10), .B0(n5), .Y(No2[2]) );
  XNOR2X1M U18 ( .A(prescale[4]), .B(n5), .Y(No2[3]) );
  NOR2X1M U19 ( .A(prescale[4]), .B(n5), .Y(n6) );
  CLKXOR2X2M U20 ( .A(prescale[5]), .B(n6), .Y(No2[4]) );
  CLKXOR2X2M U21 ( .A(\add_14/carry[4] ), .B(prescale[5]), .Y(No3[4]) );
  OAI21X1M U22 ( .A0(n11), .A1(n12), .B0(n13), .Y(sampled_bit) );
  OAI21X1M U23 ( .A0(s1), .A1(s2), .B0(s3), .Y(n13) );
  OAI22X1M U24 ( .A0(n14), .A1(n15), .B0(n16), .B1(n12), .Y(n23) );
  NOR2X1M U25 ( .A(n14), .B(n17), .Y(n16) );
  NAND4X1M U26 ( .A(n18), .B(n19), .C(n20), .D(n24), .Y(n14) );
  XNOR2X1M U27 ( .A(edge_cnt[0]), .B(No2[0]), .Y(n24) );
  NOR2X1M U28 ( .A(n25), .B(n26), .Y(n20) );
  CLKXOR2X2M U29 ( .A(edge_cnt[2]), .B(No2[2]), .Y(n26) );
  CLKXOR2X2M U30 ( .A(edge_cnt[1]), .B(No2[1]), .Y(n25) );
  XNOR2X1M U31 ( .A(edge_cnt[3]), .B(No2[3]), .Y(n19) );
  XNOR2X1M U32 ( .A(edge_cnt[4]), .B(No2[4]), .Y(n18) );
  OAI2B2X1M U33 ( .A1N(s3), .A0(n27), .B0(n15), .B1(n28), .Y(n22) );
  NOR2X1M U34 ( .A(n17), .B(n28), .Y(n27) );
  NAND4X1M U35 ( .A(n29), .B(n30), .C(n31), .D(n32), .Y(n28) );
  XNOR2X1M U36 ( .A(edge_cnt[0]), .B(No2[0]), .Y(n32) );
  NOR2X1M U37 ( .A(n33), .B(n34), .Y(n31) );
  CLKXOR2X2M U38 ( .A(edge_cnt[2]), .B(No3[2]), .Y(n34) );
  CLKXOR2X2M U39 ( .A(edge_cnt[1]), .B(No3[1]), .Y(n33) );
  XNOR2X1M U40 ( .A(edge_cnt[3]), .B(No3[3]), .Y(n30) );
  XNOR2X1M U41 ( .A(edge_cnt[4]), .B(No3[4]), .Y(n29) );
  OAI22X1M U42 ( .A0(n15), .A1(n35), .B0(n36), .B1(n11), .Y(n21) );
  NOR2X1M U43 ( .A(n17), .B(n35), .Y(n36) );
  CLKINVX1M U44 ( .A(dat_sample_en), .Y(n17) );
  NAND4X1M U45 ( .A(n37), .B(n38), .C(n39), .D(n40), .Y(n35) );
  XNOR2X1M U46 ( .A(edge_cnt[0]), .B(prescale[1]), .Y(n40) );
  NOR2X1M U47 ( .A(n41), .B(n42), .Y(n39) );
  CLKXOR2X2M U48 ( .A(prescale[3]), .B(edge_cnt[2]), .Y(n42) );
  CLKXOR2X2M U49 ( .A(prescale[2]), .B(edge_cnt[1]), .Y(n41) );
  XNOR2X1M U50 ( .A(edge_cnt[3]), .B(prescale[4]), .Y(n38) );
  XNOR2X1M U51 ( .A(edge_cnt[4]), .B(prescale[5]), .Y(n37) );
  CLKNAND2X2M U52 ( .A(RX_IN), .B(dat_sample_en), .Y(n15) );
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


module UART_RX_test_1 ( clk, rst, RX_IN, prescale, PAR_EN, PAR_TYP, 
        data_valid_reg, par_err_reg, stp_error_reg, P_DATA_reg, test_si2, 
        test_si1, test_se );
  input [5:0] prescale;
  output [7:0] P_DATA_reg;
  input clk, rst, RX_IN, PAR_EN, PAR_TYP, test_si2, test_si1, test_se;
  output data_valid_reg, par_err_reg, stp_error_reg;
  wire   system_outputs_flag, edge_cnt_flag, par_err, strt_glitch, stp_error,
         enable, dat_sample_en, deser_en, data_valid, par_chk_en, strt_chk_en,
         stp_chk_en, new_op_flag, sampled_bit, n3, n5, n7, n9, n11, n13, n15,
         n17, n1, n21, n22, n23, n24, n25, n26;
  wire   [3:0] bit_cnt;
  wire   [4:0] edge_cnt;
  wire   [7:0] P_DATA;

  SDFFRQX2M \P_DATA_reg_reg[7]  ( .D(n17), .SI(P_DATA_reg[6]), .SE(test_se), 
        .CK(clk), .RN(n1), .Q(P_DATA_reg[7]) );
  SDFFRQX2M \P_DATA_reg_reg[6]  ( .D(n15), .SI(P_DATA_reg[5]), .SE(test_se), 
        .CK(clk), .RN(n1), .Q(P_DATA_reg[6]) );
  SDFFRQX2M \P_DATA_reg_reg[5]  ( .D(n13), .SI(P_DATA_reg[4]), .SE(test_se), 
        .CK(clk), .RN(n1), .Q(P_DATA_reg[5]) );
  SDFFRQX2M \P_DATA_reg_reg[4]  ( .D(n11), .SI(P_DATA_reg[3]), .SE(test_se), 
        .CK(clk), .RN(n1), .Q(P_DATA_reg[4]) );
  SDFFRQX2M \P_DATA_reg_reg[3]  ( .D(n9), .SI(P_DATA_reg[2]), .SE(test_se), 
        .CK(clk), .RN(n1), .Q(P_DATA_reg[3]) );
  SDFFRQX2M \P_DATA_reg_reg[2]  ( .D(n7), .SI(P_DATA_reg[1]), .SE(test_se), 
        .CK(clk), .RN(n1), .Q(P_DATA_reg[2]) );
  SDFFRQX2M \P_DATA_reg_reg[1]  ( .D(n5), .SI(P_DATA_reg[0]), .SE(test_se), 
        .CK(clk), .RN(n1), .Q(P_DATA_reg[1]) );
  SDFFRQX2M \P_DATA_reg_reg[0]  ( .D(n3), .SI(test_si1), .SE(test_se), .CK(clk), .RN(n1), .Q(P_DATA_reg[0]) );
  SDFFRQX2M par_err_reg_reg ( .D(par_err), .SI(n23), .SE(test_se), .CK(clk), 
        .RN(n1), .Q(par_err_reg) );
  SDFFRQX2M data_valid_reg_reg ( .D(data_valid), .SI(P_DATA_reg[7]), .SE(
        test_se), .CK(clk), .RN(n1), .Q(data_valid_reg) );
  SDFFRQX2M stp_error_reg_reg ( .D(stp_error), .SI(test_si2), .SE(test_se), 
        .CK(clk), .RN(n1), .Q(stp_error_reg) );
  INVX2M U3 ( .A(data_valid), .Y(n22) );
  INVX4M U4 ( .A(n21), .Y(n1) );
  INVX2M U5 ( .A(rst), .Y(n21) );
  AO22X1M U6 ( .A0(P_DATA_reg[0]), .A1(n22), .B0(data_valid), .B1(P_DATA[0]), 
        .Y(n3) );
  AO22X1M U7 ( .A0(P_DATA_reg[1]), .A1(n22), .B0(P_DATA[1]), .B1(data_valid), 
        .Y(n5) );
  AO22X1M U8 ( .A0(P_DATA_reg[2]), .A1(n22), .B0(P_DATA[2]), .B1(data_valid), 
        .Y(n7) );
  AO22X1M U9 ( .A0(P_DATA_reg[3]), .A1(n22), .B0(P_DATA[3]), .B1(data_valid), 
        .Y(n9) );
  AO22X1M U10 ( .A0(P_DATA_reg[4]), .A1(n22), .B0(P_DATA[4]), .B1(data_valid), 
        .Y(n11) );
  AO22X1M U11 ( .A0(P_DATA_reg[5]), .A1(n22), .B0(P_DATA[5]), .B1(data_valid), 
        .Y(n13) );
  AO22X1M U23 ( .A0(P_DATA_reg[6]), .A1(n22), .B0(P_DATA[6]), .B1(data_valid), 
        .Y(n15) );
  AO22X1M U24 ( .A0(P_DATA_reg[7]), .A1(n22), .B0(P_DATA[7]), .B1(data_valid), 
        .Y(n17) );
  FSM_test_1 fsm ( .clk(clk), .rst(n1), .system_outputs_flag(
        system_outputs_flag), .edge_cnt_flag(edge_cnt_flag), .RX_IN(RX_IN), 
        .PAR_EN(PAR_EN), .bit_cnt(bit_cnt), .par_err(par_err), .strt_glitch(
        strt_glitch), .stp_error(stp_error), .enable(enable), .dat_sample_en(
        dat_sample_en), .deser_en(deser_en), .data_valid(data_valid), 
        .par_chk_en(par_chk_en), .strt_chk_en(strt_chk_en), .stp_chk_en(
        stp_chk_en), .new_op_flag(new_op_flag), .test_si(n24), .test_so(n23), 
        .test_se(test_se) );
  edge_bit_counter_test_1 edg_cnt ( .clk(clk), .rst(n1), .PAR_EN(PAR_EN), 
        .enable(enable), .prescale(prescale), .edge_cnt(edge_cnt), .bit_cnt(
        bit_cnt), .edge_cnt_flag(edge_cnt_flag), .system_outputs_flag(
        system_outputs_flag), .test_si(n25), .test_so(n24), .test_se(test_se)
         );
  deserializer_test_1 deser ( .clk(clk), .rst(n1), .new_op_flag(new_op_flag), 
        .deser_en(deser_en), .sampled_bit(sampled_bit), .P_DATA(P_DATA), 
        .test_si(data_valid_reg), .test_so(n26), .test_se(test_se) );
  data_sampling_test_1 ds ( .clk(clk), .rst(n1), .prescale(prescale), 
        .edge_cnt(edge_cnt), .dat_sample_en(dat_sample_en), .RX_IN(RX_IN), 
        .sampled_bit(sampled_bit), .test_si(n26), .test_so(n25), .test_se(
        test_se) );
  parity_check par ( .parity_chk_en(par_chk_en), .PAR_TYP(PAR_TYP), 
        .sampled_bit(sampled_bit), .P_DATA(P_DATA), .par_err(par_err) );
  strt_check strt ( .strt_chk_en(strt_chk_en), .strt_glitch(strt_glitch), 
        .sampled_bit(sampled_bit) );
  stop_check stop ( .stp_chk_en(stp_chk_en), .stp_err(stp_error), 
        .sampled_bit(sampled_bit) );
endmodule


module Controller_TX_test_1 ( Data_Valid, PAR_EN, Ser_Done, Mux_sel, Ser_En, 
        busy, clk, rst, test_si, test_so, test_se );
  output [2:0] Mux_sel;
  input Data_Valid, PAR_EN, Ser_Done, clk, rst, test_si, test_se;
  output Ser_En, busy, test_so;
  wire   n9, n10, n11, n12, n13, n5, n6, n7, n8, n14;
  wire   [2:0] cs;
  wire   [2:0] ns;
  assign test_so = cs[2];

  SDFFRQX2M \cs_reg[0]  ( .D(n5), .SI(test_si), .SE(test_se), .CK(clk), .RN(
        rst), .Q(cs[0]) );
  SDFFRQX1M \cs_reg[2]  ( .D(ns[2]), .SI(cs[1]), .SE(test_se), .CK(clk), .RN(
        rst), .Q(cs[2]) );
  OAI21X2M U7 ( .A0(n8), .A1(n7), .B0(n13), .Y(Mux_sel[0]) );
  INVX2M U8 ( .A(Mux_sel[1]), .Y(n8) );
  NAND2X2M U9 ( .A(Mux_sel[1]), .B(n7), .Y(n10) );
  OAI21X2M U10 ( .A0(n9), .A1(n10), .B0(n11), .Y(ns[1]) );
  AOI2B1X1M U11 ( .A1N(n9), .A0(n7), .B0(n8), .Y(ns[2]) );
  NOR3X2M U12 ( .A(cs[1]), .B(cs[2]), .C(cs[0]), .Y(Mux_sel[2]) );
  NOR2X2M U13 ( .A(n14), .B(cs[2]), .Y(Mux_sel[1]) );
  INVX2M U14 ( .A(cs[0]), .Y(n7) );
  NAND3X2M U15 ( .A(n7), .B(n14), .C(cs[2]), .Y(n13) );
  OAI211X2M U17 ( .A0(cs[2]), .A1(n7), .B0(n13), .C0(n8), .Y(busy) );
  NAND2X2M U18 ( .A(n11), .B(n10), .Y(Ser_En) );
  OR3X2M U19 ( .A(cs[2]), .B(cs[1]), .C(n7), .Y(n11) );
  INVX2M U20 ( .A(n12), .Y(n5) );
  AOI32X1M U21 ( .A0(n6), .A1(Ser_Done), .A2(PAR_EN), .B0(Data_Valid), .B1(
        Mux_sel[2]), .Y(n12) );
  INVX2M U22 ( .A(n10), .Y(n6) );
  NOR2BX2M U23 ( .AN(Ser_Done), .B(PAR_EN), .Y(n9) );
  SDFFRX1M \cs_reg[1]  ( .D(ns[1]), .SI(n7), .SE(test_se), .CK(clk), .RN(rst), 
        .Q(cs[1]), .QN(n14) );
endmodule


module Serializer_test_1 ( P_Data, Data_Valid, Ser_En, clk, rst, Ser_Done, 
        Ser_Data, busy, test_si, test_se );
  input [7:0] P_Data;
  input Data_Valid, Ser_En, clk, rst, busy, test_si, test_se;
  output Ser_Done, Ser_Data;
  wire   n14, n17, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n18, n19, n20, n21, n51, n52, n53;
  wire   [7:0] LSR;
  wire   [2:0] Counter;

  SDFFRQX2M \LSR_reg[7]  ( .D(n40), .SI(LSR[6]), .SE(test_se), .CK(clk), .RN(
        rst), .Q(LSR[7]) );
  SDFFRQX2M \LSR_reg[6]  ( .D(n41), .SI(LSR[5]), .SE(test_se), .CK(clk), .RN(
        rst), .Q(LSR[6]) );
  SDFFRQX2M \LSR_reg[5]  ( .D(n42), .SI(LSR[4]), .SE(test_se), .CK(clk), .RN(
        rst), .Q(LSR[5]) );
  SDFFRQX2M \LSR_reg[4]  ( .D(n43), .SI(LSR[3]), .SE(test_se), .CK(clk), .RN(
        rst), .Q(LSR[4]) );
  SDFFRQX2M \LSR_reg[3]  ( .D(n44), .SI(LSR[2]), .SE(test_se), .CK(clk), .RN(
        rst), .Q(LSR[3]) );
  SDFFRQX2M \LSR_reg[2]  ( .D(n45), .SI(LSR[1]), .SE(test_se), .CK(clk), .RN(
        rst), .Q(LSR[2]) );
  SDFFRQX2M \LSR_reg[1]  ( .D(n46), .SI(n53), .SE(test_se), .CK(clk), .RN(rst), 
        .Q(LSR[1]) );
  SDFFRQX2M \Counter_reg[2]  ( .D(n49), .SI(Counter[1]), .SE(test_se), .CK(clk), .RN(rst), .Q(Counter[2]) );
  SDFFRQX2M \Counter_reg[1]  ( .D(n38), .SI(Counter[0]), .SE(test_se), .CK(clk), .RN(rst), .Q(Counter[1]) );
  SDFFRQX2M \Counter_reg[0]  ( .D(n50), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(Counter[0]) );
  SDFFRQX2M Ser_Data_reg ( .D(n39), .SI(LSR[7]), .SE(test_se), .CK(clk), .RN(
        rst), .Q(Ser_Data) );
  SDFFRX1M \LSR_reg[0]  ( .D(n47), .SI(Counter[2]), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(n53), .QN(n14) );
  SDFFRX1M Ser_Done_reg ( .D(n48), .SI(Ser_Data), .SE(test_se), .CK(clk), .RN(
        rst), .Q(Ser_Done), .QN(n17) );
  INVX2M U18 ( .A(n24), .Y(n19) );
  NAND2X2M U19 ( .A(n33), .B(n24), .Y(n25) );
  NAND2X2M U20 ( .A(n51), .B(n33), .Y(n24) );
  INVX2M U21 ( .A(n33), .Y(n18) );
  NAND2BX2M U22 ( .AN(busy), .B(Data_Valid), .Y(n33) );
  AOI21X2M U23 ( .A0(n20), .A1(n51), .B0(n18), .Y(n22) );
  INVX2M U24 ( .A(n37), .Y(n51) );
  OAI32X1M U25 ( .A0(n52), .A1(Counter[2]), .A2(n23), .B0(n36), .B1(n21), .Y(
        n49) );
  AOI21BX2M U26 ( .A0(n51), .A1(n52), .B0N(n22), .Y(n36) );
  OAI32X1M U27 ( .A0(n37), .A1(Counter[0]), .A2(n18), .B0(n20), .B1(n33), .Y(
        n50) );
  OAI22X1M U28 ( .A0(n22), .A1(n52), .B0(Counter[1]), .B1(n23), .Y(n38) );
  OAI2BB2X1M U29 ( .B0(n24), .B1(n14), .A0N(Ser_Data), .A1N(n24), .Y(n39) );
  OAI2B1X2M U30 ( .A1N(LSR[1]), .A0(n25), .B0(n31), .Y(n46) );
  AOI22X1M U31 ( .A0(LSR[2]), .A1(n19), .B0(P_Data[1]), .B1(n18), .Y(n31) );
  OAI2B1X2M U32 ( .A1N(LSR[2]), .A0(n25), .B0(n30), .Y(n45) );
  AOI22X1M U33 ( .A0(LSR[3]), .A1(n19), .B0(P_Data[2]), .B1(n18), .Y(n30) );
  OAI2B1X2M U34 ( .A1N(LSR[3]), .A0(n25), .B0(n29), .Y(n44) );
  AOI22X1M U35 ( .A0(LSR[4]), .A1(n19), .B0(P_Data[3]), .B1(n18), .Y(n29) );
  OAI2B1X2M U36 ( .A1N(LSR[4]), .A0(n25), .B0(n28), .Y(n43) );
  AOI22X1M U37 ( .A0(LSR[5]), .A1(n19), .B0(P_Data[4]), .B1(n18), .Y(n28) );
  OAI2B1X2M U38 ( .A1N(LSR[5]), .A0(n25), .B0(n27), .Y(n42) );
  AOI22X1M U39 ( .A0(LSR[6]), .A1(n19), .B0(P_Data[5]), .B1(n18), .Y(n27) );
  OAI2B1X2M U40 ( .A1N(LSR[6]), .A0(n25), .B0(n26), .Y(n41) );
  AOI22X1M U41 ( .A0(LSR[7]), .A1(n19), .B0(P_Data[6]), .B1(n18), .Y(n26) );
  OAI2BB2X1M U42 ( .B0(n34), .B1(n17), .A0N(n34), .A1N(n19), .Y(n48) );
  OAI32X1M U43 ( .A0(n35), .A1(n24), .A2(n21), .B0(n51), .B1(n18), .Y(n34) );
  NAND2X2M U44 ( .A(Counter[1]), .B(Counter[0]), .Y(n35) );
  OAI21X2M U45 ( .A0(n14), .A1(n25), .B0(n32), .Y(n47) );
  AOI22X1M U46 ( .A0(LSR[1]), .A1(n19), .B0(P_Data[0]), .B1(n18), .Y(n32) );
  NAND3X2M U47 ( .A(n51), .B(n33), .C(Counter[0]), .Y(n23) );
  NAND2X2M U48 ( .A(Ser_En), .B(n17), .Y(n37) );
  AO2B2X2M U49 ( .B0(P_Data[7]), .B1(n18), .A0(LSR[7]), .A1N(n25), .Y(n40) );
  INVX2M U50 ( .A(Counter[2]), .Y(n21) );
  INVX2M U51 ( .A(Counter[0]), .Y(n20) );
  INVX2M U52 ( .A(Counter[1]), .Y(n52) );
endmodule


module Parity_Calc_test_1 ( P_DATA, Data_Valid, Par_Type, Par_En, Par_bit, clk, 
        rst, busy, test_si, test_se );
  input [7:0] P_DATA;
  input Data_Valid, Par_Type, Par_En, clk, rst, busy, test_si, test_se;
  output Par_bit;
  wire   n3, n4, n5, n6, n7, n8, n9, n10, n2;

  SDFFRQX2M Par_bit_reg ( .D(n10), .SI(test_si), .SE(test_se), .CK(clk), .RN(
        rst), .Q(Par_bit) );
  NAND2BX2M U4 ( .AN(busy), .B(Data_Valid), .Y(n5) );
  XOR3XLM U5 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n8), .Y(n7) );
  XNOR2X2M U6 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n8) );
  XOR3XLM U7 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n9), .Y(n6) );
  XNOR2X2M U8 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n9) );
  NOR2BX2M U9 ( .AN(Par_En), .B(n3), .Y(n10) );
  AOI22X1M U10 ( .A0(n2), .A1(n4), .B0(Par_bit), .B1(n5), .Y(n3) );
  XOR3XLM U11 ( .A(Par_Type), .B(n6), .C(n7), .Y(n4) );
  INVX2M U12 ( .A(n5), .Y(n2) );
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


module UART_TX_test_1 ( P_DATA, Data_Valid, PAR_TYP, PAR_EN, TX_OUT, busy, clk, 
        rst, test_si, test_so, test_se );
  input [7:0] P_DATA;
  input Data_Valid, PAR_TYP, PAR_EN, clk, rst, test_si, test_se;
  output TX_OUT, busy, test_so;
  wire   Ser_Done, Ser_En, Ser_Data, Par_bit, n1, n2, n3;
  wire   [2:0] Mux_sel;
  assign test_so = Ser_Done;

  INVX2M U3 ( .A(n2), .Y(n1) );
  INVX2M U4 ( .A(rst), .Y(n2) );
  Controller_TX_test_1 Controller_TX ( .Data_Valid(Data_Valid), .PAR_EN(PAR_EN), .Ser_Done(Ser_Done), .Mux_sel(Mux_sel), .Ser_En(Ser_En), .busy(busy), .clk(
        clk), .rst(n1), .test_si(test_si), .test_so(n3), .test_se(test_se) );
  Serializer_test_1 Serializer ( .P_Data(P_DATA), .Data_Valid(Data_Valid), 
        .Ser_En(Ser_En), .clk(clk), .rst(n1), .Ser_Done(Ser_Done), .Ser_Data(
        Ser_Data), .busy(busy), .test_si(Par_bit), .test_se(test_se) );
  Parity_Calc_test_1 Parity_Calc ( .P_DATA(P_DATA), .Data_Valid(Data_Valid), 
        .Par_Type(PAR_TYP), .Par_En(PAR_EN), .Par_bit(Par_bit), .clk(clk), 
        .rst(n1), .busy(busy), .test_si(n3), .test_se(test_se) );
  UART_Mux mux ( .Mux_Sel(Mux_sel), .Start_Bit(1'b0), .Stop_Bit(1'b1), 
        .ser_data(Ser_Data), .Par_Bit(Par_bit), .No_Trans(1'b1), .TX_OUT(
        TX_OUT) );
endmodule


module RST_SYNC_test_1 ( RST, CLK, SYNC_RST, test_si, test_se );
  input RST, CLK, test_si, test_se;
  output SYNC_RST;

  wire   [1:0] stages;

  SDFFRQX2M \stages_reg[0]  ( .D(1'b1), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(stages[0]) );
  SDFFRQX2M \stages_reg[1]  ( .D(stages[0]), .SI(stages[0]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(stages[1]) );
  SDFFRQX1M \stages_reg[2]  ( .D(stages[1]), .SI(stages[1]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(SYNC_RST) );
endmodule


module RST_SYNC_test_0 ( RST, CLK, SYNC_RST, test_si, test_se );
  input RST, CLK, test_si, test_se;
  output SYNC_RST;

  wire   [1:0] stages;

  SDFFRQX2M \stages_reg[0]  ( .D(1'b1), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(stages[0]) );
  SDFFRQX2M \stages_reg[1]  ( .D(stages[0]), .SI(stages[0]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(stages[1]) );
  SDFFRQX1M \stages_reg[2]  ( .D(stages[1]), .SI(stages[1]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(SYNC_RST) );
endmodule


module BIT_SYNC_N2_test_0 ( clk, rst, IN, OUT, test_si, test_se );
  input clk, rst, IN, test_si, test_se;
  output OUT;
  wire   \stage[0] ;

  SDFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .SI(\stage[0] ), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(OUT) );
  SDFFRQX2M \stage_reg[0]  ( .D(IN), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(\stage[0] ) );
endmodule


module Pulse_Gen_test_0 ( clk, rst, in, out, test_si, test_so, test_se );
  input clk, rst, in, test_si, test_se;
  output out, test_so;
  wire   q;
  assign test_so = q;

  SDFFRQX2M q_reg ( .D(in), .SI(test_si), .SE(test_se), .CK(clk), .RN(rst), 
        .Q(q) );
  NOR2BX2M U4 ( .AN(in), .B(q), .Y(out) );
endmodule


module DATA_SYNC_test_1 ( unsync_bus, bus_enable, clk, rst, sync_bus, 
        enable_pulse, test_si, test_se );
  input [7:0] unsync_bus;
  output [7:0] sync_bus;
  input bus_enable, clk, rst, test_si, test_se;
  output enable_pulse;
  wire   internal_enable, internal_out_of_synchronizer, n3, n5, n7, n9, n11,
         n13, n15, n17, n1, n2;

  SDFFRQX2M \sync_bus_reg[7]  ( .D(n17), .SI(sync_bus[6]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_bus[7]) );
  SDFFRQX2M \sync_bus_reg[4]  ( .D(n11), .SI(sync_bus[3]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_bus[4]) );
  SDFFRQX2M \sync_bus_reg[5]  ( .D(n13), .SI(sync_bus[4]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_bus[5]) );
  SDFFRQX2M \sync_bus_reg[6]  ( .D(n15), .SI(sync_bus[5]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_bus[6]) );
  SDFFRQX2M \sync_bus_reg[3]  ( .D(n9), .SI(sync_bus[2]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_bus[3]) );
  SDFFRQX2M \sync_bus_reg[0]  ( .D(n3), .SI(internal_out_of_synchronizer), 
        .SE(test_se), .CK(clk), .RN(rst), .Q(sync_bus[0]) );
  SDFFRQX2M \sync_bus_reg[1]  ( .D(n5), .SI(sync_bus[0]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_bus[1]) );
  SDFFRQX2M \sync_bus_reg[2]  ( .D(n7), .SI(sync_bus[1]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_bus[2]) );
  SDFFRQX2M enable_pulse_reg ( .D(internal_enable), .SI(n2), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(enable_pulse) );
  INVX2M U3 ( .A(internal_enable), .Y(n1) );
  AO22X1M U4 ( .A0(unsync_bus[0]), .A1(internal_enable), .B0(sync_bus[0]), 
        .B1(n1), .Y(n3) );
  AO22X1M U5 ( .A0(unsync_bus[1]), .A1(internal_enable), .B0(sync_bus[1]), 
        .B1(n1), .Y(n5) );
  AO22X1M U6 ( .A0(unsync_bus[2]), .A1(internal_enable), .B0(sync_bus[2]), 
        .B1(n1), .Y(n7) );
  AO22X1M U7 ( .A0(unsync_bus[3]), .A1(internal_enable), .B0(sync_bus[3]), 
        .B1(n1), .Y(n9) );
  AO22X1M U8 ( .A0(unsync_bus[4]), .A1(internal_enable), .B0(sync_bus[4]), 
        .B1(n1), .Y(n11) );
  AO22X1M U9 ( .A0(unsync_bus[5]), .A1(internal_enable), .B0(sync_bus[5]), 
        .B1(n1), .Y(n13) );
  AO22X1M U10 ( .A0(unsync_bus[6]), .A1(internal_enable), .B0(sync_bus[6]), 
        .B1(n1), .Y(n15) );
  AO22X1M U11 ( .A0(unsync_bus[7]), .A1(internal_enable), .B0(sync_bus[7]), 
        .B1(n1), .Y(n17) );
  BIT_SYNC_N2_test_0 sync ( .clk(clk), .rst(rst), .IN(bus_enable), .OUT(
        internal_out_of_synchronizer), .test_si(enable_pulse), .test_se(
        test_se) );
  Pulse_Gen_test_0 Pulse_Gen1 ( .clk(clk), .rst(rst), .in(
        internal_out_of_synchronizer), .out(internal_enable), .test_si(test_si), .test_so(n2), .test_se(test_se) );
endmodule


module SYS_CTRL_test_1 ( CLK, RST, ALU_OUT, OUT_Valid, RX_P_Data, RX_D_VLD, 
        RdData, RdData_Valid, ALU_EN, ALU_FUN, CLK_GATING_EN, Address, Wr_En, 
        Rd_En, Wr_Data, TX_P_Data, TX_D_VLD, clk_div_en, wfull, test_si, 
        test_so, test_se );
  input [15:0] ALU_OUT;
  input [7:0] RX_P_Data;
  input [7:0] RdData;
  output [3:0] ALU_FUN;
  output [3:0] Address;
  output [7:0] Wr_Data;
  output [7:0] TX_P_Data;
  input CLK, RST, OUT_Valid, RX_D_VLD, RdData_Valid, wfull, test_si, test_se;
  output ALU_EN, CLK_GATING_EN, Wr_En, Rd_En, TX_D_VLD, clk_div_en, test_so;
  wire   n1, n3, n4, n5, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n21, n23, n24, n25, n26, n27, n29, n30, n32, n34, n35, n38, n43, n44,
         n57, n61, n62, n63, n65, n66, n67, n68, n69, n70, n71, n72, n74, n75,
         n85, n87, n89, n91, n93, n95, n97, n99, n101, n103, n105, n107, n109,
         n111, n113, n115, n120, n121, n122, n123, n8, n20, n22, n28, n31, n33,
         n36, n37, n39, n40, n41, n42, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n58, n59, n60, n64, n73, n76, n77, n78, n79, n124,
         n125, n126, n127, n128, n129, n130;
  wire   [3:0] cs;
  wire   [3:0] ns;
  wire   [15:0] ALU_OUT_temp;
  assign test_so = cs[3];

  SDFFRQX2M \ALU_OUT_temp_reg[15]  ( .D(n115), .SI(ALU_OUT_temp[14]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[15]) );
  SDFFRQX2M \ALU_OUT_temp_reg[14]  ( .D(n113), .SI(ALU_OUT_temp[13]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[14]) );
  SDFFRQX2M \ALU_OUT_temp_reg[13]  ( .D(n111), .SI(ALU_OUT_temp[12]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[13]) );
  SDFFRQX2M \ALU_OUT_temp_reg[12]  ( .D(n109), .SI(ALU_OUT_temp[11]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[12]) );
  SDFFRQX2M \ALU_OUT_temp_reg[11]  ( .D(n107), .SI(ALU_OUT_temp[10]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[11]) );
  SDFFRQX2M \ALU_OUT_temp_reg[10]  ( .D(n105), .SI(ALU_OUT_temp[9]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[10]) );
  SDFFRQX2M \ALU_OUT_temp_reg[9]  ( .D(n103), .SI(ALU_OUT_temp[8]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[9]) );
  SDFFRQX2M \ALU_OUT_temp_reg[8]  ( .D(n101), .SI(ALU_OUT_temp[7]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[8]) );
  SDFFRQX2M \ALU_OUT_temp_reg[7]  ( .D(n99), .SI(ALU_OUT_temp[6]), .SE(test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[7]) );
  SDFFRQX2M \ALU_OUT_temp_reg[6]  ( .D(n97), .SI(ALU_OUT_temp[5]), .SE(test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[6]) );
  SDFFRQX2M \ALU_OUT_temp_reg[5]  ( .D(n95), .SI(ALU_OUT_temp[4]), .SE(test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[5]) );
  SDFFRQX2M \ALU_OUT_temp_reg[4]  ( .D(n93), .SI(ALU_OUT_temp[3]), .SE(test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[4]) );
  SDFFRQX2M \ALU_OUT_temp_reg[3]  ( .D(n91), .SI(ALU_OUT_temp[2]), .SE(test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[3]) );
  SDFFRQX2M \ALU_OUT_temp_reg[2]  ( .D(n89), .SI(ALU_OUT_temp[1]), .SE(test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[2]) );
  SDFFRQX2M \ALU_OUT_temp_reg[1]  ( .D(n87), .SI(ALU_OUT_temp[0]), .SE(test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT_temp[1]) );
  SDFFRQX2M \ALU_OUT_temp_reg[0]  ( .D(n85), .SI(test_si), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(ALU_OUT_temp[0]) );
  SDFFRX1M \Address_temp_out_reg[2]  ( .D(n122), .SI(n129), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(n128), .QN(n58) );
  SDFFRX1M \Address_temp_out_reg[1]  ( .D(n121), .SI(n130), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(n129), .QN(n59) );
  SDFFRX1M \Address_temp_out_reg[0]  ( .D(n120), .SI(ALU_OUT_temp[15]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(n130), .QN(n60) );
  SDFFRQX2M \cs_reg[2]  ( .D(ns[2]), .SI(n46), .SE(test_se), .CK(CLK), .RN(RST), .Q(cs[2]) );
  SDFFRQX2M \cs_reg[3]  ( .D(ns[3]), .SI(cs[2]), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(cs[3]) );
  SDFFRQX2M \cs_reg[1]  ( .D(ns[1]), .SI(n41), .SE(test_se), .CK(CLK), .RN(RST), .Q(cs[1]) );
  SDFFRQX2M \cs_reg[0]  ( .D(ns[0]), .SI(n127), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(cs[0]) );
  SDFFRX1M \Address_temp_out_reg[3]  ( .D(n123), .SI(n128), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(n127), .QN(n56) );
  OAI22X2M U6 ( .A0(n124), .A1(n39), .B0(n21), .B1(n58), .Y(Address[2]) );
  NOR2X2M U7 ( .A(n124), .B(n75), .Y(ALU_FUN[2]) );
  NOR2X2M U8 ( .A(n126), .B(n75), .Y(ALU_FUN[0]) );
  INVX2M U9 ( .A(n11), .Y(n40) );
  INVX2M U10 ( .A(Rd_En), .Y(n39) );
  INVX2M U11 ( .A(n18), .Y(n36) );
  INVX2M U12 ( .A(n30), .Y(n45) );
  OAI22X4M U13 ( .A0(n79), .A1(n39), .B0(n21), .B1(n56), .Y(Address[3]) );
  NOR3X2M U14 ( .A(n47), .B(n41), .C(n46), .Y(n11) );
  NOR2X2M U15 ( .A(n40), .B(n64), .Y(Rd_En) );
  NAND2X2M U16 ( .A(n74), .B(n43), .Y(n21) );
  NAND2X2M U17 ( .A(n74), .B(n63), .Y(n30) );
  INVX2M U18 ( .A(n43), .Y(n47) );
  OAI222X1M U19 ( .A0(n64), .A1(n30), .B0(n21), .B1(n60), .C0(n126), .C1(n39), 
        .Y(Address[0]) );
  OAI22X1M U20 ( .A0(n125), .A1(n39), .B0(n21), .B1(n59), .Y(Address[1]) );
  OA21X2M U21 ( .A0(n9), .A1(n64), .B0(n21), .Y(n62) );
  OAI222X1M U22 ( .A0(n1), .A1(n36), .B0(n3), .B1(n4), .C0(n5), .C1(n28), .Y(
        ns[3]) );
  AOI21X2M U23 ( .A0(wfull), .A1(n46), .B0(n41), .Y(n3) );
  NOR3X2M U24 ( .A(n126), .B(n14), .C(n78), .Y(n18) );
  NOR2X2M U25 ( .A(n62), .B(n126), .Y(Wr_Data[0]) );
  NOR2X2M U26 ( .A(n62), .B(n125), .Y(Wr_Data[1]) );
  NOR2X2M U27 ( .A(n62), .B(n124), .Y(Wr_Data[2]) );
  NOR2X2M U28 ( .A(n62), .B(n79), .Y(Wr_Data[3]) );
  NOR2X2M U29 ( .A(n62), .B(n78), .Y(Wr_Data[4]) );
  NOR2X2M U30 ( .A(n62), .B(n77), .Y(Wr_Data[5]) );
  NOR2X2M U31 ( .A(n62), .B(n76), .Y(Wr_Data[6]) );
  NOR2X2M U32 ( .A(n62), .B(n73), .Y(Wr_Data[7]) );
  NAND4X2M U33 ( .A(n41), .B(n46), .C(n43), .D(n44), .Y(n14) );
  NOR3X2M U34 ( .A(n73), .B(n64), .C(n79), .Y(n44) );
  OAI22X1M U35 ( .A0(n37), .A1(n56), .B0(n79), .B1(n57), .Y(n123) );
  OAI22X1M U36 ( .A0(n37), .A1(n60), .B0(n126), .B1(n57), .Y(n120) );
  OAI22X1M U37 ( .A0(n37), .A1(n59), .B0(n125), .B1(n57), .Y(n121) );
  OAI22X1M U38 ( .A0(n37), .A1(n58), .B0(n124), .B1(n57), .Y(n122) );
  AOI21X2M U39 ( .A0(n9), .A1(n21), .B0(n64), .Y(Wr_En) );
  AND3X2M U40 ( .A(n63), .B(n41), .C(n46), .Y(n12) );
  OR3X2M U41 ( .A(n8), .B(n27), .C(n12), .Y(TX_D_VLD) );
  INVX2M U42 ( .A(n57), .Y(n37) );
  AND2X2M U43 ( .A(n34), .B(n30), .Y(n9) );
  OAI2B1X2M U44 ( .A1N(n74), .A0(n4), .B0(n5), .Y(CLK_GATING_EN) );
  INVX2M U45 ( .A(n27), .Y(n42) );
  NOR2X2M U46 ( .A(n125), .B(n75), .Y(ALU_FUN[1]) );
  INVX2M U47 ( .A(n75), .Y(ALU_EN) );
  NOR2X2M U48 ( .A(n79), .B(n75), .Y(ALU_FUN[3]) );
  BUFX2M U49 ( .A(n31), .Y(n22) );
  BUFX2M U50 ( .A(n31), .Y(n20) );
  BUFX2M U51 ( .A(n31), .Y(n28) );
  NOR2BX2M U52 ( .AN(cs[2]), .B(cs[3]), .Y(n63) );
  NOR2X2M U53 ( .A(cs[2]), .B(cs[3]), .Y(n43) );
  NOR2X2M U54 ( .A(n46), .B(cs[0]), .Y(n74) );
  INVX2M U55 ( .A(cs[1]), .Y(n46) );
  INVX2M U56 ( .A(cs[0]), .Y(n41) );
  INVX2M U57 ( .A(RX_D_VLD), .Y(n64) );
  AOI221XLM U58 ( .A0(n27), .A1(n33), .B0(n45), .B1(RX_D_VLD), .C0(n29), .Y(
        n26) );
  OAI22X1M U59 ( .A0(OUT_Valid), .A1(n5), .B0(RdData_Valid), .B1(n40), .Y(n29)
         );
  INVX2M U60 ( .A(wfull), .Y(n33) );
  NOR3X2M U61 ( .A(cs[0]), .B(cs[1]), .C(n4), .Y(n27) );
  NOR3X2M U62 ( .A(n36), .B(RX_P_Data[6]), .C(RX_P_Data[2]), .Y(n35) );
  NAND3X2M U63 ( .A(RX_D_VLD), .B(cs[0]), .C(n61), .Y(n57) );
  NOR3X2M U64 ( .A(TX_D_VLD), .B(cs[2]), .C(cs[1]), .Y(n61) );
  OAI211X2M U65 ( .A0(OUT_Valid), .A1(n5), .B0(n9), .C0(n10), .Y(ns[2]) );
  AOI221XLM U66 ( .A0(RdData_Valid), .A1(n11), .B0(n12), .B1(wfull), .C0(n13), 
        .Y(n10) );
  NOR4X1M U67 ( .A(RX_P_Data[4]), .B(RX_P_Data[0]), .C(n14), .D(n1), .Y(n13)
         );
  NAND2BX2M U68 ( .AN(cs[2]), .B(cs[3]), .Y(n4) );
  INVX2M U69 ( .A(RX_P_Data[2]), .Y(n124) );
  INVX2M U70 ( .A(RX_P_Data[1]), .Y(n125) );
  INVX2M U71 ( .A(RX_P_Data[0]), .Y(n126) );
  INVX2M U72 ( .A(RX_P_Data[3]), .Y(n79) );
  NAND3X2M U73 ( .A(cs[0]), .B(n46), .C(n63), .Y(n34) );
  NAND4X2M U74 ( .A(n23), .B(n24), .C(n25), .D(n26), .Y(ns[0]) );
  NAND4BX1M U75 ( .AN(n14), .B(n19), .C(n126), .D(n78), .Y(n23) );
  AOI22X1M U76 ( .A0(n17), .A1(n64), .B0(n8), .B1(wfull), .Y(n25) );
  NAND3X2M U77 ( .A(RX_P_Data[5]), .B(RX_P_Data[1]), .C(n35), .Y(n24) );
  BUFX2M U78 ( .A(n32), .Y(n8) );
  NOR3X2M U79 ( .A(n41), .B(cs[1]), .C(n4), .Y(n32) );
  OAI31X1M U80 ( .A0(n47), .A1(cs[1]), .A2(n41), .B0(n34), .Y(n17) );
  NAND4X2M U81 ( .A(RX_P_Data[6]), .B(RX_P_Data[2]), .C(n125), .D(n77), .Y(n1)
         );
  OAI2B11X2M U82 ( .A1N(CLK_GATING_EN), .A0(OUT_Valid), .B0(n15), .C0(n16), 
        .Y(ns[1]) );
  OA22X2M U83 ( .A0(n21), .A1(RX_D_VLD), .B0(n40), .B1(RdData_Valid), .Y(n15)
         );
  AOI221XLM U84 ( .A0(RX_D_VLD), .A1(n17), .B0(n18), .B1(n19), .C0(n45), .Y(
        n16) );
  NAND3X2M U85 ( .A(n63), .B(cs[0]), .C(cs[1]), .Y(n5) );
  OAI21X2M U86 ( .A0(n42), .A1(n55), .B0(n72), .Y(TX_P_Data[0]) );
  AOI22X1M U87 ( .A0(ALU_OUT_temp[8]), .A1(n8), .B0(RdData[0]), .B1(n12), .Y(
        n72) );
  OAI21X2M U88 ( .A0(n42), .A1(n54), .B0(n71), .Y(TX_P_Data[1]) );
  AOI22X1M U89 ( .A0(ALU_OUT_temp[9]), .A1(n8), .B0(RdData[1]), .B1(n12), .Y(
        n71) );
  OAI21X2M U90 ( .A0(n42), .A1(n53), .B0(n70), .Y(TX_P_Data[2]) );
  AOI22X1M U91 ( .A0(ALU_OUT_temp[10]), .A1(n8), .B0(RdData[2]), .B1(n12), .Y(
        n70) );
  OAI21X2M U92 ( .A0(n42), .A1(n52), .B0(n69), .Y(TX_P_Data[3]) );
  AOI22X1M U93 ( .A0(ALU_OUT_temp[11]), .A1(n8), .B0(RdData[3]), .B1(n12), .Y(
        n69) );
  OAI21X2M U94 ( .A0(n42), .A1(n51), .B0(n68), .Y(TX_P_Data[4]) );
  AOI22X1M U95 ( .A0(ALU_OUT_temp[12]), .A1(n8), .B0(RdData[4]), .B1(n12), .Y(
        n68) );
  OAI21X2M U96 ( .A0(n42), .A1(n50), .B0(n67), .Y(TX_P_Data[5]) );
  AOI22X1M U97 ( .A0(ALU_OUT_temp[13]), .A1(n8), .B0(RdData[5]), .B1(n12), .Y(
        n67) );
  OAI21X2M U98 ( .A0(n42), .A1(n49), .B0(n66), .Y(TX_P_Data[6]) );
  AOI22X1M U99 ( .A0(ALU_OUT_temp[14]), .A1(n8), .B0(RdData[6]), .B1(n12), .Y(
        n66) );
  OAI21X2M U100 ( .A0(n42), .A1(n48), .B0(n65), .Y(TX_P_Data[7]) );
  AOI22X1M U101 ( .A0(ALU_OUT_temp[15]), .A1(n8), .B0(RdData[7]), .B1(n12), 
        .Y(n65) );
  INVX2M U102 ( .A(RX_P_Data[4]), .Y(n78) );
  INVX2M U103 ( .A(RX_P_Data[6]), .Y(n76) );
  INVX2M U104 ( .A(RX_P_Data[5]), .Y(n77) );
  NAND2X2M U105 ( .A(n1), .B(n38), .Y(n19) );
  NAND4X2M U106 ( .A(RX_P_Data[5]), .B(RX_P_Data[1]), .C(n124), .D(n76), .Y(
        n38) );
  INVX2M U107 ( .A(RX_P_Data[7]), .Y(n73) );
  INVX2M U108 ( .A(ALU_OUT_temp[0]), .Y(n55) );
  INVX2M U109 ( .A(ALU_OUT_temp[1]), .Y(n54) );
  INVX2M U110 ( .A(ALU_OUT_temp[2]), .Y(n53) );
  INVX2M U111 ( .A(ALU_OUT_temp[3]), .Y(n52) );
  INVX2M U112 ( .A(ALU_OUT_temp[4]), .Y(n51) );
  INVX2M U113 ( .A(ALU_OUT_temp[5]), .Y(n50) );
  INVX2M U114 ( .A(ALU_OUT_temp[6]), .Y(n49) );
  INVX2M U115 ( .A(ALU_OUT_temp[7]), .Y(n48) );
  OAI2BB2X1M U116 ( .B0(OUT_Valid), .B1(n55), .A0N(ALU_OUT[0]), .A1N(OUT_Valid), .Y(n85) );
  OAI2BB2X1M U117 ( .B0(OUT_Valid), .B1(n54), .A0N(ALU_OUT[1]), .A1N(OUT_Valid), .Y(n87) );
  OAI2BB2X1M U118 ( .B0(OUT_Valid), .B1(n53), .A0N(ALU_OUT[2]), .A1N(OUT_Valid), .Y(n89) );
  OAI2BB2X1M U119 ( .B0(OUT_Valid), .B1(n52), .A0N(ALU_OUT[3]), .A1N(OUT_Valid), .Y(n91) );
  OAI2BB2X1M U120 ( .B0(OUT_Valid), .B1(n51), .A0N(ALU_OUT[4]), .A1N(OUT_Valid), .Y(n93) );
  OAI2BB2X1M U121 ( .B0(OUT_Valid), .B1(n50), .A0N(ALU_OUT[5]), .A1N(OUT_Valid), .Y(n95) );
  OAI2BB2X1M U122 ( .B0(OUT_Valid), .B1(n49), .A0N(ALU_OUT[6]), .A1N(OUT_Valid), .Y(n97) );
  OAI2BB2X1M U123 ( .B0(OUT_Valid), .B1(n48), .A0N(ALU_OUT[7]), .A1N(OUT_Valid), .Y(n99) );
  AO22X1M U124 ( .A0(n28), .A1(ALU_OUT_temp[8]), .B0(ALU_OUT[8]), .B1(
        OUT_Valid), .Y(n101) );
  AO22X1M U125 ( .A0(n28), .A1(ALU_OUT_temp[9]), .B0(ALU_OUT[9]), .B1(
        OUT_Valid), .Y(n103) );
  AO22X1M U126 ( .A0(n28), .A1(ALU_OUT_temp[10]), .B0(ALU_OUT[10]), .B1(
        OUT_Valid), .Y(n105) );
  AO22X1M U127 ( .A0(n28), .A1(ALU_OUT_temp[11]), .B0(ALU_OUT[11]), .B1(
        OUT_Valid), .Y(n107) );
  AO22X1M U128 ( .A0(n28), .A1(ALU_OUT_temp[12]), .B0(ALU_OUT[12]), .B1(
        OUT_Valid), .Y(n109) );
  AO22X1M U129 ( .A0(n22), .A1(ALU_OUT_temp[13]), .B0(ALU_OUT[13]), .B1(
        OUT_Valid), .Y(n111) );
  AO22X1M U130 ( .A0(n20), .A1(ALU_OUT_temp[14]), .B0(ALU_OUT[14]), .B1(
        OUT_Valid), .Y(n113) );
  AO22X1M U155 ( .A0(n28), .A1(ALU_OUT_temp[15]), .B0(ALU_OUT[15]), .B1(
        OUT_Valid), .Y(n115) );
  NAND2X2M U156 ( .A(RX_D_VLD), .B(CLK_GATING_EN), .Y(n75) );
  INVX2M U157 ( .A(OUT_Valid), .Y(n31) );
  INVX2M U3 ( .A(1'b0), .Y(clk_div_en) );
endmodule


module clock_gating ( CLK_EN, CLK, GATED_CLK );
  input CLK_EN, CLK;
  output GATED_CLK;


  TLATNCAX3M gating ( .E(CLK_EN), .CK(CLK), .ECK(GATED_CLK) );
endmodule


module Pulse_Gen_test_1 ( clk, rst, in, out, test_si, test_so, test_se );
  input clk, rst, in, test_si, test_se;
  output out, test_so;
  wire   q;
  assign test_so = q;

  SDFFRQX2M q_reg ( .D(in), .SI(test_si), .SE(test_se), .CK(clk), .RN(rst), 
        .Q(q) );
  NOR2BX2M U4 ( .AN(in), .B(q), .Y(out) );
endmodule


module ClkDiv_Range_for_division8_test_1 ( i_ref_clk, i_rst_n, i_clk_en, 
        i_div_ratio, o_div_clk, test_si, test_so, test_se );
  input [7:0] i_div_ratio;
  input i_ref_clk, i_rst_n, i_clk_en, test_si, test_se;
  output o_div_clk, test_so;
  wire   N2, o_div_clk_internal, toggle_flag_odd, N17, N18, N19, N20, n24, n25,
         n26, n27, n28, n29, n30, \add_39/carry[4] , \add_39/carry[3] ,
         \add_39/carry[2] , n1, n2, n3, n4, n5, n13, n14, n15, n16, n17, n18,
         n19, n20, n21, n22, n23, n31, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n42, n43;
  wire   [4:0] counter;
  wire   [4:0] even_edge_toggle;
  assign test_so = toggle_flag_odd;

  SDFFRQX2M o_div_clk_internal_reg ( .D(n24), .SI(counter[4]), .SE(test_se), 
        .CK(i_ref_clk), .RN(i_rst_n), .Q(o_div_clk_internal) );
  SDFFRQX2M toggle_flag_odd_reg ( .D(n30), .SI(o_div_clk_internal), .SE(
        test_se), .CK(i_ref_clk), .RN(i_rst_n), .Q(toggle_flag_odd) );
  SDFFRQX2M \counter_reg[4]  ( .D(n25), .SI(counter[3]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst_n), .Q(counter[4]) );
  SDFFRQX2M \counter_reg[0]  ( .D(n29), .SI(test_si), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst_n), .Q(counter[0]) );
  SDFFRQX2M \counter_reg[1]  ( .D(n28), .SI(n15), .SE(test_se), .CK(i_ref_clk), 
        .RN(i_rst_n), .Q(counter[1]) );
  SDFFRQX2M \counter_reg[3]  ( .D(n26), .SI(counter[2]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst_n), .Q(counter[3]) );
  SDFFRQX2M \counter_reg[2]  ( .D(n27), .SI(n17), .SE(test_se), .CK(i_ref_clk), 
        .RN(i_rst_n), .Q(counter[2]) );
  INVX2M U5 ( .A(i_div_ratio[3]), .Y(n4) );
  ADDHX1M U6 ( .A(counter[2]), .B(\add_39/carry[2] ), .CO(\add_39/carry[3] ), 
        .S(N18) );
  ADDHX1M U11 ( .A(counter[1]), .B(counter[0]), .CO(\add_39/carry[2] ), .S(N17) );
  ADDHX1M U13 ( .A(counter[3]), .B(\add_39/carry[3] ), .CO(\add_39/carry[4] ), 
        .S(N19) );
  MX2X2M U14 ( .A(i_ref_clk), .B(o_div_clk_internal), .S0(N2), .Y(o_div_clk)
         );
  CLKINVX1M U15 ( .A(i_div_ratio[1]), .Y(even_edge_toggle[0]) );
  NOR2X1M U16 ( .A(i_div_ratio[2]), .B(i_div_ratio[1]), .Y(n1) );
  AO21XLM U17 ( .A0(i_div_ratio[1]), .A1(i_div_ratio[2]), .B0(n1), .Y(
        even_edge_toggle[1]) );
  CLKNAND2X2M U18 ( .A(n1), .B(n4), .Y(n2) );
  OAI21X1M U19 ( .A0(n1), .A1(n4), .B0(n2), .Y(even_edge_toggle[2]) );
  XNOR2X1M U20 ( .A(i_div_ratio[4]), .B(n2), .Y(even_edge_toggle[3]) );
  NOR2X1M U21 ( .A(i_div_ratio[4]), .B(n2), .Y(n3) );
  CLKXOR2X2M U22 ( .A(i_div_ratio[5]), .B(n3), .Y(even_edge_toggle[4]) );
  CLKXOR2X2M U23 ( .A(\add_39/carry[4] ), .B(counter[4]), .Y(N20) );
  XNOR2X1M U24 ( .A(toggle_flag_odd), .B(n5), .Y(n30) );
  OR2X1M U25 ( .A(n13), .B(n14), .Y(n5) );
  OAI2BB2X1M U26 ( .B0(N2), .B1(n15), .A0N(n15), .A1N(n16), .Y(n29) );
  OAI2BB2X1M U27 ( .B0(N2), .B1(n17), .A0N(N17), .A1N(n16), .Y(n28) );
  AO22X1M U28 ( .A0(n14), .A1(counter[2]), .B0(N18), .B1(n16), .Y(n27) );
  AO22X1M U29 ( .A0(n14), .A1(counter[3]), .B0(N19), .B1(n16), .Y(n26) );
  AO22X1M U30 ( .A0(n14), .A1(counter[4]), .B0(N20), .B1(n16), .Y(n25) );
  AND3X1M U31 ( .A(n18), .B(n13), .C(N2), .Y(n16) );
  CLKXOR2X2M U32 ( .A(o_div_clk_internal), .B(n19), .Y(n24) );
  AOI21X1M U33 ( .A0(n13), .A1(n18), .B0(n14), .Y(n19) );
  OR2X1M U34 ( .A(n20), .B(i_div_ratio[0]), .Y(n18) );
  CLKNAND2X2M U35 ( .A(n21), .B(i_div_ratio[0]), .Y(n13) );
  MXI2X1M U36 ( .A(n20), .B(n22), .S0(toggle_flag_odd), .Y(n21) );
  NAND4X1M U37 ( .A(n23), .B(n31), .C(n32), .D(n33), .Y(n22) );
  CLKXOR2X2M U38 ( .A(n17), .B(i_div_ratio[2]), .Y(n33) );
  CLKINVX1M U39 ( .A(counter[1]), .Y(n17) );
  NOR2X1M U40 ( .A(n34), .B(n35), .Y(n32) );
  CLKXOR2X2M U41 ( .A(i_div_ratio[1]), .B(counter[0]), .Y(n35) );
  CLKXOR2X2M U42 ( .A(i_div_ratio[3]), .B(counter[2]), .Y(n34) );
  XNOR2X1M U43 ( .A(counter[3]), .B(i_div_ratio[4]), .Y(n31) );
  XNOR2X1M U44 ( .A(counter[4]), .B(i_div_ratio[5]), .Y(n23) );
  NAND4X1M U45 ( .A(n36), .B(n37), .C(n38), .D(n39), .Y(n20) );
  CLKXOR2X2M U46 ( .A(n15), .B(even_edge_toggle[0]), .Y(n39) );
  CLKINVX1M U47 ( .A(counter[0]), .Y(n15) );
  NOR2X1M U48 ( .A(n40), .B(n41), .Y(n38) );
  CLKXOR2X2M U49 ( .A(even_edge_toggle[2]), .B(counter[2]), .Y(n41) );
  CLKXOR2X2M U50 ( .A(even_edge_toggle[1]), .B(counter[1]), .Y(n40) );
  XNOR2X1M U51 ( .A(counter[3]), .B(even_edge_toggle[3]), .Y(n37) );
  XNOR2X1M U52 ( .A(counter[4]), .B(even_edge_toggle[4]), .Y(n36) );
  CLKINVX1M U53 ( .A(n14), .Y(N2) );
  NAND2BX1M U54 ( .AN(n42), .B(i_clk_en), .Y(n14) );
  NOR4BX1M U55 ( .AN(n43), .B(i_div_ratio[2]), .C(i_div_ratio[3]), .D(
        i_div_ratio[1]), .Y(n42) );
  NOR4X1M U56 ( .A(i_div_ratio[7]), .B(i_div_ratio[6]), .C(i_div_ratio[5]), 
        .D(i_div_ratio[4]), .Y(n43) );
endmodule


module ClkDiv_Range_for_division2_test_1 ( i_ref_clk, i_rst_n, i_clk_en, 
        i_div_ratio, o_div_clk, test_si, test_so, test_se );
  input [1:0] i_div_ratio;
  input i_ref_clk, i_rst_n, i_clk_en, test_si, test_se;
  output o_div_clk, test_so;
  wire   o_div_clk_internal, toggle_flag_odd, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n1, n2, n3, n4;
  wire   [1:0] counter;
  assign test_so = toggle_flag_odd;

  SDFFRQX2M o_div_clk_internal_reg ( .D(n26), .SI(n4), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst_n), .Q(o_div_clk_internal) );
  SDFFRQX2M toggle_flag_odd_reg ( .D(n29), .SI(o_div_clk_internal), .SE(
        test_se), .CK(i_ref_clk), .RN(i_rst_n), .Q(toggle_flag_odd) );
  SDFFRQX2M \counter_reg[0]  ( .D(n28), .SI(test_si), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst_n), .Q(counter[0]) );
  SDFFRQX2M \counter_reg[1]  ( .D(n27), .SI(n3), .SE(test_se), .CK(i_ref_clk), 
        .RN(i_rst_n), .Q(counter[1]) );
  NAND2X2M U7 ( .A(n4), .B(n21), .Y(n22) );
  NAND2X2M U8 ( .A(n2), .B(n4), .Y(n20) );
  INVX2M U9 ( .A(n19), .Y(n2) );
  OAI32X1M U10 ( .A0(n19), .A1(counter[0]), .A2(n1), .B0(n2), .B1(n3), .Y(n28)
         );
  INVX2M U11 ( .A(n22), .Y(n1) );
  OAI2B1X2M U12 ( .A1N(o_div_clk_internal), .A0(n16), .B0(n17), .Y(n26) );
  NOR2X2M U13 ( .A(n18), .B(n20), .Y(n16) );
  OR4X1M U14 ( .A(n18), .B(n19), .C(counter[1]), .D(o_div_clk_internal), .Y(
        n17) );
  XNOR2X2M U15 ( .A(n21), .B(counter[0]), .Y(n18) );
  OAI31X1M U16 ( .A0(n22), .A1(n3), .A2(n19), .B0(n23), .Y(n27) );
  OAI21X2M U17 ( .A0(n3), .A1(n19), .B0(counter[1]), .Y(n23) );
  NAND2X2M U18 ( .A(toggle_flag_odd), .B(i_div_ratio[0]), .Y(n21) );
  NAND2X2M U19 ( .A(i_div_ratio[1]), .B(i_clk_en), .Y(n19) );
  OAI2B1X2M U20 ( .A1N(toggle_flag_odd), .A0(n24), .B0(n25), .Y(n29) );
  NAND4X2M U21 ( .A(n2), .B(i_div_ratio[0]), .C(n3), .D(n4), .Y(n25) );
  NOR2BX2M U22 ( .AN(i_div_ratio[0]), .B(n20), .Y(n24) );
  INVX2M U23 ( .A(counter[1]), .Y(n4) );
  INVX2M U24 ( .A(counter[0]), .Y(n3) );
  MX2X2M U25 ( .A(i_ref_clk), .B(o_div_clk_internal), .S0(n2), .Y(o_div_clk)
         );
endmodule


module FIFO_Memory_FIFO_DEPTH8_DATA_WIDTH8_test_1 ( w_clk, rst, w_data, w_en, 
        w_addr, r_addr, r_data, test_si2, test_si1, test_so2, test_so1, 
        test_se );
  input [7:0] w_data;
  input [2:0] w_addr;
  input [2:0] r_addr;
  output [7:0] r_data;
  input w_clk, rst, w_en, test_si2, test_si1, test_se;
  output test_so2, test_so1;
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
         \FIFO_MEM[0][0] , n75, n76, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98,
         n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126, n127, n128, n129, n130, n131, n132,
         n133, n134, n135, n136, n137, n138, n139, n140, n141, n142, n143,
         n144, n145, n146, n147, n148, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n149, n150, n151, n152, n153, n154, n155, n156, n157, n158,
         n159, n160, n161, n162, n163, n164, n165, n166, n167, n168, n169,
         n170, n171, n172, n173, n174, n175, n176, n177, n178, n182;
  assign N10 = r_addr[0];
  assign N11 = r_addr[1];
  assign N12 = r_addr[2];
  assign test_so2 = \FIFO_MEM[7][7] ;
  assign test_so1 = \FIFO_MEM[4][0] ;

  SDFFRQX2M \FIFO_MEM_reg[5][7]  ( .D(n132), .SI(\FIFO_MEM[5][6] ), .SE(n182), 
        .CK(w_clk), .RN(n164), .Q(\FIFO_MEM[5][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[5][6]  ( .D(n131), .SI(\FIFO_MEM[5][5] ), .SE(n182), 
        .CK(w_clk), .RN(n164), .Q(\FIFO_MEM[5][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[5][5]  ( .D(n130), .SI(\FIFO_MEM[5][4] ), .SE(n182), 
        .CK(w_clk), .RN(n164), .Q(\FIFO_MEM[5][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[5][4]  ( .D(n129), .SI(\FIFO_MEM[5][3] ), .SE(n182), 
        .CK(w_clk), .RN(n164), .Q(\FIFO_MEM[5][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[5][3]  ( .D(n128), .SI(\FIFO_MEM[5][2] ), .SE(n182), 
        .CK(w_clk), .RN(n164), .Q(\FIFO_MEM[5][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[5][2]  ( .D(n127), .SI(\FIFO_MEM[5][1] ), .SE(n182), 
        .CK(w_clk), .RN(n164), .Q(\FIFO_MEM[5][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[5][1]  ( .D(n126), .SI(\FIFO_MEM[5][0] ), .SE(n182), 
        .CK(w_clk), .RN(n164), .Q(\FIFO_MEM[5][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[5][0]  ( .D(n125), .SI(\FIFO_MEM[4][7] ), .SE(n182), 
        .CK(w_clk), .RN(n164), .Q(\FIFO_MEM[5][0] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][7]  ( .D(n100), .SI(\FIFO_MEM[1][6] ), .SE(n182), 
        .CK(w_clk), .RN(n167), .Q(\FIFO_MEM[1][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][6]  ( .D(n99), .SI(\FIFO_MEM[1][5] ), .SE(n182), 
        .CK(w_clk), .RN(n167), .Q(\FIFO_MEM[1][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][5]  ( .D(n98), .SI(\FIFO_MEM[1][4] ), .SE(n182), 
        .CK(w_clk), .RN(n167), .Q(\FIFO_MEM[1][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][4]  ( .D(n97), .SI(\FIFO_MEM[1][3] ), .SE(n182), 
        .CK(w_clk), .RN(n167), .Q(\FIFO_MEM[1][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][3]  ( .D(n96), .SI(\FIFO_MEM[1][2] ), .SE(n182), 
        .CK(w_clk), .RN(n167), .Q(\FIFO_MEM[1][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][2]  ( .D(n95), .SI(\FIFO_MEM[1][1] ), .SE(n182), 
        .CK(w_clk), .RN(n167), .Q(\FIFO_MEM[1][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][1]  ( .D(n94), .SI(\FIFO_MEM[1][0] ), .SE(n182), 
        .CK(w_clk), .RN(n167), .Q(\FIFO_MEM[1][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][0]  ( .D(n93), .SI(\FIFO_MEM[0][7] ), .SE(n182), 
        .CK(w_clk), .RN(n167), .Q(\FIFO_MEM[1][0] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][7]  ( .D(n148), .SI(\FIFO_MEM[7][6] ), .SE(n182), 
        .CK(w_clk), .RN(n163), .Q(\FIFO_MEM[7][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][6]  ( .D(n147), .SI(\FIFO_MEM[7][5] ), .SE(n182), 
        .CK(w_clk), .RN(n163), .Q(\FIFO_MEM[7][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][5]  ( .D(n146), .SI(\FIFO_MEM[7][4] ), .SE(n182), 
        .CK(w_clk), .RN(n163), .Q(\FIFO_MEM[7][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][4]  ( .D(n145), .SI(\FIFO_MEM[7][3] ), .SE(n182), 
        .CK(w_clk), .RN(n163), .Q(\FIFO_MEM[7][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][3]  ( .D(n144), .SI(\FIFO_MEM[7][2] ), .SE(n182), 
        .CK(w_clk), .RN(n163), .Q(\FIFO_MEM[7][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][2]  ( .D(n143), .SI(\FIFO_MEM[7][1] ), .SE(n182), 
        .CK(w_clk), .RN(n163), .Q(\FIFO_MEM[7][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][1]  ( .D(n142), .SI(\FIFO_MEM[7][0] ), .SE(n182), 
        .CK(w_clk), .RN(n163), .Q(\FIFO_MEM[7][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][0]  ( .D(n141), .SI(\FIFO_MEM[6][7] ), .SE(n182), 
        .CK(w_clk), .RN(n163), .Q(\FIFO_MEM[7][0] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][7]  ( .D(n116), .SI(\FIFO_MEM[3][6] ), .SE(n182), 
        .CK(w_clk), .RN(n165), .Q(\FIFO_MEM[3][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][6]  ( .D(n115), .SI(\FIFO_MEM[3][5] ), .SE(n182), 
        .CK(w_clk), .RN(n165), .Q(\FIFO_MEM[3][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][5]  ( .D(n114), .SI(\FIFO_MEM[3][4] ), .SE(n182), 
        .CK(w_clk), .RN(n165), .Q(\FIFO_MEM[3][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][4]  ( .D(n113), .SI(\FIFO_MEM[3][3] ), .SE(n182), 
        .CK(w_clk), .RN(n165), .Q(\FIFO_MEM[3][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][3]  ( .D(n112), .SI(\FIFO_MEM[3][2] ), .SE(n182), 
        .CK(w_clk), .RN(n166), .Q(\FIFO_MEM[3][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][2]  ( .D(n111), .SI(\FIFO_MEM[3][1] ), .SE(n182), 
        .CK(w_clk), .RN(n166), .Q(\FIFO_MEM[3][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][1]  ( .D(n110), .SI(\FIFO_MEM[3][0] ), .SE(n182), 
        .CK(w_clk), .RN(n166), .Q(\FIFO_MEM[3][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][0]  ( .D(n109), .SI(\FIFO_MEM[2][7] ), .SE(n182), 
        .CK(w_clk), .RN(n166), .Q(\FIFO_MEM[3][0] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][7]  ( .D(n140), .SI(\FIFO_MEM[6][6] ), .SE(n182), 
        .CK(w_clk), .RN(n163), .Q(\FIFO_MEM[6][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][6]  ( .D(n139), .SI(\FIFO_MEM[6][5] ), .SE(
        test_se), .CK(w_clk), .RN(n163), .Q(\FIFO_MEM[6][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][5]  ( .D(n138), .SI(\FIFO_MEM[6][4] ), .SE(
        test_se), .CK(w_clk), .RN(n163), .Q(\FIFO_MEM[6][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][4]  ( .D(n137), .SI(\FIFO_MEM[6][3] ), .SE(
        test_se), .CK(w_clk), .RN(n163), .Q(\FIFO_MEM[6][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][3]  ( .D(n136), .SI(\FIFO_MEM[6][2] ), .SE(
        test_se), .CK(w_clk), .RN(n164), .Q(\FIFO_MEM[6][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][2]  ( .D(n135), .SI(\FIFO_MEM[6][1] ), .SE(
        test_se), .CK(w_clk), .RN(n164), .Q(\FIFO_MEM[6][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][1]  ( .D(n134), .SI(\FIFO_MEM[6][0] ), .SE(
        test_se), .CK(w_clk), .RN(n164), .Q(\FIFO_MEM[6][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][0]  ( .D(n133), .SI(\FIFO_MEM[5][7] ), .SE(
        test_se), .CK(w_clk), .RN(n164), .Q(\FIFO_MEM[6][0] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][7]  ( .D(n108), .SI(\FIFO_MEM[2][6] ), .SE(
        test_se), .CK(w_clk), .RN(n166), .Q(\FIFO_MEM[2][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][6]  ( .D(n107), .SI(\FIFO_MEM[2][5] ), .SE(
        test_se), .CK(w_clk), .RN(n166), .Q(\FIFO_MEM[2][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][5]  ( .D(n106), .SI(\FIFO_MEM[2][4] ), .SE(
        test_se), .CK(w_clk), .RN(n166), .Q(\FIFO_MEM[2][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][4]  ( .D(n105), .SI(\FIFO_MEM[2][3] ), .SE(
        test_se), .CK(w_clk), .RN(n166), .Q(\FIFO_MEM[2][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][3]  ( .D(n104), .SI(\FIFO_MEM[2][2] ), .SE(
        test_se), .CK(w_clk), .RN(n166), .Q(\FIFO_MEM[2][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][2]  ( .D(n103), .SI(\FIFO_MEM[2][1] ), .SE(
        test_se), .CK(w_clk), .RN(n166), .Q(\FIFO_MEM[2][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][1]  ( .D(n102), .SI(\FIFO_MEM[2][0] ), .SE(
        test_se), .CK(w_clk), .RN(n166), .Q(\FIFO_MEM[2][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][0]  ( .D(n101), .SI(\FIFO_MEM[1][7] ), .SE(
        test_se), .CK(w_clk), .RN(n166), .Q(\FIFO_MEM[2][0] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][7]  ( .D(n124), .SI(\FIFO_MEM[4][6] ), .SE(
        test_se), .CK(w_clk), .RN(n165), .Q(\FIFO_MEM[4][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][6]  ( .D(n123), .SI(\FIFO_MEM[4][5] ), .SE(
        test_se), .CK(w_clk), .RN(n165), .Q(\FIFO_MEM[4][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][5]  ( .D(n122), .SI(\FIFO_MEM[4][4] ), .SE(
        test_se), .CK(w_clk), .RN(n165), .Q(\FIFO_MEM[4][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][4]  ( .D(n121), .SI(\FIFO_MEM[4][3] ), .SE(
        test_se), .CK(w_clk), .RN(n165), .Q(\FIFO_MEM[4][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][3]  ( .D(n120), .SI(\FIFO_MEM[4][2] ), .SE(
        test_se), .CK(w_clk), .RN(n165), .Q(\FIFO_MEM[4][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][2]  ( .D(n119), .SI(\FIFO_MEM[4][1] ), .SE(
        test_se), .CK(w_clk), .RN(n165), .Q(\FIFO_MEM[4][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][1]  ( .D(n118), .SI(test_si2), .SE(test_se), .CK(
        w_clk), .RN(n165), .Q(\FIFO_MEM[4][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][0]  ( .D(n117), .SI(\FIFO_MEM[3][7] ), .SE(
        test_se), .CK(w_clk), .RN(n165), .Q(\FIFO_MEM[4][0] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][7]  ( .D(n92), .SI(\FIFO_MEM[0][6] ), .SE(test_se), .CK(w_clk), .RN(n167), .Q(\FIFO_MEM[0][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][6]  ( .D(n91), .SI(\FIFO_MEM[0][5] ), .SE(test_se), .CK(w_clk), .RN(n167), .Q(\FIFO_MEM[0][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][5]  ( .D(n90), .SI(\FIFO_MEM[0][4] ), .SE(test_se), .CK(w_clk), .RN(n167), .Q(\FIFO_MEM[0][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][4]  ( .D(n89), .SI(\FIFO_MEM[0][3] ), .SE(test_se), .CK(w_clk), .RN(n167), .Q(\FIFO_MEM[0][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][3]  ( .D(n88), .SI(\FIFO_MEM[0][2] ), .SE(test_se), .CK(w_clk), .RN(n168), .Q(\FIFO_MEM[0][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][2]  ( .D(n87), .SI(\FIFO_MEM[0][1] ), .SE(test_se), .CK(w_clk), .RN(n168), .Q(\FIFO_MEM[0][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][1]  ( .D(n86), .SI(\FIFO_MEM[0][0] ), .SE(test_se), .CK(w_clk), .RN(n168), .Q(\FIFO_MEM[0][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][0]  ( .D(n85), .SI(test_si1), .SE(test_se), .CK(
        w_clk), .RN(n168), .Q(\FIFO_MEM[0][0] ) );
  BUFX2M U66 ( .A(n82), .Y(n159) );
  BUFX2M U67 ( .A(n83), .Y(n158) );
  BUFX2M U68 ( .A(n84), .Y(n157) );
  BUFX2M U69 ( .A(n78), .Y(n160) );
  BUFX2M U70 ( .A(n162), .Y(n167) );
  BUFX2M U71 ( .A(n162), .Y(n166) );
  BUFX2M U72 ( .A(n161), .Y(n165) );
  BUFX2M U73 ( .A(n161), .Y(n164) );
  BUFX2M U74 ( .A(n161), .Y(n163) );
  BUFX2M U75 ( .A(n162), .Y(n168) );
  BUFX2M U76 ( .A(rst), .Y(n162) );
  BUFX2M U77 ( .A(rst), .Y(n161) );
  NAND3X2M U78 ( .A(n169), .B(n170), .C(n81), .Y(n80) );
  NAND3X2M U79 ( .A(n169), .B(n170), .C(n76), .Y(n75) );
  NAND3X2M U80 ( .A(w_addr[0]), .B(n76), .C(w_addr[1]), .Y(n79) );
  NAND3X2M U81 ( .A(n76), .B(n170), .C(w_addr[0]), .Y(n77) );
  NOR2BX2M U82 ( .AN(w_en), .B(w_addr[2]), .Y(n76) );
  OAI2BB2X1M U83 ( .B0(n75), .B1(n178), .A0N(\FIFO_MEM[0][0] ), .A1N(n75), .Y(
        n85) );
  OAI2BB2X1M U84 ( .B0(n75), .B1(n177), .A0N(\FIFO_MEM[0][1] ), .A1N(n75), .Y(
        n86) );
  OAI2BB2X1M U85 ( .B0(n75), .B1(n176), .A0N(\FIFO_MEM[0][2] ), .A1N(n75), .Y(
        n87) );
  OAI2BB2X1M U86 ( .B0(n75), .B1(n175), .A0N(\FIFO_MEM[0][3] ), .A1N(n75), .Y(
        n88) );
  OAI2BB2X1M U87 ( .B0(n75), .B1(n174), .A0N(\FIFO_MEM[0][4] ), .A1N(n75), .Y(
        n89) );
  OAI2BB2X1M U88 ( .B0(n75), .B1(n173), .A0N(\FIFO_MEM[0][5] ), .A1N(n75), .Y(
        n90) );
  OAI2BB2X1M U89 ( .B0(n75), .B1(n172), .A0N(\FIFO_MEM[0][6] ), .A1N(n75), .Y(
        n91) );
  OAI2BB2X1M U90 ( .B0(n75), .B1(n171), .A0N(\FIFO_MEM[0][7] ), .A1N(n75), .Y(
        n92) );
  OAI2BB2X1M U91 ( .B0(n178), .B1(n79), .A0N(\FIFO_MEM[3][0] ), .A1N(n79), .Y(
        n109) );
  OAI2BB2X1M U92 ( .B0(n177), .B1(n79), .A0N(\FIFO_MEM[3][1] ), .A1N(n79), .Y(
        n110) );
  OAI2BB2X1M U93 ( .B0(n176), .B1(n79), .A0N(\FIFO_MEM[3][2] ), .A1N(n79), .Y(
        n111) );
  OAI2BB2X1M U94 ( .B0(n175), .B1(n79), .A0N(\FIFO_MEM[3][3] ), .A1N(n79), .Y(
        n112) );
  OAI2BB2X1M U95 ( .B0(n174), .B1(n79), .A0N(\FIFO_MEM[3][4] ), .A1N(n79), .Y(
        n113) );
  OAI2BB2X1M U96 ( .B0(n173), .B1(n79), .A0N(\FIFO_MEM[3][5] ), .A1N(n79), .Y(
        n114) );
  OAI2BB2X1M U97 ( .B0(n172), .B1(n79), .A0N(\FIFO_MEM[3][6] ), .A1N(n79), .Y(
        n115) );
  OAI2BB2X1M U98 ( .B0(n171), .B1(n79), .A0N(\FIFO_MEM[3][7] ), .A1N(n79), .Y(
        n116) );
  OAI2BB2X1M U99 ( .B0(n178), .B1(n77), .A0N(\FIFO_MEM[1][0] ), .A1N(n77), .Y(
        n93) );
  OAI2BB2X1M U100 ( .B0(n177), .B1(n77), .A0N(\FIFO_MEM[1][1] ), .A1N(n77), 
        .Y(n94) );
  OAI2BB2X1M U101 ( .B0(n176), .B1(n77), .A0N(\FIFO_MEM[1][2] ), .A1N(n77), 
        .Y(n95) );
  OAI2BB2X1M U102 ( .B0(n175), .B1(n77), .A0N(\FIFO_MEM[1][3] ), .A1N(n77), 
        .Y(n96) );
  OAI2BB2X1M U103 ( .B0(n174), .B1(n77), .A0N(\FIFO_MEM[1][4] ), .A1N(n77), 
        .Y(n97) );
  OAI2BB2X1M U104 ( .B0(n173), .B1(n77), .A0N(\FIFO_MEM[1][5] ), .A1N(n77), 
        .Y(n98) );
  OAI2BB2X1M U105 ( .B0(n172), .B1(n77), .A0N(\FIFO_MEM[1][6] ), .A1N(n77), 
        .Y(n99) );
  OAI2BB2X1M U106 ( .B0(n171), .B1(n77), .A0N(\FIFO_MEM[1][7] ), .A1N(n77), 
        .Y(n100) );
  OAI2BB2X1M U107 ( .B0(n178), .B1(n80), .A0N(\FIFO_MEM[4][0] ), .A1N(n80), 
        .Y(n117) );
  OAI2BB2X1M U108 ( .B0(n177), .B1(n80), .A0N(\FIFO_MEM[4][1] ), .A1N(n80), 
        .Y(n118) );
  OAI2BB2X1M U109 ( .B0(n176), .B1(n80), .A0N(\FIFO_MEM[4][2] ), .A1N(n80), 
        .Y(n119) );
  OAI2BB2X1M U110 ( .B0(n175), .B1(n80), .A0N(\FIFO_MEM[4][3] ), .A1N(n80), 
        .Y(n120) );
  OAI2BB2X1M U111 ( .B0(n174), .B1(n80), .A0N(\FIFO_MEM[4][4] ), .A1N(n80), 
        .Y(n121) );
  OAI2BB2X1M U112 ( .B0(n173), .B1(n80), .A0N(\FIFO_MEM[4][5] ), .A1N(n80), 
        .Y(n122) );
  OAI2BB2X1M U113 ( .B0(n172), .B1(n80), .A0N(\FIFO_MEM[4][6] ), .A1N(n80), 
        .Y(n123) );
  OAI2BB2X1M U114 ( .B0(n171), .B1(n80), .A0N(\FIFO_MEM[4][7] ), .A1N(n80), 
        .Y(n124) );
  OAI2BB2X1M U115 ( .B0(n178), .B1(n160), .A0N(\FIFO_MEM[2][0] ), .A1N(n160), 
        .Y(n101) );
  OAI2BB2X1M U116 ( .B0(n177), .B1(n160), .A0N(\FIFO_MEM[2][1] ), .A1N(n160), 
        .Y(n102) );
  OAI2BB2X1M U117 ( .B0(n176), .B1(n160), .A0N(\FIFO_MEM[2][2] ), .A1N(n160), 
        .Y(n103) );
  OAI2BB2X1M U118 ( .B0(n175), .B1(n160), .A0N(\FIFO_MEM[2][3] ), .A1N(n160), 
        .Y(n104) );
  OAI2BB2X1M U119 ( .B0(n174), .B1(n160), .A0N(\FIFO_MEM[2][4] ), .A1N(n160), 
        .Y(n105) );
  OAI2BB2X1M U120 ( .B0(n173), .B1(n160), .A0N(\FIFO_MEM[2][5] ), .A1N(n160), 
        .Y(n106) );
  OAI2BB2X1M U121 ( .B0(n172), .B1(n160), .A0N(\FIFO_MEM[2][6] ), .A1N(n160), 
        .Y(n107) );
  OAI2BB2X1M U122 ( .B0(n171), .B1(n160), .A0N(\FIFO_MEM[2][7] ), .A1N(n160), 
        .Y(n108) );
  OAI2BB2X1M U123 ( .B0(n178), .B1(n159), .A0N(\FIFO_MEM[5][0] ), .A1N(n159), 
        .Y(n125) );
  OAI2BB2X1M U124 ( .B0(n177), .B1(n159), .A0N(\FIFO_MEM[5][1] ), .A1N(n159), 
        .Y(n126) );
  OAI2BB2X1M U125 ( .B0(n176), .B1(n159), .A0N(\FIFO_MEM[5][2] ), .A1N(n159), 
        .Y(n127) );
  OAI2BB2X1M U126 ( .B0(n175), .B1(n159), .A0N(\FIFO_MEM[5][3] ), .A1N(n159), 
        .Y(n128) );
  OAI2BB2X1M U127 ( .B0(n174), .B1(n159), .A0N(\FIFO_MEM[5][4] ), .A1N(n159), 
        .Y(n129) );
  OAI2BB2X1M U128 ( .B0(n173), .B1(n159), .A0N(\FIFO_MEM[5][5] ), .A1N(n159), 
        .Y(n130) );
  OAI2BB2X1M U129 ( .B0(n172), .B1(n159), .A0N(\FIFO_MEM[5][6] ), .A1N(n159), 
        .Y(n131) );
  OAI2BB2X1M U130 ( .B0(n171), .B1(n159), .A0N(\FIFO_MEM[5][7] ), .A1N(n159), 
        .Y(n132) );
  OAI2BB2X1M U131 ( .B0(n178), .B1(n158), .A0N(\FIFO_MEM[6][0] ), .A1N(n158), 
        .Y(n133) );
  OAI2BB2X1M U132 ( .B0(n177), .B1(n158), .A0N(\FIFO_MEM[6][1] ), .A1N(n158), 
        .Y(n134) );
  OAI2BB2X1M U133 ( .B0(n176), .B1(n158), .A0N(\FIFO_MEM[6][2] ), .A1N(n158), 
        .Y(n135) );
  OAI2BB2X1M U134 ( .B0(n175), .B1(n158), .A0N(\FIFO_MEM[6][3] ), .A1N(n158), 
        .Y(n136) );
  OAI2BB2X1M U135 ( .B0(n174), .B1(n158), .A0N(\FIFO_MEM[6][4] ), .A1N(n158), 
        .Y(n137) );
  OAI2BB2X1M U136 ( .B0(n173), .B1(n158), .A0N(\FIFO_MEM[6][5] ), .A1N(n158), 
        .Y(n138) );
  OAI2BB2X1M U137 ( .B0(n172), .B1(n158), .A0N(\FIFO_MEM[6][6] ), .A1N(n158), 
        .Y(n139) );
  OAI2BB2X1M U138 ( .B0(n171), .B1(n158), .A0N(\FIFO_MEM[6][7] ), .A1N(n158), 
        .Y(n140) );
  OAI2BB2X1M U139 ( .B0(n178), .B1(n157), .A0N(\FIFO_MEM[7][0] ), .A1N(n157), 
        .Y(n141) );
  OAI2BB2X1M U140 ( .B0(n177), .B1(n157), .A0N(\FIFO_MEM[7][1] ), .A1N(n157), 
        .Y(n142) );
  OAI2BB2X1M U141 ( .B0(n176), .B1(n157), .A0N(\FIFO_MEM[7][2] ), .A1N(n157), 
        .Y(n143) );
  OAI2BB2X1M U142 ( .B0(n175), .B1(n157), .A0N(\FIFO_MEM[7][3] ), .A1N(n157), 
        .Y(n144) );
  OAI2BB2X1M U143 ( .B0(n174), .B1(n157), .A0N(\FIFO_MEM[7][4] ), .A1N(n157), 
        .Y(n145) );
  OAI2BB2X1M U144 ( .B0(n173), .B1(n157), .A0N(\FIFO_MEM[7][5] ), .A1N(n157), 
        .Y(n146) );
  OAI2BB2X1M U145 ( .B0(n172), .B1(n157), .A0N(\FIFO_MEM[7][6] ), .A1N(n157), 
        .Y(n147) );
  OAI2BB2X1M U146 ( .B0(n171), .B1(n157), .A0N(\FIFO_MEM[7][7] ), .A1N(n157), 
        .Y(n148) );
  AND2X2M U147 ( .A(w_addr[2]), .B(w_en), .Y(n81) );
  NAND3X2M U148 ( .A(w_addr[0]), .B(n170), .C(n81), .Y(n82) );
  NAND3X2M U149 ( .A(w_addr[1]), .B(n169), .C(n81), .Y(n83) );
  NAND3X2M U150 ( .A(w_addr[1]), .B(w_addr[0]), .C(n81), .Y(n84) );
  NAND3X2M U151 ( .A(n76), .B(n169), .C(w_addr[1]), .Y(n78) );
  INVX2M U152 ( .A(w_addr[1]), .Y(n170) );
  INVX2M U153 ( .A(w_addr[0]), .Y(n169) );
  INVX2M U154 ( .A(w_data[0]), .Y(n178) );
  INVX2M U155 ( .A(w_data[1]), .Y(n177) );
  INVX2M U156 ( .A(w_data[2]), .Y(n176) );
  INVX2M U157 ( .A(w_data[3]), .Y(n175) );
  INVX2M U158 ( .A(w_data[4]), .Y(n174) );
  INVX2M U159 ( .A(w_data[5]), .Y(n173) );
  INVX2M U160 ( .A(w_data[6]), .Y(n172) );
  INVX2M U161 ( .A(w_data[7]), .Y(n171) );
  MX2X2M U162 ( .A(n70), .B(n69), .S0(N12), .Y(r_data[2]) );
  MX4X1M U163 ( .A(\FIFO_MEM[4][2] ), .B(\FIFO_MEM[5][2] ), .C(
        \FIFO_MEM[6][2] ), .D(\FIFO_MEM[7][2] ), .S0(n155), .S1(N11), .Y(n69)
         );
  MX4X1M U164 ( .A(\FIFO_MEM[0][2] ), .B(\FIFO_MEM[1][2] ), .C(
        \FIFO_MEM[2][2] ), .D(\FIFO_MEM[3][2] ), .S0(n156), .S1(N11), .Y(n70)
         );
  MX2X2M U165 ( .A(n152), .B(n151), .S0(N12), .Y(r_data[6]) );
  MX4X1M U166 ( .A(\FIFO_MEM[4][6] ), .B(\FIFO_MEM[5][6] ), .C(
        \FIFO_MEM[6][6] ), .D(\FIFO_MEM[7][6] ), .S0(n155), .S1(N11), .Y(n151)
         );
  MX4X1M U167 ( .A(\FIFO_MEM[0][6] ), .B(\FIFO_MEM[1][6] ), .C(
        \FIFO_MEM[2][6] ), .D(\FIFO_MEM[3][6] ), .S0(n156), .S1(N11), .Y(n152)
         );
  MX2X2M U168 ( .A(n72), .B(n71), .S0(N12), .Y(r_data[3]) );
  MX4X1M U169 ( .A(\FIFO_MEM[4][3] ), .B(\FIFO_MEM[5][3] ), .C(
        \FIFO_MEM[6][3] ), .D(\FIFO_MEM[7][3] ), .S0(n155), .S1(N11), .Y(n71)
         );
  MX4X1M U170 ( .A(\FIFO_MEM[0][3] ), .B(\FIFO_MEM[1][3] ), .C(
        \FIFO_MEM[2][3] ), .D(\FIFO_MEM[3][3] ), .S0(n156), .S1(N11), .Y(n72)
         );
  MX2X2M U171 ( .A(n154), .B(n153), .S0(N12), .Y(r_data[7]) );
  MX4X1M U172 ( .A(\FIFO_MEM[4][7] ), .B(\FIFO_MEM[5][7] ), .C(
        \FIFO_MEM[6][7] ), .D(\FIFO_MEM[7][7] ), .S0(n155), .S1(N11), .Y(n153)
         );
  MX4X1M U173 ( .A(\FIFO_MEM[0][7] ), .B(\FIFO_MEM[1][7] ), .C(
        \FIFO_MEM[2][7] ), .D(\FIFO_MEM[3][7] ), .S0(n156), .S1(N11), .Y(n154)
         );
  MX2X2M U174 ( .A(n66), .B(n65), .S0(N12), .Y(r_data[0]) );
  MX4X1M U175 ( .A(\FIFO_MEM[4][0] ), .B(\FIFO_MEM[5][0] ), .C(
        \FIFO_MEM[6][0] ), .D(\FIFO_MEM[7][0] ), .S0(n155), .S1(N11), .Y(n65)
         );
  MX4X1M U176 ( .A(\FIFO_MEM[0][0] ), .B(\FIFO_MEM[1][0] ), .C(
        \FIFO_MEM[2][0] ), .D(\FIFO_MEM[3][0] ), .S0(n156), .S1(N11), .Y(n66)
         );
  MX2X2M U177 ( .A(n74), .B(n73), .S0(N12), .Y(r_data[4]) );
  MX4X1M U178 ( .A(\FIFO_MEM[4][4] ), .B(\FIFO_MEM[5][4] ), .C(
        \FIFO_MEM[6][4] ), .D(\FIFO_MEM[7][4] ), .S0(n155), .S1(N11), .Y(n73)
         );
  MX4X1M U179 ( .A(\FIFO_MEM[0][4] ), .B(\FIFO_MEM[1][4] ), .C(
        \FIFO_MEM[2][4] ), .D(\FIFO_MEM[3][4] ), .S0(n156), .S1(N11), .Y(n74)
         );
  MX2X2M U180 ( .A(n68), .B(n67), .S0(N12), .Y(r_data[1]) );
  MX4X1M U181 ( .A(\FIFO_MEM[4][1] ), .B(\FIFO_MEM[5][1] ), .C(
        \FIFO_MEM[6][1] ), .D(\FIFO_MEM[7][1] ), .S0(n155), .S1(N11), .Y(n67)
         );
  MX4X1M U182 ( .A(\FIFO_MEM[0][1] ), .B(\FIFO_MEM[1][1] ), .C(
        \FIFO_MEM[2][1] ), .D(\FIFO_MEM[3][1] ), .S0(n156), .S1(N11), .Y(n68)
         );
  MX2X2M U183 ( .A(n150), .B(n149), .S0(N12), .Y(r_data[5]) );
  MX4X1M U184 ( .A(\FIFO_MEM[4][5] ), .B(\FIFO_MEM[5][5] ), .C(
        \FIFO_MEM[6][5] ), .D(\FIFO_MEM[7][5] ), .S0(n155), .S1(N11), .Y(n149)
         );
  MX4X1M U185 ( .A(\FIFO_MEM[0][5] ), .B(\FIFO_MEM[1][5] ), .C(
        \FIFO_MEM[2][5] ), .D(\FIFO_MEM[3][5] ), .S0(n156), .S1(N11), .Y(n150)
         );
  BUFX2M U186 ( .A(N10), .Y(n156) );
  BUFX2M U187 ( .A(N10), .Y(n155) );
  DLY1X1M U188 ( .A(test_se), .Y(n182) );
endmodule


module binary_to_gray_POINTER_WIDTH4_0 ( binary, gray );
  input [3:0] binary;
  output [3:0] gray;


  CLKXOR2X2M U1 ( .A(binary[1]), .B(binary[0]), .Y(gray[0]) );
  CLKXOR2X2M U2 ( .A(binary[2]), .B(binary[1]), .Y(gray[1]) );
  CLKXOR2X2M U3 ( .A(binary[3]), .B(binary[2]), .Y(gray[2]) );
  BUFX2M U4 ( .A(binary[3]), .Y(gray[3]) );
endmodule


module FIFO_rptr_POINTER_WIDTH4_test_1 ( r_clk, rrst_n, rinc, rempty, r_addr, 
        gray_rptr, gray_wptr, test_si, test_so, test_se );
  output [2:0] r_addr;
  output [3:0] gray_rptr;
  input [3:0] gray_wptr;
  input r_clk, rrst_n, rinc, test_si, test_se;
  output rempty, test_so;
  wire   \rptr[3] , n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17
;
  assign test_so = \rptr[3] ;

  SDFFRQX2M \rptr_reg[3]  ( .D(n14), .SI(r_addr[2]), .SE(test_se), .CK(r_clk), 
        .RN(rrst_n), .Q(\rptr[3] ) );
  SDFFRQX2M \rptr_reg[0]  ( .D(n17), .SI(test_si), .SE(test_se), .CK(r_clk), 
        .RN(rrst_n), .Q(r_addr[0]) );
  SDFFRQX2M \rptr_reg[2]  ( .D(n15), .SI(r_addr[1]), .SE(test_se), .CK(r_clk), 
        .RN(rrst_n), .Q(r_addr[2]) );
  SDFFRQX2M \rptr_reg[1]  ( .D(n16), .SI(r_addr[0]), .SE(test_se), .CK(r_clk), 
        .RN(rrst_n), .Q(r_addr[1]) );
  INVX2M U7 ( .A(n5), .Y(rempty) );
  XNOR2X2M U8 ( .A(gray_wptr[1]), .B(gray_rptr[1]), .Y(n10) );
  NOR2BX2M U9 ( .AN(r_addr[0]), .B(n9), .Y(n8) );
  XNOR2X2M U10 ( .A(r_addr[2]), .B(n7), .Y(n15) );
  NAND4X2M U11 ( .A(n10), .B(n11), .C(n12), .D(n13), .Y(n5) );
  XNOR2X2M U12 ( .A(gray_wptr[3]), .B(gray_rptr[3]), .Y(n12) );
  XNOR2X2M U13 ( .A(gray_wptr[2]), .B(gray_rptr[2]), .Y(n13) );
  XNOR2X2M U14 ( .A(gray_wptr[0]), .B(gray_rptr[0]), .Y(n11) );
  NAND2X2M U15 ( .A(r_addr[1]), .B(n8), .Y(n7) );
  NAND2X2M U16 ( .A(rinc), .B(n5), .Y(n9) );
  CLKXOR2X2M U17 ( .A(r_addr[1]), .B(n8), .Y(n16) );
  CLKXOR2X2M U18 ( .A(\rptr[3] ), .B(n6), .Y(n14) );
  NOR2BX2M U19 ( .AN(r_addr[2]), .B(n7), .Y(n6) );
  XNOR2X2M U20 ( .A(r_addr[0]), .B(n9), .Y(n17) );
  binary_to_gray_POINTER_WIDTH4_0 b2g ( .binary({\rptr[3] , r_addr}), .gray(
        gray_rptr) );
endmodule


module binary_to_gray_POINTER_WIDTH4_1 ( binary, gray );
  input [3:0] binary;
  output [3:0] gray;


  CLKXOR2X2M U1 ( .A(binary[3]), .B(binary[2]), .Y(gray[2]) );
  CLKXOR2X2M U2 ( .A(binary[1]), .B(binary[0]), .Y(gray[0]) );
  CLKXOR2X2M U3 ( .A(binary[2]), .B(binary[1]), .Y(gray[1]) );
  BUFX2M U4 ( .A(binary[3]), .Y(gray[3]) );
endmodule


module FIFO_wptr_POINTER_WIDTH4_test_1 ( w_clk, wrst_n, winc, wfull, waddr, 
        gray_wptr, gray_rptr, test_si, test_so, test_se );
  output [2:0] waddr;
  output [3:0] gray_wptr;
  input [3:0] gray_rptr;
  input w_clk, wrst_n, winc, test_si, test_se;
  output wfull, test_so;
  wire   \wptr[3] , n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17
;
  assign test_so = \wptr[3] ;

  SDFFRQX2M \wptr_reg[3]  ( .D(n14), .SI(waddr[2]), .SE(test_se), .CK(w_clk), 
        .RN(wrst_n), .Q(\wptr[3] ) );
  SDFFRQX2M \wptr_reg[2]  ( .D(n15), .SI(waddr[1]), .SE(test_se), .CK(w_clk), 
        .RN(wrst_n), .Q(waddr[2]) );
  SDFFRQX2M \wptr_reg[0]  ( .D(n17), .SI(test_si), .SE(test_se), .CK(w_clk), 
        .RN(wrst_n), .Q(waddr[0]) );
  SDFFRQX2M \wptr_reg[1]  ( .D(n16), .SI(waddr[0]), .SE(test_se), .CK(w_clk), 
        .RN(wrst_n), .Q(waddr[1]) );
  INVX2M U7 ( .A(n5), .Y(wfull) );
  NAND2X2M U8 ( .A(winc), .B(n5), .Y(n9) );
  XNOR2X2M U9 ( .A(gray_wptr[1]), .B(gray_rptr[1]), .Y(n10) );
  NOR2BX2M U10 ( .AN(waddr[0]), .B(n9), .Y(n8) );
  XNOR2X2M U11 ( .A(waddr[2]), .B(n7), .Y(n15) );
  NAND4X2M U12 ( .A(n10), .B(n11), .C(n12), .D(n13), .Y(n5) );
  CLKXOR2X2M U13 ( .A(gray_wptr[3]), .B(gray_rptr[3]), .Y(n13) );
  CLKXOR2X2M U14 ( .A(gray_wptr[2]), .B(gray_rptr[2]), .Y(n12) );
  XNOR2X2M U15 ( .A(gray_wptr[0]), .B(gray_rptr[0]), .Y(n11) );
  NAND2X2M U16 ( .A(waddr[1]), .B(n8), .Y(n7) );
  CLKXOR2X2M U17 ( .A(waddr[1]), .B(n8), .Y(n16) );
  CLKXOR2X2M U18 ( .A(\wptr[3] ), .B(n6), .Y(n14) );
  NOR2BX2M U19 ( .AN(waddr[2]), .B(n7), .Y(n6) );
  XNOR2X2M U20 ( .A(waddr[0]), .B(n9), .Y(n17) );
  binary_to_gray_POINTER_WIDTH4_1 b2g ( .binary({\wptr[3] , waddr}), .gray(
        gray_wptr) );
endmodule


module BIT_SYNC_N2_test_5 ( clk, rst, IN, OUT, test_si, test_se );
  input clk, rst, IN, test_si, test_se;
  output OUT;
  wire   \stage[0] ;

  SDFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .SI(\stage[0] ), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(OUT) );
  SDFFRQX2M \stage_reg[0]  ( .D(IN), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(\stage[0] ) );
endmodule


module BIT_SYNC_N2_test_6 ( clk, rst, IN, OUT, test_si, test_se );
  input clk, rst, IN, test_si, test_se;
  output OUT;
  wire   \stage[0] ;

  SDFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .SI(\stage[0] ), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(OUT) );
  SDFFRQX2M \stage_reg[0]  ( .D(IN), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(\stage[0] ) );
endmodule


module BIT_SYNC_N2_test_7 ( clk, rst, IN, OUT, test_si, test_se );
  input clk, rst, IN, test_si, test_se;
  output OUT;
  wire   \stage[0] ;

  SDFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .SI(\stage[0] ), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(OUT) );
  SDFFRQX2M \stage_reg[0]  ( .D(IN), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(\stage[0] ) );
endmodule


module BIT_SYNC_N2_test_8 ( clk, rst, IN, OUT, test_si, test_se );
  input clk, rst, IN, test_si, test_se;
  output OUT;
  wire   \stage[0] ;

  SDFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .SI(\stage[0] ), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(OUT) );
  SDFFRQX2M \stage_reg[0]  ( .D(IN), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(\stage[0] ) );
endmodule


module BUS_SYNC_N2_POINTER_WIDTH4_test_1 ( clk, rst, IN, OUT, test_si, test_se
 );
  input [3:0] IN;
  output [3:0] OUT;
  input clk, rst, test_si, test_se;


  BIT_SYNC_N2_test_5 \BIT_SYNC_INST[0].BIT_SYNC_i  ( .clk(clk), .rst(rst), 
        .IN(IN[0]), .OUT(OUT[0]), .test_si(test_si), .test_se(test_se) );
  BIT_SYNC_N2_test_6 \BIT_SYNC_INST[1].BIT_SYNC_i  ( .clk(clk), .rst(rst), 
        .IN(IN[1]), .OUT(OUT[1]), .test_si(OUT[0]), .test_se(test_se) );
  BIT_SYNC_N2_test_7 \BIT_SYNC_INST[2].BIT_SYNC_i  ( .clk(clk), .rst(rst), 
        .IN(IN[2]), .OUT(OUT[2]), .test_si(OUT[1]), .test_se(test_se) );
  BIT_SYNC_N2_test_8 \BIT_SYNC_INST[3].BIT_SYNC_i  ( .clk(clk), .rst(rst), 
        .IN(IN[3]), .OUT(OUT[3]), .test_si(OUT[2]), .test_se(test_se) );
endmodule


module BIT_SYNC_N2_test_1 ( clk, rst, IN, OUT, test_si, test_se );
  input clk, rst, IN, test_si, test_se;
  output OUT;
  wire   \stage[0] ;

  SDFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .SI(\stage[0] ), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(OUT) );
  SDFFRQX2M \stage_reg[0]  ( .D(IN), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(\stage[0] ) );
endmodule


module BIT_SYNC_N2_test_2 ( clk, rst, IN, OUT, test_si, test_se );
  input clk, rst, IN, test_si, test_se;
  output OUT;
  wire   \stage[0] ;

  SDFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .SI(\stage[0] ), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(OUT) );
  SDFFRQX2M \stage_reg[0]  ( .D(IN), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(\stage[0] ) );
endmodule


module BIT_SYNC_N2_test_3 ( clk, rst, IN, OUT, test_si, test_se );
  input clk, rst, IN, test_si, test_se;
  output OUT;
  wire   \stage[0] ;

  SDFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .SI(\stage[0] ), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(OUT) );
  SDFFRQX2M \stage_reg[0]  ( .D(IN), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(\stage[0] ) );
endmodule


module BIT_SYNC_N2_test_4 ( clk, rst, IN, OUT, test_si, test_se );
  input clk, rst, IN, test_si, test_se;
  output OUT;
  wire   \stage[0] ;

  SDFFRQX2M \stage_reg[1]  ( .D(\stage[0] ), .SI(\stage[0] ), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(OUT) );
  SDFFRQX2M \stage_reg[0]  ( .D(IN), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(\stage[0] ) );
endmodule


module BUS_SYNC_N2_POINTER_WIDTH4_test_0 ( clk, rst, IN, OUT, test_si, test_se
 );
  input [3:0] IN;
  output [3:0] OUT;
  input clk, rst, test_si, test_se;


  BIT_SYNC_N2_test_1 \BIT_SYNC_INST[0].BIT_SYNC_i  ( .clk(clk), .rst(rst), 
        .IN(IN[0]), .OUT(OUT[0]), .test_si(test_si), .test_se(test_se) );
  BIT_SYNC_N2_test_2 \BIT_SYNC_INST[1].BIT_SYNC_i  ( .clk(clk), .rst(rst), 
        .IN(IN[1]), .OUT(OUT[1]), .test_si(OUT[0]), .test_se(test_se) );
  BIT_SYNC_N2_test_3 \BIT_SYNC_INST[2].BIT_SYNC_i  ( .clk(clk), .rst(rst), 
        .IN(IN[2]), .OUT(OUT[2]), .test_si(OUT[1]), .test_se(test_se) );
  BIT_SYNC_N2_test_4 \BIT_SYNC_INST[3].BIT_SYNC_i  ( .clk(clk), .rst(rst), 
        .IN(IN[3]), .OUT(OUT[3]), .test_si(OUT[2]), .test_se(test_se) );
endmodule


module FIFO_TOP_test_1 ( w_data, winc, w_clk, wrst_n, wfull, r_data, rinc, 
        rempty, r_clk, rrst_n, test_si2, test_si1, test_so2, test_so1, test_se
 );
  input [7:0] w_data;
  output [7:0] r_data;
  input winc, w_clk, wrst_n, rinc, r_clk, rrst_n, test_si2, test_si1, test_se;
  output wfull, rempty, test_so2, test_so1;
  wire   wclken, n1, n2, n4, n5;
  wire   [2:0] w_addr;
  wire   [2:0] r_addr;
  wire   [3:0] gray_rptr;
  wire   [3:0] gray_wptr_afterSYNC;
  wire   [3:0] gray_wptr;
  wire   [3:0] gray_rptr_afterSYNC;

  NOR2BX2M U1 ( .AN(winc), .B(wfull), .Y(wclken) );
  INVX2M U2 ( .A(n2), .Y(n1) );
  INVX2M U3 ( .A(wrst_n), .Y(n2) );
  FIFO_Memory_FIFO_DEPTH8_DATA_WIDTH8_test_1 FIFO_Memory ( .w_clk(w_clk), 
        .rst(n1), .w_data(w_data), .w_en(wclken), .w_addr(w_addr), .r_addr(
        r_addr), .r_data(r_data), .test_si2(test_si2), .test_si1(
        gray_wptr_afterSYNC[3]), .test_so2(n5), .test_so1(test_so1), .test_se(
        test_se) );
  FIFO_rptr_POINTER_WIDTH4_test_1 FIFO_rptr ( .r_clk(r_clk), .rrst_n(rrst_n), 
        .rinc(rinc), .rempty(rempty), .r_addr(r_addr), .gray_rptr(gray_rptr), 
        .gray_wptr(gray_wptr_afterSYNC), .test_si(n5), .test_so(n4), .test_se(
        test_se) );
  FIFO_wptr_POINTER_WIDTH4_test_1 FIFO_wptr ( .w_clk(w_clk), .wrst_n(n1), 
        .winc(winc), .wfull(wfull), .waddr(w_addr), .gray_wptr(gray_wptr), 
        .gray_rptr(gray_rptr_afterSYNC), .test_si(n4), .test_so(test_so2), 
        .test_se(test_se) );
  BUS_SYNC_N2_POINTER_WIDTH4_test_1 BUS_SYNC_w2r ( .clk(r_clk), .rst(rrst_n), 
        .IN(gray_wptr), .OUT(gray_wptr_afterSYNC), .test_si(
        gray_rptr_afterSYNC[3]), .test_se(test_se) );
  BUS_SYNC_N2_POINTER_WIDTH4_test_0 BUS_SYNC_r2w ( .clk(w_clk), .rst(n1), .IN(
        gray_rptr), .OUT(gray_rptr_afterSYNC), .test_si(test_si1), .test_se(
        test_se) );
endmodule


module RegFile_test_1 ( CLK, RST, WrEn, RdEn, Address, WrData, RdData, 
        RdData_VLD, REG0, REG1, REG2, REG3, test_si2, test_si1, test_so2, 
        test_so1, test_se );
  input [3:0] Address;
  input [7:0] WrData;
  output [7:0] RdData;
  output [7:0] REG0;
  output [7:0] REG1;
  output [7:0] REG2;
  output [7:0] REG3;
  input CLK, RST, WrEn, RdEn, test_si2, test_si1, test_se;
  output RdData_VLD, test_so2, test_so1;
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
         \regArr[4][0] , N36, N37, N38, N39, N40, N41, N42, N43, n149, n150,
         n151, n152, n153, n154, n155, n156, n157, n158, n159, n160, n161,
         n162, n163, n164, n165, n166, n167, n168, n169, n170, n171, n172,
         n173, n174, n175, n176, n177, n178, n179, n180, n181, n182, n183,
         n184, n185, n186, n187, n188, n189, n190, n191, n192, n193, n194,
         n195, n196, n197, n198, n199, n200, n201, n202, n203, n204, n205,
         n206, n207, n208, n209, n210, n211, n212, n213, n214, n215, n216,
         n217, n218, n219, n220, n221, n222, n223, n224, n225, n226, n227,
         n228, n229, n230, n231, n232, n233, n234, n235, n236, n237, n238,
         n239, n240, n241, n242, n243, n244, n245, n246, n247, n248, n249,
         n250, n251, n252, n253, n254, n255, n256, n257, n258, n259, n260,
         n261, n262, n263, n264, n265, n266, n267, n268, n269, n270, n271,
         n272, n273, n274, n275, n276, n277, n278, n279, n280, n281, n282,
         n283, n284, n285, n286, n287, n288, n289, n290, n291, n292, n293,
         n294, n295, n296, n297, n298, n299, n300, n301, n302, n303, n304,
         n305, n306, n307, n308, n309, n310, n311, n312, n313, n139, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n314, n315, n316,
         n317, n318, n319, n320, n321, n322, n323, n324, n325, n326, n327,
         n328, n329, n330, n331, n332, n333, n334, n335, n336, n337, n338,
         n339, n340, n341, n342, n343, n344, n345, n346, n347, n348, n349,
         n350, n351, n352, n353, n354, n355, n356, n357, n358, n359, n360,
         n361, n362, n363, n364, n365, n366, n370, n371, n372, n373;
  assign N11 = Address[0];
  assign N12 = Address[1];
  assign N13 = Address[2];
  assign N14 = Address[3];
  assign test_so2 = \regArr[15][7] ;
  assign test_so1 = \regArr[4][7] ;

  SDFFRQX2M \regArr_reg[13][7]  ( .D(n297), .SI(\regArr[13][6] ), .SE(n372), 
        .CK(CLK), .RN(n351), .Q(\regArr[13][7] ) );
  SDFFRQX2M \regArr_reg[13][6]  ( .D(n296), .SI(\regArr[13][5] ), .SE(n371), 
        .CK(CLK), .RN(n351), .Q(\regArr[13][6] ) );
  SDFFRQX2M \regArr_reg[13][5]  ( .D(n295), .SI(\regArr[13][4] ), .SE(n370), 
        .CK(CLK), .RN(n351), .Q(\regArr[13][5] ) );
  SDFFRQX2M \regArr_reg[13][4]  ( .D(n294), .SI(\regArr[13][3] ), .SE(n373), 
        .CK(CLK), .RN(n351), .Q(\regArr[13][4] ) );
  SDFFRQX2M \regArr_reg[13][3]  ( .D(n293), .SI(\regArr[13][2] ), .SE(n372), 
        .CK(CLK), .RN(n351), .Q(\regArr[13][3] ) );
  SDFFRQX2M \regArr_reg[13][2]  ( .D(n292), .SI(\regArr[13][1] ), .SE(n371), 
        .CK(CLK), .RN(n351), .Q(\regArr[13][2] ) );
  SDFFRQX2M \regArr_reg[13][1]  ( .D(n291), .SI(\regArr[13][0] ), .SE(n370), 
        .CK(CLK), .RN(n351), .Q(\regArr[13][1] ) );
  SDFFRQX2M \regArr_reg[13][0]  ( .D(n290), .SI(\regArr[12][7] ), .SE(n373), 
        .CK(CLK), .RN(n351), .Q(\regArr[13][0] ) );
  SDFFRQX2M \regArr_reg[9][7]  ( .D(n265), .SI(\regArr[9][6] ), .SE(n372), 
        .CK(CLK), .RN(n349), .Q(\regArr[9][7] ) );
  SDFFRQX2M \regArr_reg[9][6]  ( .D(n264), .SI(\regArr[9][5] ), .SE(n371), 
        .CK(CLK), .RN(n349), .Q(\regArr[9][6] ) );
  SDFFRQX2M \regArr_reg[9][5]  ( .D(n263), .SI(\regArr[9][4] ), .SE(n370), 
        .CK(CLK), .RN(n349), .Q(\regArr[9][5] ) );
  SDFFRQX2M \regArr_reg[9][4]  ( .D(n262), .SI(\regArr[9][3] ), .SE(n373), 
        .CK(CLK), .RN(n349), .Q(\regArr[9][4] ) );
  SDFFRQX2M \regArr_reg[9][3]  ( .D(n261), .SI(\regArr[9][2] ), .SE(n372), 
        .CK(CLK), .RN(n349), .Q(\regArr[9][3] ) );
  SDFFRQX2M \regArr_reg[9][2]  ( .D(n260), .SI(\regArr[9][1] ), .SE(n371), 
        .CK(CLK), .RN(n349), .Q(\regArr[9][2] ) );
  SDFFRQX2M \regArr_reg[9][1]  ( .D(n259), .SI(\regArr[9][0] ), .SE(n370), 
        .CK(CLK), .RN(n349), .Q(\regArr[9][1] ) );
  SDFFRQX2M \regArr_reg[9][0]  ( .D(n258), .SI(\regArr[8][7] ), .SE(n373), 
        .CK(CLK), .RN(n348), .Q(\regArr[9][0] ) );
  SDFFRQX2M \regArr_reg[5][7]  ( .D(n233), .SI(\regArr[5][6] ), .SE(n372), 
        .CK(CLK), .RN(n347), .Q(\regArr[5][7] ) );
  SDFFRQX2M \regArr_reg[5][6]  ( .D(n232), .SI(\regArr[5][5] ), .SE(n371), 
        .CK(CLK), .RN(n347), .Q(\regArr[5][6] ) );
  SDFFRQX2M \regArr_reg[5][5]  ( .D(n231), .SI(\regArr[5][4] ), .SE(n370), 
        .CK(CLK), .RN(n346), .Q(\regArr[5][5] ) );
  SDFFRQX2M \regArr_reg[5][4]  ( .D(n230), .SI(\regArr[5][3] ), .SE(n373), 
        .CK(CLK), .RN(n346), .Q(\regArr[5][4] ) );
  SDFFRQX2M \regArr_reg[5][3]  ( .D(n229), .SI(\regArr[5][2] ), .SE(n372), 
        .CK(CLK), .RN(n346), .Q(\regArr[5][3] ) );
  SDFFRQX2M \regArr_reg[5][2]  ( .D(n228), .SI(\regArr[5][1] ), .SE(n371), 
        .CK(CLK), .RN(n346), .Q(\regArr[5][2] ) );
  SDFFRQX2M \regArr_reg[5][1]  ( .D(n227), .SI(\regArr[5][0] ), .SE(n370), 
        .CK(CLK), .RN(n346), .Q(\regArr[5][1] ) );
  SDFFRQX2M \regArr_reg[5][0]  ( .D(n226), .SI(test_si2), .SE(n373), .CK(CLK), 
        .RN(n346), .Q(\regArr[5][0] ) );
  SDFFRQX2M \regArr_reg[15][7]  ( .D(n313), .SI(\regArr[15][6] ), .SE(n372), 
        .CK(CLK), .RN(n343), .Q(\regArr[15][7] ) );
  SDFFRQX2M \regArr_reg[15][6]  ( .D(n312), .SI(\regArr[15][5] ), .SE(n371), 
        .CK(CLK), .RN(n352), .Q(\regArr[15][6] ) );
  SDFFRQX2M \regArr_reg[15][5]  ( .D(n311), .SI(\regArr[15][4] ), .SE(n370), 
        .CK(CLK), .RN(n352), .Q(\regArr[15][5] ) );
  SDFFRQX2M \regArr_reg[15][4]  ( .D(n310), .SI(\regArr[15][3] ), .SE(n373), 
        .CK(CLK), .RN(n352), .Q(\regArr[15][4] ) );
  SDFFRQX2M \regArr_reg[15][3]  ( .D(n309), .SI(\regArr[15][2] ), .SE(n372), 
        .CK(CLK), .RN(n352), .Q(\regArr[15][3] ) );
  SDFFRQX2M \regArr_reg[15][2]  ( .D(n308), .SI(\regArr[15][1] ), .SE(n371), 
        .CK(CLK), .RN(n352), .Q(\regArr[15][2] ) );
  SDFFRQX2M \regArr_reg[15][1]  ( .D(n307), .SI(\regArr[15][0] ), .SE(n370), 
        .CK(CLK), .RN(n352), .Q(\regArr[15][1] ) );
  SDFFRQX2M \regArr_reg[15][0]  ( .D(n306), .SI(\regArr[14][7] ), .SE(n373), 
        .CK(CLK), .RN(n352), .Q(\regArr[15][0] ) );
  SDFFRQX2M \regArr_reg[11][7]  ( .D(n281), .SI(\regArr[11][6] ), .SE(n372), 
        .CK(CLK), .RN(n350), .Q(\regArr[11][7] ) );
  SDFFRQX2M \regArr_reg[11][6]  ( .D(n280), .SI(\regArr[11][5] ), .SE(n371), 
        .CK(CLK), .RN(n350), .Q(\regArr[11][6] ) );
  SDFFRQX2M \regArr_reg[11][5]  ( .D(n279), .SI(\regArr[11][4] ), .SE(n370), 
        .CK(CLK), .RN(n350), .Q(\regArr[11][5] ) );
  SDFFRQX2M \regArr_reg[11][4]  ( .D(n278), .SI(\regArr[11][3] ), .SE(n373), 
        .CK(CLK), .RN(n350), .Q(\regArr[11][4] ) );
  SDFFRQX2M \regArr_reg[11][3]  ( .D(n277), .SI(\regArr[11][2] ), .SE(n372), 
        .CK(CLK), .RN(n350), .Q(\regArr[11][3] ) );
  SDFFRQX2M \regArr_reg[11][2]  ( .D(n276), .SI(\regArr[11][1] ), .SE(n371), 
        .CK(CLK), .RN(n350), .Q(\regArr[11][2] ) );
  SDFFRQX2M \regArr_reg[11][1]  ( .D(n275), .SI(\regArr[11][0] ), .SE(n370), 
        .CK(CLK), .RN(n350), .Q(\regArr[11][1] ) );
  SDFFRQX2M \regArr_reg[11][0]  ( .D(n274), .SI(\regArr[10][7] ), .SE(n373), 
        .CK(CLK), .RN(n350), .Q(\regArr[11][0] ) );
  SDFFRQX2M \regArr_reg[7][7]  ( .D(n249), .SI(\regArr[7][6] ), .SE(n372), 
        .CK(CLK), .RN(n348), .Q(\regArr[7][7] ) );
  SDFFRQX2M \regArr_reg[7][6]  ( .D(n248), .SI(\regArr[7][5] ), .SE(n371), 
        .CK(CLK), .RN(n348), .Q(\regArr[7][6] ) );
  SDFFRQX2M \regArr_reg[7][5]  ( .D(n247), .SI(\regArr[7][4] ), .SE(n370), 
        .CK(CLK), .RN(n348), .Q(\regArr[7][5] ) );
  SDFFRQX2M \regArr_reg[7][4]  ( .D(n246), .SI(\regArr[7][3] ), .SE(n373), 
        .CK(CLK), .RN(n348), .Q(\regArr[7][4] ) );
  SDFFRQX2M \regArr_reg[7][3]  ( .D(n245), .SI(\regArr[7][2] ), .SE(n372), 
        .CK(CLK), .RN(n348), .Q(\regArr[7][3] ) );
  SDFFRQX2M \regArr_reg[7][2]  ( .D(n244), .SI(\regArr[7][1] ), .SE(n371), 
        .CK(CLK), .RN(n347), .Q(\regArr[7][2] ) );
  SDFFRQX2M \regArr_reg[7][1]  ( .D(n243), .SI(\regArr[7][0] ), .SE(n370), 
        .CK(CLK), .RN(n347), .Q(\regArr[7][1] ) );
  SDFFRQX2M \regArr_reg[7][0]  ( .D(n242), .SI(\regArr[6][7] ), .SE(n373), 
        .CK(CLK), .RN(n347), .Q(\regArr[7][0] ) );
  SDFFRQX2M \regArr_reg[14][7]  ( .D(n305), .SI(\regArr[14][6] ), .SE(n372), 
        .CK(CLK), .RN(n352), .Q(\regArr[14][7] ) );
  SDFFRQX2M \regArr_reg[14][6]  ( .D(n304), .SI(\regArr[14][5] ), .SE(n371), 
        .CK(CLK), .RN(n352), .Q(\regArr[14][6] ) );
  SDFFRQX2M \regArr_reg[14][5]  ( .D(n303), .SI(\regArr[14][4] ), .SE(n370), 
        .CK(CLK), .RN(n352), .Q(\regArr[14][5] ) );
  SDFFRQX2M \regArr_reg[14][4]  ( .D(n302), .SI(\regArr[14][3] ), .SE(n373), 
        .CK(CLK), .RN(n352), .Q(\regArr[14][4] ) );
  SDFFRQX2M \regArr_reg[14][3]  ( .D(n301), .SI(\regArr[14][2] ), .SE(n372), 
        .CK(CLK), .RN(n352), .Q(\regArr[14][3] ) );
  SDFFRQX2M \regArr_reg[14][2]  ( .D(n300), .SI(\regArr[14][1] ), .SE(n371), 
        .CK(CLK), .RN(n351), .Q(\regArr[14][2] ) );
  SDFFRQX2M \regArr_reg[14][1]  ( .D(n299), .SI(\regArr[14][0] ), .SE(n370), 
        .CK(CLK), .RN(n351), .Q(\regArr[14][1] ) );
  SDFFRQX2M \regArr_reg[14][0]  ( .D(n298), .SI(\regArr[13][7] ), .SE(n373), 
        .CK(CLK), .RN(n351), .Q(\regArr[14][0] ) );
  SDFFRQX2M \regArr_reg[10][7]  ( .D(n273), .SI(\regArr[10][6] ), .SE(n372), 
        .CK(CLK), .RN(n350), .Q(\regArr[10][7] ) );
  SDFFRQX2M \regArr_reg[10][6]  ( .D(n272), .SI(\regArr[10][5] ), .SE(n371), 
        .CK(CLK), .RN(n349), .Q(\regArr[10][6] ) );
  SDFFRQX2M \regArr_reg[10][5]  ( .D(n271), .SI(\regArr[10][4] ), .SE(n370), 
        .CK(CLK), .RN(n349), .Q(\regArr[10][5] ) );
  SDFFRQX2M \regArr_reg[10][4]  ( .D(n270), .SI(\regArr[10][3] ), .SE(n373), 
        .CK(CLK), .RN(n349), .Q(\regArr[10][4] ) );
  SDFFRQX2M \regArr_reg[10][3]  ( .D(n269), .SI(\regArr[10][2] ), .SE(n372), 
        .CK(CLK), .RN(n349), .Q(\regArr[10][3] ) );
  SDFFRQX2M \regArr_reg[10][2]  ( .D(n268), .SI(\regArr[10][1] ), .SE(n371), 
        .CK(CLK), .RN(n349), .Q(\regArr[10][2] ) );
  SDFFRQX2M \regArr_reg[10][1]  ( .D(n267), .SI(\regArr[10][0] ), .SE(n370), 
        .CK(CLK), .RN(n349), .Q(\regArr[10][1] ) );
  SDFFRQX2M \regArr_reg[10][0]  ( .D(n266), .SI(\regArr[9][7] ), .SE(n373), 
        .CK(CLK), .RN(n349), .Q(\regArr[10][0] ) );
  SDFFRQX2M \regArr_reg[6][7]  ( .D(n241), .SI(\regArr[6][6] ), .SE(n372), 
        .CK(CLK), .RN(n347), .Q(\regArr[6][7] ) );
  SDFFRQX2M \regArr_reg[6][6]  ( .D(n240), .SI(\regArr[6][5] ), .SE(n371), 
        .CK(CLK), .RN(n347), .Q(\regArr[6][6] ) );
  SDFFRQX2M \regArr_reg[6][5]  ( .D(n239), .SI(\regArr[6][4] ), .SE(n370), 
        .CK(CLK), .RN(n347), .Q(\regArr[6][5] ) );
  SDFFRQX2M \regArr_reg[6][4]  ( .D(n238), .SI(\regArr[6][3] ), .SE(n373), 
        .CK(CLK), .RN(n347), .Q(\regArr[6][4] ) );
  SDFFRQX2M \regArr_reg[6][3]  ( .D(n237), .SI(\regArr[6][2] ), .SE(n372), 
        .CK(CLK), .RN(n347), .Q(\regArr[6][3] ) );
  SDFFRQX2M \regArr_reg[6][2]  ( .D(n236), .SI(\regArr[6][1] ), .SE(n371), 
        .CK(CLK), .RN(n347), .Q(\regArr[6][2] ) );
  SDFFRQX2M \regArr_reg[6][1]  ( .D(n235), .SI(\regArr[6][0] ), .SE(n370), 
        .CK(CLK), .RN(n347), .Q(\regArr[6][1] ) );
  SDFFRQX2M \regArr_reg[6][0]  ( .D(n234), .SI(\regArr[5][7] ), .SE(n373), 
        .CK(CLK), .RN(n347), .Q(\regArr[6][0] ) );
  SDFFRQX2M \regArr_reg[12][7]  ( .D(n289), .SI(\regArr[12][6] ), .SE(n372), 
        .CK(CLK), .RN(n351), .Q(\regArr[12][7] ) );
  SDFFRQX2M \regArr_reg[12][6]  ( .D(n288), .SI(\regArr[12][5] ), .SE(n371), 
        .CK(CLK), .RN(n351), .Q(\regArr[12][6] ) );
  SDFFRQX2M \regArr_reg[12][5]  ( .D(n287), .SI(\regArr[12][4] ), .SE(n370), 
        .CK(CLK), .RN(n351), .Q(\regArr[12][5] ) );
  SDFFRQX2M \regArr_reg[12][4]  ( .D(n286), .SI(\regArr[12][3] ), .SE(n373), 
        .CK(CLK), .RN(n350), .Q(\regArr[12][4] ) );
  SDFFRQX2M \regArr_reg[12][3]  ( .D(n285), .SI(\regArr[12][2] ), .SE(n372), 
        .CK(CLK), .RN(n350), .Q(\regArr[12][3] ) );
  SDFFRQX2M \regArr_reg[12][2]  ( .D(n284), .SI(\regArr[12][1] ), .SE(n371), 
        .CK(CLK), .RN(n350), .Q(\regArr[12][2] ) );
  SDFFRQX2M \regArr_reg[12][1]  ( .D(n283), .SI(\regArr[12][0] ), .SE(n370), 
        .CK(CLK), .RN(n350), .Q(\regArr[12][1] ) );
  SDFFRQX2M \regArr_reg[12][0]  ( .D(n282), .SI(\regArr[11][7] ), .SE(n373), 
        .CK(CLK), .RN(n350), .Q(\regArr[12][0] ) );
  SDFFRQX2M \regArr_reg[8][7]  ( .D(n257), .SI(\regArr[8][6] ), .SE(n372), 
        .CK(CLK), .RN(n348), .Q(\regArr[8][7] ) );
  SDFFRQX2M \regArr_reg[8][6]  ( .D(n256), .SI(\regArr[8][5] ), .SE(n371), 
        .CK(CLK), .RN(n348), .Q(\regArr[8][6] ) );
  SDFFRQX2M \regArr_reg[8][5]  ( .D(n255), .SI(\regArr[8][4] ), .SE(n370), 
        .CK(CLK), .RN(n348), .Q(\regArr[8][5] ) );
  SDFFRQX2M \regArr_reg[8][4]  ( .D(n254), .SI(\regArr[8][3] ), .SE(n373), 
        .CK(CLK), .RN(n348), .Q(\regArr[8][4] ) );
  SDFFRQX2M \regArr_reg[8][3]  ( .D(n253), .SI(\regArr[8][2] ), .SE(n372), 
        .CK(CLK), .RN(n348), .Q(\regArr[8][3] ) );
  SDFFRQX2M \regArr_reg[8][2]  ( .D(n252), .SI(\regArr[8][1] ), .SE(n371), 
        .CK(CLK), .RN(n348), .Q(\regArr[8][2] ) );
  SDFFRQX2M \regArr_reg[8][1]  ( .D(n251), .SI(\regArr[8][0] ), .SE(n370), 
        .CK(CLK), .RN(n348), .Q(\regArr[8][1] ) );
  SDFFRQX2M \regArr_reg[8][0]  ( .D(n250), .SI(\regArr[7][7] ), .SE(n373), 
        .CK(CLK), .RN(n348), .Q(\regArr[8][0] ) );
  SDFFRQX2M \regArr_reg[4][7]  ( .D(n225), .SI(\regArr[4][6] ), .SE(n372), 
        .CK(CLK), .RN(n346), .Q(\regArr[4][7] ) );
  SDFFRQX2M \regArr_reg[4][6]  ( .D(n224), .SI(\regArr[4][5] ), .SE(n371), 
        .CK(CLK), .RN(n346), .Q(\regArr[4][6] ) );
  SDFFRQX2M \regArr_reg[4][5]  ( .D(n223), .SI(\regArr[4][4] ), .SE(n370), 
        .CK(CLK), .RN(n346), .Q(\regArr[4][5] ) );
  SDFFRQX2M \regArr_reg[4][4]  ( .D(n222), .SI(\regArr[4][3] ), .SE(n373), 
        .CK(CLK), .RN(n346), .Q(\regArr[4][4] ) );
  SDFFRQX2M \regArr_reg[4][3]  ( .D(n221), .SI(\regArr[4][2] ), .SE(n372), 
        .CK(CLK), .RN(n346), .Q(\regArr[4][3] ) );
  SDFFRQX2M \regArr_reg[4][2]  ( .D(n220), .SI(\regArr[4][1] ), .SE(n371), 
        .CK(CLK), .RN(n346), .Q(\regArr[4][2] ) );
  SDFFRQX2M \regArr_reg[4][1]  ( .D(n219), .SI(\regArr[4][0] ), .SE(n370), 
        .CK(CLK), .RN(n346), .Q(\regArr[4][1] ) );
  SDFFRQX2M \regArr_reg[4][0]  ( .D(n218), .SI(REG3[7]), .SE(n373), .CK(CLK), 
        .RN(n346), .Q(\regArr[4][0] ) );
  SDFFRQX2M \RdData_reg[7]  ( .D(n184), .SI(RdData[6]), .SE(n372), .CK(CLK), 
        .RN(n344), .Q(RdData[7]) );
  SDFFRQX2M \RdData_reg[6]  ( .D(n183), .SI(RdData[5]), .SE(n371), .CK(CLK), 
        .RN(n343), .Q(RdData[6]) );
  SDFFRQX2M \RdData_reg[5]  ( .D(n182), .SI(RdData[4]), .SE(n370), .CK(CLK), 
        .RN(n343), .Q(RdData[5]) );
  SDFFRQX2M \RdData_reg[4]  ( .D(n181), .SI(RdData[3]), .SE(n373), .CK(CLK), 
        .RN(n343), .Q(RdData[4]) );
  SDFFRQX2M \RdData_reg[3]  ( .D(n180), .SI(RdData[2]), .SE(n372), .CK(CLK), 
        .RN(n343), .Q(RdData[3]) );
  SDFFRQX2M \RdData_reg[2]  ( .D(n179), .SI(RdData[1]), .SE(n371), .CK(CLK), 
        .RN(n343), .Q(RdData[2]) );
  SDFFRQX2M \RdData_reg[1]  ( .D(n178), .SI(RdData[0]), .SE(n370), .CK(CLK), 
        .RN(n343), .Q(RdData[1]) );
  SDFFRQX2M \RdData_reg[0]  ( .D(n177), .SI(RdData_VLD), .SE(n373), .CK(CLK), 
        .RN(n347), .Q(RdData[0]) );
  SDFFRQX2M \regArr_reg[3][0]  ( .D(n210), .SI(REG2[7]), .SE(n372), .CK(CLK), 
        .RN(n345), .Q(REG3[0]) );
  SDFFRQX2M \regArr_reg[1][6]  ( .D(n200), .SI(REG1[5]), .SE(n371), .CK(CLK), 
        .RN(n344), .Q(REG1[6]) );
  SDFFRQX2M \regArr_reg[0][7]  ( .D(n193), .SI(REG0[6]), .SE(n370), .CK(CLK), 
        .RN(n344), .Q(REG0[7]) );
  SDFFRQX2M \regArr_reg[0][6]  ( .D(n192), .SI(REG0[5]), .SE(n373), .CK(CLK), 
        .RN(n344), .Q(REG0[6]) );
  SDFFRQX2M \regArr_reg[0][5]  ( .D(n191), .SI(REG0[4]), .SE(n372), .CK(CLK), 
        .RN(n344), .Q(REG0[5]) );
  SDFFRQX2M \regArr_reg[0][4]  ( .D(n190), .SI(REG0[3]), .SE(n371), .CK(CLK), 
        .RN(n344), .Q(REG0[4]) );
  SDFFRQX2M \regArr_reg[0][3]  ( .D(n189), .SI(REG0[2]), .SE(n370), .CK(CLK), 
        .RN(n344), .Q(REG0[3]) );
  SDFFRQX2M \regArr_reg[0][2]  ( .D(n188), .SI(REG0[1]), .SE(n373), .CK(CLK), 
        .RN(n344), .Q(REG0[2]) );
  SDFFRQX2M \regArr_reg[0][1]  ( .D(n187), .SI(REG0[0]), .SE(n372), .CK(CLK), 
        .RN(n343), .Q(REG0[1]) );
  SDFFRQX2M \regArr_reg[0][0]  ( .D(n186), .SI(RdData[7]), .SE(n371), .CK(CLK), 
        .RN(n343), .Q(REG0[0]) );
  SDFFRQX2M \regArr_reg[2][1]  ( .D(n203), .SI(REG2[0]), .SE(n370), .CK(CLK), 
        .RN(n345), .Q(REG2[1]) );
  SDFFRQX2M RdData_VLD_reg ( .D(n185), .SI(test_si1), .SE(n373), .CK(CLK), 
        .RN(n343), .Q(RdData_VLD) );
  SDFFRQX2M \regArr_reg[2][2]  ( .D(n204), .SI(REG2[1]), .SE(n372), .CK(CLK), 
        .RN(n345), .Q(REG2[2]) );
  SDFFRQX2M \regArr_reg[2][3]  ( .D(n205), .SI(REG2[2]), .SE(n371), .CK(CLK), 
        .RN(n345), .Q(REG2[3]) );
  SDFFSQX2M \regArr_reg[2][0]  ( .D(n202), .SI(REG1[7]), .SE(test_se), .CK(CLK), .SN(n343), .Q(REG2[0]) );
  SDFFRQX2M \regArr_reg[2][4]  ( .D(n206), .SI(REG2[3]), .SE(n370), .CK(CLK), 
        .RN(n345), .Q(REG2[4]) );
  SDFFRQX2M \regArr_reg[1][1]  ( .D(n195), .SI(REG1[0]), .SE(n373), .CK(CLK), 
        .RN(n344), .Q(REG1[1]) );
  SDFFRQX2M \regArr_reg[1][5]  ( .D(n199), .SI(REG1[4]), .SE(n372), .CK(CLK), 
        .RN(n345), .Q(REG1[5]) );
  SDFFRQX2M \regArr_reg[1][4]  ( .D(n198), .SI(REG1[3]), .SE(n371), .CK(CLK), 
        .RN(n344), .Q(REG1[4]) );
  SDFFRQX2M \regArr_reg[1][7]  ( .D(n201), .SI(REG1[6]), .SE(n370), .CK(CLK), 
        .RN(n344), .Q(REG1[7]) );
  SDFFRQX2M \regArr_reg[1][3]  ( .D(n197), .SI(REG1[2]), .SE(n373), .CK(CLK), 
        .RN(n344), .Q(REG1[3]) );
  SDFFRQX2M \regArr_reg[1][2]  ( .D(n196), .SI(REG1[1]), .SE(n372), .CK(CLK), 
        .RN(n344), .Q(REG1[2]) );
  SDFFRQX2M \regArr_reg[1][0]  ( .D(n194), .SI(REG0[7]), .SE(n371), .CK(CLK), 
        .RN(n344), .Q(REG1[0]) );
  SDFFSQX2M \regArr_reg[3][5]  ( .D(n215), .SI(REG3[4]), .SE(n370), .CK(CLK), 
        .SN(n343), .Q(REG3[5]) );
  SDFFRQX2M \regArr_reg[3][6]  ( .D(n216), .SI(REG3[5]), .SE(n370), .CK(CLK), 
        .RN(n345), .Q(REG3[6]) );
  SDFFRQX2M \regArr_reg[3][7]  ( .D(n217), .SI(REG3[6]), .SE(n373), .CK(CLK), 
        .RN(n345), .Q(REG3[7]) );
  SDFFRQX2M \regArr_reg[3][2]  ( .D(n212), .SI(REG3[1]), .SE(n372), .CK(CLK), 
        .RN(n345), .Q(REG3[2]) );
  SDFFRQX2M \regArr_reg[3][4]  ( .D(n214), .SI(REG3[3]), .SE(n371), .CK(CLK), 
        .RN(n345), .Q(REG3[4]) );
  SDFFRQX2M \regArr_reg[3][1]  ( .D(n211), .SI(REG3[0]), .SE(n370), .CK(CLK), 
        .RN(n345), .Q(REG3[1]) );
  SDFFRQX2M \regArr_reg[3][3]  ( .D(n213), .SI(REG3[2]), .SE(n373), .CK(CLK), 
        .RN(n345), .Q(REG3[3]) );
  SDFFRQX2M \regArr_reg[2][6]  ( .D(n208), .SI(REG2[5]), .SE(n372), .CK(CLK), 
        .RN(n345), .Q(REG2[6]) );
  SDFFRQX2M \regArr_reg[2][5]  ( .D(n207), .SI(REG2[4]), .SE(n371), .CK(CLK), 
        .RN(n345), .Q(REG2[5]) );
  SDFFSQX1M \regArr_reg[2][7]  ( .D(n209), .SI(REG2[6]), .SE(n373), .CK(CLK), 
        .SN(RST), .Q(REG2[7]) );
  NOR2BX2M U141 ( .AN(n175), .B(n341), .Y(n169) );
  NOR2BX2M U142 ( .AN(N13), .B(N12), .Y(n160) );
  NOR2BX2M U143 ( .AN(N13), .B(n342), .Y(n163) );
  NOR2BX2M U144 ( .AN(n164), .B(n341), .Y(n155) );
  NOR2X2M U145 ( .A(n342), .B(N13), .Y(n157) );
  NOR2X2M U146 ( .A(N12), .B(N13), .Y(n152) );
  INVX2M U147 ( .A(n338), .Y(n340) );
  INVX2M U148 ( .A(n338), .Y(n339) );
  INVX2M U149 ( .A(n336), .Y(n337) );
  BUFX2M U150 ( .A(n341), .Y(n338) );
  BUFX2M U151 ( .A(n342), .Y(n336) );
  NOR2BX2M U152 ( .AN(n164), .B(n339), .Y(n153) );
  NOR2BX2M U153 ( .AN(n175), .B(n339), .Y(n167) );
  NAND2X2M U154 ( .A(n167), .B(n152), .Y(n166) );
  NAND2X2M U155 ( .A(n169), .B(n152), .Y(n168) );
  NAND2X2M U156 ( .A(n167), .B(n157), .Y(n170) );
  NAND2X2M U157 ( .A(n169), .B(n157), .Y(n171) );
  NAND2X2M U158 ( .A(n157), .B(n153), .Y(n156) );
  NAND2X2M U159 ( .A(n157), .B(n155), .Y(n158) );
  NAND2X2M U160 ( .A(n160), .B(n153), .Y(n159) );
  NAND2X2M U161 ( .A(n160), .B(n155), .Y(n161) );
  NAND2X2M U162 ( .A(n163), .B(n153), .Y(n162) );
  NAND2X2M U163 ( .A(n163), .B(n155), .Y(n165) );
  NAND2X2M U164 ( .A(n167), .B(n160), .Y(n172) );
  NAND2X2M U165 ( .A(n169), .B(n160), .Y(n173) );
  NAND2X2M U166 ( .A(n167), .B(n163), .Y(n174) );
  NAND2X2M U167 ( .A(n169), .B(n163), .Y(n176) );
  NAND2X2M U168 ( .A(n155), .B(n152), .Y(n154) );
  NAND2X2M U169 ( .A(n152), .B(n153), .Y(n151) );
  INVX2M U170 ( .A(n149), .Y(n358) );
  NOR2BX2M U171 ( .AN(n150), .B(N14), .Y(n164) );
  AND2X2M U172 ( .A(N14), .B(n150), .Y(n175) );
  NAND2BX2M U173 ( .AN(WrEn), .B(RdEn), .Y(n149) );
  NOR2BX2M U174 ( .AN(WrEn), .B(RdEn), .Y(n150) );
  BUFX2M U175 ( .A(n357), .Y(n344) );
  BUFX2M U176 ( .A(n356), .Y(n345) );
  BUFX2M U177 ( .A(n356), .Y(n346) );
  BUFX2M U178 ( .A(n355), .Y(n347) );
  BUFX2M U179 ( .A(n355), .Y(n348) );
  BUFX2M U180 ( .A(n354), .Y(n349) );
  BUFX2M U181 ( .A(n354), .Y(n350) );
  BUFX2M U182 ( .A(n353), .Y(n351) );
  BUFX2M U183 ( .A(n357), .Y(n343) );
  BUFX2M U184 ( .A(n353), .Y(n352) );
  INVX2M U185 ( .A(N11), .Y(n341) );
  INVX2M U186 ( .A(N12), .Y(n342) );
  INVX2M U187 ( .A(WrData[0]), .Y(n359) );
  INVX2M U188 ( .A(WrData[1]), .Y(n360) );
  INVX2M U189 ( .A(WrData[2]), .Y(n361) );
  INVX2M U190 ( .A(WrData[3]), .Y(n362) );
  INVX2M U191 ( .A(WrData[4]), .Y(n363) );
  INVX2M U192 ( .A(WrData[5]), .Y(n364) );
  INVX2M U193 ( .A(WrData[6]), .Y(n365) );
  INVX2M U194 ( .A(WrData[7]), .Y(n366) );
  BUFX2M U195 ( .A(RST), .Y(n356) );
  BUFX2M U196 ( .A(RST), .Y(n355) );
  BUFX2M U197 ( .A(RST), .Y(n354) );
  BUFX2M U198 ( .A(RST), .Y(n353) );
  BUFX2M U199 ( .A(RST), .Y(n357) );
  OAI2BB2X1M U200 ( .B0(n359), .B1(n159), .A0N(\regArr[4][0] ), .A1N(n159), 
        .Y(n218) );
  OAI2BB2X1M U201 ( .B0(n360), .B1(n159), .A0N(\regArr[4][1] ), .A1N(n159), 
        .Y(n219) );
  OAI2BB2X1M U202 ( .B0(n361), .B1(n159), .A0N(\regArr[4][2] ), .A1N(n159), 
        .Y(n220) );
  OAI2BB2X1M U203 ( .B0(n362), .B1(n159), .A0N(\regArr[4][3] ), .A1N(n159), 
        .Y(n221) );
  OAI2BB2X1M U204 ( .B0(n363), .B1(n159), .A0N(\regArr[4][4] ), .A1N(n159), 
        .Y(n222) );
  OAI2BB2X1M U205 ( .B0(n364), .B1(n159), .A0N(\regArr[4][5] ), .A1N(n159), 
        .Y(n223) );
  OAI2BB2X1M U206 ( .B0(n365), .B1(n159), .A0N(\regArr[4][6] ), .A1N(n159), 
        .Y(n224) );
  OAI2BB2X1M U207 ( .B0(n366), .B1(n159), .A0N(\regArr[4][7] ), .A1N(n159), 
        .Y(n225) );
  OAI2BB2X1M U208 ( .B0(n359), .B1(n161), .A0N(\regArr[5][0] ), .A1N(n161), 
        .Y(n226) );
  OAI2BB2X1M U209 ( .B0(n360), .B1(n161), .A0N(\regArr[5][1] ), .A1N(n161), 
        .Y(n227) );
  OAI2BB2X1M U210 ( .B0(n361), .B1(n161), .A0N(\regArr[5][2] ), .A1N(n161), 
        .Y(n228) );
  OAI2BB2X1M U211 ( .B0(n362), .B1(n161), .A0N(\regArr[5][3] ), .A1N(n161), 
        .Y(n229) );
  OAI2BB2X1M U212 ( .B0(n363), .B1(n161), .A0N(\regArr[5][4] ), .A1N(n161), 
        .Y(n230) );
  OAI2BB2X1M U213 ( .B0(n364), .B1(n161), .A0N(\regArr[5][5] ), .A1N(n161), 
        .Y(n231) );
  OAI2BB2X1M U214 ( .B0(n365), .B1(n161), .A0N(\regArr[5][6] ), .A1N(n161), 
        .Y(n232) );
  OAI2BB2X1M U215 ( .B0(n366), .B1(n161), .A0N(\regArr[5][7] ), .A1N(n161), 
        .Y(n233) );
  OAI2BB2X1M U216 ( .B0(n359), .B1(n162), .A0N(\regArr[6][0] ), .A1N(n162), 
        .Y(n234) );
  OAI2BB2X1M U217 ( .B0(n360), .B1(n162), .A0N(\regArr[6][1] ), .A1N(n162), 
        .Y(n235) );
  OAI2BB2X1M U218 ( .B0(n361), .B1(n162), .A0N(\regArr[6][2] ), .A1N(n162), 
        .Y(n236) );
  OAI2BB2X1M U219 ( .B0(n362), .B1(n162), .A0N(\regArr[6][3] ), .A1N(n162), 
        .Y(n237) );
  OAI2BB2X1M U220 ( .B0(n363), .B1(n162), .A0N(\regArr[6][4] ), .A1N(n162), 
        .Y(n238) );
  OAI2BB2X1M U221 ( .B0(n364), .B1(n162), .A0N(\regArr[6][5] ), .A1N(n162), 
        .Y(n239) );
  OAI2BB2X1M U222 ( .B0(n365), .B1(n162), .A0N(\regArr[6][6] ), .A1N(n162), 
        .Y(n240) );
  OAI2BB2X1M U223 ( .B0(n366), .B1(n162), .A0N(\regArr[6][7] ), .A1N(n162), 
        .Y(n241) );
  OAI2BB2X1M U224 ( .B0(n359), .B1(n165), .A0N(\regArr[7][0] ), .A1N(n165), 
        .Y(n242) );
  OAI2BB2X1M U225 ( .B0(n360), .B1(n165), .A0N(\regArr[7][1] ), .A1N(n165), 
        .Y(n243) );
  OAI2BB2X1M U226 ( .B0(n361), .B1(n165), .A0N(\regArr[7][2] ), .A1N(n165), 
        .Y(n244) );
  OAI2BB2X1M U227 ( .B0(n362), .B1(n165), .A0N(\regArr[7][3] ), .A1N(n165), 
        .Y(n245) );
  OAI2BB2X1M U228 ( .B0(n363), .B1(n165), .A0N(\regArr[7][4] ), .A1N(n165), 
        .Y(n246) );
  OAI2BB2X1M U229 ( .B0(n364), .B1(n165), .A0N(\regArr[7][5] ), .A1N(n165), 
        .Y(n247) );
  OAI2BB2X1M U230 ( .B0(n365), .B1(n165), .A0N(\regArr[7][6] ), .A1N(n165), 
        .Y(n248) );
  OAI2BB2X1M U231 ( .B0(n366), .B1(n165), .A0N(\regArr[7][7] ), .A1N(n165), 
        .Y(n249) );
  OAI2BB2X1M U232 ( .B0(n359), .B1(n166), .A0N(\regArr[8][0] ), .A1N(n166), 
        .Y(n250) );
  OAI2BB2X1M U233 ( .B0(n360), .B1(n166), .A0N(\regArr[8][1] ), .A1N(n166), 
        .Y(n251) );
  OAI2BB2X1M U234 ( .B0(n361), .B1(n166), .A0N(\regArr[8][2] ), .A1N(n166), 
        .Y(n252) );
  OAI2BB2X1M U235 ( .B0(n362), .B1(n166), .A0N(\regArr[8][3] ), .A1N(n166), 
        .Y(n253) );
  OAI2BB2X1M U236 ( .B0(n363), .B1(n166), .A0N(\regArr[8][4] ), .A1N(n166), 
        .Y(n254) );
  OAI2BB2X1M U237 ( .B0(n364), .B1(n166), .A0N(\regArr[8][5] ), .A1N(n166), 
        .Y(n255) );
  OAI2BB2X1M U238 ( .B0(n365), .B1(n166), .A0N(\regArr[8][6] ), .A1N(n166), 
        .Y(n256) );
  OAI2BB2X1M U239 ( .B0(n366), .B1(n166), .A0N(\regArr[8][7] ), .A1N(n166), 
        .Y(n257) );
  OAI2BB2X1M U240 ( .B0(n359), .B1(n168), .A0N(\regArr[9][0] ), .A1N(n168), 
        .Y(n258) );
  OAI2BB2X1M U241 ( .B0(n360), .B1(n168), .A0N(\regArr[9][1] ), .A1N(n168), 
        .Y(n259) );
  OAI2BB2X1M U242 ( .B0(n361), .B1(n168), .A0N(\regArr[9][2] ), .A1N(n168), 
        .Y(n260) );
  OAI2BB2X1M U243 ( .B0(n362), .B1(n168), .A0N(\regArr[9][3] ), .A1N(n168), 
        .Y(n261) );
  OAI2BB2X1M U244 ( .B0(n363), .B1(n168), .A0N(\regArr[9][4] ), .A1N(n168), 
        .Y(n262) );
  OAI2BB2X1M U245 ( .B0(n364), .B1(n168), .A0N(\regArr[9][5] ), .A1N(n168), 
        .Y(n263) );
  OAI2BB2X1M U246 ( .B0(n365), .B1(n168), .A0N(\regArr[9][6] ), .A1N(n168), 
        .Y(n264) );
  OAI2BB2X1M U247 ( .B0(n366), .B1(n168), .A0N(\regArr[9][7] ), .A1N(n168), 
        .Y(n265) );
  OAI2BB2X1M U248 ( .B0(n359), .B1(n170), .A0N(\regArr[10][0] ), .A1N(n170), 
        .Y(n266) );
  OAI2BB2X1M U249 ( .B0(n360), .B1(n170), .A0N(\regArr[10][1] ), .A1N(n170), 
        .Y(n267) );
  OAI2BB2X1M U250 ( .B0(n361), .B1(n170), .A0N(\regArr[10][2] ), .A1N(n170), 
        .Y(n268) );
  OAI2BB2X1M U251 ( .B0(n362), .B1(n170), .A0N(\regArr[10][3] ), .A1N(n170), 
        .Y(n269) );
  OAI2BB2X1M U252 ( .B0(n363), .B1(n170), .A0N(\regArr[10][4] ), .A1N(n170), 
        .Y(n270) );
  OAI2BB2X1M U253 ( .B0(n364), .B1(n170), .A0N(\regArr[10][5] ), .A1N(n170), 
        .Y(n271) );
  OAI2BB2X1M U254 ( .B0(n365), .B1(n170), .A0N(\regArr[10][6] ), .A1N(n170), 
        .Y(n272) );
  OAI2BB2X1M U255 ( .B0(n366), .B1(n170), .A0N(\regArr[10][7] ), .A1N(n170), 
        .Y(n273) );
  OAI2BB2X1M U256 ( .B0(n359), .B1(n171), .A0N(\regArr[11][0] ), .A1N(n171), 
        .Y(n274) );
  OAI2BB2X1M U257 ( .B0(n360), .B1(n171), .A0N(\regArr[11][1] ), .A1N(n171), 
        .Y(n275) );
  OAI2BB2X1M U258 ( .B0(n361), .B1(n171), .A0N(\regArr[11][2] ), .A1N(n171), 
        .Y(n276) );
  OAI2BB2X1M U259 ( .B0(n362), .B1(n171), .A0N(\regArr[11][3] ), .A1N(n171), 
        .Y(n277) );
  OAI2BB2X1M U260 ( .B0(n363), .B1(n171), .A0N(\regArr[11][4] ), .A1N(n171), 
        .Y(n278) );
  OAI2BB2X1M U261 ( .B0(n364), .B1(n171), .A0N(\regArr[11][5] ), .A1N(n171), 
        .Y(n279) );
  OAI2BB2X1M U262 ( .B0(n365), .B1(n171), .A0N(\regArr[11][6] ), .A1N(n171), 
        .Y(n280) );
  OAI2BB2X1M U263 ( .B0(n366), .B1(n171), .A0N(\regArr[11][7] ), .A1N(n171), 
        .Y(n281) );
  OAI2BB2X1M U264 ( .B0(n359), .B1(n172), .A0N(\regArr[12][0] ), .A1N(n172), 
        .Y(n282) );
  OAI2BB2X1M U265 ( .B0(n360), .B1(n172), .A0N(\regArr[12][1] ), .A1N(n172), 
        .Y(n283) );
  OAI2BB2X1M U266 ( .B0(n361), .B1(n172), .A0N(\regArr[12][2] ), .A1N(n172), 
        .Y(n284) );
  OAI2BB2X1M U267 ( .B0(n362), .B1(n172), .A0N(\regArr[12][3] ), .A1N(n172), 
        .Y(n285) );
  OAI2BB2X1M U268 ( .B0(n363), .B1(n172), .A0N(\regArr[12][4] ), .A1N(n172), 
        .Y(n286) );
  OAI2BB2X1M U269 ( .B0(n364), .B1(n172), .A0N(\regArr[12][5] ), .A1N(n172), 
        .Y(n287) );
  OAI2BB2X1M U270 ( .B0(n365), .B1(n172), .A0N(\regArr[12][6] ), .A1N(n172), 
        .Y(n288) );
  OAI2BB2X1M U271 ( .B0(n366), .B1(n172), .A0N(\regArr[12][7] ), .A1N(n172), 
        .Y(n289) );
  OAI2BB2X1M U272 ( .B0(n359), .B1(n173), .A0N(\regArr[13][0] ), .A1N(n173), 
        .Y(n290) );
  OAI2BB2X1M U273 ( .B0(n360), .B1(n173), .A0N(\regArr[13][1] ), .A1N(n173), 
        .Y(n291) );
  OAI2BB2X1M U274 ( .B0(n361), .B1(n173), .A0N(\regArr[13][2] ), .A1N(n173), 
        .Y(n292) );
  OAI2BB2X1M U275 ( .B0(n362), .B1(n173), .A0N(\regArr[13][3] ), .A1N(n173), 
        .Y(n293) );
  OAI2BB2X1M U276 ( .B0(n363), .B1(n173), .A0N(\regArr[13][4] ), .A1N(n173), 
        .Y(n294) );
  OAI2BB2X1M U277 ( .B0(n364), .B1(n173), .A0N(\regArr[13][5] ), .A1N(n173), 
        .Y(n295) );
  OAI2BB2X1M U278 ( .B0(n365), .B1(n173), .A0N(\regArr[13][6] ), .A1N(n173), 
        .Y(n296) );
  OAI2BB2X1M U279 ( .B0(n366), .B1(n173), .A0N(\regArr[13][7] ), .A1N(n173), 
        .Y(n297) );
  OAI2BB2X1M U280 ( .B0(n359), .B1(n174), .A0N(\regArr[14][0] ), .A1N(n174), 
        .Y(n298) );
  OAI2BB2X1M U281 ( .B0(n360), .B1(n174), .A0N(\regArr[14][1] ), .A1N(n174), 
        .Y(n299) );
  OAI2BB2X1M U282 ( .B0(n361), .B1(n174), .A0N(\regArr[14][2] ), .A1N(n174), 
        .Y(n300) );
  OAI2BB2X1M U283 ( .B0(n362), .B1(n174), .A0N(\regArr[14][3] ), .A1N(n174), 
        .Y(n301) );
  OAI2BB2X1M U284 ( .B0(n363), .B1(n174), .A0N(\regArr[14][4] ), .A1N(n174), 
        .Y(n302) );
  OAI2BB2X1M U285 ( .B0(n364), .B1(n174), .A0N(\regArr[14][5] ), .A1N(n174), 
        .Y(n303) );
  OAI2BB2X1M U286 ( .B0(n365), .B1(n174), .A0N(\regArr[14][6] ), .A1N(n174), 
        .Y(n304) );
  OAI2BB2X1M U287 ( .B0(n366), .B1(n174), .A0N(\regArr[14][7] ), .A1N(n174), 
        .Y(n305) );
  OAI2BB2X1M U288 ( .B0(n359), .B1(n176), .A0N(\regArr[15][0] ), .A1N(n176), 
        .Y(n306) );
  OAI2BB2X1M U289 ( .B0(n360), .B1(n176), .A0N(\regArr[15][1] ), .A1N(n176), 
        .Y(n307) );
  OAI2BB2X1M U290 ( .B0(n361), .B1(n176), .A0N(\regArr[15][2] ), .A1N(n176), 
        .Y(n308) );
  OAI2BB2X1M U291 ( .B0(n362), .B1(n176), .A0N(\regArr[15][3] ), .A1N(n176), 
        .Y(n309) );
  OAI2BB2X1M U292 ( .B0(n363), .B1(n176), .A0N(\regArr[15][4] ), .A1N(n176), 
        .Y(n310) );
  OAI2BB2X1M U293 ( .B0(n364), .B1(n176), .A0N(\regArr[15][5] ), .A1N(n176), 
        .Y(n311) );
  OAI2BB2X1M U294 ( .B0(n365), .B1(n176), .A0N(\regArr[15][6] ), .A1N(n176), 
        .Y(n312) );
  OAI2BB2X1M U295 ( .B0(n366), .B1(n176), .A0N(\regArr[15][7] ), .A1N(n176), 
        .Y(n313) );
  OAI2BB2X1M U296 ( .B0(n359), .B1(n156), .A0N(REG2[0]), .A1N(n156), .Y(n202)
         );
  OAI2BB2X1M U297 ( .B0(n366), .B1(n156), .A0N(REG2[7]), .A1N(n156), .Y(n209)
         );
  OAI2BB2X1M U298 ( .B0(n364), .B1(n158), .A0N(REG3[5]), .A1N(n158), .Y(n215)
         );
  AO22X1M U299 ( .A0(N43), .A1(n358), .B0(RdData[0]), .B1(n149), .Y(n177) );
  MX4X1M U300 ( .A(n142), .B(n140), .C(n141), .D(n139), .S0(N14), .S1(N13), 
        .Y(N43) );
  MX4X1M U301 ( .A(REG0[0]), .B(REG1[0]), .C(REG2[0]), .D(REG3[0]), .S0(n339), 
        .S1(N12), .Y(n142) );
  MX4X1M U302 ( .A(\regArr[8][0] ), .B(\regArr[9][0] ), .C(\regArr[10][0] ), 
        .D(\regArr[11][0] ), .S0(n339), .S1(N12), .Y(n140) );
  AO22X1M U303 ( .A0(N42), .A1(n358), .B0(RdData[1]), .B1(n149), .Y(n178) );
  MX4X1M U304 ( .A(n146), .B(n144), .C(n145), .D(n143), .S0(N14), .S1(N13), 
        .Y(N42) );
  MX4X1M U305 ( .A(\regArr[8][1] ), .B(\regArr[9][1] ), .C(\regArr[10][1] ), 
        .D(\regArr[11][1] ), .S0(n339), .S1(N12), .Y(n144) );
  MX4X1M U306 ( .A(\regArr[12][1] ), .B(\regArr[13][1] ), .C(\regArr[14][1] ), 
        .D(\regArr[15][1] ), .S0(n339), .S1(n337), .Y(n143) );
  AO22X1M U307 ( .A0(N41), .A1(n358), .B0(RdData[2]), .B1(n149), .Y(n179) );
  MX4X1M U308 ( .A(n315), .B(n148), .C(n314), .D(n147), .S0(N14), .S1(N13), 
        .Y(N41) );
  MX4X1M U309 ( .A(REG0[2]), .B(REG1[2]), .C(REG2[2]), .D(REG3[2]), .S0(n340), 
        .S1(n337), .Y(n315) );
  MX4X1M U310 ( .A(\regArr[8][2] ), .B(\regArr[9][2] ), .C(\regArr[10][2] ), 
        .D(\regArr[11][2] ), .S0(n340), .S1(n337), .Y(n148) );
  AO22X1M U311 ( .A0(N40), .A1(n358), .B0(RdData[3]), .B1(n149), .Y(n180) );
  MX4X1M U312 ( .A(n319), .B(n317), .C(n318), .D(n316), .S0(N14), .S1(N13), 
        .Y(N40) );
  MX4X1M U313 ( .A(REG0[3]), .B(REG1[3]), .C(REG2[3]), .D(REG3[3]), .S0(n340), 
        .S1(n337), .Y(n319) );
  MX4X1M U314 ( .A(\regArr[8][3] ), .B(\regArr[9][3] ), .C(\regArr[10][3] ), 
        .D(\regArr[11][3] ), .S0(n340), .S1(n337), .Y(n317) );
  AO22X1M U315 ( .A0(N39), .A1(n358), .B0(RdData[4]), .B1(n149), .Y(n181) );
  MX4X1M U316 ( .A(n323), .B(n321), .C(n322), .D(n320), .S0(N14), .S1(N13), 
        .Y(N39) );
  MX4X1M U317 ( .A(REG0[4]), .B(REG1[4]), .C(REG2[4]), .D(REG3[4]), .S0(N11), 
        .S1(n337), .Y(n323) );
  MX4X1M U318 ( .A(\regArr[8][4] ), .B(\regArr[9][4] ), .C(\regArr[10][4] ), 
        .D(\regArr[11][4] ), .S0(n340), .S1(n337), .Y(n321) );
  AO22X1M U319 ( .A0(N38), .A1(n358), .B0(RdData[5]), .B1(n149), .Y(n182) );
  MX4X1M U320 ( .A(n327), .B(n325), .C(n326), .D(n324), .S0(N14), .S1(N13), 
        .Y(N38) );
  MX4X1M U321 ( .A(REG0[5]), .B(REG1[5]), .C(REG2[5]), .D(REG3[5]), .S0(N11), 
        .S1(N12), .Y(n327) );
  MX4X1M U322 ( .A(\regArr[8][5] ), .B(\regArr[9][5] ), .C(\regArr[10][5] ), 
        .D(\regArr[11][5] ), .S0(n339), .S1(N12), .Y(n325) );
  AO22X1M U323 ( .A0(N37), .A1(n358), .B0(RdData[6]), .B1(n149), .Y(n183) );
  MX4X1M U324 ( .A(n331), .B(n329), .C(n330), .D(n328), .S0(N14), .S1(N13), 
        .Y(N37) );
  MX4X1M U325 ( .A(REG0[6]), .B(REG1[6]), .C(REG2[6]), .D(REG3[6]), .S0(N11), 
        .S1(N12), .Y(n331) );
  MX4X1M U326 ( .A(\regArr[8][6] ), .B(\regArr[9][6] ), .C(\regArr[10][6] ), 
        .D(\regArr[11][6] ), .S0(n340), .S1(N12), .Y(n329) );
  AO22X1M U327 ( .A0(N36), .A1(n358), .B0(RdData[7]), .B1(n149), .Y(n184) );
  MX4X1M U328 ( .A(n335), .B(n333), .C(n334), .D(n332), .S0(N14), .S1(N13), 
        .Y(N36) );
  MX4X1M U329 ( .A(REG0[7]), .B(REG1[7]), .C(REG2[7]), .D(REG3[7]), .S0(N11), 
        .S1(N12), .Y(n335) );
  MX4X1M U330 ( .A(\regArr[8][7] ), .B(\regArr[9][7] ), .C(\regArr[10][7] ), 
        .D(\regArr[11][7] ), .S0(N11), .S1(N12), .Y(n333) );
  MX4X1M U331 ( .A(REG0[1]), .B(REG1[1]), .C(REG2[1]), .D(REG3[1]), .S0(n340), 
        .S1(N12), .Y(n146) );
  MX4X1M U332 ( .A(\regArr[4][0] ), .B(\regArr[5][0] ), .C(\regArr[6][0] ), 
        .D(\regArr[7][0] ), .S0(n339), .S1(N12), .Y(n141) );
  MX4X1M U333 ( .A(\regArr[4][1] ), .B(\regArr[5][1] ), .C(\regArr[6][1] ), 
        .D(\regArr[7][1] ), .S0(n340), .S1(N12), .Y(n145) );
  MX4X1M U334 ( .A(\regArr[4][2] ), .B(\regArr[5][2] ), .C(\regArr[6][2] ), 
        .D(\regArr[7][2] ), .S0(n340), .S1(n337), .Y(n314) );
  MX4X1M U335 ( .A(\regArr[4][3] ), .B(\regArr[5][3] ), .C(\regArr[6][3] ), 
        .D(\regArr[7][3] ), .S0(n340), .S1(n337), .Y(n318) );
  MX4X1M U336 ( .A(\regArr[4][4] ), .B(\regArr[5][4] ), .C(\regArr[6][4] ), 
        .D(\regArr[7][4] ), .S0(n340), .S1(n337), .Y(n322) );
  MX4X1M U337 ( .A(\regArr[4][5] ), .B(\regArr[5][5] ), .C(\regArr[6][5] ), 
        .D(\regArr[7][5] ), .S0(n339), .S1(N12), .Y(n326) );
  MX4X1M U338 ( .A(\regArr[4][6] ), .B(\regArr[5][6] ), .C(\regArr[6][6] ), 
        .D(\regArr[7][6] ), .S0(n339), .S1(N12), .Y(n330) );
  MX4X1M U339 ( .A(\regArr[4][7] ), .B(\regArr[5][7] ), .C(\regArr[6][7] ), 
        .D(\regArr[7][7] ), .S0(n339), .S1(N12), .Y(n334) );
  MX4X1M U340 ( .A(\regArr[12][0] ), .B(\regArr[13][0] ), .C(\regArr[14][0] ), 
        .D(\regArr[15][0] ), .S0(n339), .S1(n337), .Y(n139) );
  MX4X1M U341 ( .A(\regArr[12][2] ), .B(\regArr[13][2] ), .C(\regArr[14][2] ), 
        .D(\regArr[15][2] ), .S0(n340), .S1(n337), .Y(n147) );
  MX4X1M U342 ( .A(\regArr[12][3] ), .B(\regArr[13][3] ), .C(\regArr[14][3] ), 
        .D(\regArr[15][3] ), .S0(n340), .S1(n337), .Y(n316) );
  MX4X1M U343 ( .A(\regArr[12][4] ), .B(\regArr[13][4] ), .C(\regArr[14][4] ), 
        .D(\regArr[15][4] ), .S0(n340), .S1(n337), .Y(n320) );
  MX4X1M U344 ( .A(\regArr[12][5] ), .B(\regArr[13][5] ), .C(\regArr[14][5] ), 
        .D(\regArr[15][5] ), .S0(n339), .S1(N12), .Y(n324) );
  MX4X1M U345 ( .A(\regArr[12][6] ), .B(\regArr[13][6] ), .C(\regArr[14][6] ), 
        .D(\regArr[15][6] ), .S0(n339), .S1(N12), .Y(n328) );
  MX4X1M U346 ( .A(\regArr[12][7] ), .B(\regArr[13][7] ), .C(\regArr[14][7] ), 
        .D(\regArr[15][7] ), .S0(n339), .S1(N12), .Y(n332) );
  OAI2BB2X1M U347 ( .B0(n151), .B1(n359), .A0N(REG0[0]), .A1N(n151), .Y(n186)
         );
  OAI2BB2X1M U348 ( .B0(n151), .B1(n360), .A0N(REG0[1]), .A1N(n151), .Y(n187)
         );
  OAI2BB2X1M U349 ( .B0(n151), .B1(n361), .A0N(REG0[2]), .A1N(n151), .Y(n188)
         );
  OAI2BB2X1M U350 ( .B0(n151), .B1(n362), .A0N(REG0[3]), .A1N(n151), .Y(n189)
         );
  OAI2BB2X1M U351 ( .B0(n151), .B1(n363), .A0N(REG0[4]), .A1N(n151), .Y(n190)
         );
  OAI2BB2X1M U352 ( .B0(n151), .B1(n364), .A0N(REG0[5]), .A1N(n151), .Y(n191)
         );
  OAI2BB2X1M U353 ( .B0(n151), .B1(n365), .A0N(REG0[6]), .A1N(n151), .Y(n192)
         );
  OAI2BB2X1M U354 ( .B0(n151), .B1(n366), .A0N(REG0[7]), .A1N(n151), .Y(n193)
         );
  OAI2BB2X1M U355 ( .B0(n359), .B1(n154), .A0N(REG1[0]), .A1N(n154), .Y(n194)
         );
  OAI2BB2X1M U356 ( .B0(n360), .B1(n154), .A0N(REG1[1]), .A1N(n154), .Y(n195)
         );
  OAI2BB2X1M U357 ( .B0(n361), .B1(n154), .A0N(REG1[2]), .A1N(n154), .Y(n196)
         );
  OAI2BB2X1M U358 ( .B0(n362), .B1(n154), .A0N(REG1[3]), .A1N(n154), .Y(n197)
         );
  OAI2BB2X1M U359 ( .B0(n363), .B1(n154), .A0N(REG1[4]), .A1N(n154), .Y(n198)
         );
  OAI2BB2X1M U360 ( .B0(n364), .B1(n154), .A0N(REG1[5]), .A1N(n154), .Y(n199)
         );
  OAI2BB2X1M U361 ( .B0(n365), .B1(n154), .A0N(REG1[6]), .A1N(n154), .Y(n200)
         );
  OAI2BB2X1M U362 ( .B0(n366), .B1(n154), .A0N(REG1[7]), .A1N(n154), .Y(n201)
         );
  OAI2BB2X1M U363 ( .B0(n360), .B1(n156), .A0N(REG2[1]), .A1N(n156), .Y(n203)
         );
  OAI2BB2X1M U364 ( .B0(n361), .B1(n156), .A0N(REG2[2]), .A1N(n156), .Y(n204)
         );
  OAI2BB2X1M U365 ( .B0(n362), .B1(n156), .A0N(REG2[3]), .A1N(n156), .Y(n205)
         );
  OAI2BB2X1M U366 ( .B0(n363), .B1(n156), .A0N(REG2[4]), .A1N(n156), .Y(n206)
         );
  OAI2BB2X1M U367 ( .B0(n364), .B1(n156), .A0N(REG2[5]), .A1N(n156), .Y(n207)
         );
  OAI2BB2X1M U368 ( .B0(n365), .B1(n156), .A0N(REG2[6]), .A1N(n156), .Y(n208)
         );
  OAI2BB2X1M U369 ( .B0(n359), .B1(n158), .A0N(REG3[0]), .A1N(n158), .Y(n210)
         );
  OAI2BB2X1M U370 ( .B0(n360), .B1(n158), .A0N(REG3[1]), .A1N(n158), .Y(n211)
         );
  OAI2BB2X1M U371 ( .B0(n361), .B1(n158), .A0N(REG3[2]), .A1N(n158), .Y(n212)
         );
  OAI2BB2X1M U372 ( .B0(n362), .B1(n158), .A0N(REG3[3]), .A1N(n158), .Y(n213)
         );
  OAI2BB2X1M U373 ( .B0(n363), .B1(n158), .A0N(REG3[4]), .A1N(n158), .Y(n214)
         );
  OAI2BB2X1M U374 ( .B0(n365), .B1(n158), .A0N(REG3[6]), .A1N(n158), .Y(n216)
         );
  OAI2BB2X1M U375 ( .B0(n366), .B1(n158), .A0N(REG3[7]), .A1N(n158), .Y(n217)
         );
  OAI2BB1X2M U376 ( .A0N(RdData_VLD), .A1N(n150), .B0(n149), .Y(n185) );
  DLY1X1M U377 ( .A(test_se), .Y(n370) );
  DLY1X1M U378 ( .A(test_se), .Y(n371) );
  DLY1X1M U379 ( .A(test_se), .Y(n372) );
  DLY1X1M U380 ( .A(test_se), .Y(n373) );
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
  ADDFX2M \u_div/u_fa_PartRem_0_0_5  ( .A(\u_div/PartRem[1][5] ), .B(n13), 
        .CI(\u_div/CryTmp[0][5] ), .CO(\u_div/CryTmp[0][6] ) );
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
  ADDFX2M \u_div/u_fa_PartRem_0_0_2  ( .A(\u_div/PartRem[1][2] ), .B(n16), 
        .CI(\u_div/CryTmp[0][2] ), .CO(\u_div/CryTmp[0][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_3  ( .A(\u_div/PartRem[1][3] ), .B(n15), 
        .CI(\u_div/CryTmp[0][3] ), .CO(\u_div/CryTmp[0][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_4  ( .A(\u_div/PartRem[1][4] ), .B(n14), 
        .CI(\u_div/CryTmp[0][4] ), .CO(\u_div/CryTmp[0][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_5  ( .A(\u_div/PartRem[2][5] ), .B(n13), 
        .CI(\u_div/CryTmp[1][5] ), .CO(\u_div/CryTmp[1][6] ), .S(
        \u_div/SumTmp[1][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_4  ( .A(\u_div/PartRem[2][4] ), .B(n14), 
        .CI(\u_div/CryTmp[1][4] ), .CO(\u_div/CryTmp[1][5] ), .S(
        \u_div/SumTmp[1][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_3  ( .A(\u_div/PartRem[2][3] ), .B(n15), 
        .CI(\u_div/CryTmp[1][3] ), .CO(\u_div/CryTmp[1][4] ), .S(
        \u_div/SumTmp[1][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_4  ( .A(\u_div/PartRem[3][4] ), .B(n14), 
        .CI(\u_div/CryTmp[2][4] ), .CO(\u_div/CryTmp[2][5] ), .S(
        \u_div/SumTmp[2][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_2  ( .A(\u_div/PartRem[2][2] ), .B(n16), 
        .CI(\u_div/CryTmp[1][2] ), .CO(\u_div/CryTmp[1][3] ), .S(
        \u_div/SumTmp[1][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_3  ( .A(\u_div/PartRem[3][3] ), .B(n15), 
        .CI(\u_div/CryTmp[2][3] ), .CO(\u_div/CryTmp[2][4] ), .S(
        \u_div/SumTmp[2][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_2  ( .A(\u_div/PartRem[3][2] ), .B(n16), 
        .CI(\u_div/CryTmp[2][2] ), .CO(\u_div/CryTmp[2][3] ), .S(
        \u_div/SumTmp[2][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_3  ( .A(\u_div/PartRem[4][3] ), .B(n15), 
        .CI(\u_div/CryTmp[3][3] ), .CO(\u_div/CryTmp[3][4] ), .S(
        \u_div/SumTmp[3][3] ) );
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
  XNOR2X2M U9 ( .A(n18), .B(a[1]), .Y(\u_div/SumTmp[1][0] ) );
  NAND2X2M U10 ( .A(n2), .B(n3), .Y(\u_div/CryTmp[5][1] ) );
  INVX2M U11 ( .A(a[5]), .Y(n3) );
  INVX2M U12 ( .A(n18), .Y(n2) );
  NAND2X2M U13 ( .A(n4), .B(n5), .Y(\u_div/CryTmp[4][1] ) );
  INVX2M U14 ( .A(a[4]), .Y(n5) );
  INVX2M U15 ( .A(n18), .Y(n4) );
  NAND2X2M U16 ( .A(n6), .B(n7), .Y(\u_div/CryTmp[3][1] ) );
  INVX2M U17 ( .A(a[3]), .Y(n7) );
  INVX2M U18 ( .A(n18), .Y(n6) );
  NAND2X2M U19 ( .A(n2), .B(n8), .Y(\u_div/CryTmp[2][1] ) );
  INVX2M U20 ( .A(a[2]), .Y(n8) );
  NAND2X2M U21 ( .A(n6), .B(n9), .Y(\u_div/CryTmp[1][1] ) );
  INVX2M U22 ( .A(a[1]), .Y(n9) );
  NAND2X2M U23 ( .A(n4), .B(n10), .Y(\u_div/CryTmp[0][1] ) );
  INVX2M U24 ( .A(a[0]), .Y(n10) );
  NAND2X2M U25 ( .A(n2), .B(n1), .Y(\u_div/CryTmp[6][1] ) );
  INVX2M U26 ( .A(a[6]), .Y(n1) );
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
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [9:0] carry;

  ADDFX2M U2_7 ( .A(A[7]), .B(n2), .CI(carry[7]), .CO(carry[8]), .S(DIFF[7])
         );
  ADDFX2M U2_1 ( .A(A[1]), .B(n8), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1])
         );
  ADDFX2M U2_5 ( .A(A[5]), .B(n4), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5])
         );
  ADDFX2M U2_4 ( .A(A[4]), .B(n5), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4])
         );
  ADDFX2M U2_3 ( .A(A[3]), .B(n6), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3])
         );
  ADDFX2M U2_2 ( .A(A[2]), .B(n7), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2])
         );
  ADDFX2M U2_6 ( .A(A[6]), .B(n3), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6])
         );
  XNOR2X2M U1 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVX2M U2 ( .A(B[6]), .Y(n3) );
  INVX2M U3 ( .A(B[0]), .Y(n9) );
  INVX2M U4 ( .A(B[2]), .Y(n7) );
  INVX2M U5 ( .A(B[3]), .Y(n6) );
  INVX2M U6 ( .A(B[4]), .Y(n5) );
  INVX2M U7 ( .A(B[5]), .Y(n4) );
  NAND2X2M U8 ( .A(B[0]), .B(n1), .Y(carry[1]) );
  INVX2M U9 ( .A(B[1]), .Y(n8) );
  INVX2M U10 ( .A(A[0]), .Y(n1) );
  INVX2M U11 ( .A(B[7]), .Y(n2) );
  CLKINVX1M U12 ( .A(carry[8]), .Y(DIFF[8]) );
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
  wire   n1, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27;

  AOI21BX2M U2 ( .A0(n18), .A1(A[12]), .B0N(n19), .Y(n1) );
  NAND2X2M U3 ( .A(A[7]), .B(B[7]), .Y(n15) );
  XNOR2X2M U4 ( .A(A[7]), .B(n8), .Y(SUM[7]) );
  INVX2M U5 ( .A(B[7]), .Y(n8) );
  XNOR2X2M U6 ( .A(B[13]), .B(n1), .Y(SUM[13]) );
  INVX2M U7 ( .A(A[6]), .Y(n9) );
  INVX2M U8 ( .A(n9), .Y(SUM[6]) );
  BUFX2M U9 ( .A(A[0]), .Y(SUM[0]) );
  BUFX2M U10 ( .A(A[1]), .Y(SUM[1]) );
  BUFX2M U11 ( .A(A[2]), .Y(SUM[2]) );
  BUFX2M U12 ( .A(A[3]), .Y(SUM[3]) );
  BUFX2M U13 ( .A(A[4]), .Y(SUM[4]) );
  BUFX2M U14 ( .A(A[5]), .Y(SUM[5]) );
  XNOR2X1M U15 ( .A(n10), .B(n11), .Y(SUM[9]) );
  NOR2X1M U16 ( .A(n12), .B(n13), .Y(n11) );
  CLKXOR2X2M U17 ( .A(n14), .B(n15), .Y(SUM[8]) );
  NAND2BX1M U18 ( .AN(n16), .B(n17), .Y(n14) );
  OAI21X1M U19 ( .A0(A[12]), .A1(n18), .B0(B[12]), .Y(n19) );
  XOR3XLM U20 ( .A(B[12]), .B(A[12]), .C(n18), .Y(SUM[12]) );
  OAI21BX1M U21 ( .A0(n20), .A1(n21), .B0N(n22), .Y(n18) );
  XNOR2X1M U22 ( .A(n21), .B(n23), .Y(SUM[11]) );
  NOR2X1M U23 ( .A(n22), .B(n20), .Y(n23) );
  NOR2X1M U24 ( .A(B[11]), .B(A[11]), .Y(n20) );
  AND2X1M U25 ( .A(B[11]), .B(A[11]), .Y(n22) );
  OA21X1M U26 ( .A0(n24), .A1(n25), .B0(n26), .Y(n21) );
  CLKXOR2X2M U27 ( .A(n27), .B(n25), .Y(SUM[10]) );
  AOI2BB1X1M U28 ( .A0N(n10), .A1N(n13), .B0(n12), .Y(n25) );
  AND2X1M U29 ( .A(B[9]), .B(A[9]), .Y(n12) );
  NOR2X1M U30 ( .A(B[9]), .B(A[9]), .Y(n13) );
  OA21X1M U31 ( .A0(n15), .A1(n16), .B0(n17), .Y(n10) );
  CLKNAND2X2M U32 ( .A(B[8]), .B(A[8]), .Y(n17) );
  NOR2X1M U33 ( .A(B[8]), .B(A[8]), .Y(n16) );
  NAND2BX1M U34 ( .AN(n24), .B(n26), .Y(n27) );
  CLKNAND2X2M U35 ( .A(B[10]), .B(A[10]), .Y(n26) );
  NOR2X1M U36 ( .A(B[10]), .B(A[10]), .Y(n24) );
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

  ADDFX2M S2_6_5 ( .A(\ab[6][5] ), .B(\CARRYB[5][5] ), .CI(\SUMB[5][6] ), .CO(
        \CARRYB[6][5] ), .S(\SUMB[6][5] ) );
  ADDFX2M S2_6_4 ( .A(\ab[6][4] ), .B(\CARRYB[5][4] ), .CI(\SUMB[5][5] ), .CO(
        \CARRYB[6][4] ), .S(\SUMB[6][4] ) );
  ADDFX2M S2_5_5 ( .A(\ab[5][5] ), .B(\CARRYB[4][5] ), .CI(\SUMB[4][6] ), .CO(
        \CARRYB[5][5] ), .S(\SUMB[5][5] ) );
  ADDFX2M S2_6_3 ( .A(\ab[6][3] ), .B(\CARRYB[5][3] ), .CI(\SUMB[5][4] ), .CO(
        \CARRYB[6][3] ), .S(\SUMB[6][3] ) );
  ADDFX2M S2_5_4 ( .A(\ab[5][4] ), .B(\CARRYB[4][4] ), .CI(\SUMB[4][5] ), .CO(
        \CARRYB[5][4] ), .S(\SUMB[5][4] ) );
  ADDFX2M S1_6_0 ( .A(\ab[6][0] ), .B(\CARRYB[5][0] ), .CI(\SUMB[5][1] ), .CO(
        \CARRYB[6][0] ), .S(\A1[4] ) );
  ADDFX2M S2_6_1 ( .A(\ab[6][1] ), .B(\CARRYB[5][1] ), .CI(\SUMB[5][2] ), .CO(
        \CARRYB[6][1] ), .S(\SUMB[6][1] ) );
  ADDFX2M S2_6_2 ( .A(\ab[6][2] ), .B(\CARRYB[5][2] ), .CI(\SUMB[5][3] ), .CO(
        \CARRYB[6][2] ), .S(\SUMB[6][2] ) );
  ADDFX2M S2_4_5 ( .A(\ab[4][5] ), .B(\CARRYB[3][5] ), .CI(\SUMB[3][6] ), .CO(
        \CARRYB[4][5] ), .S(\SUMB[4][5] ) );
  ADDFX2M S1_5_0 ( .A(\ab[5][0] ), .B(\CARRYB[4][0] ), .CI(\SUMB[4][1] ), .CO(
        \CARRYB[5][0] ), .S(\A1[3] ) );
  ADDFX2M S2_5_1 ( .A(\ab[5][1] ), .B(\CARRYB[4][1] ), .CI(\SUMB[4][2] ), .CO(
        \CARRYB[5][1] ), .S(\SUMB[5][1] ) );
  ADDFX2M S2_5_2 ( .A(\ab[5][2] ), .B(\CARRYB[4][2] ), .CI(\SUMB[4][3] ), .CO(
        \CARRYB[5][2] ), .S(\SUMB[5][2] ) );
  ADDFX2M S2_5_3 ( .A(\ab[5][3] ), .B(\CARRYB[4][3] ), .CI(\SUMB[4][4] ), .CO(
        \CARRYB[5][3] ), .S(\SUMB[5][3] ) );
  ADDFX2M S1_4_0 ( .A(\ab[4][0] ), .B(\CARRYB[3][0] ), .CI(\SUMB[3][1] ), .CO(
        \CARRYB[4][0] ), .S(\A1[2] ) );
  ADDFX2M S2_4_1 ( .A(\ab[4][1] ), .B(\CARRYB[3][1] ), .CI(\SUMB[3][2] ), .CO(
        \CARRYB[4][1] ), .S(\SUMB[4][1] ) );
  ADDFX2M S2_4_2 ( .A(\ab[4][2] ), .B(\CARRYB[3][2] ), .CI(\SUMB[3][3] ), .CO(
        \CARRYB[4][2] ), .S(\SUMB[4][2] ) );
  ADDFX2M S2_4_3 ( .A(\ab[4][3] ), .B(\CARRYB[3][3] ), .CI(\SUMB[3][4] ), .CO(
        \CARRYB[4][3] ), .S(\SUMB[4][3] ) );
  ADDFX2M S2_4_4 ( .A(\ab[4][4] ), .B(\CARRYB[3][4] ), .CI(\SUMB[3][5] ), .CO(
        \CARRYB[4][4] ), .S(\SUMB[4][4] ) );
  ADDFX2M S1_3_0 ( .A(\ab[3][0] ), .B(\CARRYB[2][0] ), .CI(\SUMB[2][1] ), .CO(
        \CARRYB[3][0] ), .S(\A1[1] ) );
  ADDFX2M S2_3_1 ( .A(\ab[3][1] ), .B(\CARRYB[2][1] ), .CI(\SUMB[2][2] ), .CO(
        \CARRYB[3][1] ), .S(\SUMB[3][1] ) );
  ADDFX2M S2_3_2 ( .A(\ab[3][2] ), .B(\CARRYB[2][2] ), .CI(\SUMB[2][3] ), .CO(
        \CARRYB[3][2] ), .S(\SUMB[3][2] ) );
  ADDFX2M S2_3_3 ( .A(\ab[3][3] ), .B(\CARRYB[2][3] ), .CI(\SUMB[2][4] ), .CO(
        \CARRYB[3][3] ), .S(\SUMB[3][3] ) );
  ADDFX2M S2_3_4 ( .A(\ab[3][4] ), .B(\CARRYB[2][4] ), .CI(\SUMB[2][5] ), .CO(
        \CARRYB[3][4] ), .S(\SUMB[3][4] ) );
  ADDFX2M S2_3_5 ( .A(\ab[3][5] ), .B(\CARRYB[2][5] ), .CI(\SUMB[2][6] ), .CO(
        \CARRYB[3][5] ), .S(\SUMB[3][5] ) );
  ADDFX2M S3_6_6 ( .A(\ab[6][6] ), .B(\CARRYB[5][6] ), .CI(\ab[5][7] ), .CO(
        \CARRYB[6][6] ), .S(\SUMB[6][6] ) );
  ADDFX2M S3_5_6 ( .A(\ab[5][6] ), .B(\CARRYB[4][6] ), .CI(\ab[4][7] ), .CO(
        \CARRYB[5][6] ), .S(\SUMB[5][6] ) );
  ADDFX2M S3_4_6 ( .A(\ab[4][6] ), .B(\CARRYB[3][6] ), .CI(\ab[3][7] ), .CO(
        \CARRYB[4][6] ), .S(\SUMB[4][6] ) );
  ADDFX2M S3_3_6 ( .A(\ab[3][6] ), .B(\CARRYB[2][6] ), .CI(\ab[2][7] ), .CO(
        \CARRYB[3][6] ), .S(\SUMB[3][6] ) );
  ADDFX2M S3_2_6 ( .A(\ab[2][6] ), .B(n8), .CI(\ab[1][7] ), .CO(\CARRYB[2][6] ), .S(\SUMB[2][6] ) );
  ADDFX2M S1_2_0 ( .A(\ab[2][0] ), .B(n9), .CI(\SUMB[1][1] ), .CO(
        \CARRYB[2][0] ), .S(\A1[0] ) );
  ADDFX2M S2_2_1 ( .A(\ab[2][1] ), .B(n7), .CI(\SUMB[1][2] ), .CO(
        \CARRYB[2][1] ), .S(\SUMB[2][1] ) );
  ADDFX2M S2_2_2 ( .A(\ab[2][2] ), .B(n6), .CI(\SUMB[1][3] ), .CO(
        \CARRYB[2][2] ), .S(\SUMB[2][2] ) );
  ADDFX2M S2_2_3 ( .A(\ab[2][3] ), .B(n5), .CI(\SUMB[1][4] ), .CO(
        \CARRYB[2][3] ), .S(\SUMB[2][3] ) );
  ADDFX2M S2_2_4 ( .A(\ab[2][4] ), .B(n4), .CI(\SUMB[1][5] ), .CO(
        \CARRYB[2][4] ), .S(\SUMB[2][4] ) );
  ADDFX2M S2_2_5 ( .A(\ab[2][5] ), .B(n3), .CI(\SUMB[1][6] ), .CO(
        \CARRYB[2][5] ), .S(\SUMB[2][5] ) );
  ADDFX2M S5_6 ( .A(\ab[7][6] ), .B(\CARRYB[6][6] ), .CI(\ab[6][7] ), .CO(
        \CARRYB[7][6] ), .S(\SUMB[7][6] ) );
  ADDFX2M S4_5 ( .A(\ab[7][5] ), .B(\CARRYB[6][5] ), .CI(\SUMB[6][6] ), .CO(
        \CARRYB[7][5] ), .S(\SUMB[7][5] ) );
  ADDFX2M S4_4 ( .A(\ab[7][4] ), .B(\CARRYB[6][4] ), .CI(\SUMB[6][5] ), .CO(
        \CARRYB[7][4] ), .S(\SUMB[7][4] ) );
  ADDFX2M S4_3 ( .A(\ab[7][3] ), .B(\CARRYB[6][3] ), .CI(\SUMB[6][4] ), .CO(
        \CARRYB[7][3] ), .S(\SUMB[7][3] ) );
  ADDFX2M S4_2 ( .A(\ab[7][2] ), .B(\CARRYB[6][2] ), .CI(\SUMB[6][3] ), .CO(
        \CARRYB[7][2] ), .S(\SUMB[7][2] ) );
  ADDFX2M S4_0 ( .A(\ab[7][0] ), .B(\CARRYB[6][0] ), .CI(\SUMB[6][1] ), .CO(
        \CARRYB[7][0] ), .S(\SUMB[7][0] ) );
  ADDFX2M S4_1 ( .A(\ab[7][1] ), .B(\CARRYB[6][1] ), .CI(\SUMB[6][2] ), .CO(
        \CARRYB[7][1] ), .S(\SUMB[7][1] ) );
  AND2X2M U2 ( .A(\ab[0][6] ), .B(\ab[1][5] ), .Y(n3) );
  AND2X2M U3 ( .A(\ab[0][5] ), .B(\ab[1][4] ), .Y(n4) );
  AND2X2M U4 ( .A(\ab[0][4] ), .B(\ab[1][3] ), .Y(n5) );
  AND2X2M U5 ( .A(\ab[0][3] ), .B(\ab[1][2] ), .Y(n6) );
  AND2X2M U6 ( .A(\ab[0][2] ), .B(\ab[1][1] ), .Y(n7) );
  AND2X2M U7 ( .A(\ab[0][7] ), .B(\ab[1][6] ), .Y(n8) );
  AND2X2M U8 ( .A(\ab[0][1] ), .B(\ab[1][0] ), .Y(n9) );
  AND2X2M U9 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(n10) );
  INVX2M U10 ( .A(\ab[0][6] ), .Y(n22) );
  CLKXOR2X2M U11 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(\A1[7] ) );
  CLKXOR2X2M U12 ( .A(\ab[1][0] ), .B(\ab[0][1] ), .Y(PRODUCT[1]) );
  CLKXOR2X2M U13 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(\A1[12] ) );
  CLKXOR2X2M U14 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(\A1[8] ) );
  CLKXOR2X2M U15 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(\A1[10] ) );
  CLKXOR2X2M U16 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(\A1[9] ) );
  CLKXOR2X2M U17 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(\A1[11] ) );
  INVX2M U18 ( .A(\ab[0][7] ), .Y(n23) );
  INVX2M U19 ( .A(\ab[0][5] ), .Y(n21) );
  INVX2M U20 ( .A(\ab[0][4] ), .Y(n20) );
  INVX2M U21 ( .A(\ab[0][3] ), .Y(n19) );
  INVX2M U22 ( .A(\ab[0][2] ), .Y(n18) );
  XNOR2X2M U23 ( .A(\CARRYB[7][0] ), .B(n17), .Y(\A1[6] ) );
  INVX2M U24 ( .A(\SUMB[7][1] ), .Y(n17) );
  AND2X2M U25 ( .A(\CARRYB[7][0] ), .B(\SUMB[7][1] ), .Y(n11) );
  AND2X2M U26 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(n12) );
  AND2X2M U27 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(n13) );
  AND2X2M U28 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(n14) );
  AND2X2M U29 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(n15) );
  AND2X2M U30 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(n16) );
  XNOR2X2M U31 ( .A(\ab[1][6] ), .B(n23), .Y(\SUMB[1][6] ) );
  XNOR2X2M U32 ( .A(\ab[1][5] ), .B(n22), .Y(\SUMB[1][5] ) );
  XNOR2X2M U33 ( .A(\ab[1][4] ), .B(n21), .Y(\SUMB[1][4] ) );
  XNOR2X2M U34 ( .A(\ab[1][3] ), .B(n20), .Y(\SUMB[1][3] ) );
  XNOR2X2M U35 ( .A(\ab[1][2] ), .B(n19), .Y(\SUMB[1][2] ) );
  XNOR2X2M U36 ( .A(\ab[1][1] ), .B(n18), .Y(\SUMB[1][1] ) );
  INVX2M U37 ( .A(A[7]), .Y(n32) );
  INVX2M U38 ( .A(A[6]), .Y(n33) );
  INVX2M U39 ( .A(A[1]), .Y(n38) );
  INVX2M U40 ( .A(A[0]), .Y(n39) );
  INVX2M U41 ( .A(A[3]), .Y(n36) );
  INVX2M U42 ( .A(A[2]), .Y(n37) );
  INVX2M U43 ( .A(A[5]), .Y(n34) );
  INVX2M U44 ( .A(A[4]), .Y(n35) );
  INVX2M U45 ( .A(B[6]), .Y(n25) );
  INVX2M U46 ( .A(B[0]), .Y(n31) );
  INVX2M U47 ( .A(B[2]), .Y(n29) );
  INVX2M U48 ( .A(B[3]), .Y(n28) );
  INVX2M U49 ( .A(B[7]), .Y(n24) );
  INVX2M U50 ( .A(B[4]), .Y(n27) );
  INVX2M U51 ( .A(B[5]), .Y(n26) );
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
  ALU_DW01_add_1 FS_1 ( .A({1'b0, \A1[12] , \A1[11] , \A1[10] , \A1[9] , 
        \A1[8] , \A1[7] , \A1[6] , \SUMB[7][0] , \A1[4] , \A1[3] , \A1[2] , 
        \A1[1] , \A1[0] }), .B({n10, n14, n16, n13, n15, n12, n11, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .CI(1'b0), .SUM(PRODUCT[15:2]) );
endmodule


module ALU_test_1 ( A, B, EN, ALU_FUN, CLK, RST, ALU_OUT, OUT_VALID, test_si, 
        test_se );
  input [7:0] A;
  input [7:0] B;
  input [3:0] ALU_FUN;
  output [15:0] ALU_OUT;
  input EN, CLK, RST, test_si, test_se;
  output OUT_VALID;
  wire   N91, N92, N93, N94, N95, N96, N97, N98, N99, N100, N101, N102, N103,
         N104, N105, N106, N107, N108, N109, N110, N111, N112, N113, N114,
         N115, N116, N117, N118, N119, N120, N121, N122, N123, N124, N125,
         N126, N127, N128, N129, N130, N131, N132, N157, N158, N159, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63,
         n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77,
         n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n3, n4, n5, n6,
         n7, n8, n9, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n125, n126, n127,
         n128, n129, n130, n131, n132, n133, n134, n135, n136, n137, n138,
         n139, n140, n141, n142, n143, n144, n145, n146, n147, n148, n149,
         n150, n151, n152, n153, n154, n155, n156, n157;
  wire   [15:0] ALU_OUT_Comb;

  SDFFRQX2M \ALU_OUT_reg[7]  ( .D(ALU_OUT_Comb[7]), .SI(ALU_OUT[6]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[7]) );
  SDFFRQX2M \ALU_OUT_reg[6]  ( .D(ALU_OUT_Comb[6]), .SI(ALU_OUT[5]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[6]) );
  SDFFRQX2M \ALU_OUT_reg[5]  ( .D(ALU_OUT_Comb[5]), .SI(ALU_OUT[4]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[5]) );
  SDFFRQX2M \ALU_OUT_reg[4]  ( .D(ALU_OUT_Comb[4]), .SI(ALU_OUT[3]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[4]) );
  SDFFRQX2M \ALU_OUT_reg[3]  ( .D(ALU_OUT_Comb[3]), .SI(ALU_OUT[2]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[3]) );
  SDFFRQX2M \ALU_OUT_reg[2]  ( .D(ALU_OUT_Comb[2]), .SI(ALU_OUT[1]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[2]) );
  SDFFRQX2M \ALU_OUT_reg[1]  ( .D(ALU_OUT_Comb[1]), .SI(ALU_OUT[0]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[1]) );
  SDFFRQX2M \ALU_OUT_reg[0]  ( .D(ALU_OUT_Comb[0]), .SI(test_si), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(ALU_OUT[0]) );
  SDFFRQX2M \ALU_OUT_reg[15]  ( .D(ALU_OUT_Comb[15]), .SI(ALU_OUT[14]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[15]) );
  SDFFRQX2M \ALU_OUT_reg[14]  ( .D(ALU_OUT_Comb[14]), .SI(ALU_OUT[13]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[14]) );
  SDFFRQX2M \ALU_OUT_reg[13]  ( .D(ALU_OUT_Comb[13]), .SI(ALU_OUT[12]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[13]) );
  SDFFRQX2M \ALU_OUT_reg[12]  ( .D(ALU_OUT_Comb[12]), .SI(ALU_OUT[11]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[12]) );
  SDFFRQX2M \ALU_OUT_reg[11]  ( .D(ALU_OUT_Comb[11]), .SI(ALU_OUT[10]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[11]) );
  SDFFRQX2M \ALU_OUT_reg[10]  ( .D(ALU_OUT_Comb[10]), .SI(ALU_OUT[9]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[10]) );
  SDFFRQX2M \ALU_OUT_reg[9]  ( .D(ALU_OUT_Comb[9]), .SI(ALU_OUT[8]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[9]) );
  SDFFRQX2M \ALU_OUT_reg[8]  ( .D(ALU_OUT_Comb[8]), .SI(ALU_OUT[7]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(ALU_OUT[8]) );
  SDFFRQX2M OUT_VALID_reg ( .D(EN), .SI(ALU_OUT[15]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(OUT_VALID) );
  BUFX2M U7 ( .A(A[6]), .Y(n28) );
  OAI2BB1X2M U23 ( .A0N(n157), .A1N(n122), .B0(n118), .Y(n64) );
  OAI2BB1X2M U24 ( .A0N(n117), .A1N(n116), .B0(n118), .Y(n65) );
  NOR2BX2M U25 ( .AN(n123), .B(n154), .Y(n54) );
  AND2X2M U26 ( .A(n116), .B(n122), .Y(n59) );
  NOR2BX2M U27 ( .AN(n52), .B(n152), .Y(n48) );
  AND2X2M U28 ( .A(n123), .B(n122), .Y(n67) );
  BUFX2M U29 ( .A(n58), .Y(n30) );
  NOR2X2M U30 ( .A(n124), .B(n154), .Y(n58) );
  INVX2M U31 ( .A(n117), .Y(n154) );
  INVX2M U32 ( .A(n108), .Y(n155) );
  OAI2BB1X2M U33 ( .A0N(N118), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[9]) );
  OAI2BB1X2M U34 ( .A0N(N119), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[10]) );
  OAI2BB1X2M U35 ( .A0N(N120), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[11]) );
  OAI2BB1X2M U36 ( .A0N(N121), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[12]) );
  OAI2BB1X2M U37 ( .A0N(N122), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[13]) );
  OAI2BB1X2M U38 ( .A0N(N123), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[14]) );
  OAI2BB1X2M U39 ( .A0N(N124), .A1N(n48), .B0(n49), .Y(ALU_OUT_Comb[15]) );
  INVX2M U40 ( .A(n124), .Y(n157) );
  NOR3BX2M U41 ( .AN(n122), .B(n156), .C(ALU_FUN[2]), .Y(n66) );
  NOR3X2M U42 ( .A(n154), .B(ALU_FUN[2]), .C(n156), .Y(n52) );
  NOR2X2M U43 ( .A(ALU_FUN[2]), .B(ALU_FUN[1]), .Y(n123) );
  AND3X2M U44 ( .A(n123), .B(n153), .C(n3), .Y(n63) );
  NAND3X2M U45 ( .A(n157), .B(n153), .C(n3), .Y(n53) );
  NAND2X2M U46 ( .A(ALU_FUN[2]), .B(ALU_FUN[1]), .Y(n124) );
  INVX2M U47 ( .A(ALU_FUN[0]), .Y(n153) );
  NOR2X2M U48 ( .A(n153), .B(n3), .Y(n122) );
  NOR2X2M U49 ( .A(n3), .B(ALU_FUN[0]), .Y(n117) );
  NAND3X2M U50 ( .A(n3), .B(ALU_FUN[0]), .C(n116), .Y(n108) );
  INVX2M U51 ( .A(ALU_FUN[1]), .Y(n156) );
  NAND3X2M U52 ( .A(n123), .B(ALU_FUN[0]), .C(n3), .Y(n118) );
  NAND2X2M U53 ( .A(EN), .B(n140), .Y(n49) );
  AND2X2M U54 ( .A(ALU_FUN[2]), .B(n156), .Y(n116) );
  AND4X2M U55 ( .A(N159), .B(n116), .C(n3), .D(n153), .Y(n107) );
  INVX2M U56 ( .A(EN), .Y(n152) );
  INVX2M U57 ( .A(n4), .Y(n139) );
  OAI222X1M U58 ( .A0(n72), .A1(n139), .B0(n4), .B1(n73), .C0(n53), .C1(n146), 
        .Y(n71) );
  AOI221XLM U59 ( .A0(n28), .A1(n63), .B0(n64), .B1(n145), .C0(n30), .Y(n73)
         );
  AOI221XLM U60 ( .A0(n63), .A1(n145), .B0(n28), .B1(n65), .C0(n59), .Y(n72)
         );
  AOI31X2M U61 ( .A0(n92), .A1(n93), .A2(n94), .B0(n152), .Y(ALU_OUT_Comb[2])
         );
  AOI22X1M U62 ( .A0(N102), .A1(n67), .B0(N93), .B1(n54), .Y(n92) );
  AOI221XLM U63 ( .A0(n8), .A1(n155), .B0(n30), .B1(n149), .C0(n95), .Y(n94)
         );
  AOI222X1M U64 ( .A0(N111), .A1(n52), .B0(n7), .B1(n59), .C0(N127), .C1(n66), 
        .Y(n93) );
  AOI31X2M U65 ( .A0(n86), .A1(n87), .A2(n88), .B0(n152), .Y(ALU_OUT_Comb[3])
         );
  AOI22X1M U66 ( .A0(N103), .A1(n67), .B0(N94), .B1(n54), .Y(n86) );
  AOI221XLM U67 ( .A0(n9), .A1(n155), .B0(n30), .B1(n148), .C0(n89), .Y(n88)
         );
  AOI222X1M U68 ( .A0(N112), .A1(n52), .B0(n8), .B1(n59), .C0(N128), .C1(n66), 
        .Y(n87) );
  AOI31X2M U69 ( .A0(n80), .A1(n81), .A2(n82), .B0(n152), .Y(ALU_OUT_Comb[4])
         );
  AOI22X1M U70 ( .A0(N104), .A1(n67), .B0(N95), .B1(n54), .Y(n80) );
  AOI221XLM U71 ( .A0(n155), .A1(n27), .B0(n30), .B1(n147), .C0(n83), .Y(n82)
         );
  AOI222X1M U72 ( .A0(N113), .A1(n52), .B0(n9), .B1(n59), .C0(N129), .C1(n66), 
        .Y(n81) );
  AOI31X2M U73 ( .A0(n74), .A1(n75), .A2(n76), .B0(n152), .Y(ALU_OUT_Comb[5])
         );
  AOI22X1M U74 ( .A0(N105), .A1(n67), .B0(N96), .B1(n54), .Y(n74) );
  AOI221XLM U75 ( .A0(n155), .A1(n28), .B0(n30), .B1(n146), .C0(n77), .Y(n76)
         );
  AOI222X1M U76 ( .A0(N114), .A1(n52), .B0(n27), .B1(n59), .C0(N130), .C1(n66), 
        .Y(n75) );
  AOI31X2M U77 ( .A0(n68), .A1(n69), .A2(n70), .B0(n152), .Y(ALU_OUT_Comb[6])
         );
  AOI22X1M U78 ( .A0(N106), .A1(n67), .B0(N97), .B1(n54), .Y(n68) );
  AOI221XLM U79 ( .A0(n155), .A1(n29), .B0(n30), .B1(n145), .C0(n71), .Y(n70)
         );
  AOI222X1M U80 ( .A0(N115), .A1(n52), .B0(n59), .B1(n28), .C0(N131), .C1(n66), 
        .Y(n69) );
  AOI31X2M U81 ( .A0(n55), .A1(n56), .A2(n57), .B0(n152), .Y(ALU_OUT_Comb[7])
         );
  AOI22X1M U82 ( .A0(N132), .A1(n66), .B0(N116), .B1(n52), .Y(n56) );
  AOI22X1M U83 ( .A0(N107), .A1(n67), .B0(N98), .B1(n54), .Y(n55) );
  AOI221XLM U84 ( .A0(n30), .A1(n144), .B0(n59), .B1(n29), .C0(n60), .Y(n57)
         );
  AOI31X2M U85 ( .A0(n110), .A1(n111), .A2(n112), .B0(n152), .Y(
        ALU_OUT_Comb[0]) );
  AOI22X1M U86 ( .A0(N100), .A1(n67), .B0(N91), .B1(n54), .Y(n110) );
  AOI211X2M U87 ( .A0(n30), .A1(n151), .B0(n113), .C0(n114), .Y(n112) );
  AOI222X1M U88 ( .A0(N109), .A1(n52), .B0(n5), .B1(n59), .C0(N125), .C1(n66), 
        .Y(n111) );
  AOI31X2M U89 ( .A0(n98), .A1(n99), .A2(n100), .B0(n152), .Y(ALU_OUT_Comb[1])
         );
  AOI211X2M U90 ( .A0(n7), .A1(n155), .B0(n101), .C0(n102), .Y(n100) );
  AOI222X1M U91 ( .A0(N126), .A1(n66), .B0(n30), .B1(n150), .C0(n6), .C1(n59), 
        .Y(n99) );
  AOI222X1M U92 ( .A0(N92), .A1(n54), .B0(N110), .B1(n52), .C0(N101), .C1(n67), 
        .Y(n98) );
  INVX2M U93 ( .A(n109), .Y(n140) );
  AOI211X2M U94 ( .A0(N108), .A1(n67), .B0(n30), .C0(n64), .Y(n109) );
  AOI21X2M U95 ( .A0(n50), .A1(n51), .B0(n152), .Y(ALU_OUT_Comb[8]) );
  AOI21X2M U96 ( .A0(N99), .A1(n54), .B0(n140), .Y(n50) );
  AOI2BB2XLM U97 ( .B0(N117), .B1(n52), .A0N(n144), .A1N(n53), .Y(n51) );
  BUFX2M U98 ( .A(ALU_FUN[3]), .Y(n3) );
  INVX2M U99 ( .A(n6), .Y(n150) );
  INVX2M U100 ( .A(n5), .Y(n151) );
  INVX2M U101 ( .A(n28), .Y(n145) );
  INVX2M U102 ( .A(n29), .Y(n144) );
  INVX2M U103 ( .A(n8), .Y(n148) );
  INVX2M U104 ( .A(n7), .Y(n149) );
  INVX2M U105 ( .A(n27), .Y(n146) );
  INVX2M U106 ( .A(n9), .Y(n147) );
  OAI222X1M U107 ( .A0(n96), .A1(n136), .B0(B[2]), .B1(n97), .C0(n53), .C1(
        n150), .Y(n95) );
  AOI221XLM U108 ( .A0(n7), .A1(n63), .B0(n64), .B1(n149), .C0(n30), .Y(n97)
         );
  AOI221XLM U109 ( .A0(n63), .A1(n149), .B0(n7), .B1(n65), .C0(n59), .Y(n96)
         );
  OAI222X1M U110 ( .A0(n90), .A1(n138), .B0(B[3]), .B1(n91), .C0(n53), .C1(
        n149), .Y(n89) );
  AOI221XLM U111 ( .A0(n8), .A1(n63), .B0(n64), .B1(n148), .C0(n30), .Y(n91)
         );
  AOI221XLM U112 ( .A0(n63), .A1(n148), .B0(n8), .B1(n65), .C0(n59), .Y(n90)
         );
  OAI222X1M U113 ( .A0(n84), .A1(n143), .B0(B[4]), .B1(n85), .C0(n53), .C1(
        n148), .Y(n83) );
  INVX2M U114 ( .A(B[4]), .Y(n143) );
  AOI221XLM U115 ( .A0(n9), .A1(n63), .B0(n64), .B1(n147), .C0(n30), .Y(n85)
         );
  AOI221XLM U116 ( .A0(n63), .A1(n147), .B0(n9), .B1(n65), .C0(n59), .Y(n84)
         );
  OAI222X1M U117 ( .A0(n78), .A1(n142), .B0(B[5]), .B1(n79), .C0(n53), .C1(
        n147), .Y(n77) );
  INVX2M U118 ( .A(B[5]), .Y(n142) );
  AOI221XLM U119 ( .A0(n27), .A1(n63), .B0(n64), .B1(n146), .C0(n30), .Y(n79)
         );
  AOI221XLM U120 ( .A0(n63), .A1(n146), .B0(n27), .B1(n65), .C0(n59), .Y(n78)
         );
  OAI222X1M U121 ( .A0(n61), .A1(n141), .B0(B[7]), .B1(n62), .C0(n53), .C1(
        n145), .Y(n60) );
  INVX2M U122 ( .A(B[7]), .Y(n141) );
  AOI221XLM U123 ( .A0(n63), .A1(n29), .B0(n64), .B1(n144), .C0(n30), .Y(n62)
         );
  AOI221XLM U124 ( .A0(n63), .A1(n144), .B0(n29), .B1(n65), .C0(n59), .Y(n61)
         );
  INVX2M U125 ( .A(n31), .Y(n135) );
  OAI2B2X1M U126 ( .A1N(B[0]), .A0(n115), .B0(n108), .B1(n150), .Y(n114) );
  AOI221XLM U127 ( .A0(n63), .A1(n151), .B0(n5), .B1(n65), .C0(n59), .Y(n115)
         );
  OAI2B2X1M U128 ( .A1N(B[1]), .A0(n103), .B0(n53), .B1(n151), .Y(n102) );
  AOI221XLM U129 ( .A0(n63), .A1(n150), .B0(n6), .B1(n65), .C0(n59), .Y(n103)
         );
  INVX2M U130 ( .A(n42), .Y(n137) );
  OAI21X2M U131 ( .A0(B[0]), .A1(n119), .B0(n120), .Y(n113) );
  AOI31X2M U132 ( .A0(N157), .A1(n3), .A2(n121), .B0(n107), .Y(n120) );
  AOI221XLM U133 ( .A0(n5), .A1(n63), .B0(n64), .B1(n151), .C0(n30), .Y(n119)
         );
  NOR3X2M U134 ( .A(n156), .B(ALU_FUN[2]), .C(ALU_FUN[0]), .Y(n121) );
  OAI21X2M U135 ( .A0(B[1]), .A1(n104), .B0(n105), .Y(n101) );
  AOI31X2M U136 ( .A0(N158), .A1(n3), .A2(n106), .B0(n107), .Y(n105) );
  AOI221XLM U137 ( .A0(n6), .A1(n63), .B0(n64), .B1(n150), .C0(n30), .Y(n104)
         );
  NOR3X2M U138 ( .A(n153), .B(ALU_FUN[2]), .C(n156), .Y(n106) );
  BUFX2M U139 ( .A(A[7]), .Y(n29) );
  BUFX2M U140 ( .A(A[1]), .Y(n6) );
  BUFX2M U141 ( .A(A[0]), .Y(n5) );
  BUFX2M U142 ( .A(A[3]), .Y(n8) );
  BUFX2M U143 ( .A(A[2]), .Y(n7) );
  BUFX2M U144 ( .A(A[5]), .Y(n27) );
  BUFX2M U145 ( .A(A[4]), .Y(n9) );
  BUFX2M U146 ( .A(B[6]), .Y(n4) );
  INVX2M U147 ( .A(B[0]), .Y(n134) );
  INVX2M U148 ( .A(B[2]), .Y(n136) );
  INVX2M U149 ( .A(B[3]), .Y(n138) );
  NOR2X1M U150 ( .A(n144), .B(B[7]), .Y(n130) );
  NAND2BX1M U151 ( .AN(B[4]), .B(n9), .Y(n46) );
  NAND2BX1M U152 ( .AN(n9), .B(B[4]), .Y(n35) );
  CLKNAND2X2M U153 ( .A(n46), .B(n35), .Y(n125) );
  NOR2X1M U154 ( .A(n138), .B(n8), .Y(n43) );
  NOR2X1M U155 ( .A(n136), .B(n7), .Y(n34) );
  NOR2X1M U156 ( .A(n134), .B(n5), .Y(n31) );
  CLKNAND2X2M U157 ( .A(n7), .B(n136), .Y(n45) );
  NAND2BX1M U158 ( .AN(n34), .B(n45), .Y(n40) );
  AOI21X1M U159 ( .A0(n31), .A1(n150), .B0(B[1]), .Y(n32) );
  AOI211X1M U160 ( .A0(n6), .A1(n135), .B0(n40), .C0(n32), .Y(n33) );
  CLKNAND2X2M U161 ( .A(n8), .B(n138), .Y(n44) );
  OAI31X1M U162 ( .A0(n43), .A1(n34), .A2(n33), .B0(n44), .Y(n36) );
  NAND2BX1M U163 ( .AN(n27), .B(B[5]), .Y(n128) );
  OAI211X1M U164 ( .A0(n125), .A1(n36), .B0(n35), .C0(n128), .Y(n37) );
  NAND2BX1M U165 ( .AN(B[5]), .B(n27), .Y(n47) );
  XNOR2X1M U166 ( .A(n28), .B(n4), .Y(n127) );
  AOI32X1M U167 ( .A0(n37), .A1(n47), .A2(n127), .B0(n4), .B1(n145), .Y(n38)
         );
  CLKNAND2X2M U168 ( .A(B[7]), .B(n144), .Y(n131) );
  OAI21X1M U169 ( .A0(n130), .A1(n38), .B0(n131), .Y(N159) );
  CLKNAND2X2M U170 ( .A(n5), .B(n134), .Y(n41) );
  OA21X1M U171 ( .A0(n41), .A1(n150), .B0(B[1]), .Y(n39) );
  AOI211X1M U172 ( .A0(n41), .A1(n150), .B0(n40), .C0(n39), .Y(n42) );
  AOI31X1M U173 ( .A0(n137), .A1(n45), .A2(n44), .B0(n43), .Y(n126) );
  OAI2B11X1M U174 ( .A1N(n126), .A0(n125), .B0(n47), .C0(n46), .Y(n129) );
  AOI32X1M U175 ( .A0(n129), .A1(n128), .A2(n127), .B0(n28), .B1(n139), .Y(
        n132) );
  AOI2B1X1M U176 ( .A1N(n132), .A0(n131), .B0(n130), .Y(n133) );
  CLKINVX1M U177 ( .A(n133), .Y(N158) );
  NOR2X1M U178 ( .A(N159), .B(N158), .Y(N157) );
  ALU_DW_div_uns_0 div_52 ( .a({n29, n28, n27, n9, n8, n7, n6, n5}), .b({B[7], 
        n4, B[5:0]}), .quotient({N132, N131, N130, N129, N128, N127, N126, 
        N125}) );
  ALU_DW01_sub_0 sub_46 ( .A({1'b0, n29, n28, n27, n9, n8, n7, n6, n5}), .B({
        1'b0, B[7], n4, B[5:0]}), .CI(1'b0), .DIFF({N108, N107, N106, N105, 
        N104, N103, N102, N101, N100}) );
  ALU_DW01_add_0 add_43 ( .A({1'b0, n29, n28, n27, n9, n8, n7, n6, n5}), .B({
        1'b0, B[7], n4, B[5:0]}), .CI(1'b0), .SUM({N99, N98, N97, N96, N95, 
        N94, N93, N92, N91}) );
  ALU_DW02_mult_0 mult_49 ( .A({n29, n28, n27, n9, n8, n7, n6, n5}), .B({B[7], 
        n4, B[5:0]}), .TC(1'b0), .PRODUCT({N124, N123, N122, N121, N120, N119, 
        N118, N117, N116, N115, N114, N113, N112, N111, N110, N109}) );
endmodule


module SYS_TOP_dft ( REF_CLK, RST, UART_CLK, RX_IN, par_err_reg, stp_error_reg, 
        TX_OUT, SI, SO, SE, test_mode, scan_clock, scan_rst, test_si2, 
        test_so2, test_si3, test_so3, test_si4 );
  input REF_CLK, RST, UART_CLK, RX_IN, SI, SE, test_mode, scan_clock, scan_rst,
         test_si2, test_si3, test_si4;
  output par_err_reg, stp_error_reg, TX_OUT, SO, test_so2, test_so3;
  wire   N0, UART_CLK_M, REF_CLK_M, TX_CLK_M, TX_CLK, RX_CLK_M, RX_CLK, RST_M,
         SYNC_RST_sys_M, SYNC_RST_sys, SYNC_RST_UART_M, SYNC_RST_UART,
         data_valid_reg_RX, busy, rempty, RX_D_VLD, OUT_Valid, RdData_Valid,
         ALU_EN, CLK_GATING_EN, Wr_En, Rd_En, TX_D_VLD, wfull, _1_net_,
         ALU_CLK, rinc, \Div_Ratio_RX[1] , n1, n2, n4, n5, n6, n7, n8, n9, n10,
         n11, n12, n13, n15, n16, n21, n22, n25, n26, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41;
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
  assign N0 = test_mode;

  BUFX2M U18 ( .A(Address[0]), .Y(n8) );
  BUFX2M U19 ( .A(Address[1]), .Y(n9) );
  INVX2M U20 ( .A(rempty), .Y(n1) );
  OR2X2M U21 ( .A(CLK_GATING_EN), .B(n7), .Y(_1_net_) );
  MX2X2M U22 ( .A(RX_CLK), .B(scan_clock), .S0(n7), .Y(RX_CLK_M) );
  MX2X2M U23 ( .A(TX_CLK), .B(scan_clock), .S0(n7), .Y(TX_CLK_M) );
  NAND3BX2M U24 ( .AN(prescale[5]), .B(n13), .C(prescale[4]), .Y(n4) );
  INVX2M U25 ( .A(n5), .Y(n2) );
  NOR4BX1M U26 ( .AN(n6), .B(prescale[0]), .C(prescale[1]), .D(prescale[2]), 
        .Y(n5) );
  OAI31X1M U27 ( .A0(n13), .A1(prescale[5]), .A2(prescale[4]), .B0(n4), .Y(n6)
         );
  INVX2M U28 ( .A(prescale[3]), .Y(n13) );
  NOR4X1M U29 ( .A(prescale[2]), .B(prescale[1]), .C(prescale[0]), .D(n4), .Y(
        \Div_Ratio_RX[1] ) );
  INVX4M U30 ( .A(n12), .Y(n11) );
  INVX2M U31 ( .A(SYNC_RST_sys_M), .Y(n12) );
  MX2X2M U32 ( .A(SYNC_RST_sys), .B(scan_rst), .S0(n7), .Y(SYNC_RST_sys_M) );
  MX2X2M U33 ( .A(RST), .B(scan_rst), .S0(n7), .Y(RST_M) );
  MX2X2M U34 ( .A(SYNC_RST_UART), .B(scan_rst), .S0(n7), .Y(SYNC_RST_UART_M)
         );
  BUFX2M U35 ( .A(N0), .Y(n7) );
  BUFX2M U36 ( .A(OUT_Valid), .Y(n10) );
  MX2X6M U37 ( .A(REF_CLK), .B(scan_clock), .S0(n7), .Y(REF_CLK_M) );
  MX2X2M U38 ( .A(UART_CLK), .B(scan_clock), .S0(n7), .Y(UART_CLK_M) );
  DLY1X1M U40 ( .A(n30), .Y(n28) );
  INVXLM U41 ( .A(n41), .Y(n29) );
  INVXLM U42 ( .A(n29), .Y(n30) );
  INVXLM U43 ( .A(n29), .Y(n31) );
  INVXLM U44 ( .A(n29), .Y(n32) );
  INVXLM U45 ( .A(n29), .Y(n33) );
  DLY1X1M U46 ( .A(n36), .Y(n34) );
  INVXLM U47 ( .A(n40), .Y(n35) );
  INVXLM U48 ( .A(n35), .Y(n36) );
  INVXLM U49 ( .A(n35), .Y(n37) );
  INVXLM U50 ( .A(n35), .Y(n38) );
  INVXLM U51 ( .A(SE), .Y(n39) );
  INVXLM U52 ( .A(n39), .Y(n40) );
  INVXLM U53 ( .A(n39), .Y(n41) );
  UART_RX_test_1 RX ( .clk(RX_CLK_M), .rst(SYNC_RST_UART_M), .RX_IN(RX_IN), 
        .prescale(prescale), .PAR_EN(REG2[0]), .PAR_TYP(REG2[1]), 
        .data_valid_reg(data_valid_reg_RX), .par_err_reg(par_err_reg), 
        .stp_error_reg(stp_error_reg), .P_DATA_reg(P_DATA_reg_RX), .test_si2(
        n15), .test_si1(SYNC_RST_UART), .test_se(n34) );
  UART_TX_test_1 TX ( .P_DATA(r_data), .Data_Valid(n1), .PAR_TYP(REG2[1]), 
        .PAR_EN(REG2[0]), .TX_OUT(TX_OUT), .busy(busy), .clk(TX_CLK_M), .rst(
        SYNC_RST_UART_M), .test_si(n16), .test_so(n15), .test_se(n31) );
  RST_SYNC_test_1 RST_SYNC_REF_CLK ( .RST(RST_M), .CLK(REF_CLK_M), .SYNC_RST(
        SYNC_RST_sys), .test_si(test_si4), .test_se(n32) );
  RST_SYNC_test_0 RST_SYNC_UART_CLK ( .RST(RST_M), .CLK(UART_CLK_M), 
        .SYNC_RST(SYNC_RST_UART), .test_si(SYNC_RST_sys), .test_se(n38) );
  DATA_SYNC_test_1 DATA_SYNC ( .unsync_bus(P_DATA_reg_RX), .bus_enable(
        data_valid_reg_RX), .clk(REF_CLK_M), .rst(n11), .sync_bus(RX_P_Data), 
        .enable_pulse(RX_D_VLD), .test_si(n25), .test_se(n32) );
  SYS_CTRL_test_1 SYS_CTRL ( .CLK(REF_CLK_M), .RST(n11), .ALU_OUT(ALU_OUT), 
        .OUT_Valid(n10), .RX_P_Data(RX_P_Data), .RX_D_VLD(RX_D_VLD), .RdData(
        RdData), .RdData_Valid(RdData_Valid), .ALU_EN(ALU_EN), .ALU_FUN(
        ALU_FUN), .CLK_GATING_EN(CLK_GATING_EN), .Address(Address), .Wr_En(
        Wr_En), .Rd_En(Rd_En), .Wr_Data(Wr_Data), .TX_P_Data(TX_P_Data), 
        .TX_D_VLD(TX_D_VLD), .wfull(wfull), .test_si(par_err_reg), .test_so(
        n16), .test_se(n28) );
  clock_gating clk_gating ( .CLK_EN(_1_net_), .CLK(REF_CLK_M), .GATED_CLK(
        ALU_CLK) );
  Pulse_Gen_test_1 PULSE_GEN ( .clk(TX_CLK_M), .rst(SYNC_RST_UART_M), .in(busy), .out(rinc), .test_si(n22), .test_so(n21), .test_se(n38) );
  ClkDiv_Range_for_division8_test_1 CLK_DIV_TX ( .i_ref_clk(UART_CLK_M), 
        .i_rst_n(SYNC_RST_UART_M), .i_clk_en(1'b1), .i_div_ratio(REG3), 
        .o_div_clk(TX_CLK), .test_si(n26), .test_so(n25), .test_se(n38) );
  ClkDiv_Range_for_division2_test_1 CLK_DIV_RX ( .i_ref_clk(UART_CLK_M), 
        .i_rst_n(SYNC_RST_UART_M), .i_clk_en(1'b1), .i_div_ratio({
        \Div_Ratio_RX[1] , n2}), .o_div_clk(RX_CLK), .test_si(OUT_Valid), 
        .test_so(n26), .test_se(n33) );
  FIFO_TOP_test_1 FIFO ( .w_data(TX_P_Data), .winc(TX_D_VLD), .w_clk(REF_CLK_M), .wrst_n(n11), .wfull(wfull), .r_data(r_data), .rinc(rinc), .rempty(rempty), 
        .r_clk(TX_CLK_M), .rrst_n(SYNC_RST_UART_M), .test_si2(test_si2), 
        .test_si1(RX_P_Data[7]), .test_so2(n22), .test_so1(SO), .test_se(SE)
         );
  RegFile_test_1 REG ( .CLK(REF_CLK_M), .RST(n11), .WrEn(Wr_En), .RdEn(Rd_En), 
        .Address({Address[3:2], n9, n8}), .WrData(Wr_Data), .RdData(RdData), 
        .RdData_VLD(RdData_Valid), .REG0(REG0), .REG1(REG1), .REG2({prescale, 
        REG2}), .REG3(REG3), .test_si2(test_si3), .test_si1(n21), .test_so2(
        test_so3), .test_so1(test_so2), .test_se(SE) );
  ALU_test_1 ALU ( .A(REG0), .B(REG1), .EN(ALU_EN), .ALU_FUN(ALU_FUN), .CLK(
        ALU_CLK), .RST(n11), .ALU_OUT(ALU_OUT), .OUT_VALID(OUT_Valid), 
        .test_si(SI), .test_se(n37) );
endmodule

