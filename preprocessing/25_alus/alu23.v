module alu_0001_W64_2d3c_czo_NP (
    input  wire [63:0] a,
    input  wire [63:0] b,
    input  wire [2:0] opcode,
    output reg  [63:0] result,
    output reg carry,
    output reg zero,
    output reg overflow
);

    always @(*) begin
        carry = 0;
        overflow = 0;
        case (opcode)
            3'd0: result = (a == b) ? {63'b0, 1'b1} : 64'b0;
            3'd1: result = a >> 1;
            3'd2: result = a * b;
            3'd3: result = a[63] ? -a : a;
            3'd4: result = (b != 0) ? a / b : 64'b0;
            3'd5: result = (a < b) ? {63'b0, 1'b1} : 64'b0;
            default: result = 64'b0;
        endcase
        zero = (result == 0);
    end
endmodule

