module Mux#(
    parameter DATA_WIDTH = 128
)(
    input   logic sel,
    input   logic [DATA_WIDTH-1 : 0] in0,
    input   logic [DATA_WIDTH-1 : 0] in1,
    output  logic [DATA_WIDTH-1 : 0] out
);

always @(*) begin
    if (sel == 0) begin
        out = in0;
    end else begin
        out = in1;
    end
end

endmodule