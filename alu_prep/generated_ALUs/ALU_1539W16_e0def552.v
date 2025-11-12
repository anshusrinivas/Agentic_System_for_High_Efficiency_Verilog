`timescale 1ns / 1ps

// Generated ALU Module
// Style: STANDARD
// Bit width: 16
// Operations: ADD, SUB, AND, OR, DIV, NAND, XNOR, PASSB
// Flags: carry, zero, sign

module ALU_1539W16_e0def552(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [15:0] result
    ,output wire carryFlag
    ,output wire zeroFlag
    ,output wire signFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam AND = 4'd2;
    localparam OR = 4'd3;
    localparam DIV = 4'd4;
    localparam NAND = 4'd5;
    localparam XNOR = 4'd6;
    localparam PASSB = 4'd7;

    // Internal signals
    wire [16:0] sum = (opcode == SUB) ? 
                             {1'b0, input1} - {1'b0, input2} : 
                             {1'b0, input1} + {1'b0, input2};

    // Combinational logic
    always @(*) begin
        case (opcode)
            ADD: begin
                result = input1 + input2;
                
            end
            SUB: begin
                result = input1 - input2;
                
            end
            AND: begin
                result = input1 & input2;
            end
            OR: begin
                result = input1 | input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            PASSB: begin
                result = input2;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule