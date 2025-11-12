`timescale 1ns / 1ps

// Generated ALU Module
// Style: PIPELINED
// Bit width: 16
// Operations: ADD, SUB, MUL, SRA
// Flags: carry

module ALU_0552W16_64a5617e(
    input  wire             clk,
    input  wire             rst,
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam MUL = 4'd2;
    localparam SRA = 4'd3;

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
                SRA: begin
                    result <= $signed(input1_r) >>> shiftValue_r;
                end
            default: result <= 16'b0;
        endcase
    end

endmodule