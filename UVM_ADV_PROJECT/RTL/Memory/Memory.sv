module memory #(
    parameter  DATA_WIDTH = 32,
    parameter  MEM_DEPTH  = 64,
    localparam ADDR_WIDTH = $clog2(MEM_DEPTH)
) (
    input       wire                                clk,
    input       wire                                rst,
    input       wire                                write_En,
    input       wire                                read_En,
    input       wire        [ADDR_WIDTH-1:0]        Address,
    input       wire        [DATA_WIDTH-1:0]        Data_in,
    output      reg         [DATA_WIDTH-1:0]        Data_out,
    output      reg                                 Valid_out
);

reg [DATA_WIDTH-1:0] MEM [0:MEM_DEPTH-1];

always @(posedge clk, negedge rst) begin
    if (!rst) begin
        Data_out <= 0;
        Valid_out <= 0;
    end
    else begin
        if (write_En) begin
            MEM[Address] <= Data_in;
            Valid_out <= 0;
        end
        else if (read_En) begin
            Data_out <= MEM[Address];
            Valid_out <= 1;
        end
        else begin
            Valid_out <= 0;
        end
    end
end

endmodule