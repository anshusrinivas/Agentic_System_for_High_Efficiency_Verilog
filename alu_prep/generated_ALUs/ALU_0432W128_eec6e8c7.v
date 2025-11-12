`timescale 1ns / 1ps

// Generated ALU Module
// Style: PIPELINED
// Bit width: 128
// Operations: ADD, SUB, MUL, ROL, ROR, SLT, SGE, AND
// Flags: carry, zero, overflow, sign

module ALU_0432W128_eec6e8c7(
    input  wire             clk,
    input  wire             rst,
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam MUL = 4'd2;
    localparam ROL = 4'd3;
    localparam ROR = 4'd4;
    localparam SLT = 4'd5;
    localparam SGE = 4'd6;
    localparam AND = 4'd7;

    // Pipeline registers
    reg [127:0] input1_r, input2_r;
    reg [3:0] opcode_r;
    reg [4:0] shiftValue_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            input1_r <= 128'b0;
            input2_r <= 128'b0;
            opcode_r <= 4'b0;
            shiftValue_r <= 5'b0;
            result <= 128'b0;
            carryFlag <= 1'b0;
            zeroFlag <= 1'b0;
            overFlowFlag <= 1'b0;
            signFlag <= 1'b0;
        end else begin
            input1_r <= input1;
            input2_r <= input2;
            opcode_r <= opcode;
            shiftValue_r <= shiftValue;

            case (opcode_r)
                ADD: begin
                    {carryFlag, result} <= {1'b0, input1_r} + {1'b0, input2_r};
                    overFlowFlag <= (input1_r[127] == input2_r[127]) && (result[127] != input1_r[127]);
                end
                SUB: begin
                    {carryFlag, result} <= {1'b0, input1_r} - {1'b0, input2_r};
                    overFlowFlag <= (input1_r[127] != input2_r[127]) && (result[127] != input1_r[127]);
                end
                MUL: begin
                    result <= input1_r * input2_r;
                end
                ROL: begin
                    result <= rol(input1_r, shiftValue_r);
                end
                ROR: begin
                    result <= ror(input1_r, shiftValue_r);
                end
                SLT: begin
                end
                SGE: begin
                end
                AND: begin
                    result <= input1_r & input2_r;
                end
            default: result <= 128'b0;
        endcase
    end

endmodule