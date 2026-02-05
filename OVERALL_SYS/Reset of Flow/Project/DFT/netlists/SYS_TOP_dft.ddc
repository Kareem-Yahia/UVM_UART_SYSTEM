/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Sun Aug 18 00:34:29 2024
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
  wire   enable, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26;
  wire   [2:0] cs;
  wire   [2:0] ns;
  assign dat_sample_en = enable;
  assign test_so = cs[2];

  SDFFRQX2M \cs_reg[0]  ( .D(ns[0]), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(cs[0]) );
  SDFFRQX2M \cs_reg[2]  ( .D(ns[2]), .SI(cs[1]), .SE(test_se), .CK(clk), .RN(
        rst), .Q(cs[2]) );
  SDFFRQX2M \cs_reg[1]  ( .D(ns[1]), .SI(cs[0]), .SE(test_se), .CK(clk), .RN(
        rst), .Q(cs[1]) );
  NOR2X1M U6 ( .A(n4), .B(n5), .Y(par_chk_en) );
  OAI31X1M U7 ( .A0(n6), .A1(PAR_EN), .A2(n7), .B0(n8), .Y(ns[2]) );
  MXI2X1M U8 ( .A(n9), .B(n10), .S0(n11), .Y(n8) );
  NOR2BX1M U9 ( .AN(n12), .B(n13), .Y(n10) );
  NOR2BX1M U10 ( .AN(n14), .B(n5), .Y(n9) );
  OAI211X1M U11 ( .A0(strt_glitch), .A1(n15), .B0(n16), .C0(n17), .Y(ns[1]) );
  OAI21X1M U12 ( .A0(PAR_EN), .A1(n7), .B0(n18), .Y(n16) );
  OAI2B11X1M U13 ( .A1N(n19), .A0(n20), .B0(n17), .C0(n21), .Y(ns[0]) );
  AOI32X1M U14 ( .A0(n18), .A1(n22), .A2(PAR_EN), .B0(new_op_flag), .B1(n11), 
        .Y(n21) );
  CLKINVX1M U15 ( .A(n7), .Y(n22) );
  NAND3X1M U16 ( .A(edge_cnt_flag), .B(bit_cnt[3]), .C(n23), .Y(n7) );
  NOR3X1M U17 ( .A(bit_cnt[0]), .B(bit_cnt[2]), .C(bit_cnt[1]), .Y(n23) );
  CLKINVX1M U18 ( .A(n6), .Y(n18) );
  NAND3BX1M U19 ( .AN(n5), .B(n14), .C(n11), .Y(n17) );
  CLKNAND2X2M U20 ( .A(par_err), .B(system_outputs_flag), .Y(n14) );
  NAND3X1M U21 ( .A(cs[0]), .B(n24), .C(cs[1]), .Y(n5) );
  OR2X1M U22 ( .A(RX_IN), .B(n25), .Y(n20) );
  AOI21X1M U23 ( .A0(edge_cnt_flag), .A1(n12), .B0(n24), .Y(n25) );
  CLKNAND2X2M U24 ( .A(stp_error), .B(system_outputs_flag), .Y(n12) );
  CLKINVX1M U25 ( .A(n15), .Y(strt_chk_en) );
  CLKNAND2X2M U26 ( .A(new_op_flag), .B(edge_cnt_flag), .Y(n15) );
  NOR3X1M U27 ( .A(cs[1]), .B(cs[2]), .C(n26), .Y(new_op_flag) );
  OAI21X1M U28 ( .A0(cs[2]), .A1(n19), .B0(n13), .Y(enable) );
  NOR2X1M U29 ( .A(n11), .B(n6), .Y(deser_en) );
  NAND3X1M U30 ( .A(n26), .B(n24), .C(cs[1]), .Y(n6) );
  CLKINVX1M U31 ( .A(cs[2]), .Y(n24) );
  CLKINVX1M U32 ( .A(cs[0]), .Y(n26) );
  CLKINVX1M U33 ( .A(edge_cnt_flag), .Y(n11) );
  NOR2BX1M U34 ( .AN(stp_chk_en), .B(stp_error), .Y(data_valid) );
  NOR2X1M U35 ( .A(n4), .B(n13), .Y(stp_chk_en) );
  CLKNAND2X2M U36 ( .A(cs[2]), .B(n19), .Y(n13) );
  NOR2X1M U37 ( .A(cs[1]), .B(cs[0]), .Y(n19) );
  CLKINVX1M U38 ( .A(system_outputs_flag), .Y(n4) );
endmodule


module edge_bit_counter_test_1 ( clk, rst, PAR_EN, enable, prescale, edge_cnt, 
        bit_cnt, edge_cnt_flag, system_outputs_flag, test_si, test_so, test_se
 );
  input [5:0] prescale;
  output [4:0] edge_cnt;
  output [3:0] bit_cnt;
  input clk, rst, PAR_EN, enable, test_si, test_se;
  output edge_cnt_flag, system_outputs_flag, test_so;
  wire   N21, N22, N23, N24, N25, bit_cnt_flag, N48, N57, n34, n36, n38, n40,
         n42, n44, n47, n48, n49, n50, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64,
         n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78,
         n79, n80, n81, n82, n83, n84, n85, n86, n87, n88;
  wire   [5:0] prescale_sampled;
  assign test_so = prescale_sampled[5];

  SDFFRQX2M bit_cnt_flag_reg ( .D(N48), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(bit_cnt_flag) );
  SDFFRQX2M \prescale_sampled_reg[5]  ( .D(n44), .SI(prescale_sampled[4]), 
        .SE(test_se), .CK(clk), .RN(rst), .Q(prescale_sampled[5]) );
  SDFFRQX2M \prescale_sampled_reg[4]  ( .D(n42), .SI(prescale_sampled[3]), 
        .SE(test_se), .CK(clk), .RN(rst), .Q(prescale_sampled[4]) );
  SDFFRQX2M \prescale_sampled_reg[2]  ( .D(n38), .SI(prescale_sampled[1]), 
        .SE(test_se), .CK(clk), .RN(rst), .Q(prescale_sampled[2]) );
  SDFFRQX2M \prescale_sampled_reg[3]  ( .D(n40), .SI(prescale_sampled[2]), 
        .SE(test_se), .CK(clk), .RN(rst), .Q(prescale_sampled[3]) );
  SDFFRQX2M \bit_cnt_reg[3]  ( .D(n50), .SI(bit_cnt[2]), .SE(test_se), .CK(clk), .RN(rst), .Q(bit_cnt[3]) );
  SDFFRQX2M \prescale_sampled_reg[1]  ( .D(n36), .SI(N57), .SE(test_se), .CK(
        clk), .RN(rst), .Q(prescale_sampled[1]) );
  SDFFRQX2M \edge_cnt_reg[0]  ( .D(N21), .SI(bit_cnt[3]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(edge_cnt[0]) );
  SDFFRQX2M \prescale_sampled_reg[0]  ( .D(n34), .SI(edge_cnt[4]), .SE(test_se), .CK(clk), .RN(rst), .Q(N57) );
  SDFFRQX2M \edge_cnt_reg[1]  ( .D(N22), .SI(edge_cnt[0]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(edge_cnt[1]) );
  SDFFRQX2M \bit_cnt_reg[1]  ( .D(n48), .SI(bit_cnt[0]), .SE(test_se), .CK(clk), .RN(rst), .Q(bit_cnt[1]) );
  SDFFRQX2M \edge_cnt_reg[3]  ( .D(N24), .SI(edge_cnt[2]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(edge_cnt[3]) );
  SDFFRQX2M \bit_cnt_reg[2]  ( .D(n47), .SI(bit_cnt[1]), .SE(test_se), .CK(clk), .RN(rst), .Q(bit_cnt[2]) );
  SDFFRQX2M \edge_cnt_reg[4]  ( .D(N25), .SI(edge_cnt[3]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(edge_cnt[4]) );
  SDFFRQX2M \bit_cnt_reg[0]  ( .D(n49), .SI(bit_cnt_flag), .SE(test_se), .CK(
        clk), .RN(rst), .Q(bit_cnt[0]) );
  SDFFRQX2M \edge_cnt_reg[2]  ( .D(N23), .SI(edge_cnt[1]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(edge_cnt[2]) );
  NOR4X1M U3 ( .A(n1), .B(n2), .C(n3), .D(n4), .Y(system_outputs_flag) );
  CLKXOR2X2M U4 ( .A(n5), .B(edge_cnt[3]), .Y(n3) );
  OAI21X1M U5 ( .A0(n6), .A1(n7), .B0(n8), .Y(n5) );
  OAI2B1X1M U6 ( .A1N(prescale_sampled[2]), .A0(n9), .B0(n10), .Y(n2) );
  CLKXOR2X2M U7 ( .A(n11), .B(prescale_sampled[5]), .Y(n10) );
  OR2X1M U8 ( .A(n8), .B(prescale_sampled[4]), .Y(n11) );
  CLKXOR2X2M U9 ( .A(n12), .B(prescale_sampled[1]), .Y(n9) );
  CLKINVX1M U10 ( .A(edge_cnt[2]), .Y(n12) );
  NAND3X1M U11 ( .A(n13), .B(n14), .C(n15), .Y(n1) );
  MXI2X1M U12 ( .A(n6), .B(n16), .S0(edge_cnt[2]), .Y(n15) );
  NOR2BX1M U13 ( .AN(prescale_sampled[1]), .B(prescale_sampled[2]), .Y(n16) );
  CLKXOR2X2M U14 ( .A(N57), .B(n17), .Y(n14) );
  XOR3XLM U15 ( .A(prescale_sampled[4]), .B(edge_cnt[4]), .C(n8), .Y(n13) );
  CLKNAND2X2M U16 ( .A(n6), .B(n7), .Y(n8) );
  CLKINVX1M U17 ( .A(prescale_sampled[3]), .Y(n7) );
  OAI32X1M U18 ( .A0(n18), .A1(bit_cnt_flag), .A2(n19), .B0(n20), .B1(n21), 
        .Y(n50) );
  MXI2X1M U19 ( .A(bit_cnt[3]), .B(n22), .S0(bit_cnt[2]), .Y(n18) );
  NOR3X1M U20 ( .A(n23), .B(bit_cnt[3]), .C(n24), .Y(n22) );
  OAI21X1M U21 ( .A0(n51), .A1(n52), .B0(n53), .Y(n49) );
  MXI2X1M U22 ( .A(n54), .B(n55), .S0(bit_cnt[1]), .Y(n48) );
  NOR2BX1M U23 ( .AN(n53), .B(n56), .Y(n55) );
  CLKNAND2X2M U24 ( .A(n57), .B(n51), .Y(n53) );
  CLKINVX1M U25 ( .A(bit_cnt[0]), .Y(n51) );
  CLKNAND2X2M U26 ( .A(n57), .B(bit_cnt[0]), .Y(n54) );
  MXI2X1M U27 ( .A(n58), .B(n20), .S0(bit_cnt[2]), .Y(n47) );
  AOI31X1M U28 ( .A0(enable), .A1(n59), .A2(n24), .B0(n56), .Y(n20) );
  CLKINVX1M U29 ( .A(bit_cnt_flag), .Y(n59) );
  NAND2BX1M U30 ( .AN(n24), .B(n57), .Y(n58) );
  NOR3X1M U31 ( .A(n23), .B(bit_cnt_flag), .C(n19), .Y(n57) );
  CLKINVX1M U32 ( .A(enable), .Y(n19) );
  CLKNAND2X2M U33 ( .A(bit_cnt[1]), .B(bit_cnt[0]), .Y(n24) );
  CLKMX2X2M U34 ( .A(prescale_sampled[5]), .B(prescale[5]), .S0(n60), .Y(n44)
         );
  CLKMX2X2M U35 ( .A(prescale_sampled[4]), .B(prescale[4]), .S0(n60), .Y(n42)
         );
  CLKMX2X2M U36 ( .A(prescale_sampled[3]), .B(prescale[3]), .S0(n60), .Y(n40)
         );
  CLKMX2X2M U37 ( .A(prescale_sampled[2]), .B(prescale[2]), .S0(n60), .Y(n38)
         );
  CLKMX2X2M U38 ( .A(prescale_sampled[1]), .B(prescale[1]), .S0(n60), .Y(n36)
         );
  CLKMX2X2M U39 ( .A(N57), .B(prescale[0]), .S0(n60), .Y(n34) );
  NOR4X1M U56 ( .A(bit_cnt[0]), .B(bit_cnt[1]), .C(bit_cnt[2]), .D(bit_cnt[3]), 
        .Y(n60) );
  CLKINVX1M U57 ( .A(n23), .Y(edge_cnt_flag) );
  NOR3X1M U58 ( .A(n61), .B(bit_cnt[2]), .C(n21), .Y(N48) );
  CLKINVX1M U59 ( .A(bit_cnt[3]), .Y(n21) );
  MXI2X1M U60 ( .A(n62), .B(n63), .S0(bit_cnt[0]), .Y(n61) );
  NOR2X1M U61 ( .A(bit_cnt[1]), .B(PAR_EN), .Y(n63) );
  AND2X1M U62 ( .A(bit_cnt[1]), .B(PAR_EN), .Y(n62) );
  NOR2X1M U63 ( .A(n64), .B(n52), .Y(N25) );
  XNOR2X1M U64 ( .A(edge_cnt[4]), .B(n65), .Y(n64) );
  NOR2X1M U65 ( .A(n66), .B(n67), .Y(n65) );
  CLKINVX1M U66 ( .A(edge_cnt[3]), .Y(n66) );
  NOR2X1M U67 ( .A(n68), .B(n52), .Y(N24) );
  CLKXOR2X2M U68 ( .A(n67), .B(edge_cnt[3]), .Y(n68) );
  NAND3X1M U69 ( .A(edge_cnt[2]), .B(edge_cnt[1]), .C(edge_cnt[0]), .Y(n67) );
  MXI2X1M U70 ( .A(n69), .B(n70), .S0(edge_cnt[2]), .Y(N23) );
  AOI2B1X1M U71 ( .A1N(edge_cnt[1]), .A0(n56), .B0(N21), .Y(n70) );
  NAND3X1M U72 ( .A(edge_cnt[0]), .B(edge_cnt[1]), .C(n56), .Y(n69) );
  MXI2X1M U73 ( .A(n71), .B(n72), .S0(edge_cnt[1]), .Y(N22) );
  CLKNAND2X2M U74 ( .A(n56), .B(edge_cnt[0]), .Y(n71) );
  CLKINVX1M U75 ( .A(n72), .Y(N21) );
  CLKNAND2X2M U76 ( .A(n56), .B(n17), .Y(n72) );
  CLKINVX1M U77 ( .A(n52), .Y(n56) );
  CLKNAND2X2M U78 ( .A(enable), .B(n23), .Y(n52) );
  NAND4X1M U79 ( .A(n73), .B(n74), .C(n75), .D(n76), .Y(n23) );
  AOI211X1M U80 ( .A0(n77), .A1(prescale_sampled[3]), .B0(n78), .C0(n79), .Y(
        n76) );
  CLKXOR2X2M U81 ( .A(n80), .B(edge_cnt[2]), .Y(n79) );
  CLKNAND2X2M U82 ( .A(n81), .B(n82), .Y(n80) );
  OAI21X1M U83 ( .A0(N57), .A1(prescale_sampled[1]), .B0(prescale_sampled[2]), 
        .Y(n82) );
  XOR3XLM U84 ( .A(prescale_sampled[4]), .B(edge_cnt[4]), .C(n83), .Y(n78) );
  CLKXOR2X2M U85 ( .A(n81), .B(edge_cnt[3]), .Y(n77) );
  MXI2X1M U86 ( .A(n84), .B(n85), .S0(N57), .Y(n75) );
  CLKNAND2X2M U87 ( .A(n4), .B(n17), .Y(n85) );
  CLKINVX1M U88 ( .A(edge_cnt[0]), .Y(n17) );
  NAND2BX1M U89 ( .AN(n4), .B(edge_cnt[0]), .Y(n84) );
  XNOR2X1M U90 ( .A(edge_cnt[1]), .B(prescale_sampled[1]), .Y(n4) );
  CLKXOR2X2M U91 ( .A(n86), .B(prescale_sampled[5]), .Y(n74) );
  NAND2BX1M U92 ( .AN(prescale_sampled[4]), .B(n83), .Y(n86) );
  MXI2X1M U93 ( .A(n83), .B(n87), .S0(edge_cnt[3]), .Y(n73) );
  NOR2X1M U94 ( .A(prescale_sampled[3]), .B(n88), .Y(n87) );
  CLKINVX1M U95 ( .A(n81), .Y(n88) );
  NOR2X1M U96 ( .A(n81), .B(prescale_sampled[3]), .Y(n83) );
  NAND2BX1M U97 ( .AN(N57), .B(n6), .Y(n81) );
  NOR2X1M U98 ( .A(prescale_sampled[2]), .B(prescale_sampled[1]), .Y(n6) );
endmodule


module deserializer_test_1 ( clk, rst, new_op_flag, deser_en, sampled_bit, 
        P_DATA, test_si, test_se );
  output [7:0] P_DATA;
  input clk, rst, new_op_flag, deser_en, sampled_bit, test_si, test_se;
  wire   n9, n10, n11, n12, n13, n14, n15, n20, n21, n22, n23, n24, n25, n26,
         n27, n16, n17, n18, n19;

  SDFFRX1M \P_DATA_reg[4]  ( .D(n24), .SI(P_DATA[3]), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(P_DATA[4]), .QN(n12) );
  SDFFRX1M \P_DATA_reg[1]  ( .D(n27), .SI(P_DATA[0]), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(P_DATA[1]), .QN(n15) );
  SDFFRX1M \P_DATA_reg[7]  ( .D(n21), .SI(P_DATA[6]), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(P_DATA[7]), .QN(n9) );
  SDFFRX1M \P_DATA_reg[3]  ( .D(n25), .SI(P_DATA[2]), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(P_DATA[3]), .QN(n13) );
  SDFFRX1M \P_DATA_reg[6]  ( .D(n22), .SI(P_DATA[5]), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(P_DATA[6]), .QN(n10) );
  SDFFRX1M \P_DATA_reg[2]  ( .D(n26), .SI(P_DATA[1]), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(P_DATA[2]), .QN(n14) );
  SDFFRX1M \P_DATA_reg[5]  ( .D(n23), .SI(P_DATA[4]), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(P_DATA[5]), .QN(n11) );
  SDFFRQX2M \P_DATA_reg[0]  ( .D(n20), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(P_DATA[0]) );
  OAI22X1M U11 ( .A0(n14), .A1(n16), .B0(n15), .B1(n17), .Y(n27) );
  OAI22X1M U12 ( .A0(n13), .A1(n16), .B0(n14), .B1(n17), .Y(n26) );
  OAI22X1M U13 ( .A0(n12), .A1(n16), .B0(n13), .B1(n17), .Y(n25) );
  OAI22X1M U14 ( .A0(n11), .A1(n16), .B0(n12), .B1(n17), .Y(n24) );
  OAI22X1M U15 ( .A0(n10), .A1(n16), .B0(n11), .B1(n17), .Y(n23) );
  OAI22X1M U16 ( .A0(n9), .A1(n16), .B0(n10), .B1(n17), .Y(n22) );
  OAI2BB2X1M U17 ( .B0(n9), .B1(n17), .A0N(sampled_bit), .A1N(n18), .Y(n21) );
  CLKINVX1M U18 ( .A(n19), .Y(n17) );
  OAI2BB2X1M U19 ( .B0(n15), .B1(n16), .A0N(P_DATA[0]), .A1N(n19), .Y(n20) );
  NOR2X1M U20 ( .A(n18), .B(new_op_flag), .Y(n19) );
  CLKINVX1M U21 ( .A(n16), .Y(n18) );
  NAND2BX1M U22 ( .AN(new_op_flag), .B(deser_en), .Y(n16) );
endmodule


module data_sampling_test_1 ( clk, rst, prescale, edge_cnt, dat_sample_en, 
        RX_IN, sampled_bit, test_si, test_so, test_se );
  input [5:0] prescale;
  input [4:0] edge_cnt;
  input clk, rst, dat_sample_en, RX_IN, test_si, test_se;
  output sampled_bit, test_so;
  wire   s3, s2, s1, n21, n22, n23, n1, n2, n3, n4, n5, n6, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42;
  assign test_so = s3;

  SDFFRQX2M s3_reg ( .D(n22), .SI(s2), .SE(test_se), .CK(clk), .RN(rst), .Q(s3) );
  SDFFRQX2M s2_reg ( .D(n23), .SI(s1), .SE(test_se), .CK(clk), .RN(rst), .Q(s2) );
  SDFFRQX2M s1_reg ( .D(n21), .SI(test_si), .SE(test_se), .CK(clk), .RN(rst), 
        .Q(s1) );
  OAI21X1M U6 ( .A0(n1), .A1(n2), .B0(n3), .Y(sampled_bit) );
  OAI21X1M U7 ( .A0(s1), .A1(s2), .B0(s3), .Y(n3) );
  OAI22X1M U8 ( .A0(n4), .A1(n5), .B0(n6), .B1(n2), .Y(n23) );
  CLKINVX1M U9 ( .A(s2), .Y(n2) );
  NOR2X1M U10 ( .A(n4), .B(n10), .Y(n6) );
  NAND4X1M U11 ( .A(n11), .B(n12), .C(n13), .D(n14), .Y(n4) );
  CLKXOR2X2M U12 ( .A(prescale[1]), .B(n15), .Y(n14) );
  NOR2X1M U13 ( .A(n16), .B(n17), .Y(n13) );
  CLKXOR2X2M U14 ( .A(n18), .B(edge_cnt[2]), .Y(n16) );
  OAI21X1M U15 ( .A0(n19), .A1(n20), .B0(n24), .Y(n18) );
  XNOR2X1M U16 ( .A(n24), .B(n25), .Y(n12) );
  XOR3XLM U17 ( .A(prescale[5]), .B(edge_cnt[4]), .C(n26), .Y(n11) );
  OR2X1M U18 ( .A(n24), .B(prescale[4]), .Y(n26) );
  CLKNAND2X2M U19 ( .A(n19), .B(n20), .Y(n24) );
  CLKINVX1M U20 ( .A(prescale[3]), .Y(n20) );
  NOR2X1M U21 ( .A(prescale[2]), .B(prescale[1]), .Y(n19) );
  OAI2B2X1M U22 ( .A1N(s3), .A0(n27), .B0(n5), .B1(n28), .Y(n22) );
  NOR2X1M U23 ( .A(n10), .B(n28), .Y(n27) );
  NAND4BX1M U24 ( .AN(n17), .B(n29), .C(n30), .D(n31), .Y(n28) );
  NOR2X1M U25 ( .A(n32), .B(n33), .Y(n31) );
  XOR3XLM U26 ( .A(prescale[3]), .B(edge_cnt[2]), .C(n34), .Y(n33) );
  NOR2BX1M U27 ( .AN(prescale[2]), .B(n35), .Y(n34) );
  XOR3XLM U28 ( .A(prescale[5]), .B(edge_cnt[4]), .C(n36), .Y(n32) );
  NOR2BX1M U29 ( .AN(prescale[4]), .B(n37), .Y(n36) );
  CLKXOR2X2M U30 ( .A(n15), .B(n35), .Y(n30) );
  XNOR2X1M U31 ( .A(n37), .B(n25), .Y(n29) );
  NAND3X1M U32 ( .A(prescale[1]), .B(prescale[3]), .C(prescale[2]), .Y(n37) );
  OAI22X1M U33 ( .A0(n5), .A1(n38), .B0(n39), .B1(n1), .Y(n21) );
  CLKINVX1M U34 ( .A(s1), .Y(n1) );
  NOR2X1M U35 ( .A(n10), .B(n38), .Y(n39) );
  CLKINVX1M U36 ( .A(dat_sample_en), .Y(n10) );
  NAND4BX1M U37 ( .AN(n15), .B(n25), .C(n17), .D(n40), .Y(n38) );
  NOR2X1M U38 ( .A(n41), .B(n42), .Y(n40) );
  CLKXOR2X2M U39 ( .A(prescale[5]), .B(edge_cnt[4]), .Y(n42) );
  CLKXOR2X2M U40 ( .A(prescale[3]), .B(edge_cnt[2]), .Y(n41) );
  CLKXOR2X2M U41 ( .A(n35), .B(edge_cnt[0]), .Y(n17) );
  CLKINVX1M U42 ( .A(prescale[1]), .Y(n35) );
  XNOR2X1M U43 ( .A(prescale[4]), .B(edge_cnt[3]), .Y(n25) );
  CLKXOR2X2M U44 ( .A(prescale[2]), .B(edge_cnt[1]), .Y(n15) );
  CLKNAND2X2M U45 ( .A(RX_IN), .B(dat_sample_en), .Y(n5) );
endmodule


module parity_check ( parity_chk_en, PAR_TYP, sampled_bit, P_DATA, par_err );
  input [7:0] P_DATA;
  input parity_chk_en, PAR_TYP, sampled_bit;
  output par_err;
  wire   n1, n2, n3, n4, n5, n6;

  NOR2BX1M U3 ( .AN(parity_chk_en), .B(n1), .Y(par_err) );
  XOR3XLM U4 ( .A(n2), .B(n3), .C(n4), .Y(n1) );
  XNOR2X1M U5 ( .A(P_DATA[1]), .B(P_DATA[0]), .Y(n4) );
  XOR3XLM U6 ( .A(P_DATA[6]), .B(P_DATA[5]), .C(n5), .Y(n3) );
  XNOR2X1M U7 ( .A(sampled_bit), .B(P_DATA[7]), .Y(n5) );
  XOR3XLM U8 ( .A(P_DATA[2]), .B(PAR_TYP), .C(n6), .Y(n2) );
  XNOR2X1M U9 ( .A(P_DATA[4]), .B(P_DATA[3]), .Y(n6) );
endmodule


module strt_check ( strt_chk_en, strt_glitch, sampled_bit );
  input strt_chk_en, sampled_bit;
  output strt_glitch;


  AND2X1M U2 ( .A(strt_chk_en), .B(sampled_bit), .Y(strt_glitch) );
endmodule


module stop_check ( stp_chk_en, stp_err, sampled_bit );
  input stp_chk_en, sampled_bit;
  output stp_err;


  NOR2BX1M U2 ( .AN(stp_chk_en), .B(sampled_bit), .Y(stp_err) );
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
         n17, n1, n2, n4;
  wire   [3:0] bit_cnt;
  wire   [4:0] edge_cnt;
  wire   [7:0] P_DATA;

  SDFFRQX2M \P_DATA_reg_reg[7]  ( .D(n17), .SI(P_DATA_reg[6]), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(P_DATA_reg[7]) );
  SDFFRQX2M \P_DATA_reg_reg[6]  ( .D(n15), .SI(P_DATA_reg[5]), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(P_DATA_reg[6]) );
  SDFFRQX2M \P_DATA_reg_reg[5]  ( .D(n13), .SI(P_DATA_reg[4]), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(P_DATA_reg[5]) );
  SDFFRQX2M \P_DATA_reg_reg[4]  ( .D(n11), .SI(P_DATA_reg[3]), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(P_DATA_reg[4]) );
  SDFFRQX2M \P_DATA_reg_reg[3]  ( .D(n9), .SI(P_DATA_reg[2]), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(P_DATA_reg[3]) );
  SDFFRQX2M \P_DATA_reg_reg[2]  ( .D(n7), .SI(P_DATA_reg[1]), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(P_DATA_reg[2]) );
  SDFFRQX2M \P_DATA_reg_reg[1]  ( .D(n5), .SI(P_DATA_reg[0]), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(P_DATA_reg[1]) );
  SDFFRQX2M \P_DATA_reg_reg[0]  ( .D(n3), .SI(test_si1), .SE(test_se), .CK(clk), .RN(rst), .Q(P_DATA_reg[0]) );
  SDFFRQX2M stp_error_reg_reg ( .D(stp_error), .SI(test_si2), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(stp_error_reg) );
  SDFFRQX2M par_err_reg_reg ( .D(par_err), .SI(n1), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(par_err_reg) );
  SDFFRQX2M data_valid_reg_reg ( .D(data_valid), .SI(P_DATA_reg[7]), .SE(
        test_se), .CK(clk), .RN(rst), .Q(data_valid_reg) );
  CLKMX2X2M U3 ( .A(P_DATA_reg[3]), .B(P_DATA[3]), .S0(data_valid), .Y(n9) );
  CLKMX2X2M U4 ( .A(P_DATA_reg[2]), .B(P_DATA[2]), .S0(data_valid), .Y(n7) );
  CLKMX2X2M U5 ( .A(P_DATA_reg[1]), .B(P_DATA[1]), .S0(data_valid), .Y(n5) );
  CLKMX2X2M U6 ( .A(P_DATA_reg[0]), .B(P_DATA[0]), .S0(data_valid), .Y(n3) );
  CLKMX2X2M U7 ( .A(P_DATA_reg[7]), .B(P_DATA[7]), .S0(data_valid), .Y(n17) );
  CLKMX2X2M U8 ( .A(P_DATA_reg[6]), .B(P_DATA[6]), .S0(data_valid), .Y(n15) );
  CLKMX2X2M U9 ( .A(P_DATA_reg[5]), .B(P_DATA[5]), .S0(data_valid), .Y(n13) );
  CLKMX2X2M U10 ( .A(P_DATA_reg[4]), .B(P_DATA[4]), .S0(data_valid), .Y(n11)
         );
  FSM_test_1 fsm ( .clk(clk), .rst(rst), .system_outputs_flag(
        system_outputs_flag), .edge_cnt_flag(edge_cnt_flag), .RX_IN(RX_IN), 
        .PAR_EN(PAR_EN), .bit_cnt(bit_cnt), .par_err(par_err), .strt_glitch(
        strt_glitch), .stp_error(stp_error), .enable(enable), .dat_sample_en(
        dat_sample_en), .deser_en(deser_en), .data_valid(data_valid), 
        .par_chk_en(par_chk_en), .strt_chk_en(strt_chk_en), .stp_chk_en(
        stp_chk_en), .new_op_flag(new_op_flag), .test_si(n2), .test_so(n1), 
        .test_se(test_se) );
  edge_bit_counter_test_1 edg_cnt ( .clk(clk), .rst(rst), .PAR_EN(PAR_EN), 
        .enable(enable), .prescale(prescale), .edge_cnt(edge_cnt), .bit_cnt(
        bit_cnt), .edge_cnt_flag(edge_cnt_flag), .system_outputs_flag(
        system_outputs_flag), .test_si(n4), .test_so(n2), .test_se(test_se) );
  deserializer_test_1 deser ( .clk(clk), .rst(rst), .new_op_flag(new_op_flag), 
        .deser_en(deser_en), .sampled_bit(sampled_bit), .P_DATA(P_DATA), 
        .test_si(data_valid_reg), .test_se(test_se) );
  data_sampling_test_1 ds ( .clk(clk), .rst(rst), .prescale(prescale), 
        .edge_cnt(edge_cnt), .dat_sample_en(dat_sample_en), .RX_IN(RX_IN), 
        .sampled_bit(sampled_bit), .test_si(P_DATA[7]), .test_so(n4), 
        .test_se(test_se) );
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
  wire   N43, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13;
  wire   [2:0] cs;
  wire   [2:0] ns;
  assign test_so = cs[2];
  assign Mux_sel[2] = N43;

  SDFFRQX2M \cs_reg[0]  ( .D(n13), .SI(test_si), .SE(test_se), .CK(clk), .RN(
        rst), .Q(cs[0]) );
  SDFFRQX2M \cs_reg[1]  ( .D(ns[1]), .SI(cs[0]), .SE(test_se), .CK(clk), .RN(
        rst), .Q(cs[1]) );
  SDFFRQX2M \cs_reg[2]  ( .D(ns[2]), .SI(cs[1]), .SE(test_se), .CK(clk), .RN(
        rst), .Q(cs[2]) );
  AOI2B1X1M U6 ( .A1N(n4), .A0(n5), .B0(n6), .Y(ns[2]) );
  OAI21X1M U7 ( .A0(n4), .A1(n7), .B0(n8), .Y(ns[1]) );
  NOR2BX1M U8 ( .AN(Ser_Done), .B(PAR_EN), .Y(n4) );
  CLKINVX1M U9 ( .A(n9), .Y(n13) );
  AOI32X1M U10 ( .A0(n10), .A1(Ser_Done), .A2(PAR_EN), .B0(Data_Valid), .B1(
        N43), .Y(n9) );
  CLKINVX1M U11 ( .A(n7), .Y(n10) );
  OAI211X1M U12 ( .A0(cs[2]), .A1(n5), .B0(n11), .C0(n6), .Y(busy) );
  CLKNAND2X2M U13 ( .A(n8), .B(n7), .Y(Ser_En) );
  CLKNAND2X2M U14 ( .A(Mux_sel[1]), .B(n5), .Y(n7) );
  OR3X1M U15 ( .A(cs[2]), .B(cs[1]), .C(n5), .Y(n8) );
  NOR3X1M U16 ( .A(cs[1]), .B(cs[2]), .C(cs[0]), .Y(N43) );
  OAI21X1M U17 ( .A0(n6), .A1(n5), .B0(n11), .Y(Mux_sel[0]) );
  NAND3X1M U18 ( .A(n5), .B(n12), .C(cs[2]), .Y(n11) );
  CLKINVX1M U19 ( .A(cs[0]), .Y(n5) );
  CLKINVX1M U20 ( .A(Mux_sel[1]), .Y(n6) );
  NOR2X1M U21 ( .A(n12), .B(cs[2]), .Y(Mux_sel[1]) );
  CLKINVX1M U22 ( .A(cs[1]), .Y(n12) );
endmodule


module Serializer_test_1 ( P_Data, Data_Valid, Ser_En, clk, rst, Ser_Done, 
        Ser_Data, busy, test_si, test_se );
  input [7:0] P_Data;
  input Data_Valid, Ser_En, clk, rst, busy, test_si, test_se;
  output Ser_Done, Ser_Data;
  wire   n17, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n14, n15, n16, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n51, n52, n53, n54, n55,
         n56;
  wire   [7:0] LSR;
  wire   [2:0] Counter;

  SDFFRX1M Ser_Done_reg ( .D(n48), .SI(Ser_Data), .SE(test_se), .CK(clk), .RN(
        rst), .Q(Ser_Done), .QN(n17) );
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
  SDFFRQX2M \LSR_reg[1]  ( .D(n46), .SI(n56), .SE(test_se), .CK(clk), .RN(rst), 
        .Q(LSR[1]) );
  SDFFRX1M \LSR_reg[0]  ( .D(n47), .SI(Counter[2]), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(n56), .QN(n14) );
  SDFFRQX2M Ser_Data_reg ( .D(n39), .SI(LSR[7]), .SE(test_se), .CK(clk), .RN(
        rst), .Q(Ser_Data) );
  SDFFRQX2M \Counter_reg[2]  ( .D(n49), .SI(Counter[1]), .SE(test_se), .CK(clk), .RN(rst), .Q(Counter[2]) );
  SDFFRQX2M \Counter_reg[1]  ( .D(n38), .SI(Counter[0]), .SE(test_se), .CK(clk), .RN(rst), .Q(Counter[1]) );
  SDFFRQX2M \Counter_reg[0]  ( .D(n50), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(Counter[0]) );
  MXI2X1M U16 ( .A(n15), .B(n16), .S0(Counter[0]), .Y(n50) );
  MXI2X1M U17 ( .A(n18), .B(n19), .S0(Counter[2]), .Y(n49) );
  AOI2BB1X1M U18 ( .A0N(n20), .A1N(Counter[1]), .B0(n21), .Y(n19) );
  MXI2X1M U19 ( .A(n15), .B(n17), .S0(n22), .Y(n48) );
  AOI22X1M U20 ( .A0(n23), .A1(Counter[2]), .B0(n20), .B1(n16), .Y(n22) );
  CLKINVX1M U21 ( .A(n18), .Y(n23) );
  NAND3X1M U22 ( .A(n24), .B(Counter[0]), .C(Counter[1]), .Y(n18) );
  OAI221X1M U23 ( .A0(n25), .A1(n14), .B0(n15), .B1(n26), .C0(n27), .Y(n47) );
  CLKNAND2X2M U24 ( .A(P_Data[0]), .B(n28), .Y(n27) );
  OAI221X1M U25 ( .A0(n25), .A1(n26), .B0(n15), .B1(n29), .C0(n30), .Y(n46) );
  CLKNAND2X2M U26 ( .A(P_Data[1]), .B(n28), .Y(n30) );
  CLKINVX1M U27 ( .A(LSR[1]), .Y(n26) );
  OAI221X1M U28 ( .A0(n25), .A1(n29), .B0(n15), .B1(n31), .C0(n32), .Y(n45) );
  CLKNAND2X2M U29 ( .A(P_Data[2]), .B(n28), .Y(n32) );
  CLKINVX1M U30 ( .A(LSR[2]), .Y(n29) );
  OAI221X1M U31 ( .A0(n25), .A1(n31), .B0(n15), .B1(n33), .C0(n34), .Y(n44) );
  CLKNAND2X2M U32 ( .A(P_Data[3]), .B(n28), .Y(n34) );
  CLKINVX1M U33 ( .A(LSR[3]), .Y(n31) );
  OAI221X1M U34 ( .A0(n25), .A1(n33), .B0(n15), .B1(n35), .C0(n36), .Y(n43) );
  CLKNAND2X2M U35 ( .A(P_Data[4]), .B(n28), .Y(n36) );
  CLKINVX1M U36 ( .A(LSR[4]), .Y(n33) );
  OAI221X1M U37 ( .A0(n25), .A1(n35), .B0(n15), .B1(n37), .C0(n51), .Y(n42) );
  CLKNAND2X2M U38 ( .A(P_Data[5]), .B(n28), .Y(n51) );
  CLKINVX1M U39 ( .A(LSR[5]), .Y(n35) );
  OAI221X1M U40 ( .A0(n25), .A1(n37), .B0(n15), .B1(n52), .C0(n53), .Y(n41) );
  CLKNAND2X2M U41 ( .A(P_Data[6]), .B(n28), .Y(n53) );
  CLKINVX1M U42 ( .A(LSR[6]), .Y(n37) );
  OAI2BB2X1M U43 ( .B0(n25), .B1(n52), .A0N(P_Data[7]), .A1N(n28), .Y(n40) );
  CLKINVX1M U44 ( .A(LSR[7]), .Y(n52) );
  CLKNAND2X2M U45 ( .A(n16), .B(n15), .Y(n25) );
  CLKMX2X2M U46 ( .A(n56), .B(Ser_Data), .S0(n15), .Y(n39) );
  CLKINVX1M U47 ( .A(n24), .Y(n15) );
  MXI2X1M U48 ( .A(n54), .B(n55), .S0(Counter[1]), .Y(n38) );
  CLKINVX1M U49 ( .A(n21), .Y(n55) );
  OAI21X1M U50 ( .A0(Counter[0]), .A1(n20), .B0(n16), .Y(n21) );
  CLKINVX1M U51 ( .A(n28), .Y(n16) );
  CLKNAND2X2M U52 ( .A(n24), .B(Counter[0]), .Y(n54) );
  NOR2X1M U53 ( .A(n20), .B(n28), .Y(n24) );
  NOR2BX1M U54 ( .AN(Data_Valid), .B(busy), .Y(n28) );
  CLKNAND2X2M U55 ( .A(n17), .B(Ser_En), .Y(n20) );
endmodule


module Parity_Calc_test_1 ( P_DATA, Data_Valid, Par_Type, Par_En, Par_bit, clk, 
        rst, busy, test_si, test_se );
  input [7:0] P_DATA;
  input Data_Valid, Par_Type, Par_En, clk, rst, busy, test_si, test_se;
  output Par_bit;
  wire   n10, n2, n3, n4, n5, n6, n7, n8;

  SDFFRQX2M Par_bit_reg ( .D(n10), .SI(test_si), .SE(test_se), .CK(clk), .RN(
        rst), .Q(Par_bit) );
  NOR2BX1M U4 ( .AN(Par_En), .B(n2), .Y(n10) );
  MXI2X1M U5 ( .A(Par_bit), .B(n3), .S0(n4), .Y(n2) );
  NOR2BX1M U6 ( .AN(Data_Valid), .B(busy), .Y(n4) );
  XOR3XLM U7 ( .A(Par_Type), .B(n5), .C(n6), .Y(n3) );
  XOR3XLM U8 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n7), .Y(n6) );
  XNOR2X1M U9 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n7) );
  XOR3XLM U10 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n8), .Y(n5) );
  XNOR2X1M U11 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n8) );
