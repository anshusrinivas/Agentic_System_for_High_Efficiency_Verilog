`timescale 1ns / 1ps

// Generated ALU Module
// Style: PIPELINED
// Bit width: 16
// Operations: ADD, SUB, MUL, SGT, SGE, SLL, NAND, ROL
// Flags: carry, zero, sign

module ALU_0795W16_85719efd(
    input  wire             clk,
    input  wire             rst,
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam MUL = 4'd2;
    localparam SGT = 4'd3;
    localparam SGE = 4'd4;
    localparam SLL = 4'd5;
    localparam NAND = 4'd6;
    localparam ROL = 4'd7;

    // Pipeline registers
    reg [15:0] input1_r, input2_r;
    reg [3:0] opcode_r;
    reg [4:0] shiftValue_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            input1_r <= 16'b0;
            input2_r <= 16'b0;
            opcode_r <= 4'b0;
            shiftValue_r <= 5'b0;
            result <= 16'b0;
            carryFlag <= 1'b0;
            zeroFlag <= 1'b0;
            signFlag <= 1'b0;
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
                SGT: begin
                end
                SGE: begin
                end
                SLL: begin
                    result <= input1_r << shiftValue_r;
                end
                NAND: begin
                    result <= ~(input1_r & input2_r);
                end
                ROL: begin
                    result <= rol(input1_r, shiftValue_r);
                end
            default: result <= 16'b0;
        endcase
    end

endmodule