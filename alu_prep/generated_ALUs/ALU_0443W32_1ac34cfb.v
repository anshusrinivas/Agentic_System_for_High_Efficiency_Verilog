`timescale 1ns / 1ps

// Generated ALU Module
// Style: PIPELINED
// Bit width: 32
// Operations: ADD, SUB, MUL, SGT, NAND, SLTU
// Flags: carry, zero, overflow, sign

module ALU_0443W32_1ac34cfb(
    input  wire             clk,
    input  wire             rst,
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam MUL = 4'd2;
    localparam SGT = 4'd3;
    localparam NAND = 4'd4;
    localparam SLTU = 4'd5;

    // Pipeline registers
    reg [31:0] input1_r, input2_r;
    reg [3:0] opcode_r;
    reg [4:0] shiftValue_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            input1_r <= 32'b0;
            input2_r <= 32'b0;
            opcode_r <= 4'b0;
            shiftValue_r <= 5'b0;
            result <= 32'b0;
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
                    overFlowFlag <= (input1_r[31] == input2_r[31]) && (result[31] != input1_r[31]);
                end
                SUB: begin
                    {carryFlag, result} <= {1'b0, input1_r} - {1'b0, input2_r};
                    overFlowFlag <= (input1_r[31] != input2_r[31]) && (result[31] != input1_r[31]);
                end
                MUL: begin
                    result <= input1_r * input2_r;
                end
                SGT: begin
                end
                NAND: begin
                    result <= ~(input1_r & input2_r);
                end
                SLTU: begin
                end
            default: result <= 32'b0;
        endcase
    end

endmodule