endmodule


module UART_Mux ( Mux_Sel, Start_Bit, Stop_Bit, ser_data, Par_Bit, No_Trans, 
        TX_OUT );
  input [2:0] Mux_Sel;
  input Start_Bit, Stop_Bit, ser_data, Par_Bit, No_Trans;
  output TX_OUT;
  wire   n1, n2, n3;

  MXI2X1M U2 ( .A(n1), .B(n2), .S0(Mux_Sel[2]), .Y(TX_OUT) );
  NAND3BX1M U3 ( .AN(Mux_Sel[0]), .B(No_Trans), .C(n3), .Y(n2) );
  CLKINVX1M U4 ( .A(Mux_Sel[1]), .Y(n3) );
  MXI4X1M U5 ( .A(Start_Bit), .B(ser_data), .C(Stop_Bit), .D(Par_Bit), .S0(
        Mux_Sel[1]), .S1(Mux_Sel[0]), .Y(n1) );
endmodule


module UART_TX_test_1 ( P_DATA, Data_Valid, PAR_TYP, PAR_EN, TX_OUT, busy, clk, 
        rst, test_si, test_so, test_se );
  input [7:0] P_DATA;
  input Data_Valid, PAR_TYP, PAR_EN, clk, rst, test_si, test_se;
  output TX_OUT, busy, test_so;
  wire   Ser_Done, Ser_En, Ser_Data, Par_bit, n1;
  wire   [2:0] Mux_sel;
  assign test_so = Ser_Done;

  Controller_TX_test_1 Controller_TX ( .Data_Valid(Data_Valid), .PAR_EN(PAR_EN), .Ser_Done(Ser_Done), .Mux_sel(Mux_sel), .Ser_En(Ser_En), .busy(busy), .clk(
        clk), .rst(rst), .test_si(test_si), .test_so(n1), .test_se(test_se) );
  Serializer_test_1 Serializer ( .P_Data(P_DATA), .Data_Valid(Data_Valid), 
        .Ser_En(Ser_En), .clk(clk), .rst(rst), .Ser_Done(Ser_Done), .Ser_Data(
        Ser_Data), .busy(busy), .test_si(Par_bit), .test_se(test_se) );
  Parity_Calc_test_1 Parity_Calc ( .P_DATA(P_DATA), .Data_Valid(Data_Valid), 
        .Par_Type(PAR_TYP), .Par_En(PAR_EN), .Par_bit(Par_bit), .clk(clk), 
        .rst(rst), .busy(busy), .test_si(n1), .test_se(test_se) );
  UART_Mux mux ( .Mux_Sel(Mux_sel), .Start_Bit(1'b0), .Stop_Bit(1'b1), 
        .ser_data(Ser_Data), .Par_Bit(Par_bit), .No_Trans(1'b1), .TX_OUT(
        TX_OUT) );
endmodule


