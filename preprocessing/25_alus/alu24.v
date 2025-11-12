// ============================================================
// Automatically generated ALU module
// Name: alu_0002_W16_12cd_z_NP
// Width: 16-bit | Pipeline: False | Flags: {'carry': False, 'zero': True, 'overflow': False}
// ============================================================

module alu_0002_W16_12cd_z_NP (
    input  wire [15:0] a,
    input  wire [15:0] b,
    input  wire [3:0] opcode,
    output reg  [15:0] result,
    output reg zero
);

    always @(*) begin
        case (opcode)
            4'd0: result = a - b;               // carry flag not used
            4'd1: result = a[15] ? -a : a;
            4'd2: result = a | b;
            4'd3: result = (a < b) ? a : b;
            4'd4: result = {a[15], a[15:1]};    // arithmetic shift right
            4'd5: result = ~(a & b);
            4'd6: result = (a > b) ? {15'b0, 1'b1} : 16'b0; // flattened concatenation
            4'd7: result = a + b;               // carry flag not used
            4'd8: result = -a;
            4'd9: result = a - 1;
            4'd10: result = a + 1;
            4'd11: result = a * b;
            4'd12: result = ~(a | b);
            default: result = 16'b0;
        endcase
        zero = (result == 0);                  // zero flag
    end
endmodule

