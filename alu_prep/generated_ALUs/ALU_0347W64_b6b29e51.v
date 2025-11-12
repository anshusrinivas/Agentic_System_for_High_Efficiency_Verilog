`timescale 1ns / 1ps

// Generated ALU Module
// Style: PIPELINED
// Bit width: 64
// Operations: ADD, SUB, MUL, XOR, ROR, SEQ, NAND, AND, OR, MIN, SGE
// Flags: carry

module ALU_0347W64_b6b29e51(
    input  wire             clk,
    input  wire             rst,
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam MUL = 4'd2;
    localparam XOR = 4'd3;
    localparam ROR = 4'd4;
    localparam SEQ = 4'd5;
    localparam NAND = 4'd6;
    localparam AND = 4'd7;
    localparam OR = 4'd8;
    localparam MIN = 4'd9;
    localparam SGE = 4'd10;

    // Pipeline registers
    reg [63:0] input1_r, input2_r;
    reg [3:0] opcode_r;
    reg [4:0] shiftValue_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            input1_r <= 64'b0;
            input2_r <= 64'b0;
            opcode_r <= 4'b0;
            shiftValue_r <= 5'b0;
            result <= 64'b0;
            carryFlag <= 1'b0;
        end else begin
            input1_r <= input1;
            input2_r <= input2;
            opcode_r <= opcode;
            shiftValue_r <= shiftValue;

            case (opcode_r)
                ADD: begin
                    {carryFlag, result} <= {1'b0, input1_r} + {1'b0, input2_r};
                    
                end
                SUB: begin
                    {carryFlag, result} <= {1'b0, input1_r} - {1'b0, input2_r};
                    
                end
                MUL: begin
                    result <= input1_r * input2_r;
                end
                XOR: begin
                    result <= input1_r ^ input2_r;
                end
                ROR: begin
                    result <= ror(input1_r, shiftValue_r);
                end
                SEQ: begin
                end
                NAND: begin
                    result <= ~(input1_r & input2_r);
                end
                AND: begin
                    result <= input1_r & input2_r;
                end
                OR: begin
                    result <= input1_r | input2_r;
                end
                MIN: begin
                    result <= (input1_r < input2_r) ? input1_r : input2_r;
                end
                SGE: begin
                end
            default: result <= 64'b0;
        endcase
    end

endmodule