module RST_SYNC_test_1 ( RST, CLK, SYNC_RST, test_si, test_se );
  input RST, CLK, test_si, test_se;
  output SYNC_RST;

  wire   [1:0] stages;

  SDFFRQX2M \stages_reg[2]  ( .D(stages[1]), .SI(stages[1]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(SYNC_RST) );
  SDFFRQX2M \stages_reg[0]  ( .D(1'b1), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(stages[0]) );
  SDFFRQX2M \stages_reg[1]  ( .D(stages[0]), .SI(stages[0]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(stages[1]) );
endmodule


module RST_SYNC_test_0 ( RST, CLK, SYNC_RST, test_si, test_se );
  input RST, CLK, test_si, test_se;
  output SYNC_RST;

  wire   [1:0] stages;

  SDFFRQX2M \stages_reg[2]  ( .D(stages[1]), .SI(stages[1]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(SYNC_RST) );
  SDFFRQX2M \stages_reg[0]  ( .D(1'b1), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(stages[0]) );
  SDFFRQX2M \stages_reg[1]  ( .D(stages[0]), .SI(stages[0]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(stages[1]) );
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
  NOR2BX1M U4 ( .AN(in), .B(q), .Y(out) );
endmodule


module DATA_SYNC_test_1 ( unsync_bus, bus_enable, clk, rst, sync_bus, 
        enable_pulse, test_si, test_se );
  input [7:0] unsync_bus;
  output [7:0] sync_bus;
  input bus_enable, clk, rst, test_si, test_se;
  output enable_pulse;
  wire   internal_enable, internal_out_of_synchronizer, n3, n5, n7, n9, n11,
         n13, n15, n17, n1;

  SDFFRQX2M \sync_bus_reg[7]  ( .D(n17), .SI(sync_bus[6]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_bus[7]) );
  SDFFRQX2M \sync_bus_reg[5]  ( .D(n13), .SI(sync_bus[4]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_bus[5]) );
  SDFFRQX2M \sync_bus_reg[3]  ( .D(n9), .SI(sync_bus[2]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_bus[3]) );
  SDFFRQX2M \sync_bus_reg[1]  ( .D(n5), .SI(sync_bus[0]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_bus[1]) );
  SDFFRQX2M \sync_bus_reg[6]  ( .D(n15), .SI(sync_bus[5]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_bus[6]) );
  SDFFRQX2M \sync_bus_reg[2]  ( .D(n7), .SI(sync_bus[1]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_bus[2]) );
  SDFFRQX2M \sync_bus_reg[4]  ( .D(n11), .SI(sync_bus[3]), .SE(test_se), .CK(
        clk), .RN(rst), .Q(sync_bus[4]) );
  SDFFRQX2M \sync_bus_reg[0]  ( .D(n3), .SI(internal_out_of_synchronizer), 
        .SE(test_se), .CK(clk), .RN(rst), .Q(sync_bus[0]) );
  SDFFRQX2M enable_pulse_reg ( .D(internal_enable), .SI(n1), .SE(test_se), 
        .CK(clk), .RN(rst), .Q(enable_pulse) );
  CLKMX2X2M U3 ( .A(sync_bus[3]), .B(unsync_bus[3]), .S0(internal_enable), .Y(
        n9) );
  CLKMX2X2M U4 ( .A(sync_bus[2]), .B(unsync_bus[2]), .S0(internal_enable), .Y(
        n7) );
  CLKMX2X2M U5 ( .A(sync_bus[1]), .B(unsync_bus[1]), .S0(internal_enable), .Y(
        n5) );
  CLKMX2X2M U6 ( .A(sync_bus[0]), .B(unsync_bus[0]), .S0(internal_enable), .Y(
        n3) );
  CLKMX2X2M U7 ( .A(sync_bus[7]), .B(unsync_bus[7]), .S0(internal_enable), .Y(
        n17) );
  CLKMX2X2M U8 ( .A(sync_bus[6]), .B(unsync_bus[6]), .S0(internal_enable), .Y(
        n15) );
  CLKMX2X2M U9 ( .A(sync_bus[5]), .B(unsync_bus[5]), .S0(internal_enable), .Y(
        n13) );
  CLKMX2X2M U10 ( .A(sync_bus[4]), .B(unsync_bus[4]), .S0(internal_enable), 
        .Y(n11) );
  BIT_SYNC_N2_test_0 sync ( .clk(clk), .rst(rst), .IN(bus_enable), .OUT(
        internal_out_of_synchronizer), .test_si(enable_pulse), .test_se(
        test_se) );
  Pulse_Gen_test_0 Pulse_Gen1 ( .clk(clk), .rst(rst), .in(
        internal_out_of_synchronizer), .out(internal_enable), .test_si(test_si), .test_so(n1), .test_se(test_se) );
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
  wire   n122, n76, n78, n80, n82, n84, n86, n88, n90, n92, n94, n96, n98,
         n100, n102, n104, n106, n113, n114, n115, n116, n2, n3, n4, n5, n6,
         n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n123, n124, n125, n126;
  wire   [3:0] cs;
  wire   [3:0] ns;
  wire   [15:0] ALU_OUT_temp;
  assign clk_div_en = 1'b1;
  assign test_so = cs[3];

  SDFFRX1M \Address_temp_out_reg[3]  ( .D(n116), .SI(n124), .SE(test_se), .CK(
        CLK), .RN(n2), .Q(n123), .QN(n68) );
  SDFFRX1M \Address_temp_out_reg[2]  ( .D(n115), .SI(n125), .SE(test_se), .CK(
        CLK), .RN(n2), .Q(n124), .QN(n67) );
  SDFFRX1M \Address_temp_out_reg[1]  ( .D(n114), .SI(n126), .SE(test_se), .CK(
        CLK), .RN(n2), .Q(n125), .QN(n66) );
  SDFFRX1M \Address_temp_out_reg[0]  ( .D(n113), .SI(ALU_OUT_temp[15]), .SE(
        test_se), .CK(CLK), .RN(n2), .Q(n126), .QN(n65) );
  SDFFRQX2M \ALU_OUT_temp_reg[15]  ( .D(n106), .SI(ALU_OUT_temp[14]), .SE(
        test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[15]) );
  SDFFRQX2M \ALU_OUT_temp_reg[14]  ( .D(n104), .SI(ALU_OUT_temp[13]), .SE(
        test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[14]) );
  SDFFRQX2M \ALU_OUT_temp_reg[13]  ( .D(n102), .SI(ALU_OUT_temp[12]), .SE(
        test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[13]) );
  SDFFRQX2M \ALU_OUT_temp_reg[12]  ( .D(n100), .SI(ALU_OUT_temp[11]), .SE(
        test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[12]) );
  SDFFRQX2M \ALU_OUT_temp_reg[11]  ( .D(n98), .SI(ALU_OUT_temp[10]), .SE(
        test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[11]) );
  SDFFRQX2M \ALU_OUT_temp_reg[10]  ( .D(n96), .SI(ALU_OUT_temp[9]), .SE(
        test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[10]) );
  SDFFRQX2M \ALU_OUT_temp_reg[9]  ( .D(n94), .SI(ALU_OUT_temp[8]), .SE(test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[9]) );
  SDFFRQX2M \ALU_OUT_temp_reg[8]  ( .D(n92), .SI(ALU_OUT_temp[7]), .SE(test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[8]) );
  SDFFRQX2M \ALU_OUT_temp_reg[7]  ( .D(n90), .SI(ALU_OUT_temp[6]), .SE(test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[7]) );
  SDFFRQX2M \ALU_OUT_temp_reg[6]  ( .D(n88), .SI(ALU_OUT_temp[5]), .SE(test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[6]) );
  SDFFRQX2M \ALU_OUT_temp_reg[5]  ( .D(n86), .SI(ALU_OUT_temp[4]), .SE(test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[5]) );
  SDFFRQX2M \ALU_OUT_temp_reg[4]  ( .D(n84), .SI(ALU_OUT_temp[3]), .SE(test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[4]) );
  SDFFRQX2M \ALU_OUT_temp_reg[3]  ( .D(n82), .SI(ALU_OUT_temp[2]), .SE(test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[3]) );
  SDFFRQX2M \ALU_OUT_temp_reg[2]  ( .D(n80), .SI(ALU_OUT_temp[1]), .SE(test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[2]) );
  SDFFRQX2M \ALU_OUT_temp_reg[1]  ( .D(n78), .SI(ALU_OUT_temp[0]), .SE(test_se), .CK(CLK), .RN(n2), .Q(ALU_OUT_temp[1]) );
  SDFFRQX2M \ALU_OUT_temp_reg[0]  ( .D(n76), .SI(test_si), .SE(test_se), .CK(
        CLK), .RN(n2), .Q(ALU_OUT_temp[0]) );
  SDFFRQX2M \cs_reg[2]  ( .D(ns[2]), .SI(cs[1]), .SE(test_se), .CK(CLK), .RN(
        n2), .Q(cs[2]) );
  SDFFRQX2M \cs_reg[1]  ( .D(ns[1]), .SI(cs[0]), .SE(test_se), .CK(CLK), .RN(
        n2), .Q(cs[1]) );
  SDFFRQX2M \cs_reg[0]  ( .D(ns[0]), .SI(n123), .SE(test_se), .CK(CLK), .RN(n2), .Q(cs[0]) );
  SDFFRQX2M \cs_reg[3]  ( .D(ns[3]), .SI(cs[2]), .SE(test_se), .CK(CLK), .RN(
        n2), .Q(cs[3]) );
  OAI22X4M U3 ( .A0(n44), .A1(n63), .B0(n68), .B1(n26), .Y(Address[3]) );
  OAI22X4M U4 ( .A0(n40), .A1(n63), .B0(n66), .B1(n26), .Y(Address[1]) );
  BUFX4M U5 ( .A(n122), .Y(Address[0]) );
  INVX2M U6 ( .A(n3), .Y(n2) );
  INVX2M U7 ( .A(RST), .Y(n3) );
  OAI222X1M U8 ( .A0(n4), .A1(n5), .B0(n6), .B1(n7), .C0(n8), .C1(n9), .Y(
        ns[3]) );
  AOI21X1M U9 ( .A0(wfull), .A1(n10), .B0(n11), .Y(n6) );
  OAI211X1M U10 ( .A0(OUT_Valid), .A1(n8), .B0(n12), .C0(n13), .Y(ns[2]) );
  AOI221XLM U11 ( .A0(RdData_Valid), .A1(n14), .B0(n15), .B1(wfull), .C0(n16), 
        .Y(n13) );
  NOR4X1M U12 ( .A(RX_P_Data[4]), .B(RX_P_Data[0]), .C(n17), .D(n4), .Y(n16)
         );
  OAI211X1M U13 ( .A0(OUT_Valid), .A1(n18), .B0(n19), .C0(n20), .Y(ns[1]) );
  AOI221XLM U14 ( .A0(n14), .A1(n21), .B0(n22), .B1(n23), .C0(n24), .Y(n20) );
  CLKINVX1M U15 ( .A(RdData_Valid), .Y(n21) );
  CLKMX2X2M U16 ( .A(n25), .B(n26), .S0(n27), .Y(n19) );
  CLKINVX1M U17 ( .A(CLK_GATING_EN), .Y(n18) );
  OAI2B11X1M U18 ( .A1N(n14), .A0(RdData_Valid), .B0(n28), .C0(n29), .Y(ns[0])
         );
  AOI211X1M U19 ( .A0(n30), .A1(n9), .B0(n31), .C0(n32), .Y(n29) );
  MXI2X1M U20 ( .A(n33), .B(n34), .S0(wfull), .Y(n32) );
  MXI2X1M U21 ( .A(n25), .B(n35), .S0(RX_D_VLD), .Y(n31) );
  CLKINVX1M U22 ( .A(n36), .Y(n25) );
  CLKINVX1M U23 ( .A(OUT_Valid), .Y(n9) );
  CLKINVX1M U24 ( .A(n8), .Y(n30) );
  AOI32X1M U25 ( .A0(n37), .A1(n23), .A2(n38), .B0(n39), .B1(n22), .Y(n28) );
  CLKINVX1M U26 ( .A(n5), .Y(n22) );
  NAND3X1M U27 ( .A(RX_P_Data[0]), .B(n37), .C(RX_P_Data[4]), .Y(n5) );
  NOR2X1M U28 ( .A(RX_P_Data[4]), .B(RX_P_Data[0]), .Y(n38) );
  NAND2BX1M U29 ( .AN(n39), .B(n4), .Y(n23) );
  NAND4X1M U30 ( .A(RX_P_Data[6]), .B(RX_P_Data[2]), .C(n40), .D(n41), .Y(n4)
         );
  NOR4X1M U31 ( .A(n41), .B(n40), .C(RX_P_Data[2]), .D(RX_P_Data[6]), .Y(n39)
         );
  CLKINVX1M U32 ( .A(n17), .Y(n37) );
  NAND4X1M U33 ( .A(n42), .B(n10), .C(RX_D_VLD), .D(n43), .Y(n17) );
  NOR2X1M U34 ( .A(n44), .B(n45), .Y(n43) );
  OAI2B1X1M U35 ( .A1N(ALU_OUT_temp[15]), .A0(n34), .B0(n46), .Y(TX_P_Data[7])
         );
  AOI22X1M U36 ( .A0(RdData[7]), .A1(n15), .B0(ALU_OUT_temp[7]), .B1(n47), .Y(
        n46) );
  OAI2B1X1M U37 ( .A1N(ALU_OUT_temp[14]), .A0(n34), .B0(n48), .Y(TX_P_Data[6])
         );
  AOI22X1M U38 ( .A0(RdData[6]), .A1(n15), .B0(ALU_OUT_temp[6]), .B1(n47), .Y(
        n48) );
  OAI2B1X1M U39 ( .A1N(ALU_OUT_temp[13]), .A0(n34), .B0(n49), .Y(TX_P_Data[5])
         );
  AOI22X1M U40 ( .A0(RdData[5]), .A1(n15), .B0(ALU_OUT_temp[5]), .B1(n47), .Y(
        n49) );
  OAI2B1X1M U41 ( .A1N(ALU_OUT_temp[12]), .A0(n34), .B0(n50), .Y(TX_P_Data[4])
         );
  AOI22X1M U42 ( .A0(RdData[4]), .A1(n15), .B0(ALU_OUT_temp[4]), .B1(n47), .Y(
        n50) );
  OAI2B1X1M U43 ( .A1N(ALU_OUT_temp[11]), .A0(n34), .B0(n51), .Y(TX_P_Data[3])
         );
  AOI22X1M U44 ( .A0(RdData[3]), .A1(n15), .B0(ALU_OUT_temp[3]), .B1(n47), .Y(
        n51) );
  OAI2B1X1M U45 ( .A1N(ALU_OUT_temp[10]), .A0(n34), .B0(n52), .Y(TX_P_Data[2])
         );
  AOI22X1M U46 ( .A0(RdData[2]), .A1(n15), .B0(ALU_OUT_temp[2]), .B1(n47), .Y(
        n52) );
  OAI2B1X1M U47 ( .A1N(ALU_OUT_temp[9]), .A0(n34), .B0(n53), .Y(TX_P_Data[1])
         );
  AOI22X1M U48 ( .A0(RdData[1]), .A1(n15), .B0(ALU_OUT_temp[1]), .B1(n47), .Y(
        n53) );
  OAI2B1X1M U49 ( .A1N(ALU_OUT_temp[8]), .A0(n34), .B0(n54), .Y(TX_P_Data[0])
         );
  AOI22X1M U50 ( .A0(RdData[0]), .A1(n15), .B0(ALU_OUT_temp[0]), .B1(n47), .Y(
        n54) );
  CLKINVX1M U51 ( .A(n33), .Y(n47) );
  CLKINVX1M U52 ( .A(n55), .Y(ALU_EN) );
  CLKMX2X2M U53 ( .A(ALU_OUT_temp[11]), .B(ALU_OUT[11]), .S0(OUT_Valid), .Y(
        n98) );
  CLKMX2X2M U54 ( .A(ALU_OUT_temp[10]), .B(ALU_OUT[10]), .S0(OUT_Valid), .Y(
        n96) );
  CLKMX2X2M U55 ( .A(ALU_OUT_temp[9]), .B(ALU_OUT[9]), .S0(OUT_Valid), .Y(n94)
         );
  CLKMX2X2M U56 ( .A(ALU_OUT_temp[8]), .B(ALU_OUT[8]), .S0(OUT_Valid), .Y(n92)
         );
  CLKMX2X2M U57 ( .A(ALU_OUT_temp[7]), .B(ALU_OUT[7]), .S0(OUT_Valid), .Y(n90)
         );
  CLKMX2X2M U58 ( .A(ALU_OUT_temp[6]), .B(ALU_OUT[6]), .S0(OUT_Valid), .Y(n88)
         );
  CLKMX2X2M U59 ( .A(ALU_OUT_temp[5]), .B(ALU_OUT[5]), .S0(OUT_Valid), .Y(n86)
         );
  CLKMX2X2M U60 ( .A(ALU_OUT_temp[4]), .B(ALU_OUT[4]), .S0(OUT_Valid), .Y(n84)
         );
  CLKMX2X2M U61 ( .A(ALU_OUT_temp[3]), .B(ALU_OUT[3]), .S0(OUT_Valid), .Y(n82)
         );
  CLKMX2X2M U62 ( .A(ALU_OUT_temp[2]), .B(ALU_OUT[2]), .S0(OUT_Valid), .Y(n80)
         );
  CLKMX2X2M U63 ( .A(ALU_OUT_temp[1]), .B(ALU_OUT[1]), .S0(OUT_Valid), .Y(n78)
         );
  CLKMX2X2M U64 ( .A(ALU_OUT_temp[0]), .B(ALU_OUT[0]), .S0(OUT_Valid), .Y(n76)
         );
  MXI2X1M U65 ( .A(n68), .B(n44), .S0(n56), .Y(n116) );
  MXI2X1M U66 ( .A(n67), .B(n57), .S0(n56), .Y(n115) );
  MXI2X1M U67 ( .A(n66), .B(n40), .S0(n56), .Y(n114) );
  MXI2X1M U68 ( .A(n65), .B(n58), .S0(n56), .Y(n113) );
  NOR3BX1M U69 ( .AN(n59), .B(n27), .C(n11), .Y(n56) );
  NOR3X1M U70 ( .A(TX_D_VLD), .B(cs[2]), .C(cs[1]), .Y(n59) );
  CLKMX2X2M U71 ( .A(ALU_OUT_temp[15]), .B(ALU_OUT[15]), .S0(OUT_Valid), .Y(
        n106) );
  CLKMX2X2M U72 ( .A(ALU_OUT_temp[14]), .B(ALU_OUT[14]), .S0(OUT_Valid), .Y(
        n104) );
  CLKMX2X2M U73 ( .A(ALU_OUT_temp[13]), .B(ALU_OUT[13]), .S0(OUT_Valid), .Y(
        n102) );
  CLKMX2X2M U74 ( .A(ALU_OUT_temp[12]), .B(ALU_OUT[12]), .S0(OUT_Valid), .Y(
        n100) );
  AOI21X1M U75 ( .A0(n12), .A1(n26), .B0(n27), .Y(Wr_En) );
  NOR2X1M U76 ( .A(n60), .B(n45), .Y(Wr_Data[7]) );
  CLKINVX1M U77 ( .A(RX_P_Data[7]), .Y(n45) );
  NOR2BX1M U78 ( .AN(RX_P_Data[6]), .B(n60), .Y(Wr_Data[6]) );
  NOR2X1M U79 ( .A(n60), .B(n41), .Y(Wr_Data[5]) );
  CLKINVX1M U80 ( .A(RX_P_Data[5]), .Y(n41) );
  NOR2BX1M U81 ( .AN(RX_P_Data[4]), .B(n60), .Y(Wr_Data[4]) );
  NOR2X1M U82 ( .A(n60), .B(n44), .Y(Wr_Data[3]) );
  NOR2X1M U83 ( .A(n60), .B(n57), .Y(Wr_Data[2]) );
  NOR2X1M U84 ( .A(n60), .B(n40), .Y(Wr_Data[1]) );
  NOR2X1M U85 ( .A(n60), .B(n58), .Y(Wr_Data[0]) );
  OA21X1M U86 ( .A0(n12), .A1(n27), .B0(n26), .Y(n60) );
  AOI21X1M U87 ( .A0(cs[2]), .A1(n36), .B0(n24), .Y(n12) );
  CLKINVX1M U88 ( .A(n35), .Y(n24) );
  NOR3X1M U89 ( .A(cs[1]), .B(cs[3]), .C(n11), .Y(n36) );
  NAND3BX1M U90 ( .AN(n15), .B(n33), .C(n34), .Y(TX_D_VLD) );
  NAND3X1M U91 ( .A(cs[0]), .B(n10), .C(n61), .Y(n34) );
  NAND3X1M U92 ( .A(n11), .B(n10), .C(n61), .Y(n33) );
  CLKINVX1M U93 ( .A(n7), .Y(n61) );
  NOR4X1M U94 ( .A(n62), .B(cs[0]), .C(cs[1]), .D(cs[3]), .Y(n15) );
  CLKINVX1M U95 ( .A(n63), .Y(Rd_En) );
  OAI22X1M U96 ( .A0(n57), .A1(n63), .B0(n67), .B1(n26), .Y(Address[2]) );
  OAI222X1M U97 ( .A0(n27), .A1(n35), .B0(n65), .B1(n26), .C0(n58), .C1(n63), 
        .Y(n122) );
  CLKNAND2X2M U98 ( .A(n14), .B(RX_D_VLD), .Y(n63) );
  NOR4X1M U99 ( .A(n10), .B(n11), .C(cs[2]), .D(cs[3]), .Y(n14) );
  CLKNAND2X2M U100 ( .A(cs[1]), .B(n42), .Y(n26) );
  NOR3X1M U101 ( .A(cs[2]), .B(cs[3]), .C(cs[0]), .Y(n42) );
  CLKNAND2X2M U102 ( .A(n64), .B(n11), .Y(n35) );
  CLKINVX1M U103 ( .A(cs[0]), .Y(n11) );
  CLKINVX1M U104 ( .A(RX_D_VLD), .Y(n27) );
  NOR2X1M U105 ( .A(n44), .B(n55), .Y(ALU_FUN[3]) );
  CLKINVX1M U106 ( .A(RX_P_Data[3]), .Y(n44) );
  NOR2X1M U107 ( .A(n57), .B(n55), .Y(ALU_FUN[2]) );
  CLKINVX1M U108 ( .A(RX_P_Data[2]), .Y(n57) );
  NOR2X1M U109 ( .A(n40), .B(n55), .Y(ALU_FUN[1]) );
  CLKINVX1M U110 ( .A(RX_P_Data[1]), .Y(n40) );
  NOR2X1M U111 ( .A(n58), .B(n55), .Y(ALU_FUN[0]) );
  CLKNAND2X2M U112 ( .A(RX_D_VLD), .B(CLK_GATING_EN), .Y(n55) );
  OAI31X1M U113 ( .A0(n10), .A1(cs[0]), .A2(n7), .B0(n8), .Y(CLK_GATING_EN) );
  CLKNAND2X2M U114 ( .A(n64), .B(cs[0]), .Y(n8) );
  NOR3X1M U115 ( .A(n10), .B(cs[3]), .C(n62), .Y(n64) );
  CLKNAND2X2M U116 ( .A(cs[3]), .B(n62), .Y(n7) );
  CLKINVX1M U117 ( .A(cs[2]), .Y(n62) );
  CLKINVX1M U118 ( .A(cs[1]), .Y(n10) );
  CLKINVX1M U119 ( .A(RX_P_Data[0]), .Y(n58) );
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
  NOR2BX1M U4 ( .AN(in), .B(q), .Y(out) );
endmodule


module ClkDiv_Range_for_division8_test_1 ( i_ref_clk, i_rst_n, i_clk_en, 
        i_div_ratio, o_div_clk, test_si, test_so, test_se );
  input [7:0] i_div_ratio;
  input i_ref_clk, i_rst_n, i_clk_en, test_si, test_se;
  output o_div_clk, test_so;
  wire   o_div_clk_internal, toggle_flag_odd, n24, n25, n26, n27, n28, n29,
         n30, n1, n2, n3, n4, n5, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56;
  wire   [4:0] counter;
  assign test_so = toggle_flag_odd;

  SDFFRQX2M o_div_clk_internal_reg ( .D(n24), .SI(counter[4]), .SE(test_se), 
        .CK(i_ref_clk), .RN(i_rst_n), .Q(o_div_clk_internal) );
  SDFFRQX2M \counter_reg[3]  ( .D(n26), .SI(counter[2]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst_n), .Q(counter[3]) );
  SDFFRQX2M toggle_flag_odd_reg ( .D(n30), .SI(o_div_clk_internal), .SE(
        test_se), .CK(i_ref_clk), .RN(i_rst_n), .Q(toggle_flag_odd) );
  SDFFRQX2M \counter_reg[4]  ( .D(n25), .SI(counter[3]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst_n), .Q(counter[4]) );
  SDFFRQX2M \counter_reg[2]  ( .D(n27), .SI(counter[1]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst_n), .Q(counter[2]) );
  SDFFRQX2M \counter_reg[1]  ( .D(n28), .SI(counter[0]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst_n), .Q(counter[1]) );
  SDFFRQX2M \counter_reg[0]  ( .D(n29), .SI(test_si), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst_n), .Q(counter[0]) );
  MX2X2M U5 ( .A(i_ref_clk), .B(o_div_clk_internal), .S0(n56), .Y(o_div_clk)
         );
  CLKXOR2X2M U6 ( .A(toggle_flag_odd), .B(n1), .Y(n30) );
  NOR2X1M U11 ( .A(n2), .B(n3), .Y(n1) );
  MXI2X1M U13 ( .A(n4), .B(n56), .S0(counter[0]), .Y(n29) );
  MXI2X1M U14 ( .A(n5), .B(n13), .S0(counter[1]), .Y(n28) );
  CLKINVX1M U15 ( .A(n14), .Y(n13) );
  CLKNAND2X2M U16 ( .A(n15), .B(counter[0]), .Y(n5) );
  MXI2X1M U17 ( .A(n16), .B(n17), .S0(counter[2]), .Y(n27) );
  AOI2BB1X1M U18 ( .A0N(counter[1]), .A1N(n4), .B0(n14), .Y(n17) );
  OAI21X1M U19 ( .A0(counter[0]), .A1(n4), .B0(n56), .Y(n14) );
  NAND3X1M U20 ( .A(counter[0]), .B(counter[1]), .C(n15), .Y(n16) );
  MXI2X1M U21 ( .A(n18), .B(n19), .S0(counter[3]), .Y(n26) );
  CLKINVX1M U22 ( .A(n20), .Y(n19) );
  CLKNAND2X2M U23 ( .A(n21), .B(n15), .Y(n18) );
  MXI2X1M U24 ( .A(n22), .B(n23), .S0(counter[4]), .Y(n25) );
  AOI21X1M U25 ( .A0(n15), .A1(n31), .B0(n20), .Y(n23) );
  OAI21X1M U26 ( .A0(n21), .A1(n4), .B0(n56), .Y(n20) );
  NAND3X1M U27 ( .A(n15), .B(counter[3]), .C(n21), .Y(n22) );
  AND3X1M U28 ( .A(counter[0]), .B(counter[1]), .C(counter[2]), .Y(n21) );
  CLKINVX1M U29 ( .A(n4), .Y(n15) );
  NAND3X1M U30 ( .A(n32), .B(n2), .C(n56), .Y(n4) );
  CLKINVX1M U31 ( .A(n3), .Y(n56) );
  CLKXOR2X2M U32 ( .A(o_div_clk_internal), .B(n33), .Y(n24) );
  AOI21X1M U33 ( .A0(n2), .A1(n32), .B0(n3), .Y(n33) );
  OAI31X1M U34 ( .A0(n34), .A1(i_div_ratio[7]), .A2(i_div_ratio[6]), .B0(
        i_clk_en), .Y(n3) );
  OR2X1M U35 ( .A(n35), .B(i_div_ratio[0]), .Y(n32) );
  CLKNAND2X2M U36 ( .A(n36), .B(i_div_ratio[0]), .Y(n2) );
  MXI2X1M U37 ( .A(n35), .B(n37), .S0(toggle_flag_odd), .Y(n36) );
  NAND4BX1M U38 ( .AN(n38), .B(n39), .C(n40), .D(n41), .Y(n37) );
  NOR2X1M U39 ( .A(n42), .B(n43), .Y(n41) );
  CLKXOR2X2M U40 ( .A(i_div_ratio[5]), .B(counter[4]), .Y(n43) );
  CLKXOR2X2M U41 ( .A(i_div_ratio[3]), .B(counter[2]), .Y(n42) );
  XNOR2X1M U42 ( .A(i_div_ratio[1]), .B(counter[0]), .Y(n40) );
  NAND4X1M U43 ( .A(n44), .B(n45), .C(n46), .D(n47), .Y(n35) );
  XNOR2X1M U44 ( .A(counter[2]), .B(n48), .Y(n47) );
  OAI21X1M U45 ( .A0(n49), .A1(n50), .B0(n51), .Y(n48) );
  XNOR2X1M U46 ( .A(counter[4]), .B(n52), .Y(n46) );
  CLKNAND2X2M U47 ( .A(n34), .B(n53), .Y(n52) );
  OAI21X1M U48 ( .A0(i_div_ratio[4]), .A1(n51), .B0(i_div_ratio[5]), .Y(n53)
         );
  OR3X1M U49 ( .A(i_div_ratio[4]), .B(i_div_ratio[5]), .C(n51), .Y(n34) );
  XNOR2X1M U50 ( .A(n51), .B(n39), .Y(n45) );
  CLKXOR2X2M U51 ( .A(i_div_ratio[4]), .B(n31), .Y(n39) );
  CLKINVX1M U52 ( .A(counter[3]), .Y(n31) );
  CLKNAND2X2M U53 ( .A(n49), .B(n50), .Y(n51) );
  CLKINVX1M U54 ( .A(i_div_ratio[3]), .Y(n50) );
  NOR2X1M U55 ( .A(i_div_ratio[2]), .B(i_div_ratio[1]), .Y(n49) );
  MXI2X1M U56 ( .A(n54), .B(n55), .S0(i_div_ratio[1]), .Y(n44) );
  OR2X1M U57 ( .A(counter[0]), .B(n38), .Y(n55) );
  CLKNAND2X2M U58 ( .A(counter[0]), .B(n38), .Y(n54) );
  CLKXOR2X2M U59 ( .A(i_div_ratio[2]), .B(counter[1]), .Y(n38) );
endmodule


module ClkDiv_Range_for_division2_test_1 ( i_ref_clk, i_rst_n, i_clk_en, 
        i_div_ratio, o_div_clk, test_si, test_so, test_se );
  input [1:0] i_div_ratio;
  input i_ref_clk, i_rst_n, i_clk_en, test_si, test_se;
  output o_div_clk, test_so;
  wire   o_div_clk_internal, toggle_flag_odd, n26, n27, n28, n29, n1, n2, n3,
         n4, n5, n6, n7, n12, n13, n14, n15, n16;
  wire   [1:0] counter;
  assign test_so = toggle_flag_odd;

  SDFFRQX2M \counter_reg[1]  ( .D(n27), .SI(counter[0]), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst_n), .Q(counter[1]) );
  SDFFRQX2M toggle_flag_odd_reg ( .D(n29), .SI(o_div_clk_internal), .SE(
        test_se), .CK(i_ref_clk), .RN(i_rst_n), .Q(toggle_flag_odd) );
  SDFFRQX2M o_div_clk_internal_reg ( .D(n26), .SI(counter[1]), .SE(test_se), 
        .CK(i_ref_clk), .RN(i_rst_n), .Q(o_div_clk_internal) );
  SDFFRQX2M \counter_reg[0]  ( .D(n28), .SI(test_si), .SE(test_se), .CK(
        i_ref_clk), .RN(i_rst_n), .Q(counter[0]) );
  MX2X2M U7 ( .A(i_ref_clk), .B(o_div_clk_internal), .S0(n16), .Y(o_div_clk)
         );
  MXI2X1M U8 ( .A(n1), .B(counter[0]), .S0(n2), .Y(n29) );
  NOR2X1M U9 ( .A(n3), .B(n4), .Y(n2) );
  MXI2X1M U10 ( .A(n5), .B(n16), .S0(counter[0]), .Y(n28) );
  CLKNAND2X2M U11 ( .A(n16), .B(n6), .Y(n5) );
  MXI2X1M U12 ( .A(n7), .B(n6), .S0(n12), .Y(n27) );
  AND2X1M U13 ( .A(n16), .B(counter[0]), .Y(n12) );
  OAI21X1M U14 ( .A0(n4), .A1(n1), .B0(n7), .Y(n6) );
  CLKINVX1M U15 ( .A(toggle_flag_odd), .Y(n1) );
  CLKINVX1M U16 ( .A(i_div_ratio[0]), .Y(n4) );
  CLKXOR2X2M U17 ( .A(o_div_clk_internal), .B(n13), .Y(n26) );
  NOR2X1M U18 ( .A(n3), .B(n14), .Y(n13) );
  XNOR2X1M U19 ( .A(counter[0]), .B(n15), .Y(n14) );
  CLKNAND2X2M U20 ( .A(toggle_flag_odd), .B(i_div_ratio[0]), .Y(n15) );
  CLKNAND2X2M U21 ( .A(n16), .B(n7), .Y(n3) );
  CLKINVX1M U22 ( .A(counter[1]), .Y(n7) );
  AND2X1M U23 ( .A(i_div_ratio[1]), .B(i_clk_en), .Y(n16) );
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
         \FIFO_MEM[0][0] , n85, n86, n87, n88, n89, n90, n91, n92, n93, n94,
         n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105, n106,
         n107, n108, n109, n110, n111, n112, n113, n114, n115, n116, n117,
         n118, n119, n120, n121, n122, n123, n124, n125, n126, n127, n128,
         n129, n130, n131, n132, n133, n134, n135, n136, n137, n138, n139,
         n140, n141, n142, n143, n144, n145, n146, n147, n148, n65, n66, n67,
         n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81,
         n82, n83, n84, n149, n150, n151, n152, n153, n154, n155, n156, n157,
         n158, n159, n160, n161, n162, n163, n164, n165, n166, n167;
  assign N10 = r_addr[0];
  assign N11 = r_addr[1];
  assign N12 = r_addr[2];
  assign test_so2 = \FIFO_MEM[7][7] ;
  assign test_so1 = \FIFO_MEM[4][0] ;

  SDFFRQX2M \FIFO_MEM_reg[5][7]  ( .D(n132), .SI(\FIFO_MEM[5][6] ), .SE(
        test_se), .CK(n73), .RN(n67), .Q(\FIFO_MEM[5][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[5][6]  ( .D(n131), .SI(\FIFO_MEM[5][5] ), .SE(
        test_se), .CK(n72), .RN(n66), .Q(\FIFO_MEM[5][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[5][5]  ( .D(n130), .SI(\FIFO_MEM[5][4] ), .SE(
        test_se), .CK(n71), .RN(n65), .Q(\FIFO_MEM[5][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[5][4]  ( .D(n129), .SI(\FIFO_MEM[5][3] ), .SE(
        test_se), .CK(n71), .RN(n65), .Q(\FIFO_MEM[5][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[5][3]  ( .D(n128), .SI(\FIFO_MEM[5][2] ), .SE(
        test_se), .CK(n75), .RN(n69), .Q(\FIFO_MEM[5][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[5][2]  ( .D(n127), .SI(\FIFO_MEM[5][1] ), .SE(
        test_se), .CK(n74), .RN(n69), .Q(\FIFO_MEM[5][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[5][1]  ( .D(n126), .SI(\FIFO_MEM[5][0] ), .SE(
        test_se), .CK(n74), .RN(n68), .Q(\FIFO_MEM[5][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[5][0]  ( .D(n125), .SI(\FIFO_MEM[4][7] ), .SE(
        test_se), .CK(n73), .RN(n67), .Q(\FIFO_MEM[5][0] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][7]  ( .D(n100), .SI(\FIFO_MEM[1][6] ), .SE(
        test_se), .CK(n72), .RN(n67), .Q(\FIFO_MEM[1][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][6]  ( .D(n99), .SI(\FIFO_MEM[1][5] ), .SE(test_se), .CK(n72), .RN(n66), .Q(\FIFO_MEM[1][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][5]  ( .D(n98), .SI(\FIFO_MEM[1][4] ), .SE(test_se), .CK(n72), .RN(n66), .Q(\FIFO_MEM[1][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][4]  ( .D(n97), .SI(\FIFO_MEM[1][3] ), .SE(test_se), .CK(n71), .RN(n65), .Q(\FIFO_MEM[1][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][3]  ( .D(n96), .SI(\FIFO_MEM[1][2] ), .SE(test_se), .CK(n75), .RN(n70), .Q(\FIFO_MEM[1][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][2]  ( .D(n95), .SI(\FIFO_MEM[1][1] ), .SE(test_se), .CK(n75), .RN(n69), .Q(\FIFO_MEM[1][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][1]  ( .D(n94), .SI(\FIFO_MEM[1][0] ), .SE(test_se), .CK(n74), .RN(n68), .Q(\FIFO_MEM[1][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[1][0]  ( .D(n93), .SI(\FIFO_MEM[0][7] ), .SE(test_se), .CK(n74), .RN(n68), .Q(\FIFO_MEM[1][0] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][7]  ( .D(n148), .SI(\FIFO_MEM[7][6] ), .SE(
        test_se), .CK(n73), .RN(n67), .Q(\FIFO_MEM[7][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][6]  ( .D(n147), .SI(\FIFO_MEM[7][5] ), .SE(
        test_se), .CK(n72), .RN(n66), .Q(\FIFO_MEM[7][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][5]  ( .D(n146), .SI(\FIFO_MEM[7][4] ), .SE(
        test_se), .CK(n72), .RN(n66), .Q(\FIFO_MEM[7][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][4]  ( .D(n145), .SI(\FIFO_MEM[7][3] ), .SE(
        test_se), .CK(n71), .RN(n65), .Q(\FIFO_MEM[7][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][3]  ( .D(n144), .SI(\FIFO_MEM[7][2] ), .SE(
        test_se), .CK(n75), .RN(n70), .Q(\FIFO_MEM[7][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][2]  ( .D(n143), .SI(\FIFO_MEM[7][1] ), .SE(
        test_se), .CK(n75), .RN(n69), .Q(\FIFO_MEM[7][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][1]  ( .D(n142), .SI(\FIFO_MEM[7][0] ), .SE(
        test_se), .CK(n74), .RN(n68), .Q(\FIFO_MEM[7][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[7][0]  ( .D(n141), .SI(\FIFO_MEM[6][7] ), .SE(
        test_se), .CK(n73), .RN(n68), .Q(\FIFO_MEM[7][0] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][7]  ( .D(n116), .SI(\FIFO_MEM[3][6] ), .SE(
        test_se), .CK(n73), .RN(n67), .Q(\FIFO_MEM[3][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][6]  ( .D(n115), .SI(\FIFO_MEM[3][5] ), .SE(
        test_se), .CK(n72), .RN(n66), .Q(\FIFO_MEM[3][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][5]  ( .D(n114), .SI(\FIFO_MEM[3][4] ), .SE(
        test_se), .CK(n71), .RN(n65), .Q(\FIFO_MEM[3][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][4]  ( .D(n113), .SI(\FIFO_MEM[3][3] ), .SE(
        test_se), .CK(n71), .RN(n65), .Q(\FIFO_MEM[3][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][3]  ( .D(n112), .SI(\FIFO_MEM[3][2] ), .SE(
        test_se), .CK(n75), .RN(n69), .Q(\FIFO_MEM[3][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][2]  ( .D(n111), .SI(\FIFO_MEM[3][1] ), .SE(
        test_se), .CK(n74), .RN(n69), .Q(\FIFO_MEM[3][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][1]  ( .D(n110), .SI(\FIFO_MEM[3][0] ), .SE(
        test_se), .CK(n74), .RN(n68), .Q(\FIFO_MEM[3][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[3][0]  ( .D(n109), .SI(\FIFO_MEM[2][7] ), .SE(
        test_se), .CK(n73), .RN(n67), .Q(\FIFO_MEM[3][0] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][7]  ( .D(n140), .SI(\FIFO_MEM[6][6] ), .SE(
        test_se), .CK(n73), .RN(n67), .Q(\FIFO_MEM[6][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][6]  ( .D(n139), .SI(\FIFO_MEM[6][5] ), .SE(
        test_se), .CK(n72), .RN(n66), .Q(\FIFO_MEM[6][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][5]  ( .D(n138), .SI(\FIFO_MEM[6][4] ), .SE(
        test_se), .CK(n71), .RN(n66), .Q(\FIFO_MEM[6][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][4]  ( .D(n137), .SI(\FIFO_MEM[6][3] ), .SE(
        test_se), .CK(n71), .RN(n65), .Q(\FIFO_MEM[6][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][3]  ( .D(n136), .SI(\FIFO_MEM[6][2] ), .SE(
        test_se), .CK(n75), .RN(n70), .Q(\FIFO_MEM[6][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][2]  ( .D(n135), .SI(\FIFO_MEM[6][1] ), .SE(
        test_se), .CK(n75), .RN(n69), .Q(\FIFO_MEM[6][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][1]  ( .D(n134), .SI(\FIFO_MEM[6][0] ), .SE(
        test_se), .CK(n74), .RN(n68), .Q(\FIFO_MEM[6][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[6][0]  ( .D(n133), .SI(\FIFO_MEM[5][7] ), .SE(
        test_se), .CK(n73), .RN(n68), .Q(\FIFO_MEM[6][0] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][7]  ( .D(n108), .SI(\FIFO_MEM[2][6] ), .SE(
        test_se), .CK(n72), .RN(n67), .Q(\FIFO_MEM[2][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][6]  ( .D(n107), .SI(\FIFO_MEM[2][5] ), .SE(
        test_se), .CK(n72), .RN(n66), .Q(\FIFO_MEM[2][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][5]  ( .D(n106), .SI(\FIFO_MEM[2][4] ), .SE(
        test_se), .CK(n71), .RN(n65), .Q(\FIFO_MEM[2][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][4]  ( .D(n105), .SI(\FIFO_MEM[2][3] ), .SE(
        test_se), .CK(n71), .RN(n65), .Q(\FIFO_MEM[2][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][3]  ( .D(n104), .SI(\FIFO_MEM[2][2] ), .SE(
        test_se), .CK(n75), .RN(n69), .Q(\FIFO_MEM[2][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][2]  ( .D(n103), .SI(\FIFO_MEM[2][1] ), .SE(
        test_se), .CK(n74), .RN(n69), .Q(\FIFO_MEM[2][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][1]  ( .D(n102), .SI(\FIFO_MEM[2][0] ), .SE(
        test_se), .CK(n74), .RN(n68), .Q(\FIFO_MEM[2][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[2][0]  ( .D(n101), .SI(\FIFO_MEM[1][7] ), .SE(
        test_se), .CK(n73), .RN(n67), .Q(\FIFO_MEM[2][0] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][7]  ( .D(n124), .SI(\FIFO_MEM[4][6] ), .SE(
        test_se), .CK(n73), .RN(n67), .Q(\FIFO_MEM[4][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][6]  ( .D(n123), .SI(\FIFO_MEM[4][5] ), .SE(
        test_se), .CK(n72), .RN(n66), .Q(\FIFO_MEM[4][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][5]  ( .D(n122), .SI(\FIFO_MEM[4][4] ), .SE(
        test_se), .CK(n71), .RN(n65), .Q(\FIFO_MEM[4][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][4]  ( .D(n121), .SI(\FIFO_MEM[4][3] ), .SE(
        test_se), .CK(n71), .RN(n65), .Q(\FIFO_MEM[4][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][3]  ( .D(n120), .SI(\FIFO_MEM[4][2] ), .SE(
        test_se), .CK(n75), .RN(n69), .Q(\FIFO_MEM[4][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][2]  ( .D(n119), .SI(\FIFO_MEM[4][1] ), .SE(
        test_se), .CK(n74), .RN(n69), .Q(\FIFO_MEM[4][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][1]  ( .D(n118), .SI(test_si2), .SE(test_se), .CK(
        n74), .RN(n68), .Q(\FIFO_MEM[4][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[4][0]  ( .D(n117), .SI(\FIFO_MEM[3][7] ), .SE(
        test_se), .CK(n73), .RN(n67), .Q(\FIFO_MEM[4][0] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][7]  ( .D(n92), .SI(\FIFO_MEM[0][6] ), .SE(test_se), .CK(n73), .RN(n67), .Q(\FIFO_MEM[0][7] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][6]  ( .D(n91), .SI(\FIFO_MEM[0][5] ), .SE(test_se), .CK(n72), .RN(n66), .Q(\FIFO_MEM[0][6] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][5]  ( .D(n90), .SI(\FIFO_MEM[0][4] ), .SE(test_se), .CK(n72), .RN(n66), .Q(\FIFO_MEM[0][5] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][4]  ( .D(n89), .SI(\FIFO_MEM[0][3] ), .SE(test_se), .CK(n71), .RN(n65), .Q(\FIFO_MEM[0][4] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][3]  ( .D(n88), .SI(\FIFO_MEM[0][2] ), .SE(test_se), .CK(n75), .RN(n70), .Q(\FIFO_MEM[0][3] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][2]  ( .D(n87), .SI(\FIFO_MEM[0][1] ), .SE(test_se), .CK(n75), .RN(n69), .Q(\FIFO_MEM[0][2] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][1]  ( .D(n86), .SI(\FIFO_MEM[0][0] ), .SE(test_se), .CK(n74), .RN(n68), .Q(\FIFO_MEM[0][1] ) );
  SDFFRQX2M \FIFO_MEM_reg[0][0]  ( .D(n85), .SI(test_si1), .SE(test_se), .CK(
        n73), .RN(n68), .Q(\FIFO_MEM[0][0] ) );
  BUFX2M U66 ( .A(rst), .Y(n68) );
  BUFX2M U67 ( .A(rst), .Y(n69) );
  BUFX2M U68 ( .A(rst), .Y(n65) );
  BUFX2M U69 ( .A(rst), .Y(n66) );
  BUFX2M U70 ( .A(rst), .Y(n67) );
  BUFX2M U71 ( .A(w_clk), .Y(n74) );
  BUFX2M U72 ( .A(w_clk), .Y(n71) );
  BUFX2M U73 ( .A(w_clk), .Y(n72) );
  BUFX2M U74 ( .A(w_clk), .Y(n73) );
  BUFX2M U75 ( .A(w_clk), .Y(n75) );
  BUFX2M U76 ( .A(rst), .Y(n70) );
  MX2X2M U77 ( .A(n77), .B(n76), .S0(N12), .Y(r_data[0]) );
  MX4X1M U78 ( .A(\FIFO_MEM[4][0] ), .B(\FIFO_MEM[5][0] ), .C(\FIFO_MEM[6][0] ), .D(\FIFO_MEM[7][0] ), .S0(N10), .S1(N11), .Y(n76) );
  MX4X1M U79 ( .A(\FIFO_MEM[0][0] ), .B(\FIFO_MEM[1][0] ), .C(\FIFO_MEM[2][0] ), .D(\FIFO_MEM[3][0] ), .S0(N10), .S1(N11), .Y(n77) );
  MX2X2M U80 ( .A(n149), .B(n84), .S0(N12), .Y(r_data[4]) );
  MX4X1M U81 ( .A(\FIFO_MEM[4][4] ), .B(\FIFO_MEM[5][4] ), .C(\FIFO_MEM[6][4] ), .D(\FIFO_MEM[7][4] ), .S0(N10), .S1(N11), .Y(n84) );
  MX4X1M U82 ( .A(\FIFO_MEM[0][4] ), .B(\FIFO_MEM[1][4] ), .C(\FIFO_MEM[2][4] ), .D(\FIFO_MEM[3][4] ), .S0(N10), .S1(N11), .Y(n149) );
  MX2X2M U83 ( .A(n79), .B(n78), .S0(N12), .Y(r_data[1]) );
  MX4X1M U84 ( .A(\FIFO_MEM[4][1] ), .B(\FIFO_MEM[5][1] ), .C(\FIFO_MEM[6][1] ), .D(\FIFO_MEM[7][1] ), .S0(N10), .S1(N11), .Y(n78) );
  MX4X1M U85 ( .A(\FIFO_MEM[0][1] ), .B(\FIFO_MEM[1][1] ), .C(\FIFO_MEM[2][1] ), .D(\FIFO_MEM[3][1] ), .S0(N10), .S1(N11), .Y(n79) );
  MX2X2M U86 ( .A(n151), .B(n150), .S0(N12), .Y(r_data[5]) );
  MX4X1M U87 ( .A(\FIFO_MEM[4][5] ), .B(\FIFO_MEM[5][5] ), .C(\FIFO_MEM[6][5] ), .D(\FIFO_MEM[7][5] ), .S0(N10), .S1(N11), .Y(n150) );
  MX4X1M U88 ( .A(\FIFO_MEM[0][5] ), .B(\FIFO_MEM[1][5] ), .C(\FIFO_MEM[2][5] ), .D(\FIFO_MEM[3][5] ), .S0(N10), .S1(N11), .Y(n151) );
  MX2X2M U89 ( .A(n81), .B(n80), .S0(N12), .Y(r_data[2]) );
  MX4X1M U90 ( .A(\FIFO_MEM[4][2] ), .B(\FIFO_MEM[5][2] ), .C(\FIFO_MEM[6][2] ), .D(\FIFO_MEM[7][2] ), .S0(N10), .S1(N11), .Y(n80) );
  MX4X1M U91 ( .A(\FIFO_MEM[0][2] ), .B(\FIFO_MEM[1][2] ), .C(\FIFO_MEM[2][2] ), .D(\FIFO_MEM[3][2] ), .S0(N10), .S1(N11), .Y(n81) );
  MX2X2M U92 ( .A(n153), .B(n152), .S0(N12), .Y(r_data[6]) );
  MX4X1M U93 ( .A(\FIFO_MEM[4][6] ), .B(\FIFO_MEM[5][6] ), .C(\FIFO_MEM[6][6] ), .D(\FIFO_MEM[7][6] ), .S0(N10), .S1(N11), .Y(n152) );
  MX4X1M U94 ( .A(\FIFO_MEM[0][6] ), .B(\FIFO_MEM[1][6] ), .C(\FIFO_MEM[2][6] ), .D(\FIFO_MEM[3][6] ), .S0(N10), .S1(N11), .Y(n153) );
  MX2X2M U95 ( .A(n83), .B(n82), .S0(N12), .Y(r_data[3]) );
  MX4X1M U96 ( .A(\FIFO_MEM[4][3] ), .B(\FIFO_MEM[5][3] ), .C(\FIFO_MEM[6][3] ), .D(\FIFO_MEM[7][3] ), .S0(N10), .S1(N11), .Y(n82) );
  MX4X1M U97 ( .A(\FIFO_MEM[0][3] ), .B(\FIFO_MEM[1][3] ), .C(\FIFO_MEM[2][3] ), .D(\FIFO_MEM[3][3] ), .S0(N10), .S1(N11), .Y(n83) );
  MX2X2M U98 ( .A(n155), .B(n154), .S0(N12), .Y(r_data[7]) );
  MX4X1M U99 ( .A(\FIFO_MEM[4][7] ), .B(\FIFO_MEM[5][7] ), .C(\FIFO_MEM[6][7] ), .D(\FIFO_MEM[7][7] ), .S0(N10), .S1(N11), .Y(n154) );
  MX4X1M U100 ( .A(\FIFO_MEM[0][7] ), .B(\FIFO_MEM[1][7] ), .C(
        \FIFO_MEM[2][7] ), .D(\FIFO_MEM[3][7] ), .S0(N10), .S1(N11), .Y(n155)
         );
  CLKMX2X2M U101 ( .A(\FIFO_MEM[1][6] ), .B(w_data[6]), .S0(n156), .Y(n99) );
  CLKMX2X2M U102 ( .A(\FIFO_MEM[1][5] ), .B(w_data[5]), .S0(n156), .Y(n98) );
  CLKMX2X2M U103 ( .A(\FIFO_MEM[1][4] ), .B(w_data[4]), .S0(n156), .Y(n97) );
  CLKMX2X2M U104 ( .A(\FIFO_MEM[1][3] ), .B(w_data[3]), .S0(n156), .Y(n96) );
  CLKMX2X2M U105 ( .A(\FIFO_MEM[1][2] ), .B(w_data[2]), .S0(n156), .Y(n95) );
  CLKMX2X2M U106 ( .A(\FIFO_MEM[1][1] ), .B(w_data[1]), .S0(n156), .Y(n94) );
  CLKMX2X2M U107 ( .A(\FIFO_MEM[1][0] ), .B(w_data[0]), .S0(n156), .Y(n93) );
  CLKMX2X2M U108 ( .A(\FIFO_MEM[0][7] ), .B(w_data[7]), .S0(n157), .Y(n92) );
  CLKMX2X2M U109 ( .A(\FIFO_MEM[0][6] ), .B(w_data[6]), .S0(n157), .Y(n91) );
  CLKMX2X2M U110 ( .A(\FIFO_MEM[0][5] ), .B(w_data[5]), .S0(n157), .Y(n90) );
  CLKMX2X2M U111 ( .A(\FIFO_MEM[0][4] ), .B(w_data[4]), .S0(n157), .Y(n89) );
  CLKMX2X2M U112 ( .A(\FIFO_MEM[0][3] ), .B(w_data[3]), .S0(n157), .Y(n88) );
  CLKMX2X2M U113 ( .A(\FIFO_MEM[0][2] ), .B(w_data[2]), .S0(n157), .Y(n87) );
  CLKMX2X2M U114 ( .A(\FIFO_MEM[0][1] ), .B(w_data[1]), .S0(n157), .Y(n86) );
  CLKMX2X2M U115 ( .A(\FIFO_MEM[0][0] ), .B(w_data[0]), .S0(n157), .Y(n85) );
  AND3X1M U116 ( .A(n158), .B(n159), .C(n160), .Y(n157) );
  CLKMX2X2M U117 ( .A(\FIFO_MEM[7][7] ), .B(w_data[7]), .S0(n161), .Y(n148) );
  CLKMX2X2M U118 ( .A(\FIFO_MEM[7][6] ), .B(w_data[6]), .S0(n161), .Y(n147) );
  CLKMX2X2M U119 ( .A(\FIFO_MEM[7][5] ), .B(w_data[5]), .S0(n161), .Y(n146) );
  CLKMX2X2M U120 ( .A(\FIFO_MEM[7][4] ), .B(w_data[4]), .S0(n161), .Y(n145) );
  CLKMX2X2M U121 ( .A(\FIFO_MEM[7][3] ), .B(w_data[3]), .S0(n161), .Y(n144) );
  CLKMX2X2M U122 ( .A(\FIFO_MEM[7][2] ), .B(w_data[2]), .S0(n161), .Y(n143) );
  CLKMX2X2M U123 ( .A(\FIFO_MEM[7][1] ), .B(w_data[1]), .S0(n161), .Y(n142) );
  CLKMX2X2M U124 ( .A(\FIFO_MEM[7][0] ), .B(w_data[0]), .S0(n161), .Y(n141) );
  AND3X1M U125 ( .A(n162), .B(w_addr[0]), .C(w_addr[1]), .Y(n161) );
  CLKMX2X2M U126 ( .A(\FIFO_MEM[6][7] ), .B(w_data[7]), .S0(n163), .Y(n140) );
  CLKMX2X2M U127 ( .A(\FIFO_MEM[6][6] ), .B(w_data[6]), .S0(n163), .Y(n139) );
  CLKMX2X2M U128 ( .A(\FIFO_MEM[6][5] ), .B(w_data[5]), .S0(n163), .Y(n138) );
  CLKMX2X2M U129 ( .A(\FIFO_MEM[6][4] ), .B(w_data[4]), .S0(n163), .Y(n137) );
  CLKMX2X2M U130 ( .A(\FIFO_MEM[6][3] ), .B(w_data[3]), .S0(n163), .Y(n136) );
  CLKMX2X2M U131 ( .A(\FIFO_MEM[6][2] ), .B(w_data[2]), .S0(n163), .Y(n135) );
  CLKMX2X2M U132 ( .A(\FIFO_MEM[6][1] ), .B(w_data[1]), .S0(n163), .Y(n134) );
  CLKMX2X2M U133 ( .A(\FIFO_MEM[6][0] ), .B(w_data[0]), .S0(n163), .Y(n133) );
  AND3X1M U134 ( .A(n162), .B(n159), .C(w_addr[1]), .Y(n163) );
  CLKMX2X2M U135 ( .A(\FIFO_MEM[5][7] ), .B(w_data[7]), .S0(n164), .Y(n132) );
  CLKMX2X2M U136 ( .A(\FIFO_MEM[5][6] ), .B(w_data[6]), .S0(n164), .Y(n131) );
  CLKMX2X2M U137 ( .A(\FIFO_MEM[5][5] ), .B(w_data[5]), .S0(n164), .Y(n130) );
  CLKMX2X2M U138 ( .A(\FIFO_MEM[5][4] ), .B(w_data[4]), .S0(n164), .Y(n129) );
  CLKMX2X2M U139 ( .A(\FIFO_MEM[5][3] ), .B(w_data[3]), .S0(n164), .Y(n128) );
  CLKMX2X2M U140 ( .A(\FIFO_MEM[5][2] ), .B(w_data[2]), .S0(n164), .Y(n127) );
  CLKMX2X2M U141 ( .A(\FIFO_MEM[5][1] ), .B(w_data[1]), .S0(n164), .Y(n126) );
  CLKMX2X2M U142 ( .A(\FIFO_MEM[5][0] ), .B(w_data[0]), .S0(n164), .Y(n125) );
  AND3X1M U143 ( .A(n162), .B(w_addr[0]), .C(n160), .Y(n164) );
  CLKMX2X2M U144 ( .A(\FIFO_MEM[4][7] ), .B(w_data[7]), .S0(n165), .Y(n124) );
  CLKMX2X2M U145 ( .A(\FIFO_MEM[4][6] ), .B(w_data[6]), .S0(n165), .Y(n123) );
  CLKMX2X2M U146 ( .A(\FIFO_MEM[4][5] ), .B(w_data[5]), .S0(n165), .Y(n122) );
  CLKMX2X2M U147 ( .A(\FIFO_MEM[4][4] ), .B(w_data[4]), .S0(n165), .Y(n121) );
  CLKMX2X2M U148 ( .A(\FIFO_MEM[4][3] ), .B(w_data[3]), .S0(n165), .Y(n120) );
  CLKMX2X2M U149 ( .A(\FIFO_MEM[4][2] ), .B(w_data[2]), .S0(n165), .Y(n119) );
  CLKMX2X2M U150 ( .A(\FIFO_MEM[4][1] ), .B(w_data[1]), .S0(n165), .Y(n118) );
  CLKMX2X2M U151 ( .A(\FIFO_MEM[4][0] ), .B(w_data[0]), .S0(n165), .Y(n117) );
  AND3X1M U152 ( .A(n162), .B(n159), .C(n160), .Y(n165) );
  AND2X1M U153 ( .A(w_addr[2]), .B(w_en), .Y(n162) );
  CLKMX2X2M U154 ( .A(\FIFO_MEM[3][7] ), .B(w_data[7]), .S0(n166), .Y(n116) );
  CLKMX2X2M U155 ( .A(\FIFO_MEM[3][6] ), .B(w_data[6]), .S0(n166), .Y(n115) );
  CLKMX2X2M U156 ( .A(\FIFO_MEM[3][5] ), .B(w_data[5]), .S0(n166), .Y(n114) );
  CLKMX2X2M U157 ( .A(\FIFO_MEM[3][4] ), .B(w_data[4]), .S0(n166), .Y(n113) );
  CLKMX2X2M U158 ( .A(\FIFO_MEM[3][3] ), .B(w_data[3]), .S0(n166), .Y(n112) );
  CLKMX2X2M U159 ( .A(\FIFO_MEM[3][2] ), .B(w_data[2]), .S0(n166), .Y(n111) );
  CLKMX2X2M U160 ( .A(\FIFO_MEM[3][1] ), .B(w_data[1]), .S0(n166), .Y(n110) );
  CLKMX2X2M U161 ( .A(\FIFO_MEM[3][0] ), .B(w_data[0]), .S0(n166), .Y(n109) );
  AND3X1M U162 ( .A(n158), .B(w_addr[0]), .C(w_addr[1]), .Y(n166) );
  CLKMX2X2M U163 ( .A(\FIFO_MEM[2][7] ), .B(w_data[7]), .S0(n167), .Y(n108) );
  CLKMX2X2M U164 ( .A(\FIFO_MEM[2][6] ), .B(w_data[6]), .S0(n167), .Y(n107) );
  CLKMX2X2M U165 ( .A(\FIFO_MEM[2][5] ), .B(w_data[5]), .S0(n167), .Y(n106) );
  CLKMX2X2M U166 ( .A(\FIFO_MEM[2][4] ), .B(w_data[4]), .S0(n167), .Y(n105) );
  CLKMX2X2M U167 ( .A(\FIFO_MEM[2][3] ), .B(w_data[3]), .S0(n167), .Y(n104) );
  CLKMX2X2M U168 ( .A(\FIFO_MEM[2][2] ), .B(w_data[2]), .S0(n167), .Y(n103) );
  CLKMX2X2M U169 ( .A(\FIFO_MEM[2][1] ), .B(w_data[1]), .S0(n167), .Y(n102) );
  CLKMX2X2M U170 ( .A(\FIFO_MEM[2][0] ), .B(w_data[0]), .S0(n167), .Y(n101) );
  AND3X1M U171 ( .A(n158), .B(n159), .C(w_addr[1]), .Y(n167) );
  CLKINVX1M U172 ( .A(w_addr[0]), .Y(n159) );
  CLKMX2X2M U173 ( .A(\FIFO_MEM[1][7] ), .B(w_data[7]), .S0(n156), .Y(n100) );
  AND3X1M U174 ( .A(n158), .B(n160), .C(w_addr[0]), .Y(n156) );
  CLKINVX1M U175 ( .A(w_addr[1]), .Y(n160) );
  NOR2BX1M U176 ( .AN(w_en), .B(w_addr[2]), .Y(n158) );
endmodule


module binary_to_gray_POINTER_WIDTH4_0 ( binary, gray );
  input [3:0] binary;
  output [3:0] gray;
  wire   \binary[3] ;
  assign gray[3] = \binary[3] ;
  assign \binary[3]  = binary[3];

  CLKXOR2X2M U1 ( .A(\binary[3] ), .B(binary[2]), .Y(gray[2]) );
  CLKXOR2X2M U2 ( .A(binary[2]), .B(binary[1]), .Y(gray[1]) );
  CLKXOR2X2M U3 ( .A(binary[1]), .B(binary[0]), .Y(gray[0]) );
endmodule


module FIFO_rptr_POINTER_WIDTH4_test_1 ( r_clk, rrst_n, rinc, rempty, r_addr, 
        gray_rptr, gray_wptr, test_si, test_se );
  output [2:0] r_addr;
  output [3:0] gray_rptr;
  input [3:0] gray_wptr;
  input r_clk, rrst_n, rinc, test_si, test_se;
  output rempty;
  wire   \rptr[3] , n15, n16, n17, n18, n5, n6, n7, n8, n9, n10, n11, n12, n13
;

  SDFFRQX2M \rptr_reg[3]  ( .D(n15), .SI(r_addr[2]), .SE(test_se), .CK(r_clk), 
        .RN(rrst_n), .Q(\rptr[3] ) );
  SDFFRQX2M \rptr_reg[2]  ( .D(n16), .SI(r_addr[1]), .SE(test_se), .CK(r_clk), 
        .RN(rrst_n), .Q(r_addr[2]) );
  SDFFRQX2M \rptr_reg[1]  ( .D(n17), .SI(r_addr[0]), .SE(test_se), .CK(r_clk), 
        .RN(rrst_n), .Q(r_addr[1]) );
  SDFFRQX4M \rptr_reg[0]  ( .D(n18), .SI(test_si), .SE(test_se), .CK(r_clk), 
        .RN(rrst_n), .Q(r_addr[0]) );
  CLKINVX1M U7 ( .A(n5), .Y(rempty) );
  XNOR2X1M U8 ( .A(r_addr[0]), .B(n6), .Y(n18) );
  CLKNAND2X2M U9 ( .A(rinc), .B(n5), .Y(n6) );
  XNOR2X1M U10 ( .A(r_addr[1]), .B(n7), .Y(n17) );
  CLKXOR2X2M U11 ( .A(r_addr[2]), .B(n8), .Y(n16) );
  CLKXOR2X2M U12 ( .A(\rptr[3] ), .B(n9), .Y(n15) );
  AND2X1M U13 ( .A(r_addr[2]), .B(n8), .Y(n9) );
  NOR2BX1M U14 ( .AN(r_addr[1]), .B(n7), .Y(n8) );
  NAND3X1M U15 ( .A(rinc), .B(n5), .C(r_addr[0]), .Y(n7) );
  NAND4X1M U16 ( .A(n10), .B(n11), .C(n12), .D(n13), .Y(n5) );
  XNOR2X1M U17 ( .A(gray_wptr[0]), .B(gray_rptr[0]), .Y(n13) );
  XNOR2X1M U18 ( .A(gray_wptr[1]), .B(gray_rptr[1]), .Y(n12) );
  XNOR2X1M U19 ( .A(gray_wptr[2]), .B(gray_rptr[2]), .Y(n11) );
  XNOR2X1M U20 ( .A(gray_wptr[3]), .B(gray_rptr[3]), .Y(n10) );
  binary_to_gray_POINTER_WIDTH4_0 b2g ( .binary({\rptr[3] , r_addr}), .gray(
        gray_rptr) );
endmodule


module binary_to_gray_POINTER_WIDTH4_1 ( binary, gray );
  input [3:0] binary;
  output [3:0] gray;
  wire   \binary[3] ;
  assign gray[3] = \binary[3] ;
  assign \binary[3]  = binary[3];

  CLKXOR2X2M U1 ( .A(\binary[3] ), .B(binary[2]), .Y(gray[2]) );
  CLKXOR2X2M U2 ( .A(binary[2]), .B(binary[1]), .Y(gray[1]) );
  CLKXOR2X2M U3 ( .A(binary[1]), .B(binary[0]), .Y(gray[0]) );
endmodule


module FIFO_wptr_POINTER_WIDTH4_test_1 ( w_clk, wrst_n, winc, wfull, waddr, 
        gray_wptr, gray_rptr, test_si, test_se );
  output [2:0] waddr;
  output [3:0] gray_wptr;
  input [3:0] gray_rptr;
  input w_clk, wrst_n, winc, test_si, test_se;
  output wfull;
  wire   \wptr[3] , n15, n16, n17, n18, n5, n6, n7, n8, n9, n10, n11, n12, n13
;

  SDFFRQX2M \wptr_reg[0]  ( .D(n18), .SI(test_si), .SE(test_se), .CK(w_clk), 
        .RN(wrst_n), .Q(waddr[0]) );
  SDFFRQX2M \wptr_reg[3]  ( .D(n15), .SI(waddr[2]), .SE(test_se), .CK(w_clk), 
        .RN(wrst_n), .Q(\wptr[3] ) );
  SDFFRQX2M \wptr_reg[2]  ( .D(n16), .SI(waddr[1]), .SE(test_se), .CK(w_clk), 
        .RN(wrst_n), .Q(waddr[2]) );
  SDFFRQX2M \wptr_reg[1]  ( .D(n17), .SI(waddr[0]), .SE(test_se), .CK(w_clk), 
        .RN(wrst_n), .Q(waddr[1]) );
  CLKINVX1M U7 ( .A(n5), .Y(wfull) );
  XNOR2X1M U8 ( .A(waddr[0]), .B(n6), .Y(n18) );
  CLKNAND2X2M U9 ( .A(winc), .B(n5), .Y(n6) );
  XNOR2X1M U10 ( .A(waddr[1]), .B(n7), .Y(n17) );
  CLKXOR2X2M U11 ( .A(waddr[2]), .B(n8), .Y(n16) );
  CLKXOR2X2M U12 ( .A(\wptr[3] ), .B(n9), .Y(n15) );
  AND2X1M U13 ( .A(waddr[2]), .B(n8), .Y(n9) );
  NOR2BX1M U14 ( .AN(waddr[1]), .B(n7), .Y(n8) );
  NAND3X1M U15 ( .A(winc), .B(n5), .C(waddr[0]), .Y(n7) );
  NAND4X1M U16 ( .A(n10), .B(n11), .C(n12), .D(n13), .Y(n5) );
  CLKXOR2X2M U17 ( .A(gray_wptr[2]), .B(gray_rptr[2]), .Y(n13) );
  CLKXOR2X2M U18 ( .A(gray_wptr[3]), .B(gray_rptr[3]), .Y(n12) );
  XNOR2X1M U19 ( .A(gray_wptr[0]), .B(gray_rptr[0]), .Y(n11) );
  XNOR2X1M U20 ( .A(gray_wptr[1]), .B(gray_rptr[1]), .Y(n10) );
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
  wire   wclken, n1;
  wire   [2:0] w_addr;
  wire   [2:0] r_addr;
  wire   [3:0] gray_rptr;
  wire   [3:0] gray_wptr_afterSYNC;
  wire   [3:0] gray_wptr;
  wire   [3:0] gray_rptr_afterSYNC;
  assign test_so2 = gray_wptr[3];

  NOR2BX1M U1 ( .AN(winc), .B(wfull), .Y(wclken) );
  FIFO_Memory_FIFO_DEPTH8_DATA_WIDTH8_test_1 FIFO_Memory ( .w_clk(w_clk), 
        .rst(wrst_n), .w_data(w_data), .w_en(wclken), .w_addr(w_addr), 
        .r_addr(r_addr), .r_data(r_data), .test_si2(test_si2), .test_si1(
        gray_wptr_afterSYNC[3]), .test_so2(n1), .test_so1(test_so1), .test_se(
        test_se) );
  FIFO_rptr_POINTER_WIDTH4_test_1 FIFO_rptr ( .r_clk(r_clk), .rrst_n(rrst_n), 
        .rinc(rinc), .rempty(rempty), .r_addr(r_addr), .gray_rptr(gray_rptr), 
        .gray_wptr(gray_wptr_afterSYNC), .test_si(n1), .test_se(test_se) );
  FIFO_wptr_POINTER_WIDTH4_test_1 FIFO_wptr ( .w_clk(w_clk), .wrst_n(wrst_n), 
        .winc(winc), .wfull(wfull), .waddr(w_addr), .gray_wptr(gray_wptr), 
        .gray_rptr(gray_rptr_afterSYNC), .test_si(gray_rptr[3]), .test_se(
        test_se) );
  BUS_SYNC_N2_POINTER_WIDTH4_test_1 BUS_SYNC_w2r ( .clk(r_clk), .rst(rrst_n), 
        .IN(gray_wptr), .OUT(gray_wptr_afterSYNC), .test_si(
        gray_rptr_afterSYNC[3]), .test_se(test_se) );
  BUS_SYNC_N2_POINTER_WIDTH4_test_0 BUS_SYNC_r2w ( .clk(w_clk), .rst(wrst_n), 
        .IN(gray_rptr), .OUT(gray_rptr_afterSYNC), .test_si(test_si1), 
        .test_se(test_se) );
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
         \regArr[4][0] , N36, N37, N38, N39, N40, N41, N42, N43, n177, n178,
         n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200,
         n201, n202, n203, n204, n205, n206, n207, n208, n209, n210, n211,
         n212, n213, n214, n215, n216, n217, n218, n219, n220, n221, n222,
         n223, n224, n225, n226, n227, n228, n229, n230, n231, n232, n233,
         n234, n235, n236, n237, n238, n239, n240, n241, n242, n243, n244,
         n245, n246, n247, n248, n249, n250, n251, n252, n253, n254, n255,
         n256, n257, n258, n259, n260, n261, n262, n263, n264, n265, n266,
         n267, n268, n269, n270, n271, n272, n273, n274, n275, n276, n277,
         n278, n279, n280, n281, n282, n283, n284, n285, n286, n287, n288,
         n289, n290, n291, n292, n293, n294, n295, n296, n297, n298, n299,
         n300, n301, n302, n303, n304, n305, n306, n307, n308, n309, n310,
         n311, n312, n313, n138, n139, n140, n141, n142, n143, n144, n145,
         n146, n147, n148, n149, n150, n151, n152, n153, n154, n155, n156,
         n157, n158, n159, n160, n161, n162, n163, n164, n165, n166, n167,
         n168, n169, n170, n171, n172, n173, n174, n175, n176, n314, n315,
         n316, n317, n318, n319, n320, n321, n322, n323, n324, n325, n326,
         n327, n328, n329, n330, n331, n332, n333, n334, n335, n336, n337,
         n338, n339, n340, n341, n342, n343, n344, n345, n346, n347, n348,
         n349, n350, n351, n352, n353, n354, n355, n356, n357, n358, n359,
         n360, n361, n362, n363, n364, n365, n366;
  assign N11 = Address[0];
  assign N12 = Address[1];
  assign N13 = Address[2];
  assign N14 = Address[3];
  assign test_so2 = \regArr[15][7] ;
  assign test_so1 = \regArr[4][7] ;

  SDFFSQX2M \regArr_reg[3][5]  ( .D(n215), .SI(REG3[4]), .SE(test_se), .CK(
        n153), .SN(n138), .Q(REG3[5]) );
  SDFFRQX2M \RdData_reg[7]  ( .D(n184), .SI(RdData[6]), .SE(test_se), .CK(n153), .RN(n138), .Q(RdData[7]) );
  SDFFRQX2M \RdData_reg[3]  ( .D(n180), .SI(RdData[2]), .SE(test_se), .CK(n162), .RN(n147), .Q(RdData[3]) );
  SDFFRQX2M \RdData_reg[2]  ( .D(n179), .SI(RdData[1]), .SE(test_se), .CK(n162), .RN(n147), .Q(RdData[2]) );
  SDFFRQX2M \RdData_reg[1]  ( .D(n178), .SI(RdData[0]), .SE(test_se), .CK(n162), .RN(n147), .Q(RdData[1]) );
  SDFFRQX2M \RdData_reg[0]  ( .D(n177), .SI(RdData_VLD), .SE(test_se), .CK(
        n162), .RN(n146), .Q(RdData[0]) );
  SDFFRQX2M \RdData_reg[6]  ( .D(n183), .SI(RdData[5]), .SE(test_se), .CK(n163), .RN(n147), .Q(RdData[6]) );
  SDFFRQX2M \RdData_reg[5]  ( .D(n182), .SI(RdData[4]), .SE(test_se), .CK(n163), .RN(n147), .Q(RdData[5]) );
  SDFFRQX2M \RdData_reg[4]  ( .D(n181), .SI(RdData[3]), .SE(test_se), .CK(n163), .RN(n147), .Q(RdData[4]) );
  SDFFRQX2M \regArr_reg[13][7]  ( .D(n297), .SI(\regArr[13][6] ), .SE(test_se), 
        .CK(n156), .RN(n140), .Q(\regArr[13][7] ) );
  SDFFRQX2M \regArr_reg[13][6]  ( .D(n296), .SI(\regArr[13][5] ), .SE(test_se), 
        .CK(n156), .RN(n140), .Q(\regArr[13][6] ) );
  SDFFRQX2M \regArr_reg[13][5]  ( .D(n295), .SI(\regArr[13][4] ), .SE(test_se), 
        .CK(n155), .RN(n140), .Q(\regArr[13][5] ) );
  SDFFRQX2M \regArr_reg[13][4]  ( .D(n294), .SI(\regArr[13][3] ), .SE(test_se), 
        .CK(n156), .RN(n141), .Q(\regArr[13][4] ) );
  SDFFRQX2M \regArr_reg[13][3]  ( .D(n293), .SI(\regArr[13][2] ), .SE(test_se), 
        .CK(n155), .RN(n140), .Q(\regArr[13][3] ) );
  SDFFRQX2M \regArr_reg[13][2]  ( .D(n292), .SI(\regArr[13][1] ), .SE(test_se), 
        .CK(n155), .RN(n140), .Q(\regArr[13][2] ) );
  SDFFRQX2M \regArr_reg[13][1]  ( .D(n291), .SI(\regArr[13][0] ), .SE(test_se), 
        .CK(n158), .RN(n142), .Q(\regArr[13][1] ) );
  SDFFRQX2M \regArr_reg[13][0]  ( .D(n290), .SI(\regArr[12][7] ), .SE(test_se), 
        .CK(n155), .RN(n140), .Q(\regArr[13][0] ) );
  SDFFRQX2M \regArr_reg[9][7]  ( .D(n265), .SI(\regArr[9][6] ), .SE(test_se), 
        .CK(n154), .RN(n139), .Q(\regArr[9][7] ) );
  SDFFRQX2M \regArr_reg[9][6]  ( .D(n264), .SI(\regArr[9][5] ), .SE(test_se), 
        .CK(n154), .RN(n139), .Q(\regArr[9][6] ) );
  SDFFRQX2M \regArr_reg[9][5]  ( .D(n263), .SI(\regArr[9][4] ), .SE(test_se), 
        .CK(n155), .RN(n140), .Q(\regArr[9][5] ) );
  SDFFRQX2M \regArr_reg[9][4]  ( .D(n262), .SI(\regArr[9][3] ), .SE(test_se), 
        .CK(n154), .RN(n139), .Q(\regArr[9][4] ) );
  SDFFRQX2M \regArr_reg[9][3]  ( .D(n261), .SI(\regArr[9][2] ), .SE(test_se), 
        .CK(n154), .RN(n139), .Q(\regArr[9][3] ) );
  SDFFRQX2M \regArr_reg[9][2]  ( .D(n260), .SI(\regArr[9][1] ), .SE(test_se), 
        .CK(n154), .RN(n139), .Q(\regArr[9][2] ) );
  SDFFRQX2M \regArr_reg[9][1]  ( .D(n259), .SI(\regArr[9][0] ), .SE(test_se), 
        .CK(n154), .RN(n139), .Q(\regArr[9][1] ) );
  SDFFRQX2M \regArr_reg[9][0]  ( .D(n258), .SI(\regArr[8][7] ), .SE(test_se), 
        .CK(n154), .RN(n139), .Q(\regArr[9][0] ) );
  SDFFRQX2M \regArr_reg[5][7]  ( .D(n233), .SI(\regArr[5][6] ), .SE(test_se), 
        .CK(n158), .RN(n143), .Q(\regArr[5][7] ) );
  SDFFRQX2M \regArr_reg[5][6]  ( .D(n232), .SI(\regArr[5][5] ), .SE(test_se), 
        .CK(n158), .RN(n143), .Q(\regArr[5][6] ) );
  SDFFRQX2M \regArr_reg[5][5]  ( .D(n231), .SI(\regArr[5][4] ), .SE(test_se), 
        .CK(n158), .RN(n143), .Q(\regArr[5][5] ) );
  SDFFRQX2M \regArr_reg[5][4]  ( .D(n230), .SI(\regArr[5][3] ), .SE(test_se), 
        .CK(n158), .RN(n143), .Q(\regArr[5][4] ) );
  SDFFRQX2M \regArr_reg[5][3]  ( .D(n229), .SI(\regArr[5][2] ), .SE(test_se), 
        .CK(n158), .RN(n143), .Q(\regArr[5][3] ) );
  SDFFRQX2M \regArr_reg[5][2]  ( .D(n228), .SI(\regArr[5][1] ), .SE(test_se), 
        .CK(n158), .RN(n142), .Q(\regArr[5][2] ) );
  SDFFRQX2M \regArr_reg[5][1]  ( .D(n227), .SI(\regArr[5][0] ), .SE(test_se), 
        .CK(n158), .RN(n142), .Q(\regArr[5][1] ) );
  SDFFRQX2M \regArr_reg[5][0]  ( .D(n226), .SI(test_si2), .SE(test_se), .CK(
        n158), .RN(n142), .Q(\regArr[5][0] ) );
  SDFFRQX2M \regArr_reg[15][7]  ( .D(n313), .SI(\regArr[15][6] ), .SE(test_se), 
        .CK(n156), .RN(n141), .Q(\regArr[15][7] ) );
  SDFFRQX2M \regArr_reg[15][6]  ( .D(n312), .SI(\regArr[15][5] ), .SE(test_se), 
        .CK(n157), .RN(n141), .Q(\regArr[15][6] ) );
  SDFFRQX2M \regArr_reg[15][5]  ( .D(n311), .SI(\regArr[15][4] ), .SE(test_se), 
        .CK(n156), .RN(n141), .Q(\regArr[15][5] ) );
  SDFFRQX2M \regArr_reg[15][4]  ( .D(n310), .SI(\regArr[15][3] ), .SE(test_se), 
        .CK(n156), .RN(n141), .Q(\regArr[15][4] ) );
  SDFFRQX2M \regArr_reg[15][3]  ( .D(n309), .SI(\regArr[15][2] ), .SE(test_se), 
        .CK(n156), .RN(n141), .Q(\regArr[15][3] ) );
  SDFFRQX2M \regArr_reg[15][2]  ( .D(n308), .SI(\regArr[15][1] ), .SE(test_se), 
        .CK(n156), .RN(n141), .Q(\regArr[15][2] ) );
  SDFFRQX2M \regArr_reg[15][1]  ( .D(n307), .SI(\regArr[15][0] ), .SE(test_se), 
        .CK(n156), .RN(n141), .Q(\regArr[15][1] ) );
  SDFFRQX2M \regArr_reg[15][0]  ( .D(n306), .SI(\regArr[14][7] ), .SE(test_se), 
        .CK(n156), .RN(n141), .Q(\regArr[15][0] ) );
  SDFFRQX2M \regArr_reg[11][7]  ( .D(n281), .SI(\regArr[11][6] ), .SE(test_se), 
        .CK(n155), .RN(n140), .Q(\regArr[11][7] ) );
  SDFFRQX2M \regArr_reg[11][6]  ( .D(n280), .SI(\regArr[11][5] ), .SE(test_se), 
        .CK(n155), .RN(n140), .Q(\regArr[11][6] ) );
  SDFFRQX2M \regArr_reg[11][5]  ( .D(n279), .SI(\regArr[11][4] ), .SE(test_se), 
        .CK(n155), .RN(n140), .Q(\regArr[11][5] ) );
  SDFFRQX2M \regArr_reg[11][4]  ( .D(n278), .SI(\regArr[11][3] ), .SE(test_se), 
        .CK(n155), .RN(n140), .Q(\regArr[11][4] ) );
  SDFFRQX2M \regArr_reg[11][3]  ( .D(n277), .SI(\regArr[11][2] ), .SE(test_se), 
        .CK(n155), .RN(n140), .Q(\regArr[11][3] ) );
  SDFFRQX2M \regArr_reg[11][2]  ( .D(n276), .SI(\regArr[11][1] ), .SE(test_se), 
        .CK(n155), .RN(n140), .Q(\regArr[11][2] ) );
  SDFFRQX2M \regArr_reg[11][1]  ( .D(n275), .SI(\regArr[11][0] ), .SE(test_se), 
        .CK(n155), .RN(n140), .Q(\regArr[11][1] ) );
  SDFFRQX2M \regArr_reg[11][0]  ( .D(n274), .SI(\regArr[10][7] ), .SE(test_se), 
        .CK(n155), .RN(n139), .Q(\regArr[11][0] ) );
  SDFFRQX2M \regArr_reg[7][7]  ( .D(n249), .SI(\regArr[7][6] ), .SE(test_se), 
        .CK(n159), .RN(n143), .Q(\regArr[7][7] ) );
  SDFFRQX2M \regArr_reg[7][6]  ( .D(n248), .SI(\regArr[7][5] ), .SE(test_se), 
        .CK(n159), .RN(n143), .Q(\regArr[7][6] ) );
  SDFFRQX2M \regArr_reg[7][5]  ( .D(n247), .SI(\regArr[7][4] ), .SE(test_se), 
        .CK(n159), .RN(n143), .Q(\regArr[7][5] ) );
  SDFFRQX2M \regArr_reg[7][4]  ( .D(n246), .SI(\regArr[7][3] ), .SE(test_se), 
        .CK(n159), .RN(n143), .Q(\regArr[7][4] ) );
  SDFFRQX2M \regArr_reg[7][3]  ( .D(n245), .SI(\regArr[7][2] ), .SE(test_se), 
        .CK(n158), .RN(n143), .Q(\regArr[7][3] ) );
  SDFFRQX2M \regArr_reg[7][2]  ( .D(n244), .SI(\regArr[7][1] ), .SE(test_se), 
        .CK(n158), .RN(n143), .Q(\regArr[7][2] ) );
  SDFFRQX2M \regArr_reg[7][1]  ( .D(n243), .SI(\regArr[7][0] ), .SE(test_se), 
        .CK(n158), .RN(n143), .Q(\regArr[7][1] ) );
  SDFFRQX2M \regArr_reg[7][0]  ( .D(n242), .SI(\regArr[6][7] ), .SE(test_se), 
        .CK(n158), .RN(n143), .Q(\regArr[7][0] ) );
  SDFFRQX2M \regArr_reg[14][7]  ( .D(n305), .SI(\regArr[14][6] ), .SE(test_se), 
        .CK(n161), .RN(n146), .Q(\regArr[14][7] ) );
  SDFFRQX2M \regArr_reg[14][6]  ( .D(n304), .SI(\regArr[14][5] ), .SE(test_se), 
        .CK(n161), .RN(n146), .Q(\regArr[14][6] ) );
  SDFFRQX2M \regArr_reg[14][5]  ( .D(n303), .SI(\regArr[14][4] ), .SE(test_se), 
        .CK(n161), .RN(n146), .Q(\regArr[14][5] ) );
  SDFFRQX2M \regArr_reg[14][4]  ( .D(n302), .SI(\regArr[14][3] ), .SE(test_se), 
        .CK(n161), .RN(n145), .Q(\regArr[14][4] ) );
  SDFFRQX2M \regArr_reg[14][3]  ( .D(n301), .SI(\regArr[14][2] ), .SE(test_se), 
        .CK(n161), .RN(n145), .Q(\regArr[14][3] ) );
  SDFFRQX2M \regArr_reg[14][2]  ( .D(n300), .SI(\regArr[14][1] ), .SE(test_se), 
        .CK(n161), .RN(n145), .Q(\regArr[14][2] ) );
  SDFFRQX2M \regArr_reg[14][1]  ( .D(n299), .SI(\regArr[14][0] ), .SE(test_se), 
        .CK(n161), .RN(n145), .Q(\regArr[14][1] ) );
  SDFFRQX2M \regArr_reg[14][0]  ( .D(n298), .SI(\regArr[13][7] ), .SE(test_se), 
        .CK(n161), .RN(n145), .Q(\regArr[14][0] ) );
  SDFFRQX2M \regArr_reg[10][7]  ( .D(n273), .SI(\regArr[10][6] ), .SE(test_se), 
        .CK(n160), .RN(n145), .Q(\regArr[10][7] ) );
  SDFFRQX2M \regArr_reg[10][6]  ( .D(n272), .SI(\regArr[10][5] ), .SE(test_se), 
        .CK(n160), .RN(n144), .Q(\regArr[10][6] ) );
  SDFFRQX2M \regArr_reg[10][5]  ( .D(n271), .SI(\regArr[10][4] ), .SE(test_se), 
        .CK(n160), .RN(n144), .Q(\regArr[10][5] ) );
  SDFFRQX2M \regArr_reg[10][4]  ( .D(n270), .SI(\regArr[10][3] ), .SE(test_se), 
        .CK(n160), .RN(n144), .Q(\regArr[10][4] ) );
  SDFFRQX2M \regArr_reg[10][3]  ( .D(n269), .SI(\regArr[10][2] ), .SE(test_se), 
        .CK(n160), .RN(n144), .Q(\regArr[10][3] ) );
  SDFFRQX2M \regArr_reg[10][2]  ( .D(n268), .SI(\regArr[10][1] ), .SE(test_se), 
        .CK(n160), .RN(n144), .Q(\regArr[10][2] ) );
  SDFFRQX2M \regArr_reg[10][1]  ( .D(n267), .SI(\regArr[10][0] ), .SE(test_se), 
        .CK(n160), .RN(n144), .Q(\regArr[10][1] ) );
  SDFFRQX2M \regArr_reg[10][0]  ( .D(n266), .SI(\regArr[9][7] ), .SE(test_se), 
        .CK(n159), .RN(n144), .Q(\regArr[10][0] ) );
  SDFFRQX2M \regArr_reg[6][3]  ( .D(n237), .SI(\regArr[6][2] ), .SE(test_se), 
        .CK(n162), .RN(n147), .Q(\regArr[6][3] ) );
  SDFFRQX2M \regArr_reg[6][2]  ( .D(n236), .SI(\regArr[6][1] ), .SE(test_se), 
        .CK(n162), .RN(n147), .Q(\regArr[6][2] ) );
  SDFFRQX2M \regArr_reg[6][1]  ( .D(n235), .SI(\regArr[6][0] ), .SE(test_se), 
        .CK(n162), .RN(n146), .Q(\regArr[6][1] ) );
  SDFFRQX2M \regArr_reg[6][0]  ( .D(n234), .SI(\regArr[5][7] ), .SE(test_se), 
        .CK(n162), .RN(n146), .Q(\regArr[6][0] ) );
  SDFFRQX2M \regArr_reg[6][7]  ( .D(n241), .SI(\regArr[6][6] ), .SE(test_se), 
        .CK(n163), .RN(n147), .Q(\regArr[6][7] ) );
  SDFFRQX2M \regArr_reg[6][6]  ( .D(n240), .SI(\regArr[6][5] ), .SE(test_se), 
        .CK(n163), .RN(n147), .Q(\regArr[6][6] ) );
  SDFFRQX2M \regArr_reg[6][5]  ( .D(n239), .SI(\regArr[6][4] ), .SE(test_se), 
        .CK(n163), .RN(n147), .Q(\regArr[6][5] ) );
  SDFFRQX2M \regArr_reg[6][4]  ( .D(n238), .SI(\regArr[6][3] ), .SE(test_se), 
        .CK(n163), .RN(n147), .Q(\regArr[6][4] ) );
  SDFFRQX2M \regArr_reg[12][7]  ( .D(n289), .SI(\regArr[12][6] ), .SE(test_se), 
        .CK(n161), .RN(n145), .Q(\regArr[12][7] ) );
  SDFFRQX2M \regArr_reg[12][6]  ( .D(n288), .SI(\regArr[12][5] ), .SE(test_se), 
        .CK(n161), .RN(n145), .Q(\regArr[12][6] ) );
  SDFFRQX2M \regArr_reg[12][5]  ( .D(n287), .SI(\regArr[12][4] ), .SE(test_se), 
        .CK(n160), .RN(n145), .Q(\regArr[12][5] ) );
  SDFFRQX2M \regArr_reg[12][4]  ( .D(n286), .SI(\regArr[12][3] ), .SE(test_se), 
        .CK(n160), .RN(n145), .Q(\regArr[12][4] ) );
  SDFFRQX2M \regArr_reg[12][3]  ( .D(n285), .SI(\regArr[12][2] ), .SE(test_se), 
        .CK(n160), .RN(n145), .Q(\regArr[12][3] ) );
  SDFFRQX2M \regArr_reg[12][2]  ( .D(n284), .SI(\regArr[12][1] ), .SE(test_se), 
        .CK(n160), .RN(n145), .Q(\regArr[12][2] ) );
  SDFFRQX2M \regArr_reg[12][1]  ( .D(n283), .SI(\regArr[12][0] ), .SE(test_se), 
        .CK(n160), .RN(n145), .Q(\regArr[12][1] ) );
  SDFFRQX2M \regArr_reg[12][0]  ( .D(n282), .SI(\regArr[11][7] ), .SE(test_se), 
        .CK(n160), .RN(n145), .Q(\regArr[12][0] ) );
  SDFFRQX2M \regArr_reg[8][7]  ( .D(n257), .SI(\regArr[8][6] ), .SE(test_se), 
        .CK(n159), .RN(n144), .Q(\regArr[8][7] ) );
  SDFFRQX2M \regArr_reg[8][6]  ( .D(n256), .SI(\regArr[8][5] ), .SE(test_se), 
        .CK(n159), .RN(n144), .Q(\regArr[8][6] ) );
  SDFFRQX2M \regArr_reg[8][5]  ( .D(n255), .SI(\regArr[8][4] ), .SE(test_se), 
        .CK(n159), .RN(n144), .Q(\regArr[8][5] ) );
  SDFFRQX2M \regArr_reg[8][4]  ( .D(n254), .SI(\regArr[8][3] ), .SE(test_se), 
        .CK(n159), .RN(n144), .Q(\regArr[8][4] ) );
  SDFFRQX2M \regArr_reg[8][3]  ( .D(n253), .SI(\regArr[8][2] ), .SE(test_se), 
        .CK(n159), .RN(n144), .Q(\regArr[8][3] ) );
  SDFFRQX2M \regArr_reg[8][2]  ( .D(n252), .SI(\regArr[8][1] ), .SE(test_se), 
        .CK(n159), .RN(n144), .Q(\regArr[8][2] ) );
  SDFFRQX2M \regArr_reg[8][1]  ( .D(n251), .SI(\regArr[8][0] ), .SE(test_se), 
        .CK(n159), .RN(n144), .Q(\regArr[8][1] ) );
  SDFFRQX2M \regArr_reg[8][0]  ( .D(n250), .SI(\regArr[7][7] ), .SE(test_se), 
        .CK(n159), .RN(n143), .Q(\regArr[8][0] ) );
  SDFFRQX2M \regArr_reg[4][7]  ( .D(n225), .SI(\regArr[4][6] ), .SE(test_se), 
        .CK(n162), .RN(n146), .Q(\regArr[4][7] ) );
  SDFFRQX2M \regArr_reg[4][6]  ( .D(n224), .SI(\regArr[4][5] ), .SE(test_se), 
        .CK(n162), .RN(n146), .Q(\regArr[4][6] ) );
  SDFFRQX2M \regArr_reg[4][5]  ( .D(n223), .SI(\regArr[4][4] ), .SE(test_se), 
        .CK(n162), .RN(n146), .Q(\regArr[4][5] ) );
  SDFFRQX2M \regArr_reg[4][4]  ( .D(n222), .SI(\regArr[4][3] ), .SE(test_se), 
        .CK(n162), .RN(n146), .Q(\regArr[4][4] ) );
  SDFFRQX2M \regArr_reg[4][3]  ( .D(n221), .SI(\regArr[4][2] ), .SE(test_se), 
        .CK(n162), .RN(n146), .Q(\regArr[4][3] ) );
  SDFFRQX2M \regArr_reg[4][2]  ( .D(n220), .SI(\regArr[4][1] ), .SE(test_se), 
        .CK(n161), .RN(n146), .Q(\regArr[4][2] ) );
  SDFFRQX2M \regArr_reg[4][1]  ( .D(n219), .SI(\regArr[4][0] ), .SE(test_se), 
        .CK(n161), .RN(n146), .Q(\regArr[4][1] ) );
  SDFFRQX2M \regArr_reg[4][0]  ( .D(n218), .SI(REG3[7]), .SE(test_se), .CK(
        n161), .RN(n146), .Q(\regArr[4][0] ) );
  SDFFRQX2M RdData_VLD_reg ( .D(n185), .SI(test_si1), .SE(test_se), .CK(n154), 
        .RN(n139), .Q(RdData_VLD) );
  SDFFRQX2M \regArr_reg[3][6]  ( .D(n216), .SI(REG3[5]), .SE(test_se), .CK(
        n157), .RN(n142), .Q(REG3[6]) );
  SDFFRQX2M \regArr_reg[3][7]  ( .D(n217), .SI(REG3[6]), .SE(test_se), .CK(
        n157), .RN(n142), .Q(REG3[7]) );
  SDFFSQX2M \regArr_reg[2][7]  ( .D(n209), .SI(REG2[6]), .SE(test_se), .CK(
        n153), .SN(n138), .Q(REG2[7]) );
  SDFFRQX2M \regArr_reg[3][0]  ( .D(n210), .SI(REG2[7]), .SE(test_se), .CK(
        n157), .RN(n142), .Q(REG3[0]) );
  SDFFRQX2M \regArr_reg[2][2]  ( .D(n204), .SI(REG2[1]), .SE(test_se), .CK(
        n154), .RN(n139), .Q(REG2[2]) );
  SDFFRQX2M \regArr_reg[2][1]  ( .D(n203), .SI(REG2[0]), .SE(test_se), .CK(
        n153), .RN(n138), .Q(REG2[1]) );
  SDFFSQX2M \regArr_reg[2][0]  ( .D(n202), .SI(REG1[7]), .SE(test_se), .CK(
        n153), .SN(n138), .Q(REG2[0]) );
  SDFFRQX2M \regArr_reg[3][3]  ( .D(n213), .SI(REG3[2]), .SE(test_se), .CK(
        n157), .RN(n142), .Q(REG3[3]) );
  SDFFRQX2M \regArr_reg[3][2]  ( .D(n212), .SI(REG3[1]), .SE(test_se), .CK(
        n157), .RN(n142), .Q(REG3[2]) );
  SDFFRQX2M \regArr_reg[3][4]  ( .D(n214), .SI(REG3[3]), .SE(test_se), .CK(
        n157), .RN(n142), .Q(REG3[4]) );
  SDFFRQX2M \regArr_reg[3][1]  ( .D(n211), .SI(REG3[0]), .SE(test_se), .CK(
        n157), .RN(n142), .Q(REG3[1]) );
  SDFFRQX2M \regArr_reg[2][6]  ( .D(n208), .SI(REG2[5]), .SE(test_se), .CK(
        n153), .RN(n138), .Q(REG2[6]) );
  SDFFRQX2M \regArr_reg[2][4]  ( .D(n206), .SI(REG2[3]), .SE(test_se), .CK(
        n153), .RN(n138), .Q(REG2[4]) );
  SDFFRQX2M \regArr_reg[2][3]  ( .D(n205), .SI(REG2[2]), .SE(test_se), .CK(
        n153), .RN(n138), .Q(REG2[3]) );
  SDFFRQX2M \regArr_reg[2][5]  ( .D(n207), .SI(REG2[4]), .SE(test_se), .CK(
        n153), .RN(n138), .Q(REG2[5]) );
  SDFFRQX2M \regArr_reg[1][1]  ( .D(n195), .SI(REG1[0]), .SE(test_se), .CK(
        n156), .RN(n141), .Q(REG1[1]) );
  SDFFRQX2M \regArr_reg[1][5]  ( .D(n199), .SI(REG1[4]), .SE(test_se), .CK(
        n157), .RN(n141), .Q(REG1[5]) );
  SDFFRQX2M \regArr_reg[1][3]  ( .D(n197), .SI(REG1[2]), .SE(test_se), .CK(
        n157), .RN(n142), .Q(REG1[3]) );
  SDFFRQX2M \regArr_reg[1][0]  ( .D(n194), .SI(REG0[7]), .SE(test_se), .CK(
        n156), .RN(n141), .Q(REG1[0]) );
  SDFFRQX2M \regArr_reg[1][6]  ( .D(n200), .SI(REG1[5]), .SE(test_se), .CK(
        n157), .RN(n142), .Q(REG1[6]) );
  SDFFRQX2M \regArr_reg[1][7]  ( .D(n201), .SI(REG1[6]), .SE(test_se), .CK(
        n157), .RN(n142), .Q(REG1[7]) );
  SDFFRQX2M \regArr_reg[1][2]  ( .D(n196), .SI(REG1[1]), .SE(test_se), .CK(
        n156), .RN(n141), .Q(REG1[2]) );
  SDFFRQX2M \regArr_reg[1][4]  ( .D(n198), .SI(REG1[3]), .SE(test_se), .CK(
        n157), .RN(n141), .Q(REG1[4]) );
  SDFFRQX2M \regArr_reg[0][0]  ( .D(n186), .SI(RdData[7]), .SE(test_se), .CK(
        n154), .RN(n139), .Q(REG0[0]) );
  SDFFRQX2M \regArr_reg[0][2]  ( .D(n188), .SI(REG0[1]), .SE(test_se), .CK(
        n153), .RN(n138), .Q(REG0[2]) );
  SDFFRQX2M \regArr_reg[0][5]  ( .D(n191), .SI(REG0[4]), .SE(test_se), .CK(
        n153), .RN(n138), .Q(REG0[5]) );
  SDFFRQX2M \regArr_reg[0][7]  ( .D(n193), .SI(REG0[6]), .SE(test_se), .CK(
        n154), .RN(n139), .Q(REG0[7]) );
  SDFFRQX2M \regArr_reg[0][3]  ( .D(n189), .SI(REG0[2]), .SE(test_se), .CK(
        n153), .RN(n138), .Q(REG0[3]) );
  SDFFRQX2M \regArr_reg[0][6]  ( .D(n192), .SI(REG0[5]), .SE(test_se), .CK(
        n154), .RN(n139), .Q(REG0[6]) );
  SDFFRQX2M \regArr_reg[0][4]  ( .D(n190), .SI(REG0[3]), .SE(test_se), .CK(
        n154), .RN(n139), .Q(REG0[4]) );
  SDFFRQX2M \regArr_reg[0][1]  ( .D(n187), .SI(REG0[0]), .SE(test_se), .CK(
        n153), .RN(n138), .Q(REG0[1]) );
  NOR3BXLM U140 ( .AN(n350), .B(N11), .C(N14), .Y(n356) );
  INVXLM U141 ( .A(N11), .Y(n352) );
  INVXLM U142 ( .A(N12), .Y(n358) );
  NOR2XLM U143 ( .A(n357), .B(N12), .Y(n343) );
  NOR3BXLM U144 ( .AN(n350), .B(N14), .C(n352), .Y(n354) );
  AND3XLM U145 ( .A(n350), .B(N11), .C(N14), .Y(n338) );
  AND3XLM U146 ( .A(n350), .B(n352), .C(N14), .Y(n341) );
  BUFX2M U147 ( .A(n150), .Y(n143) );
  BUFX2M U148 ( .A(n149), .Y(n144) );
  BUFX2M U149 ( .A(n152), .Y(n139) );
  BUFX2M U150 ( .A(n150), .Y(n142) );
  BUFX2M U151 ( .A(n151), .Y(n140) );
  BUFX2M U152 ( .A(n149), .Y(n145) );
  BUFX2M U153 ( .A(n148), .Y(n146) );
  BUFX2M U154 ( .A(n151), .Y(n141) );
  BUFX2M U155 ( .A(n152), .Y(n138) );
  BUFX2M U156 ( .A(n148), .Y(n147) );
  BUFX2M U157 ( .A(n167), .Y(n153) );
  BUFX2M U158 ( .A(n164), .Y(n162) );
  BUFX2M U159 ( .A(n165), .Y(n159) );
  BUFX2M U160 ( .A(n165), .Y(n160) );
  BUFX2M U161 ( .A(n165), .Y(n158) );
  BUFX2M U162 ( .A(n166), .Y(n155) );
  BUFX2M U163 ( .A(n164), .Y(n161) );
  BUFX2M U164 ( .A(n166), .Y(n157) );
  BUFX2M U165 ( .A(n166), .Y(n156) );
  BUFX2M U166 ( .A(n167), .Y(n154) );
  BUFX2M U167 ( .A(n164), .Y(n163) );
  BUFX2M U168 ( .A(RST), .Y(n152) );
  BUFX2M U169 ( .A(RST), .Y(n150) );
  BUFX2M U170 ( .A(RST), .Y(n149) );
  BUFX2M U171 ( .A(RST), .Y(n148) );
  BUFX2M U172 ( .A(RST), .Y(n151) );
  BUFX2M U173 ( .A(CLK), .Y(n165) );
  BUFX2M U174 ( .A(CLK), .Y(n164) );
  BUFX2M U175 ( .A(CLK), .Y(n166) );
  BUFX2M U176 ( .A(CLK), .Y(n167) );
  MX4XLM U177 ( .A(REG0[0]), .B(REG1[0]), .C(REG2[0]), .D(REG3[0]), .S0(N11), 
        .S1(N12), .Y(n171) );
  MX4XLM U178 ( .A(REG0[1]), .B(REG1[1]), .C(REG2[1]), .D(REG3[1]), .S0(N11), 
        .S1(N12), .Y(n175) );
  MX4XLM U179 ( .A(REG0[2]), .B(REG1[2]), .C(REG2[2]), .D(REG3[2]), .S0(N11), 
        .S1(N12), .Y(n316) );
  MX4XLM U180 ( .A(REG0[3]), .B(REG1[3]), .C(REG2[3]), .D(REG3[3]), .S0(N11), 
        .S1(N12), .Y(n320) );
  MX4XLM U181 ( .A(REG0[4]), .B(REG1[4]), .C(REG2[4]), .D(REG3[4]), .S0(N11), 
        .S1(N12), .Y(n324) );
  MX4XLM U182 ( .A(REG0[5]), .B(REG1[5]), .C(REG2[5]), .D(REG3[5]), .S0(N11), 
        .S1(N12), .Y(n328) );
  MX4XLM U183 ( .A(REG0[6]), .B(REG1[6]), .C(REG2[6]), .D(REG3[6]), .S0(N11), 
        .S1(N12), .Y(n332) );
  MX4XLM U184 ( .A(REG0[7]), .B(REG1[7]), .C(REG2[7]), .D(REG3[7]), .S0(N11), 
        .S1(N12), .Y(n336) );
  MX4XLM U185 ( .A(\regArr[4][0] ), .B(\regArr[5][0] ), .C(\regArr[6][0] ), 
        .D(\regArr[7][0] ), .S0(N11), .S1(N12), .Y(n170) );
  MX4XLM U186 ( .A(\regArr[4][1] ), .B(\regArr[5][1] ), .C(\regArr[6][1] ), 
        .D(\regArr[7][1] ), .S0(N11), .S1(N12), .Y(n174) );
  MX4XLM U187 ( .A(\regArr[4][2] ), .B(\regArr[5][2] ), .C(\regArr[6][2] ), 
        .D(\regArr[7][2] ), .S0(N11), .S1(N12), .Y(n315) );
  MX4XLM U188 ( .A(\regArr[4][3] ), .B(\regArr[5][3] ), .C(\regArr[6][3] ), 
        .D(\regArr[7][3] ), .S0(N11), .S1(N12), .Y(n319) );
  MX4XLM U189 ( .A(\regArr[4][4] ), .B(\regArr[5][4] ), .C(\regArr[6][4] ), 
        .D(\regArr[7][4] ), .S0(N11), .S1(N12), .Y(n323) );
  MX4XLM U190 ( .A(\regArr[4][5] ), .B(\regArr[5][5] ), .C(\regArr[6][5] ), 
        .D(\regArr[7][5] ), .S0(N11), .S1(N12), .Y(n327) );
  MX4XLM U191 ( .A(\regArr[4][6] ), .B(\regArr[5][6] ), .C(\regArr[6][6] ), 
        .D(\regArr[7][6] ), .S0(N11), .S1(N12), .Y(n331) );
  MX4XLM U192 ( .A(\regArr[4][7] ), .B(\regArr[5][7] ), .C(\regArr[6][7] ), 
        .D(\regArr[7][7] ), .S0(N11), .S1(N12), .Y(n335) );
  MX4XLM U193 ( .A(n171), .B(n169), .C(n170), .D(n168), .S0(N14), .S1(N13), 
        .Y(N43) );
  MX4XLM U194 ( .A(\regArr[8][0] ), .B(\regArr[9][0] ), .C(\regArr[10][0] ), 
        .D(\regArr[11][0] ), .S0(N11), .S1(N12), .Y(n169) );
  MX4XLM U195 ( .A(\regArr[12][0] ), .B(\regArr[13][0] ), .C(\regArr[14][0] ), 
        .D(\regArr[15][0] ), .S0(N11), .S1(N12), .Y(n168) );
  MX4XLM U196 ( .A(n175), .B(n173), .C(n174), .D(n172), .S0(N14), .S1(N13), 
        .Y(N42) );
  MX4XLM U197 ( .A(\regArr[8][1] ), .B(\regArr[9][1] ), .C(\regArr[10][1] ), 
        .D(\regArr[11][1] ), .S0(N11), .S1(N12), .Y(n173) );
  MX4XLM U198 ( .A(\regArr[12][1] ), .B(\regArr[13][1] ), .C(\regArr[14][1] ), 
        .D(\regArr[15][1] ), .S0(N11), .S1(N12), .Y(n172) );
  MX4XLM U199 ( .A(n316), .B(n314), .C(n315), .D(n176), .S0(N14), .S1(N13), 
        .Y(N41) );
  MX4XLM U200 ( .A(\regArr[8][2] ), .B(\regArr[9][2] ), .C(\regArr[10][2] ), 
        .D(\regArr[11][2] ), .S0(N11), .S1(N12), .Y(n314) );
  MX4XLM U201 ( .A(\regArr[12][2] ), .B(\regArr[13][2] ), .C(\regArr[14][2] ), 
        .D(\regArr[15][2] ), .S0(N11), .S1(N12), .Y(n176) );
  MX4XLM U202 ( .A(n320), .B(n318), .C(n319), .D(n317), .S0(N14), .S1(N13), 
        .Y(N40) );
  MX4XLM U203 ( .A(\regArr[8][3] ), .B(\regArr[9][3] ), .C(\regArr[10][3] ), 
        .D(\regArr[11][3] ), .S0(N11), .S1(N12), .Y(n318) );
  MX4XLM U204 ( .A(\regArr[12][3] ), .B(\regArr[13][3] ), .C(\regArr[14][3] ), 
        .D(\regArr[15][3] ), .S0(N11), .S1(N12), .Y(n317) );
  MX4XLM U205 ( .A(n324), .B(n322), .C(n323), .D(n321), .S0(N14), .S1(N13), 
        .Y(N39) );
  MX4XLM U206 ( .A(\regArr[8][4] ), .B(\regArr[9][4] ), .C(\regArr[10][4] ), 
        .D(\regArr[11][4] ), .S0(N11), .S1(N12), .Y(n322) );
  MX4XLM U207 ( .A(\regArr[12][4] ), .B(\regArr[13][4] ), .C(\regArr[14][4] ), 
        .D(\regArr[15][4] ), .S0(N11), .S1(N12), .Y(n321) );
  MX4XLM U208 ( .A(n328), .B(n326), .C(n327), .D(n325), .S0(N14), .S1(N13), 
        .Y(N38) );
  MX4XLM U209 ( .A(\regArr[8][5] ), .B(\regArr[9][5] ), .C(\regArr[10][5] ), 
        .D(\regArr[11][5] ), .S0(N11), .S1(N12), .Y(n326) );
  MX4XLM U210 ( .A(\regArr[12][5] ), .B(\regArr[13][5] ), .C(\regArr[14][5] ), 
        .D(\regArr[15][5] ), .S0(N11), .S1(N12), .Y(n325) );
  MX4XLM U211 ( .A(n332), .B(n330), .C(n331), .D(n329), .S0(N14), .S1(N13), 
        .Y(N37) );
  MX4XLM U212 ( .A(\regArr[8][6] ), .B(\regArr[9][6] ), .C(\regArr[10][6] ), 
        .D(\regArr[11][6] ), .S0(N11), .S1(N12), .Y(n330) );
  MX4XLM U213 ( .A(\regArr[12][6] ), .B(\regArr[13][6] ), .C(\regArr[14][6] ), 
        .D(\regArr[15][6] ), .S0(N11), .S1(N12), .Y(n329) );
  MX4XLM U214 ( .A(n336), .B(n334), .C(n335), .D(n333), .S0(N14), .S1(N13), 
        .Y(N36) );
  MX4XLM U215 ( .A(\regArr[8][7] ), .B(\regArr[9][7] ), .C(\regArr[10][7] ), 
        .D(\regArr[11][7] ), .S0(N11), .S1(N12), .Y(n334) );
  MX4XLM U216 ( .A(\regArr[12][7] ), .B(\regArr[13][7] ), .C(\regArr[14][7] ), 
        .D(\regArr[15][7] ), .S0(N11), .S1(N12), .Y(n333) );
  CLKMX2X2M U217 ( .A(\regArr[15][7] ), .B(WrData[7]), .S0(n337), .Y(n313) );
  CLKMX2X2M U218 ( .A(\regArr[15][6] ), .B(WrData[6]), .S0(n337), .Y(n312) );
  CLKMX2X2M U219 ( .A(\regArr[15][5] ), .B(WrData[5]), .S0(n337), .Y(n311) );
  CLKMX2X2M U220 ( .A(\regArr[15][4] ), .B(WrData[4]), .S0(n337), .Y(n310) );
  CLKMX2X2M U221 ( .A(\regArr[15][3] ), .B(WrData[3]), .S0(n337), .Y(n309) );
  CLKMX2X2M U222 ( .A(\regArr[15][2] ), .B(WrData[2]), .S0(n337), .Y(n308) );
  CLKMX2X2M U223 ( .A(\regArr[15][1] ), .B(WrData[1]), .S0(n337), .Y(n307) );
  CLKMX2X2M U224 ( .A(\regArr[15][0] ), .B(WrData[0]), .S0(n337), .Y(n306) );
  AND2X1M U225 ( .A(n338), .B(n339), .Y(n337) );
  CLKMX2X2M U226 ( .A(\regArr[14][7] ), .B(WrData[7]), .S0(n340), .Y(n305) );
  CLKMX2X2M U227 ( .A(\regArr[14][6] ), .B(WrData[6]), .S0(n340), .Y(n304) );
  CLKMX2X2M U228 ( .A(\regArr[14][5] ), .B(WrData[5]), .S0(n340), .Y(n303) );
  CLKMX2X2M U229 ( .A(\regArr[14][4] ), .B(WrData[4]), .S0(n340), .Y(n302) );
  CLKMX2X2M U230 ( .A(\regArr[14][3] ), .B(WrData[3]), .S0(n340), .Y(n301) );
  CLKMX2X2M U231 ( .A(\regArr[14][2] ), .B(WrData[2]), .S0(n340), .Y(n300) );
  CLKMX2X2M U232 ( .A(\regArr[14][1] ), .B(WrData[1]), .S0(n340), .Y(n299) );
  CLKMX2X2M U233 ( .A(\regArr[14][0] ), .B(WrData[0]), .S0(n340), .Y(n298) );
  AND2X1M U234 ( .A(n341), .B(n339), .Y(n340) );
  CLKMX2X2M U235 ( .A(\regArr[13][7] ), .B(WrData[7]), .S0(n342), .Y(n297) );
  CLKMX2X2M U236 ( .A(\regArr[13][6] ), .B(WrData[6]), .S0(n342), .Y(n296) );
  CLKMX2X2M U237 ( .A(\regArr[13][5] ), .B(WrData[5]), .S0(n342), .Y(n295) );
  CLKMX2X2M U238 ( .A(\regArr[13][4] ), .B(WrData[4]), .S0(n342), .Y(n294) );
  CLKMX2X2M U239 ( .A(\regArr[13][3] ), .B(WrData[3]), .S0(n342), .Y(n293) );
  CLKMX2X2M U240 ( .A(\regArr[13][2] ), .B(WrData[2]), .S0(n342), .Y(n292) );
  CLKMX2X2M U241 ( .A(\regArr[13][1] ), .B(WrData[1]), .S0(n342), .Y(n291) );
  CLKMX2X2M U242 ( .A(\regArr[13][0] ), .B(WrData[0]), .S0(n342), .Y(n290) );
  AND2X1M U243 ( .A(n343), .B(n338), .Y(n342) );
  CLKMX2X2M U244 ( .A(\regArr[12][7] ), .B(WrData[7]), .S0(n344), .Y(n289) );
  CLKMX2X2M U245 ( .A(\regArr[12][6] ), .B(WrData[6]), .S0(n344), .Y(n288) );
  CLKMX2X2M U246 ( .A(\regArr[12][5] ), .B(WrData[5]), .S0(n344), .Y(n287) );
  CLKMX2X2M U247 ( .A(\regArr[12][4] ), .B(WrData[4]), .S0(n344), .Y(n286) );
  CLKMX2X2M U248 ( .A(\regArr[12][3] ), .B(WrData[3]), .S0(n344), .Y(n285) );
  CLKMX2X2M U249 ( .A(\regArr[12][2] ), .B(WrData[2]), .S0(n344), .Y(n284) );
  CLKMX2X2M U250 ( .A(\regArr[12][1] ), .B(WrData[1]), .S0(n344), .Y(n283) );
  CLKMX2X2M U251 ( .A(\regArr[12][0] ), .B(WrData[0]), .S0(n344), .Y(n282) );
  AND2X1M U252 ( .A(n343), .B(n341), .Y(n344) );
  CLKMX2X2M U253 ( .A(\regArr[11][7] ), .B(WrData[7]), .S0(n345), .Y(n281) );
  CLKMX2X2M U254 ( .A(\regArr[11][6] ), .B(WrData[6]), .S0(n345), .Y(n280) );
  CLKMX2X2M U255 ( .A(\regArr[11][5] ), .B(WrData[5]), .S0(n345), .Y(n279) );
  CLKMX2X2M U256 ( .A(\regArr[11][4] ), .B(WrData[4]), .S0(n345), .Y(n278) );
  CLKMX2X2M U257 ( .A(\regArr[11][3] ), .B(WrData[3]), .S0(n345), .Y(n277) );
  CLKMX2X2M U258 ( .A(\regArr[11][2] ), .B(WrData[2]), .S0(n345), .Y(n276) );
  CLKMX2X2M U259 ( .A(\regArr[11][1] ), .B(WrData[1]), .S0(n345), .Y(n275) );
  CLKMX2X2M U260 ( .A(\regArr[11][0] ), .B(WrData[0]), .S0(n345), .Y(n274) );
  AND2X1M U261 ( .A(n346), .B(n338), .Y(n345) );
  CLKMX2X2M U262 ( .A(\regArr[10][7] ), .B(WrData[7]), .S0(n347), .Y(n273) );
  CLKMX2X2M U263 ( .A(\regArr[10][6] ), .B(WrData[6]), .S0(n347), .Y(n272) );
  CLKMX2X2M U264 ( .A(\regArr[10][5] ), .B(WrData[5]), .S0(n347), .Y(n271) );
  CLKMX2X2M U265 ( .A(\regArr[10][4] ), .B(WrData[4]), .S0(n347), .Y(n270) );
  CLKMX2X2M U266 ( .A(\regArr[10][3] ), .B(WrData[3]), .S0(n347), .Y(n269) );
  CLKMX2X2M U267 ( .A(\regArr[10][2] ), .B(WrData[2]), .S0(n347), .Y(n268) );
  CLKMX2X2M U268 ( .A(\regArr[10][1] ), .B(WrData[1]), .S0(n347), .Y(n267) );
  CLKMX2X2M U269 ( .A(\regArr[10][0] ), .B(WrData[0]), .S0(n347), .Y(n266) );
  AND2X1M U270 ( .A(n346), .B(n341), .Y(n347) );
  CLKMX2X2M U271 ( .A(\regArr[9][7] ), .B(WrData[7]), .S0(n348), .Y(n265) );
  CLKMX2X2M U272 ( .A(\regArr[9][6] ), .B(WrData[6]), .S0(n348), .Y(n264) );
  CLKMX2X2M U273 ( .A(\regArr[9][5] ), .B(WrData[5]), .S0(n348), .Y(n263) );
  CLKMX2X2M U274 ( .A(\regArr[9][4] ), .B(WrData[4]), .S0(n348), .Y(n262) );
  CLKMX2X2M U275 ( .A(\regArr[9][3] ), .B(WrData[3]), .S0(n348), .Y(n261) );
  CLKMX2X2M U276 ( .A(\regArr[9][2] ), .B(WrData[2]), .S0(n348), .Y(n260) );
  CLKMX2X2M U277 ( .A(\regArr[9][1] ), .B(WrData[1]), .S0(n348), .Y(n259) );
  CLKMX2X2M U278 ( .A(\regArr[9][0] ), .B(WrData[0]), .S0(n348), .Y(n258) );
  AND2X1M U279 ( .A(n349), .B(n338), .Y(n348) );
  CLKMX2X2M U280 ( .A(\regArr[8][7] ), .B(WrData[7]), .S0(n351), .Y(n257) );
  CLKMX2X2M U281 ( .A(\regArr[8][6] ), .B(WrData[6]), .S0(n351), .Y(n256) );
  CLKMX2X2M U282 ( .A(\regArr[8][5] ), .B(WrData[5]), .S0(n351), .Y(n255) );
  CLKMX2X2M U283 ( .A(\regArr[8][4] ), .B(WrData[4]), .S0(n351), .Y(n254) );
  CLKMX2X2M U284 ( .A(\regArr[8][3] ), .B(WrData[3]), .S0(n351), .Y(n253) );
  CLKMX2X2M U285 ( .A(\regArr[8][2] ), .B(WrData[2]), .S0(n351), .Y(n252) );
  CLKMX2X2M U286 ( .A(\regArr[8][1] ), .B(WrData[1]), .S0(n351), .Y(n251) );
  CLKMX2X2M U287 ( .A(\regArr[8][0] ), .B(WrData[0]), .S0(n351), .Y(n250) );
  AND2X1M U288 ( .A(n349), .B(n341), .Y(n351) );
  CLKMX2X2M U289 ( .A(\regArr[7][7] ), .B(WrData[7]), .S0(n353), .Y(n249) );
  CLKMX2X2M U290 ( .A(\regArr[7][6] ), .B(WrData[6]), .S0(n353), .Y(n248) );
  CLKMX2X2M U291 ( .A(\regArr[7][5] ), .B(WrData[5]), .S0(n353), .Y(n247) );
  CLKMX2X2M U292 ( .A(\regArr[7][4] ), .B(WrData[4]), .S0(n353), .Y(n246) );
  CLKMX2X2M U293 ( .A(\regArr[7][3] ), .B(WrData[3]), .S0(n353), .Y(n245) );
  CLKMX2X2M U294 ( .A(\regArr[7][2] ), .B(WrData[2]), .S0(n353), .Y(n244) );
  CLKMX2X2M U295 ( .A(\regArr[7][1] ), .B(WrData[1]), .S0(n353), .Y(n243) );
  CLKMX2X2M U296 ( .A(\regArr[7][0] ), .B(WrData[0]), .S0(n353), .Y(n242) );
  AND2X1M U297 ( .A(n354), .B(n339), .Y(n353) );
  CLKMX2X2M U298 ( .A(\regArr[6][7] ), .B(WrData[7]), .S0(n355), .Y(n241) );
  CLKMX2X2M U299 ( .A(\regArr[6][6] ), .B(WrData[6]), .S0(n355), .Y(n240) );
  CLKMX2X2M U300 ( .A(\regArr[6][5] ), .B(WrData[5]), .S0(n355), .Y(n239) );
  CLKMX2X2M U301 ( .A(\regArr[6][4] ), .B(WrData[4]), .S0(n355), .Y(n238) );
  CLKMX2X2M U302 ( .A(\regArr[6][3] ), .B(WrData[3]), .S0(n355), .Y(n237) );
  CLKMX2X2M U303 ( .A(\regArr[6][2] ), .B(WrData[2]), .S0(n355), .Y(n236) );
  CLKMX2X2M U304 ( .A(\regArr[6][1] ), .B(WrData[1]), .S0(n355), .Y(n235) );
  CLKMX2X2M U305 ( .A(\regArr[6][0] ), .B(WrData[0]), .S0(n355), .Y(n234) );
  AND2X1M U306 ( .A(n356), .B(n339), .Y(n355) );
  NOR2X1M U307 ( .A(n357), .B(n358), .Y(n339) );
  CLKMX2X2M U308 ( .A(\regArr[5][7] ), .B(WrData[7]), .S0(n359), .Y(n233) );
  CLKMX2X2M U309 ( .A(\regArr[5][6] ), .B(WrData[6]), .S0(n359), .Y(n232) );
  CLKMX2X2M U310 ( .A(\regArr[5][5] ), .B(WrData[5]), .S0(n359), .Y(n231) );
  CLKMX2X2M U311 ( .A(\regArr[5][4] ), .B(WrData[4]), .S0(n359), .Y(n230) );
  CLKMX2X2M U312 ( .A(\regArr[5][3] ), .B(WrData[3]), .S0(n359), .Y(n229) );
  CLKMX2X2M U313 ( .A(\regArr[5][2] ), .B(WrData[2]), .S0(n359), .Y(n228) );
  CLKMX2X2M U314 ( .A(\regArr[5][1] ), .B(WrData[1]), .S0(n359), .Y(n227) );
  CLKMX2X2M U315 ( .A(\regArr[5][0] ), .B(WrData[0]), .S0(n359), .Y(n226) );
  AND2X1M U316 ( .A(n354), .B(n343), .Y(n359) );
  CLKMX2X2M U317 ( .A(\regArr[4][7] ), .B(WrData[7]), .S0(n360), .Y(n225) );
  CLKMX2X2M U318 ( .A(\regArr[4][6] ), .B(WrData[6]), .S0(n360), .Y(n224) );
  CLKMX2X2M U319 ( .A(\regArr[4][5] ), .B(WrData[5]), .S0(n360), .Y(n223) );
  CLKMX2X2M U320 ( .A(\regArr[4][4] ), .B(WrData[4]), .S0(n360), .Y(n222) );
  CLKMX2X2M U321 ( .A(\regArr[4][3] ), .B(WrData[3]), .S0(n360), .Y(n221) );
  CLKMX2X2M U322 ( .A(\regArr[4][2] ), .B(WrData[2]), .S0(n360), .Y(n220) );
  CLKMX2X2M U323 ( .A(\regArr[4][1] ), .B(WrData[1]), .S0(n360), .Y(n219) );
  CLKMX2X2M U324 ( .A(\regArr[4][0] ), .B(WrData[0]), .S0(n360), .Y(n218) );
  AND2X1M U325 ( .A(n356), .B(n343), .Y(n360) );
  CLKINVX1M U326 ( .A(N13), .Y(n357) );
  CLKMX2X2M U327 ( .A(REG3[7]), .B(WrData[7]), .S0(n361), .Y(n217) );
  CLKMX2X2M U328 ( .A(REG3[6]), .B(WrData[6]), .S0(n361), .Y(n216) );
  CLKMX2X2M U329 ( .A(REG3[5]), .B(WrData[5]), .S0(n361), .Y(n215) );
  CLKMX2X2M U330 ( .A(REG3[4]), .B(WrData[4]), .S0(n361), .Y(n214) );
  CLKMX2X2M U331 ( .A(REG3[3]), .B(WrData[3]), .S0(n361), .Y(n213) );
  CLKMX2X2M U332 ( .A(REG3[2]), .B(WrData[2]), .S0(n361), .Y(n212) );
  CLKMX2X2M U333 ( .A(REG3[1]), .B(WrData[1]), .S0(n361), .Y(n211) );
  CLKMX2X2M U334 ( .A(REG3[0]), .B(WrData[0]), .S0(n361), .Y(n210) );
  AND2X1M U335 ( .A(n354), .B(n346), .Y(n361) );
  CLKMX2X2M U336 ( .A(REG2[7]), .B(WrData[7]), .S0(n362), .Y(n209) );
  CLKMX2X2M U337 ( .A(REG2[6]), .B(WrData[6]), .S0(n362), .Y(n208) );
  CLKMX2X2M U338 ( .A(REG2[5]), .B(WrData[5]), .S0(n362), .Y(n207) );
  CLKMX2X2M U339 ( .A(REG2[4]), .B(WrData[4]), .S0(n362), .Y(n206) );
  CLKMX2X2M U340 ( .A(REG2[3]), .B(WrData[3]), .S0(n362), .Y(n205) );
  CLKMX2X2M U341 ( .A(REG2[2]), .B(WrData[2]), .S0(n362), .Y(n204) );
  CLKMX2X2M U342 ( .A(REG2[1]), .B(WrData[1]), .S0(n362), .Y(n203) );
  CLKMX2X2M U343 ( .A(REG2[0]), .B(WrData[0]), .S0(n362), .Y(n202) );
  AND2X1M U344 ( .A(n356), .B(n346), .Y(n362) );
  NOR2X1M U345 ( .A(n358), .B(N13), .Y(n346) );
  CLKMX2X2M U346 ( .A(REG1[7]), .B(WrData[7]), .S0(n363), .Y(n201) );
  CLKMX2X2M U347 ( .A(REG1[6]), .B(WrData[6]), .S0(n363), .Y(n200) );
  CLKMX2X2M U348 ( .A(REG1[5]), .B(WrData[5]), .S0(n363), .Y(n199) );
  CLKMX2X2M U349 ( .A(REG1[4]), .B(WrData[4]), .S0(n363), .Y(n198) );
  CLKMX2X2M U350 ( .A(REG1[3]), .B(WrData[3]), .S0(n363), .Y(n197) );
  CLKMX2X2M U351 ( .A(REG1[2]), .B(WrData[2]), .S0(n363), .Y(n196) );
  CLKMX2X2M U352 ( .A(REG1[1]), .B(WrData[1]), .S0(n363), .Y(n195) );
  CLKMX2X2M U353 ( .A(REG1[0]), .B(WrData[0]), .S0(n363), .Y(n194) );
  AND2X1M U354 ( .A(n354), .B(n349), .Y(n363) );
  CLKMX2X2M U355 ( .A(REG0[7]), .B(WrData[7]), .S0(n364), .Y(n193) );
  CLKMX2X2M U356 ( .A(REG0[6]), .B(WrData[6]), .S0(n364), .Y(n192) );
  CLKMX2X2M U357 ( .A(REG0[5]), .B(WrData[5]), .S0(n364), .Y(n191) );
  CLKMX2X2M U358 ( .A(REG0[4]), .B(WrData[4]), .S0(n364), .Y(n190) );
  CLKMX2X2M U359 ( .A(REG0[3]), .B(WrData[3]), .S0(n364), .Y(n189) );
  CLKMX2X2M U360 ( .A(REG0[2]), .B(WrData[2]), .S0(n364), .Y(n188) );
  CLKMX2X2M U361 ( .A(REG0[1]), .B(WrData[1]), .S0(n364), .Y(n187) );
  CLKMX2X2M U362 ( .A(REG0[0]), .B(WrData[0]), .S0(n364), .Y(n186) );
  AND2X1M U363 ( .A(n356), .B(n349), .Y(n364) );
  NOR2X1M U364 ( .A(N13), .B(N12), .Y(n349) );
  OAI2BB1X1M U365 ( .A0N(RdData_VLD), .A1N(n350), .B0(n365), .Y(n185) );
  NOR2X1M U366 ( .A(n366), .B(RdEn), .Y(n350) );
  CLKMX2X2M U367 ( .A(N36), .B(RdData[7]), .S0(n365), .Y(n184) );
  CLKMX2X2M U368 ( .A(N37), .B(RdData[6]), .S0(n365), .Y(n183) );
  CLKMX2X2M U369 ( .A(N38), .B(RdData[5]), .S0(n365), .Y(n182) );
  CLKMX2X2M U370 ( .A(N39), .B(RdData[4]), .S0(n365), .Y(n181) );
  CLKMX2X2M U371 ( .A(N40), .B(RdData[3]), .S0(n365), .Y(n180) );
  CLKMX2X2M U372 ( .A(N41), .B(RdData[2]), .S0(n365), .Y(n179) );
  CLKMX2X2M U373 ( .A(N42), .B(RdData[1]), .S0(n365), .Y(n178) );
  CLKMX2X2M U374 ( .A(N43), .B(RdData[0]), .S0(n365), .Y(n177) );
  CLKNAND2X2M U375 ( .A(RdEn), .B(n366), .Y(n365) );
  CLKINVX1M U376 ( .A(WrEn), .Y(n366) );
endmodule


module ALU_DW01_addsub_0 ( A, B, CI, ADD_SUB, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI, ADD_SUB;
  output CO;

  wire   [9:0] carry;
  wire   [8:0] B_AS;
  assign carry[0] = ADD_SUB;

  ADDFX2M U1_6 ( .A(A[6]), .B(B_AS[6]), .CI(carry[6]), .CO(carry[7]), .S(
        SUM[6]) );
  ADDFX2M U1_5 ( .A(A[5]), .B(B_AS[5]), .CI(carry[5]), .CO(carry[6]), .S(
        SUM[5]) );
  ADDFX2M U1_4 ( .A(A[4]), .B(B_AS[4]), .CI(carry[4]), .CO(carry[5]), .S(
        SUM[4]) );
  ADDFX2M U1_3 ( .A(A[3]), .B(B_AS[3]), .CI(carry[3]), .CO(carry[4]), .S(
        SUM[3]) );
  ADDFX2M U1_2 ( .A(A[2]), .B(B_AS[2]), .CI(carry[2]), .CO(carry[3]), .S(
        SUM[2]) );
  ADDFX2M U1_1 ( .A(A[1]), .B(B_AS[1]), .CI(carry[1]), .CO(carry[2]), .S(
        SUM[1]) );
  ADDFX2M U1_7 ( .A(A[7]), .B(B_AS[7]), .CI(carry[7]), .CO(carry[8]), .S(
        SUM[7]) );
  ADDFX2M U1_0 ( .A(A[0]), .B(B_AS[0]), .CI(carry[0]), .CO(carry[1]), .S(
        SUM[0]) );
  CLKXOR2X2M U1 ( .A(carry[0]), .B(carry[8]), .Y(SUM[8]) );
  CLKXOR2X2M U2 ( .A(B[7]), .B(carry[0]), .Y(B_AS[7]) );
  CLKXOR2X2M U3 ( .A(B[6]), .B(carry[0]), .Y(B_AS[6]) );
  CLKXOR2X2M U4 ( .A(B[5]), .B(carry[0]), .Y(B_AS[5]) );
  CLKXOR2X2M U5 ( .A(B[4]), .B(carry[0]), .Y(B_AS[4]) );
  CLKXOR2X2M U6 ( .A(B[3]), .B(carry[0]), .Y(B_AS[3]) );
  CLKXOR2X2M U7 ( .A(B[2]), .B(carry[0]), .Y(B_AS[2]) );
  CLKXOR2X2M U8 ( .A(B[1]), .B(carry[0]), .Y(B_AS[1]) );
  CLKXOR2X2M U9 ( .A(B[0]), .B(carry[0]), .Y(B_AS[0]) );
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
         n12, n13, n14, n15, n16, n17, n18;

  ADDFX2M \u_div/u_fa_PartRem_0_6_1  ( .A(\u_div/PartRem[7][1] ), .B(n14), 
        .CI(\u_div/CryTmp[6][1] ), .CO(\u_div/CryTmp[6][2] ), .S(
        \u_div/SumTmp[6][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_1  ( .A(\u_div/PartRem[2][1] ), .B(n14), 
        .CI(\u_div/CryTmp[1][1] ), .CO(\u_div/CryTmp[1][2] ), .S(
        \u_div/SumTmp[1][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_1  ( .A(\u_div/PartRem[3][1] ), .B(n14), 
        .CI(\u_div/CryTmp[2][1] ), .CO(\u_div/CryTmp[2][2] ), .S(
        \u_div/SumTmp[2][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_1  ( .A(\u_div/PartRem[4][1] ), .B(n14), 
        .CI(\u_div/CryTmp[3][1] ), .CO(\u_div/CryTmp[3][2] ), .S(
        \u_div/SumTmp[3][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_1  ( .A(\u_div/PartRem[5][1] ), .B(n14), 
        .CI(\u_div/CryTmp[4][1] ), .CO(\u_div/CryTmp[4][2] ), .S(
        \u_div/SumTmp[4][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_5_1  ( .A(\u_div/PartRem[6][1] ), .B(n14), 
        .CI(\u_div/CryTmp[5][1] ), .CO(\u_div/CryTmp[5][2] ), .S(
        \u_div/SumTmp[5][1] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_7  ( .A(\u_div/PartRem[1][7] ), .B(n8), .CI(
        \u_div/CryTmp[0][7] ), .CO(quotient[0]) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_6  ( .A(\u_div/PartRem[2][6] ), .B(n9), .CI(
        \u_div/CryTmp[1][6] ), .CO(\u_div/CryTmp[1][7] ), .S(
        \u_div/SumTmp[1][6] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_5  ( .A(\u_div/PartRem[3][5] ), .B(n10), 
        .CI(\u_div/CryTmp[2][5] ), .CO(\u_div/CryTmp[2][6] ), .S(
        \u_div/SumTmp[2][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_3  ( .A(\u_div/PartRem[5][3] ), .B(n12), 
        .CI(\u_div/CryTmp[4][3] ), .CO(\u_div/CryTmp[4][4] ), .S(
        \u_div/SumTmp[4][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_5_2  ( .A(\u_div/PartRem[6][2] ), .B(n13), 
        .CI(\u_div/CryTmp[5][2] ), .CO(\u_div/CryTmp[5][3] ), .S(
        \u_div/SumTmp[5][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_4  ( .A(\u_div/PartRem[4][4] ), .B(n11), 
        .CI(\u_div/CryTmp[3][4] ), .CO(\u_div/CryTmp[3][5] ), .S(
        \u_div/SumTmp[3][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_4  ( .A(\u_div/PartRem[1][4] ), .B(n11), 
        .CI(\u_div/CryTmp[0][4] ), .CO(\u_div/CryTmp[0][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_5  ( .A(\u_div/PartRem[1][5] ), .B(n10), 
        .CI(\u_div/CryTmp[0][5] ), .CO(\u_div/CryTmp[0][6] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_6  ( .A(\u_div/PartRem[1][6] ), .B(n9), .CI(
        \u_div/CryTmp[0][6] ), .CO(\u_div/CryTmp[0][7] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_5  ( .A(\u_div/PartRem[2][5] ), .B(n10), 
        .CI(\u_div/CryTmp[1][5] ), .CO(\u_div/CryTmp[1][6] ), .S(
        \u_div/SumTmp[1][5] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_1  ( .A(\u_div/PartRem[1][1] ), .B(n14), 
        .CI(\u_div/CryTmp[0][1] ), .CO(\u_div/CryTmp[0][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_2  ( .A(\u_div/PartRem[1][2] ), .B(n13), 
        .CI(\u_div/CryTmp[0][2] ), .CO(\u_div/CryTmp[0][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_0_3  ( .A(\u_div/PartRem[1][3] ), .B(n12), 
        .CI(\u_div/CryTmp[0][3] ), .CO(\u_div/CryTmp[0][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_4  ( .A(\u_div/PartRem[2][4] ), .B(n11), 
        .CI(\u_div/CryTmp[1][4] ), .CO(\u_div/CryTmp[1][5] ), .S(
        \u_div/SumTmp[1][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_3  ( .A(\u_div/PartRem[2][3] ), .B(n12), 
        .CI(\u_div/CryTmp[1][3] ), .CO(\u_div/CryTmp[1][4] ), .S(
        \u_div/SumTmp[1][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_1_2  ( .A(\u_div/PartRem[2][2] ), .B(n13), 
        .CI(\u_div/CryTmp[1][2] ), .CO(\u_div/CryTmp[1][3] ), .S(
        \u_div/SumTmp[1][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_4  ( .A(\u_div/PartRem[3][4] ), .B(n11), 
        .CI(\u_div/CryTmp[2][4] ), .CO(\u_div/CryTmp[2][5] ), .S(
        \u_div/SumTmp[2][4] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_3  ( .A(\u_div/PartRem[3][3] ), .B(n12), 
        .CI(\u_div/CryTmp[2][3] ), .CO(\u_div/CryTmp[2][4] ), .S(
        \u_div/SumTmp[2][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_2_2  ( .A(\u_div/PartRem[3][2] ), .B(n13), 
        .CI(\u_div/CryTmp[2][2] ), .CO(\u_div/CryTmp[2][3] ), .S(
        \u_div/SumTmp[2][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_3  ( .A(\u_div/PartRem[4][3] ), .B(n12), 
        .CI(\u_div/CryTmp[3][3] ), .CO(\u_div/CryTmp[3][4] ), .S(
        \u_div/SumTmp[3][3] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_3_2  ( .A(\u_div/PartRem[4][2] ), .B(n13), 
        .CI(\u_div/CryTmp[3][2] ), .CO(\u_div/CryTmp[3][3] ), .S(
        \u_div/SumTmp[3][2] ) );
  ADDFX2M \u_div/u_fa_PartRem_0_4_2  ( .A(\u_div/PartRem[5][2] ), .B(n13), 
        .CI(\u_div/CryTmp[4][2] ), .CO(\u_div/CryTmp[4][3] ), .S(
        \u_div/SumTmp[4][2] ) );
  XNOR2X2M U1 ( .A(n15), .B(a[7]), .Y(\u_div/SumTmp[7][0] ) );
  XNOR2X2M U2 ( .A(n15), .B(a[6]), .Y(\u_div/SumTmp[6][0] ) );
  XNOR2X2M U3 ( .A(n15), .B(a[5]), .Y(\u_div/SumTmp[5][0] ) );
  XNOR2X2M U4 ( .A(n15), .B(a[4]), .Y(\u_div/SumTmp[4][0] ) );
  XNOR2X2M U5 ( .A(n15), .B(a[3]), .Y(\u_div/SumTmp[3][0] ) );
  XNOR2X2M U6 ( .A(n15), .B(a[2]), .Y(\u_div/SumTmp[2][0] ) );
  INVX2M U7 ( .A(b[0]), .Y(n15) );
  XNOR2X2M U8 ( .A(n15), .B(a[1]), .Y(\u_div/SumTmp[1][0] ) );
  INVX2M U9 ( .A(b[1]), .Y(n14) );
  INVX2M U10 ( .A(b[2]), .Y(n13) );
  OR2X2M U11 ( .A(n15), .B(a[7]), .Y(\u_div/CryTmp[7][1] ) );
  INVX2M U12 ( .A(b[3]), .Y(n12) );
  INVX2M U13 ( .A(b[4]), .Y(n11) );
  INVX2M U14 ( .A(b[5]), .Y(n10) );
  NAND2X2M U15 ( .A(n2), .B(n3), .Y(\u_div/CryTmp[5][1] ) );
  INVX2M U16 ( .A(n15), .Y(n2) );
  INVX2M U17 ( .A(a[5]), .Y(n3) );
  NAND2X2M U18 ( .A(n2), .B(n4), .Y(\u_div/CryTmp[4][1] ) );
  INVX2M U19 ( .A(a[4]), .Y(n4) );
  NAND2X2M U20 ( .A(n2), .B(n5), .Y(\u_div/CryTmp[3][1] ) );
  INVX2M U21 ( .A(a[3]), .Y(n5) );
  NAND2X2M U22 ( .A(n2), .B(n6), .Y(\u_div/CryTmp[2][1] ) );
  INVX2M U23 ( .A(a[2]), .Y(n6) );
  NAND2X2M U24 ( .A(n2), .B(n7), .Y(\u_div/CryTmp[1][1] ) );
  INVX2M U25 ( .A(a[1]), .Y(n7) );
  INVX2M U26 ( .A(b[6]), .Y(n9) );
  NAND2X2M U27 ( .A(n2), .B(n1), .Y(\u_div/CryTmp[6][1] ) );
  INVX2M U28 ( .A(a[6]), .Y(n1) );
  INVX2M U29 ( .A(b[7]), .Y(n8) );
  OR2X2M U30 ( .A(n15), .B(a[0]), .Y(\u_div/CryTmp[0][1] ) );
  CLKMX2X2M U31 ( .A(\u_div/PartRem[2][6] ), .B(\u_div/SumTmp[1][6] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][7] ) );
  CLKMX2X2M U32 ( .A(\u_div/PartRem[3][5] ), .B(\u_div/SumTmp[2][5] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][6] ) );
  CLKMX2X2M U33 ( .A(\u_div/PartRem[4][4] ), .B(\u_div/SumTmp[3][4] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][5] ) );
  CLKMX2X2M U34 ( .A(\u_div/PartRem[5][3] ), .B(\u_div/SumTmp[4][3] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][4] ) );
  CLKMX2X2M U35 ( .A(\u_div/PartRem[6][2] ), .B(\u_div/SumTmp[5][2] ), .S0(
        quotient[5]), .Y(\u_div/PartRem[5][3] ) );
  CLKMX2X2M U36 ( .A(\u_div/PartRem[7][1] ), .B(\u_div/SumTmp[6][1] ), .S0(
        quotient[6]), .Y(\u_div/PartRem[6][2] ) );
  CLKMX2X2M U37 ( .A(a[7]), .B(\u_div/SumTmp[7][0] ), .S0(quotient[7]), .Y(
        \u_div/PartRem[7][1] ) );
  CLKMX2X2M U38 ( .A(\u_div/PartRem[2][5] ), .B(\u_div/SumTmp[1][5] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][6] ) );
  CLKMX2X2M U39 ( .A(\u_div/PartRem[3][4] ), .B(\u_div/SumTmp[2][4] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][5] ) );
  CLKMX2X2M U40 ( .A(\u_div/PartRem[4][3] ), .B(\u_div/SumTmp[3][3] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][4] ) );
  CLKMX2X2M U41 ( .A(\u_div/PartRem[5][2] ), .B(\u_div/SumTmp[4][2] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][3] ) );
  CLKMX2X2M U42 ( .A(\u_div/PartRem[6][1] ), .B(\u_div/SumTmp[5][1] ), .S0(
        quotient[5]), .Y(\u_div/PartRem[5][2] ) );
  CLKMX2X2M U43 ( .A(a[6]), .B(\u_div/SumTmp[6][0] ), .S0(quotient[6]), .Y(
        \u_div/PartRem[6][1] ) );
  CLKMX2X2M U44 ( .A(\u_div/PartRem[2][4] ), .B(\u_div/SumTmp[1][4] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][5] ) );
  CLKMX2X2M U45 ( .A(\u_div/PartRem[3][3] ), .B(\u_div/SumTmp[2][3] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][4] ) );
  CLKMX2X2M U46 ( .A(\u_div/PartRem[4][2] ), .B(\u_div/SumTmp[3][2] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][3] ) );
  CLKMX2X2M U47 ( .A(\u_div/PartRem[5][1] ), .B(\u_div/SumTmp[4][1] ), .S0(
        quotient[4]), .Y(\u_div/PartRem[4][2] ) );
  CLKMX2X2M U48 ( .A(a[5]), .B(\u_div/SumTmp[5][0] ), .S0(quotient[5]), .Y(
        \u_div/PartRem[5][1] ) );
  CLKMX2X2M U49 ( .A(\u_div/PartRem[2][3] ), .B(\u_div/SumTmp[1][3] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][4] ) );
  CLKMX2X2M U50 ( .A(\u_div/PartRem[3][2] ), .B(\u_div/SumTmp[2][2] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][3] ) );
  CLKMX2X2M U51 ( .A(\u_div/PartRem[4][1] ), .B(\u_div/SumTmp[3][1] ), .S0(
        quotient[3]), .Y(\u_div/PartRem[3][2] ) );
  CLKMX2X2M U52 ( .A(a[4]), .B(\u_div/SumTmp[4][0] ), .S0(quotient[4]), .Y(
        \u_div/PartRem[4][1] ) );
  CLKMX2X2M U53 ( .A(\u_div/PartRem[2][2] ), .B(\u_div/SumTmp[1][2] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][3] ) );
  CLKMX2X2M U54 ( .A(\u_div/PartRem[3][1] ), .B(\u_div/SumTmp[2][1] ), .S0(
        quotient[2]), .Y(\u_div/PartRem[2][2] ) );
  CLKMX2X2M U55 ( .A(a[3]), .B(\u_div/SumTmp[3][0] ), .S0(quotient[3]), .Y(
        \u_div/PartRem[3][1] ) );
  CLKMX2X2M U56 ( .A(\u_div/PartRem[2][1] ), .B(\u_div/SumTmp[1][1] ), .S0(
        quotient[1]), .Y(\u_div/PartRem[1][2] ) );
  CLKMX2X2M U57 ( .A(a[2]), .B(\u_div/SumTmp[2][0] ), .S0(quotient[2]), .Y(
        \u_div/PartRem[2][1] ) );
  CLKMX2X2M U58 ( .A(a[1]), .B(\u_div/SumTmp[1][0] ), .S0(quotient[1]), .Y(
        \u_div/PartRem[1][1] ) );
  AND4X1M U59 ( .A(\u_div/CryTmp[7][1] ), .B(n16), .C(n14), .D(n13), .Y(
        quotient[7]) );
  AND3X1M U60 ( .A(n16), .B(n13), .C(\u_div/CryTmp[6][2] ), .Y(quotient[6]) );
  AND2X1M U61 ( .A(\u_div/CryTmp[5][3] ), .B(n16), .Y(quotient[5]) );
  AND2X1M U62 ( .A(n17), .B(n12), .Y(n16) );
  AND2X1M U63 ( .A(\u_div/CryTmp[4][4] ), .B(n17), .Y(quotient[4]) );
  AND3X1M U64 ( .A(n18), .B(n11), .C(n10), .Y(n17) );
  AND3X1M U65 ( .A(n18), .B(n10), .C(\u_div/CryTmp[3][5] ), .Y(quotient[3]) );
  AND2X1M U66 ( .A(\u_div/CryTmp[2][6] ), .B(n18), .Y(quotient[2]) );
  NOR2X1M U67 ( .A(b[6]), .B(b[7]), .Y(n18) );
  AND2X1M U68 ( .A(\u_div/CryTmp[1][7] ), .B(n8), .Y(quotient[1]) );
endmodule


module ALU_DW01_add_0 ( A, B, CI, SUM, CO );
  input [13:0] A;
  input [13:0] B;
  output [13:0] SUM;
  input CI;
  output CO;
  wire   \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19;
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

  AOI21BX2M U2 ( .A0(n10), .A1(A[12]), .B0N(n11), .Y(n1) );
  CLKXOR2X2M U3 ( .A(A[7]), .B(B[7]), .Y(SUM[7]) );
  XNOR2X2M U4 ( .A(B[13]), .B(n1), .Y(SUM[13]) );
  NAND2X2M U5 ( .A(A[7]), .B(B[7]), .Y(n7) );
  XNOR2X1M U6 ( .A(n2), .B(n3), .Y(SUM[9]) );
  NOR2X1M U7 ( .A(n4), .B(n5), .Y(n3) );
  CLKXOR2X2M U8 ( .A(n6), .B(n7), .Y(SUM[8]) );
  NAND2BX1M U9 ( .AN(n8), .B(n9), .Y(n6) );
  OAI21X1M U10 ( .A0(A[12]), .A1(n10), .B0(B[12]), .Y(n11) );
  XOR3XLM U11 ( .A(B[12]), .B(A[12]), .C(n10), .Y(SUM[12]) );
  OAI21BX1M U12 ( .A0(n12), .A1(n13), .B0N(n14), .Y(n10) );
  XNOR2X1M U13 ( .A(n13), .B(n15), .Y(SUM[11]) );
  NOR2X1M U14 ( .A(n14), .B(n12), .Y(n15) );
  NOR2X1M U15 ( .A(B[11]), .B(A[11]), .Y(n12) );
  AND2X1M U16 ( .A(B[11]), .B(A[11]), .Y(n14) );
  OA21X1M U17 ( .A0(n16), .A1(n17), .B0(n18), .Y(n13) );
  CLKXOR2X2M U18 ( .A(n19), .B(n17), .Y(SUM[10]) );
  AOI2BB1X1M U19 ( .A0N(n2), .A1N(n5), .B0(n4), .Y(n17) );
  AND2X1M U20 ( .A(B[9]), .B(A[9]), .Y(n4) );
  NOR2X1M U21 ( .A(B[9]), .B(A[9]), .Y(n5) );
  OA21X1M U22 ( .A0(n7), .A1(n8), .B0(n9), .Y(n2) );
  CLKNAND2X2M U23 ( .A(B[8]), .B(A[8]), .Y(n9) );
  NOR2X1M U24 ( .A(B[8]), .B(A[8]), .Y(n8) );
  NAND2BX1M U25 ( .AN(n16), .B(n18), .Y(n19) );
  CLKNAND2X2M U26 ( .A(B[10]), .B(A[10]), .Y(n18) );
  NOR2X1M U27 ( .A(B[10]), .B(A[10]), .Y(n16) );
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
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40;

  ADDFX2M S1_6_0 ( .A(\ab[6][0] ), .B(\CARRYB[5][0] ), .CI(\SUMB[5][1] ), .CO(
        \CARRYB[6][0] ), .S(\A1[4] ) );
  ADDFX2M S1_5_0 ( .A(\ab[5][0] ), .B(\CARRYB[4][0] ), .CI(\SUMB[4][1] ), .CO(
        \CARRYB[5][0] ), .S(\A1[3] ) );
  ADDFX2M S1_4_0 ( .A(\ab[4][0] ), .B(\CARRYB[3][0] ), .CI(\SUMB[3][1] ), .CO(
        \CARRYB[4][0] ), .S(\A1[2] ) );
  ADDFX2M S1_3_0 ( .A(\ab[3][0] ), .B(\CARRYB[2][0] ), .CI(\SUMB[2][1] ), .CO(
        \CARRYB[3][0] ), .S(\A1[1] ) );
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
  ADDFX2M S2_6_1 ( .A(\ab[6][1] ), .B(\CARRYB[5][1] ), .CI(\SUMB[5][2] ), .CO(
        \CARRYB[6][1] ), .S(\SUMB[6][1] ) );
  ADDFX2M S2_6_2 ( .A(\ab[6][2] ), .B(\CARRYB[5][2] ), .CI(\SUMB[5][3] ), .CO(
        \CARRYB[6][2] ), .S(\SUMB[6][2] ) );
  ADDFX2M S2_4_5 ( .A(\ab[4][5] ), .B(\CARRYB[3][5] ), .CI(\SUMB[3][6] ), .CO(
        \CARRYB[4][5] ), .S(\SUMB[4][5] ) );
  ADDFX2M S2_5_1 ( .A(\ab[5][1] ), .B(\CARRYB[4][1] ), .CI(\SUMB[4][2] ), .CO(
        \CARRYB[5][1] ), .S(\SUMB[5][1] ) );
  ADDFX2M S2_5_2 ( .A(\ab[5][2] ), .B(\CARRYB[4][2] ), .CI(\SUMB[4][3] ), .CO(
        \CARRYB[5][2] ), .S(\SUMB[5][2] ) );
  ADDFX2M S2_5_3 ( .A(\ab[5][3] ), .B(\CARRYB[4][3] ), .CI(\SUMB[4][4] ), .CO(
        \CARRYB[5][3] ), .S(\SUMB[5][3] ) );
  ADDFX2M S2_4_1 ( .A(\ab[4][1] ), .B(\CARRYB[3][1] ), .CI(\SUMB[3][2] ), .CO(
        \CARRYB[4][1] ), .S(\SUMB[4][1] ) );
  ADDFX2M S2_4_2 ( .A(\ab[4][2] ), .B(\CARRYB[3][2] ), .CI(\SUMB[3][3] ), .CO(
        \CARRYB[4][2] ), .S(\SUMB[4][2] ) );
  ADDFX2M S2_4_3 ( .A(\ab[4][3] ), .B(\CARRYB[3][3] ), .CI(\SUMB[3][4] ), .CO(
        \CARRYB[4][3] ), .S(\SUMB[4][3] ) );
  ADDFX2M S2_4_4 ( .A(\ab[4][4] ), .B(\CARRYB[3][4] ), .CI(\SUMB[3][5] ), .CO(
        \CARRYB[4][4] ), .S(\SUMB[4][4] ) );
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
  ADDFX2M S3_2_6 ( .A(\ab[2][6] ), .B(n9), .CI(\ab[1][7] ), .CO(\CARRYB[2][6] ), .S(\SUMB[2][6] ) );
  ADDFX2M S1_2_0 ( .A(\ab[2][0] ), .B(n8), .CI(\SUMB[1][1] ), .CO(
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
  ADDFX2M S4_0 ( .A(\ab[7][0] ), .B(\CARRYB[6][0] ), .CI(\SUMB[6][1] ), .CO(
        \CARRYB[7][0] ), .S(\SUMB[7][0] ) );
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
  ADDFX2M S4_1 ( .A(\ab[7][1] ), .B(\CARRYB[6][1] ), .CI(\SUMB[6][2] ), .CO(
        \CARRYB[7][1] ), .S(\SUMB[7][1] ) );
  AND2X2M U2 ( .A(\ab[0][6] ), .B(\ab[1][5] ), .Y(n3) );
  AND2X2M U3 ( .A(\ab[0][5] ), .B(\ab[1][4] ), .Y(n4) );
  AND2X2M U4 ( .A(\ab[0][4] ), .B(\ab[1][3] ), .Y(n5) );
  AND2X2M U5 ( .A(\ab[0][3] ), .B(\ab[1][2] ), .Y(n6) );
  AND2X2M U6 ( .A(\ab[0][2] ), .B(\ab[1][1] ), .Y(n7) );
  AND2X2M U7 ( .A(\ab[0][1] ), .B(\ab[1][0] ), .Y(n8) );
  AND2X2M U8 ( .A(\ab[0][7] ), .B(\ab[1][6] ), .Y(n9) );
  AND2X2M U9 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(n10) );
  CLKXOR2X2M U10 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(\A1[7] ) );
  CLKXOR2X2M U11 ( .A(\CARRYB[7][6] ), .B(\ab[7][7] ), .Y(\A1[12] ) );
  CLKXOR2X2M U12 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(\A1[8] ) );
  CLKXOR2X2M U13 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(\A1[10] ) );
  CLKXOR2X2M U14 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(\A1[9] ) );
  CLKXOR2X2M U15 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(\A1[11] ) );
  INVX2M U16 ( .A(\ab[0][7] ), .Y(n24) );
  INVX2M U17 ( .A(\ab[0][6] ), .Y(n23) );
  INVX2M U18 ( .A(\ab[0][5] ), .Y(n22) );
  INVX2M U19 ( .A(\ab[0][4] ), .Y(n21) );
  INVX2M U20 ( .A(\ab[0][3] ), .Y(n20) );
  INVX2M U21 ( .A(\ab[0][2] ), .Y(n19) );
  INVX2M U22 ( .A(\ab[0][1] ), .Y(n18) );
  AND2X2M U23 ( .A(\CARRYB[7][0] ), .B(\SUMB[7][1] ), .Y(n11) );
  INVX2M U24 ( .A(\SUMB[7][1] ), .Y(n17) );
  AND2X2M U25 ( .A(\CARRYB[7][1] ), .B(\SUMB[7][2] ), .Y(n12) );
  AND2X2M U26 ( .A(\CARRYB[7][3] ), .B(\SUMB[7][4] ), .Y(n13) );
  AND2X2M U27 ( .A(\CARRYB[7][5] ), .B(\SUMB[7][6] ), .Y(n14) );
  AND2X2M U28 ( .A(\CARRYB[7][2] ), .B(\SUMB[7][3] ), .Y(n15) );
  AND2X2M U29 ( .A(\CARRYB[7][4] ), .B(\SUMB[7][5] ), .Y(n16) );
  XNOR2X2M U30 ( .A(\ab[1][6] ), .B(n24), .Y(\SUMB[1][6] ) );
  XNOR2X2M U31 ( .A(\ab[1][5] ), .B(n23), .Y(\SUMB[1][5] ) );
  XNOR2X2M U32 ( .A(\ab[1][4] ), .B(n22), .Y(\SUMB[1][4] ) );
  XNOR2X2M U33 ( .A(\ab[1][3] ), .B(n21), .Y(\SUMB[1][3] ) );
  XNOR2X2M U34 ( .A(\ab[1][2] ), .B(n20), .Y(\SUMB[1][2] ) );
  XNOR2X2M U35 ( .A(\ab[1][1] ), .B(n19), .Y(\SUMB[1][1] ) );
  XNOR2X2M U36 ( .A(\CARRYB[7][0] ), .B(n17), .Y(\A1[6] ) );
  XNOR2X2M U37 ( .A(\ab[1][0] ), .B(n18), .Y(PRODUCT[1]) );
  INVX2M U38 ( .A(A[1]), .Y(n39) );
  INVX2M U39 ( .A(A[4]), .Y(n36) );
  INVX2M U40 ( .A(A[7]), .Y(n33) );
  INVX2M U41 ( .A(A[6]), .Y(n34) );
  INVX2M U42 ( .A(A[3]), .Y(n37) );
  INVX2M U43 ( .A(A[5]), .Y(n35) );
  INVX2M U44 ( .A(A[2]), .Y(n38) );
  INVX2M U45 ( .A(A[0]), .Y(n40) );
  INVX2M U46 ( .A(B[4]), .Y(n28) );
  INVX2M U47 ( .A(B[2]), .Y(n30) );
  INVX2M U48 ( .A(B[7]), .Y(n25) );
  INVX2M U49 ( .A(B[6]), .Y(n26) );
  INVX2M U50 ( .A(B[0]), .Y(n32) );
  INVX2M U51 ( .A(B[3]), .Y(n29) );
  INVX2M U52 ( .A(B[5]), .Y(n27) );
  INVX2M U53 ( .A(B[1]), .Y(n31) );
  NOR2X1M U55 ( .A(n33), .B(n25), .Y(\ab[7][7] ) );
  NOR2X1M U56 ( .A(n33), .B(n26), .Y(\ab[7][6] ) );
  NOR2X1M U57 ( .A(n33), .B(n27), .Y(\ab[7][5] ) );
  NOR2X1M U58 ( .A(n33), .B(n28), .Y(\ab[7][4] ) );
  NOR2X1M U59 ( .A(n33), .B(n29), .Y(\ab[7][3] ) );
  NOR2X1M U60 ( .A(n33), .B(n30), .Y(\ab[7][2] ) );
  NOR2X1M U61 ( .A(n33), .B(n31), .Y(\ab[7][1] ) );
  NOR2X1M U62 ( .A(n33), .B(n32), .Y(\ab[7][0] ) );
  NOR2X1M U63 ( .A(n25), .B(n34), .Y(\ab[6][7] ) );
  NOR2X1M U64 ( .A(n26), .B(n34), .Y(\ab[6][6] ) );
  NOR2X1M U65 ( .A(n27), .B(n34), .Y(\ab[6][5] ) );
  NOR2X1M U66 ( .A(n28), .B(n34), .Y(\ab[6][4] ) );
  NOR2X1M U67 ( .A(n29), .B(n34), .Y(\ab[6][3] ) );
  NOR2X1M U68 ( .A(n30), .B(n34), .Y(\ab[6][2] ) );
  NOR2X1M U69 ( .A(n31), .B(n34), .Y(\ab[6][1] ) );
  NOR2X1M U70 ( .A(n32), .B(n34), .Y(\ab[6][0] ) );
  NOR2X1M U71 ( .A(n25), .B(n35), .Y(\ab[5][7] ) );
  NOR2X1M U72 ( .A(n26), .B(n35), .Y(\ab[5][6] ) );
  NOR2X1M U73 ( .A(n27), .B(n35), .Y(\ab[5][5] ) );
  NOR2X1M U74 ( .A(n28), .B(n35), .Y(\ab[5][4] ) );
  NOR2X1M U75 ( .A(n29), .B(n35), .Y(\ab[5][3] ) );
  NOR2X1M U76 ( .A(n30), .B(n35), .Y(\ab[5][2] ) );
  NOR2X1M U77 ( .A(n31), .B(n35), .Y(\ab[5][1] ) );
  NOR2X1M U78 ( .A(n32), .B(n35), .Y(\ab[5][0] ) );
  NOR2X1M U79 ( .A(n25), .B(n36), .Y(\ab[4][7] ) );
  NOR2X1M U80 ( .A(n26), .B(n36), .Y(\ab[4][6] ) );
  NOR2X1M U81 ( .A(n27), .B(n36), .Y(\ab[4][5] ) );
  NOR2X1M U82 ( .A(n28), .B(n36), .Y(\ab[4][4] ) );
  NOR2X1M U83 ( .A(n29), .B(n36), .Y(\ab[4][3] ) );
  NOR2X1M U84 ( .A(n30), .B(n36), .Y(\ab[4][2] ) );
  NOR2X1M U85 ( .A(n31), .B(n36), .Y(\ab[4][1] ) );
  NOR2X1M U86 ( .A(n32), .B(n36), .Y(\ab[4][0] ) );
  NOR2X1M U87 ( .A(n25), .B(n37), .Y(\ab[3][7] ) );
  NOR2X1M U88 ( .A(n26), .B(n37), .Y(\ab[3][6] ) );
  NOR2X1M U89 ( .A(n27), .B(n37), .Y(\ab[3][5] ) );
  NOR2X1M U90 ( .A(n28), .B(n37), .Y(\ab[3][4] ) );
  NOR2X1M U91 ( .A(n29), .B(n37), .Y(\ab[3][3] ) );
  NOR2X1M U92 ( .A(n30), .B(n37), .Y(\ab[3][2] ) );
  NOR2X1M U93 ( .A(n31), .B(n37), .Y(\ab[3][1] ) );
  NOR2X1M U94 ( .A(n32), .B(n37), .Y(\ab[3][0] ) );
  NOR2X1M U95 ( .A(n25), .B(n38), .Y(\ab[2][7] ) );
  NOR2X1M U96 ( .A(n26), .B(n38), .Y(\ab[2][6] ) );
  NOR2X1M U97 ( .A(n27), .B(n38), .Y(\ab[2][5] ) );
  NOR2X1M U98 ( .A(n28), .B(n38), .Y(\ab[2][4] ) );
  NOR2X1M U99 ( .A(n29), .B(n38), .Y(\ab[2][3] ) );
  NOR2X1M U100 ( .A(n30), .B(n38), .Y(\ab[2][2] ) );
  NOR2X1M U101 ( .A(n31), .B(n38), .Y(\ab[2][1] ) );
  NOR2X1M U102 ( .A(n32), .B(n38), .Y(\ab[2][0] ) );
  NOR2X1M U103 ( .A(n25), .B(n39), .Y(\ab[1][7] ) );
  NOR2X1M U104 ( .A(n26), .B(n39), .Y(\ab[1][6] ) );
  NOR2X1M U105 ( .A(n27), .B(n39), .Y(\ab[1][5] ) );
  NOR2X1M U106 ( .A(n28), .B(n39), .Y(\ab[1][4] ) );
  NOR2X1M U107 ( .A(n29), .B(n39), .Y(\ab[1][3] ) );
  NOR2X1M U108 ( .A(n30), .B(n39), .Y(\ab[1][2] ) );
  NOR2X1M U109 ( .A(n31), .B(n39), .Y(\ab[1][1] ) );
  NOR2X1M U110 ( .A(n32), .B(n39), .Y(\ab[1][0] ) );
  NOR2X1M U111 ( .A(n25), .B(n40), .Y(\ab[0][7] ) );
  NOR2X1M U112 ( .A(n26), .B(n40), .Y(\ab[0][6] ) );
  NOR2X1M U113 ( .A(n27), .B(n40), .Y(\ab[0][5] ) );
  NOR2X1M U114 ( .A(n28), .B(n40), .Y(\ab[0][4] ) );
  NOR2X1M U115 ( .A(n29), .B(n40), .Y(\ab[0][3] ) );
  NOR2X1M U116 ( .A(n30), .B(n40), .Y(\ab[0][2] ) );
  NOR2X1M U117 ( .A(n31), .B(n40), .Y(\ab[0][1] ) );
  NOR2X1M U118 ( .A(n32), .B(n40), .Y(PRODUCT[0]) );
  ALU_DW01_add_0 FS_1 ( .A({1'b0, \A1[12] , \A1[11] , \A1[10] , \A1[9] , 
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
  wire   N100, N101, N102, N103, N104, N105, N106, N107, N108, N109, N110,
         N111, N112, N113, N114, N115, N116, N117, N118, N119, N120, N121,
         N122, N123, N124, N125, N126, N127, N128, N129, N130, N131, N132, n2,
         n3, n4, n6, n7, n8, n9, n10, n11, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63,
         n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77,
         n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137,
         n138, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159,
         n160, n161, n162, n163, n164, n165, n166, n167, n168, n169, n170,
         n171, n172;
  wire   [15:0] ALU_OUT_Comb;

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
  SDFFRQX2M OUT_VALID_reg ( .D(EN), .SI(ALU_OUT[15]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(OUT_VALID) );
  OAI2BB1X1M U7 ( .A0N(N118), .A1N(n2), .B0(n3), .Y(ALU_OUT_Comb[9]) );
  OAI211X1M U23 ( .A0(n4), .A1(n6), .B0(n3), .C0(n7), .Y(ALU_OUT_Comb[8]) );
  CLKNAND2X2M U24 ( .A(N117), .B(n2), .Y(n7) );
  AOI32X1M U25 ( .A0(n8), .A1(n9), .A2(N108), .B0(A[7]), .B1(n10), .Y(n4) );
  NAND3X1M U26 ( .A(n11), .B(n29), .C(n30), .Y(ALU_OUT_Comb[7]) );
  AOI22X1M U27 ( .A0(EN), .A1(n31), .B0(N116), .B1(n2), .Y(n30) );
  OAI2B11X1M U28 ( .A1N(N132), .A0(n32), .B0(n33), .C0(n34), .Y(n31) );
  AOI221XLM U29 ( .A0(N107), .A1(n35), .B0(A[6]), .B1(n10), .C0(n36), .Y(n34)
         );
  AOI2B1X1M U30 ( .A1N(n37), .A0(n38), .B0(n39), .Y(n36) );
  MXI2X1M U31 ( .A(n40), .B(n41), .S0(B[7]), .Y(n33) );
  NOR2X1M U32 ( .A(n42), .B(n43), .Y(n41) );
  NOR2X1M U33 ( .A(A[7]), .B(n44), .Y(n40) );
  OAI21X1M U34 ( .A0(A[7]), .A1(B[7]), .B0(n45), .Y(n29) );
  AO21XLM U35 ( .A0(A[7]), .A1(B[7]), .B0(n46), .Y(n11) );
  OAI211X1M U36 ( .A0(n47), .A1(n46), .B0(n48), .C0(n49), .Y(ALU_OUT_Comb[6])
         );
  AOI22X1M U37 ( .A0(EN), .A1(n50), .B0(N115), .B1(n2), .Y(n49) );
  NAND3X1M U38 ( .A(n51), .B(n52), .C(n53), .Y(n50) );
  AOI222X1M U39 ( .A0(N106), .A1(n35), .B0(A[5]), .B1(n10), .C0(n54), .C1(n55), 
        .Y(n53) );
  MXI2X1M U40 ( .A(n56), .B(n57), .S0(B[6]), .Y(n52) );
  NOR2X1M U41 ( .A(n58), .B(n43), .Y(n57) );
  NOR2X1M U42 ( .A(A[6]), .B(n44), .Y(n56) );
  AOI22X1M U43 ( .A0(n59), .A1(A[7]), .B0(N131), .B1(n60), .Y(n51) );
  OAI21X1M U44 ( .A0(A[6]), .A1(B[6]), .B0(n45), .Y(n48) );
  NOR2X1M U45 ( .A(n58), .B(n61), .Y(n47) );
  NAND3X1M U46 ( .A(n62), .B(n63), .C(n64), .Y(ALU_OUT_Comb[5]) );
  AOI21X1M U47 ( .A0(N114), .A1(n2), .B0(n65), .Y(n64) );
  AOI31X1M U48 ( .A0(n66), .A1(n67), .A2(n68), .B0(n6), .Y(n65) );
  AOI221XLM U49 ( .A0(N105), .A1(n35), .B0(A[4]), .B1(n10), .C0(n69), .Y(n68)
         );
  AOI21X1M U50 ( .A0(n70), .A1(n71), .B0(n39), .Y(n69) );
  MXI2X1M U51 ( .A(n72), .B(n73), .S0(B[5]), .Y(n67) );
  NOR2X1M U52 ( .A(n43), .B(n74), .Y(n73) );
  NOR2X1M U53 ( .A(A[5]), .B(n44), .Y(n72) );
  AOI22X1M U54 ( .A0(n59), .A1(A[6]), .B0(N130), .B1(n60), .Y(n66) );
  OAI21X1M U55 ( .A0(A[5]), .A1(B[5]), .B0(n45), .Y(n63) );
  OAI21X1M U56 ( .A0(n74), .A1(n75), .B0(n76), .Y(n62) );
  NAND3X1M U57 ( .A(n77), .B(n78), .C(n79), .Y(ALU_OUT_Comb[4]) );
  AOI22X1M U58 ( .A0(EN), .A1(n80), .B0(N113), .B1(n2), .Y(n79) );
  OAI211X1M U59 ( .A0(n74), .A1(n81), .B0(n82), .C0(n83), .Y(n80) );
  AOI21X1M U60 ( .A0(N129), .A1(n60), .B0(n84), .Y(n83) );
  MX4X1M U61 ( .A(n85), .B(n54), .C(n54), .D(n86), .S0(B[4]), .S1(A[4]), .Y(
        n84) );
  AOI22X1M U62 ( .A0(A[3]), .A1(n10), .B0(N104), .B1(n35), .Y(n82) );
  OAI21X1M U63 ( .A0(A[4]), .A1(B[4]), .B0(n45), .Y(n78) );
  OAI21X1M U64 ( .A0(n87), .A1(n88), .B0(n76), .Y(n77) );
  NAND3X1M U65 ( .A(n89), .B(n90), .C(n91), .Y(ALU_OUT_Comb[3]) );
  AOI21X1M U66 ( .A0(N112), .A1(n2), .B0(n92), .Y(n91) );
  AOI31X1M U67 ( .A0(n93), .A1(n94), .A2(n95), .B0(n6), .Y(n92) );
  AOI221XLM U68 ( .A0(N103), .A1(n35), .B0(A[2]), .B1(n10), .C0(n96), .Y(n95)
         );
  AOI21X1M U69 ( .A0(n97), .A1(n98), .B0(n39), .Y(n96) );
  MXI2X1M U70 ( .A(n99), .B(n100), .S0(B[3]), .Y(n94) );
  NOR2X1M U71 ( .A(n43), .B(n101), .Y(n100) );
  NOR2X1M U72 ( .A(A[3]), .B(n44), .Y(n99) );
  AOI22X1M U73 ( .A0(A[4]), .A1(n59), .B0(N128), .B1(n60), .Y(n93) );
  OAI21X1M U74 ( .A0(A[3]), .A1(B[3]), .B0(n45), .Y(n90) );
  OAI21X1M U75 ( .A0(n101), .A1(n102), .B0(n76), .Y(n89) );
  CLKINVX1M U76 ( .A(n46), .Y(n76) );
  OAI211X1M U77 ( .A0(n103), .A1(n46), .B0(n104), .C0(n105), .Y(
        ALU_OUT_Comb[2]) );
  AOI22X1M U78 ( .A0(EN), .A1(n106), .B0(N111), .B1(n2), .Y(n105) );
  NAND3X1M U79 ( .A(n107), .B(n108), .C(n109), .Y(n106) );
  AOI222X1M U80 ( .A0(N102), .A1(n35), .B0(A[1]), .B1(n10), .C0(n54), .C1(n110), .Y(n109) );
  MXI2X1M U81 ( .A(n111), .B(n112), .S0(B[2]), .Y(n108) );
  NOR2X1M U82 ( .A(n43), .B(n113), .Y(n112) );
  NOR2X1M U83 ( .A(A[2]), .B(n44), .Y(n111) );
  AOI22X1M U84 ( .A0(A[3]), .A1(n59), .B0(N127), .B1(n60), .Y(n107) );
  OAI21X1M U85 ( .A0(A[2]), .A1(B[2]), .B0(n45), .Y(n104) );
  NOR2X1M U86 ( .A(n114), .B(n6), .Y(n45) );
  CLKNAND2X2M U87 ( .A(n115), .B(EN), .Y(n46) );
  NOR2BX1M U88 ( .AN(B[2]), .B(n113), .Y(n103) );
  OAI2BB2X1M U89 ( .B0(n116), .B1(n6), .A0N(N110), .A1N(n2), .Y(
        ALU_OUT_Comb[1]) );
  AND4X1M U90 ( .A(n117), .B(n118), .C(n119), .D(n120), .Y(n116) );
  AOI221XLM U91 ( .A0(A[0]), .A1(n10), .B0(N101), .B1(n35), .C0(n121), .Y(n120) );
  OAI31X1M U92 ( .A0(n122), .A1(n123), .A2(n9), .B0(n124), .Y(n121) );
  NOR2BX1M U93 ( .AN(n125), .B(n9), .Y(n10) );
  AOI22X1M U94 ( .A0(A[2]), .A1(n59), .B0(N126), .B1(n60), .Y(n119) );
  MXI2X1M U95 ( .A(n126), .B(n127), .S0(B[1]), .Y(n118) );
  CLKNAND2X2M U96 ( .A(n128), .B(n114), .Y(n127) );
  MXI2X1M U97 ( .A(n54), .B(n86), .S0(A[1]), .Y(n128) );
  CLKINVX1M U98 ( .A(n43), .Y(n86) );
  CLKNAND2X2M U99 ( .A(n129), .B(n130), .Y(n126) );
  MXI2X1M U100 ( .A(n85), .B(n54), .S0(A[1]), .Y(n129) );
  CLKINVX1M U101 ( .A(n39), .Y(n54) );
  MXI2X1M U102 ( .A(n115), .B(n131), .S0(A[1]), .Y(n117) );
  OAI2BB1X1M U103 ( .A0N(N124), .A1N(n2), .B0(n3), .Y(ALU_OUT_Comb[15]) );
  OAI2BB1X1M U104 ( .A0N(N123), .A1N(n2), .B0(n3), .Y(ALU_OUT_Comb[14]) );
  OAI2BB1X1M U105 ( .A0N(N122), .A1N(n2), .B0(n3), .Y(ALU_OUT_Comb[13]) );
  OAI2BB1X1M U106 ( .A0N(N121), .A1N(n2), .B0(n3), .Y(ALU_OUT_Comb[12]) );
  OAI2BB1X1M U107 ( .A0N(N120), .A1N(n2), .B0(n3), .Y(ALU_OUT_Comb[11]) );
  OAI2BB1X1M U108 ( .A0N(N119), .A1N(n2), .B0(n3), .Y(ALU_OUT_Comb[10]) );
  OAI21X1M U109 ( .A0(n85), .A1(n132), .B0(EN), .Y(n3) );
  AO21XLM U110 ( .A0(n172), .A1(N108), .B0(n115), .Y(n132) );
  CLKINVX1M U111 ( .A(n133), .Y(n172) );
  CLKINVX1M U112 ( .A(n44), .Y(n85) );
  OAI2BB2X1M U113 ( .B0(n134), .B1(n6), .A0N(N109), .A1N(n2), .Y(
        ALU_OUT_Comb[0]) );
  NOR3X1M U114 ( .A(n9), .B(n135), .C(n6), .Y(n2) );
  CLKINVX1M U115 ( .A(EN), .Y(n6) );
  AND4X1M U116 ( .A(n136), .B(n124), .C(n137), .D(n138), .Y(n134) );
  AOI211X1M U117 ( .A0(N125), .A1(n60), .B0(n139), .C0(n140), .Y(n138) );
  MXI2X1M U118 ( .A(n130), .B(n114), .S0(A[0]), .Y(n140) );
  CLKINVX1M U119 ( .A(n115), .Y(n130) );
  MXI2X1M U120 ( .A(n141), .B(n142), .S0(B[0]), .Y(n139) );
  NOR2X1M U121 ( .A(n131), .B(n143), .Y(n142) );
  MXI2X1M U122 ( .A(n39), .B(n43), .S0(A[0]), .Y(n143) );
  CLKNAND2X2M U123 ( .A(n144), .B(n9), .Y(n43) );
  OAI21X1M U124 ( .A0(ALU_FUN[3]), .A1(n145), .B0(n122), .Y(n144) );
  CLKINVX1M U125 ( .A(n114), .Y(n131) );
  CLKNAND2X2M U126 ( .A(ALU_FUN[2]), .B(n146), .Y(n114) );
  NOR2X1M U127 ( .A(n115), .B(n147), .Y(n141) );
  MXI2X1M U128 ( .A(n44), .B(n39), .S0(A[0]), .Y(n147) );
  NAND4X1M U129 ( .A(ALU_FUN[3]), .B(n148), .C(n9), .D(n145), .Y(n39) );
  AOI2BB2XLM U130 ( .B0(ALU_FUN[2]), .B1(n149), .A0N(ALU_FUN[1]), .A1N(n122), 
        .Y(n44) );
  NAND3X1M U131 ( .A(ALU_FUN[0]), .B(n145), .C(ALU_FUN[3]), .Y(n122) );
  NOR4X1M U132 ( .A(n145), .B(n9), .C(ALU_FUN[0]), .D(ALU_FUN[3]), .Y(n115) );
  CLKINVX1M U133 ( .A(n32), .Y(n60) );
  CLKNAND2X2M U134 ( .A(n149), .B(n145), .Y(n32) );
  NOR3X1M U135 ( .A(n148), .B(ALU_FUN[3]), .C(n9), .Y(n149) );
  AOI22X1M U136 ( .A0(N100), .A1(n35), .B0(A[1]), .B1(n59), .Y(n137) );
  CLKINVX1M U137 ( .A(n81), .Y(n59) );
  NAND4X1M U138 ( .A(ALU_FUN[3]), .B(ALU_FUN[2]), .C(ALU_FUN[0]), .D(n9), .Y(
        n81) );
  OAI21X1M U139 ( .A0(ALU_FUN[1]), .A1(n135), .B0(n133), .Y(n35) );
  CLKNAND2X2M U140 ( .A(n146), .B(n145), .Y(n133) );
  NOR3X1M U141 ( .A(ALU_FUN[1]), .B(ALU_FUN[3]), .C(n148), .Y(n146) );
  CLKINVX1M U142 ( .A(ALU_FUN[0]), .Y(n148) );
  CLKINVX1M U143 ( .A(n8), .Y(n135) );
  NOR3X1M U144 ( .A(ALU_FUN[2]), .B(ALU_FUN[3]), .C(ALU_FUN[0]), .Y(n8) );
  NAND3X1M U145 ( .A(n150), .B(n9), .C(n125), .Y(n124) );
  NOR3BX1M U146 ( .AN(ALU_FUN[3]), .B(n145), .C(ALU_FUN[0]), .Y(n125) );
  CLKINVX1M U147 ( .A(ALU_FUN[2]), .Y(n145) );
  NAND4BX1M U148 ( .AN(n150), .B(ALU_FUN[3]), .C(n123), .D(n151), .Y(n136) );
  NOR3X1M U149 ( .A(n9), .B(ALU_FUN[2]), .C(ALU_FUN[0]), .Y(n151) );
  CLKINVX1M U150 ( .A(ALU_FUN[1]), .Y(n9) );
  AOI2B1X1M U151 ( .A1N(n152), .A0(n38), .B0(n37), .Y(n123) );
  AOI32X1M U152 ( .A0(n153), .A1(n71), .A2(n154), .B0(A[6]), .B1(n61), .Y(n152) );
  OAI211X1M U153 ( .A0(n87), .A1(n155), .B0(n156), .C0(n70), .Y(n153) );
  AO21XLM U154 ( .A0(n155), .A1(n87), .B0(B[4]), .Y(n156) );
  OAI21X1M U155 ( .A0(n157), .A1(n158), .B0(n97), .Y(n155) );
  OAI31X1M U156 ( .A0(n110), .A1(n159), .A2(n160), .B0(n98), .Y(n158) );
  AOI2B1X1M U157 ( .A1N(B[0]), .A0(A[0]), .B0(A[1]), .Y(n160) );
  CLKINVX1M U158 ( .A(n161), .Y(n159) );
  OAI31X1M U159 ( .A0(n162), .A1(B[0]), .A2(n163), .B0(B[1]), .Y(n161) );
  NOR2X1M U160 ( .A(B[2]), .B(n113), .Y(n157) );
  CLKINVX1M U161 ( .A(A[4]), .Y(n87) );
  OAI21X1M U162 ( .A0(n37), .A1(n164), .B0(n38), .Y(n150) );
  CLKNAND2X2M U163 ( .A(B[7]), .B(n42), .Y(n38) );
  AOI32X1M U164 ( .A0(n165), .A1(n70), .A2(n154), .B0(B[6]), .B1(n58), .Y(n164) );
  CLKINVX1M U165 ( .A(A[6]), .Y(n58) );
  CLKINVX1M U166 ( .A(n55), .Y(n154) );
  XNOR2X1M U167 ( .A(n61), .B(A[6]), .Y(n55) );
  CLKINVX1M U168 ( .A(B[6]), .Y(n61) );
  CLKNAND2X2M U169 ( .A(A[5]), .B(n75), .Y(n70) );
  CLKINVX1M U170 ( .A(B[5]), .Y(n75) );
  OAI211X1M U171 ( .A0(A[4]), .A1(n166), .B0(n167), .C0(n71), .Y(n165) );
  CLKNAND2X2M U172 ( .A(B[5]), .B(n74), .Y(n71) );
  CLKINVX1M U173 ( .A(A[5]), .Y(n74) );
  AO21XLM U174 ( .A0(n166), .A1(A[4]), .B0(n88), .Y(n167) );
  CLKINVX1M U175 ( .A(B[4]), .Y(n88) );
  OAI2B1X1M U176 ( .A1N(n168), .A0(n169), .B0(n98), .Y(n166) );
  CLKNAND2X2M U177 ( .A(A[3]), .B(n102), .Y(n98) );
  CLKINVX1M U178 ( .A(B[3]), .Y(n102) );
  OAI31X1M U179 ( .A0(n110), .A1(n170), .A2(n171), .B0(n97), .Y(n169) );
  CLKNAND2X2M U180 ( .A(B[3]), .B(n101), .Y(n97) );
  CLKINVX1M U181 ( .A(A[3]), .Y(n101) );
  AOI21X1M U182 ( .A0(B[0]), .A1(n163), .B0(n162), .Y(n171) );
  AOI31X1M U183 ( .A0(n163), .A1(n162), .A2(B[0]), .B0(B[1]), .Y(n170) );
  CLKINVX1M U184 ( .A(A[1]), .Y(n162) );
  CLKINVX1M U185 ( .A(A[0]), .Y(n163) );
  OAI21X1M U186 ( .A0(B[2]), .A1(n113), .B0(n168), .Y(n110) );
  CLKNAND2X2M U187 ( .A(B[2]), .B(n113), .Y(n168) );
  CLKINVX1M U188 ( .A(A[2]), .Y(n113) );
  NOR2X1M U189 ( .A(n42), .B(B[7]), .Y(n37) );
  CLKINVX1M U190 ( .A(A[7]), .Y(n42) );
  ALU_DW01_addsub_0 r89 ( .A({1'b0, A}), .B({1'b0, B}), .CI(1'b0), .ADD_SUB(
        n172), .SUM({N108, N107, N106, N105, N104, N103, N102, N101, N100}) );
  ALU_DW_div_uns_0 div_52 ( .a(A), .b(B), .quotient({N132, N131, N130, N129, 
        N128, N127, N126, N125}) );
  ALU_DW02_mult_0 mult_49 ( .A(A), .B(B), .TC(1'b0), .PRODUCT({N124, N123, 
        N122, N121, N120, N119, N118, N117, N116, N115, N114, N113, N112, N111, 
        N110, N109}) );
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
         ALU_CLK_M, rinc, \Div_Ratio_RX[1] , n7, n8, n9, n10, n11, n13, n14,
         n19, n20, n23, n24;
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

  CLKMX2X4M U18 ( .A(REF_CLK), .B(scan_clock), .S0(N0), .Y(REF_CLK_M) );
  CLKMX2X4M U19 ( .A(SYNC_RST_sys), .B(scan_rst), .S0(N0), .Y(SYNC_RST_sys_M)
         );
  MX2X6M U20 ( .A(SYNC_RST_UART), .B(scan_rst), .S0(N0), .Y(SYNC_RST_UART_M)
         );
  CLKMX2X4M U21 ( .A(RX_CLK), .B(scan_clock), .S0(N0), .Y(RX_CLK_M) );
  MX2X2M U22 ( .A(TX_CLK), .B(scan_clock), .S0(N0), .Y(TX_CLK_M) );
  MX2X2M U23 ( .A(UART_CLK), .B(scan_clock), .S0(N0), .Y(UART_CLK_M) );
  MX2X2M U24 ( .A(RST), .B(scan_rst), .S0(N0), .Y(RST_M) );
  CLKINVX1M U25 ( .A(rempty), .Y(n10) );
  CLKNAND2X2M U26 ( .A(n7), .B(n8), .Y(n11) );
  CLKXOR2X2M U27 ( .A(prescale[4]), .B(prescale[3]), .Y(n8) );
  OR2X1M U28 ( .A(CLK_GATING_EN), .B(N0), .Y(_1_net_) );
  AND3X1M U29 ( .A(n9), .B(n7), .C(prescale[4]), .Y(\Div_Ratio_RX[1] ) );
  NOR4X1M U30 ( .A(prescale[1]), .B(prescale[0]), .C(prescale[5]), .D(
        prescale[2]), .Y(n7) );
  CLKINVX1M U31 ( .A(prescale[3]), .Y(n9) );
  UART_RX_test_1 RX ( .clk(RX_CLK_M), .rst(SYNC_RST_UART_M), .RX_IN(RX_IN), 
        .prescale(prescale), .PAR_EN(REG2[0]), .PAR_TYP(REG2[1]), 
        .data_valid_reg(data_valid_reg_RX), .par_err_reg(par_err_reg), 
        .stp_error_reg(stp_error_reg), .P_DATA_reg(P_DATA_reg_RX), .test_si2(
        n13), .test_si1(SYNC_RST_UART), .test_se(SE) );
  UART_TX_test_1 TX ( .P_DATA(r_data), .Data_Valid(n10), .PAR_TYP(REG2[1]), 
        .PAR_EN(REG2[0]), .TX_OUT(TX_OUT), .busy(busy), .clk(TX_CLK_M), .rst(
        SYNC_RST_UART_M), .test_si(n14), .test_so(n13), .test_se(SE) );
  RST_SYNC_test_1 RST_SYNC_REF_CLK ( .RST(RST_M), .CLK(REF_CLK_M), .SYNC_RST(
        SYNC_RST_sys), .test_si(test_si4), .test_se(SE) );
  RST_SYNC_test_0 RST_SYNC_UART_CLK ( .RST(RST_M), .CLK(UART_CLK_M), 
        .SYNC_RST(SYNC_RST_UART), .test_si(SYNC_RST_sys), .test_se(SE) );
  DATA_SYNC_test_1 DATA_SYNC ( .unsync_bus(P_DATA_reg_RX), .bus_enable(
        data_valid_reg_RX), .clk(REF_CLK_M), .rst(SYNC_RST_sys_M), .sync_bus(
        RX_P_Data), .enable_pulse(RX_D_VLD), .test_si(n23), .test_se(SE) );
  SYS_CTRL_test_1 SYS_CTRL ( .CLK(REF_CLK_M), .RST(SYNC_RST_sys_M), .ALU_OUT(
        ALU_OUT), .OUT_Valid(OUT_Valid), .RX_P_Data(RX_P_Data), .RX_D_VLD(
        RX_D_VLD), .RdData(RdData), .RdData_Valid(RdData_Valid), .ALU_EN(
        ALU_EN), .ALU_FUN(ALU_FUN), .CLK_GATING_EN(CLK_GATING_EN), .Address(
        Address), .Wr_En(Wr_En), .Rd_En(Rd_En), .Wr_Data(Wr_Data), .TX_P_Data(
        TX_P_Data), .TX_D_VLD(TX_D_VLD), .wfull(wfull), .test_si(par_err_reg), 
        .test_so(n14), .test_se(SE) );
  clock_gating clk_gating ( .CLK_EN(_1_net_), .CLK(REF_CLK_M), .GATED_CLK(
        ALU_CLK_M) );
  Pulse_Gen_test_1 PULSE_GEN ( .clk(TX_CLK_M), .rst(SYNC_RST_UART_M), .in(busy), .out(rinc), .test_si(n20), .test_so(n19), .test_se(SE) );
  ClkDiv_Range_for_division8_test_1 CLK_DIV_TX ( .i_ref_clk(UART_CLK_M), 
        .i_rst_n(SYNC_RST_UART_M), .i_clk_en(1'b1), .i_div_ratio(REG3), 
        .o_div_clk(TX_CLK), .test_si(n24), .test_so(n23), .test_se(SE) );
  ClkDiv_Range_for_division2_test_1 CLK_DIV_RX ( .i_ref_clk(UART_CLK_M), 
        .i_rst_n(SYNC_RST_UART_M), .i_clk_en(1'b1), .i_div_ratio({
        \Div_Ratio_RX[1] , n11}), .o_div_clk(RX_CLK), .test_si(OUT_Valid), 
        .test_so(n24), .test_se(SE) );
  FIFO_TOP_test_1 FIFO ( .w_data(TX_P_Data), .winc(TX_D_VLD), .w_clk(REF_CLK_M), .wrst_n(SYNC_RST_sys_M), .wfull(wfull), .r_data(r_data), .rinc(rinc), 
        .rempty(rempty), .r_clk(TX_CLK_M), .rrst_n(SYNC_RST_UART_M), 
        .test_si2(test_si2), .test_si1(RX_P_Data[7]), .test_so2(n20), 
        .test_so1(SO), .test_se(SE) );
  RegFile_test_1 REG ( .CLK(REF_CLK_M), .RST(SYNC_RST_sys_M), .WrEn(Wr_En), 
        .RdEn(Rd_En), .Address(Address), .WrData(Wr_Data), .RdData(RdData), 
        .RdData_VLD(RdData_Valid), .REG0(REG0), .REG1(REG1), .REG2({prescale, 
        REG2}), .REG3(REG3), .test_si2(test_si3), .test_si1(n19), .test_so2(
        test_so3), .test_so1(test_so2), .test_se(SE) );
  ALU_test_1 ALU ( .A(REG0), .B(REG1), .EN(ALU_EN), .ALU_FUN(ALU_FUN), .CLK(
        ALU_CLK_M), .RST(SYNC_RST_sys_M), .ALU_OUT(ALU_OUT), .OUT_VALID(
        OUT_Valid), .test_si(SI), .test_se(SE) );
endmodule

