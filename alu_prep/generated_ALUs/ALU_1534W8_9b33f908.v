`timescale 1ns / 1ps

// Generated ALU Module
// Style: PIPELINED
// Bit width: 8
// Operations: ADD, SUB, MUL, MIN, SGE, SRL, NOR, SLL, AND, NAND, SRA
// Flags: carry, zero, sign

module ALU_1534W8_9b33f908(
    input  wire             clk,
    input  wire             rst,
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam MUL = 4'd2;
    localparam MIN = 4'd3;
    localparam SGE = 4'd4;
    localparam SRL = 4'd5;
    localparam NOR = 4'd6;
    localparam SLL = 4'd7;
    localparam AND = 4'd8;
    localparam NAND = 4'd9;
    localparam SRA = 4'd10;

    // Pipeline registers
    reg [7:0] input1_r, input2_r;
    reg [3:0] opcode_r;
    reg [4:0] shiftValue_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            input1_r <= 8'b0;
            input2_r <= 8'b0;
            opcode_r <= 4'b0;
            shiftValue_r <= 5'b0;
            result <= 8'b0;
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
                MIN: begin
                    result <= (input1_r < input2_r) ? input1_r : input2_r;
                end
                SGE: begin
                end
                SRL: begin
                    result <= input1_r >> shiftValue_r;
                end
                NOR: begin
                    result <= ~(input1_r | input2_r);
                end
                SLL: begin
                    result <= input1_r << shiftValue_r;
                end
                AND: begin
                    result <= input1_r & input2_r;
                end
                NAND: begin
                    result <= ~(input1_r & input2_r);
                end
                SRA: begin
                    result <= $signed(input1_r) >>> shiftValue_r;
                end
            default: result <= 8'b0;
        endcase
    end

endmodule