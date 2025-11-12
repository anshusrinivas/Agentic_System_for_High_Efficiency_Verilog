`timescale 1ns / 1ps

// --------------------------- ALU22 : Maximum operations ----------------------
module alu22_max(
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]  shiftValue,
    input  wire [3:0]  ALUSel,
    output reg  [31:0] result,
    output wire        carryFlag,
    output wire        zeroFlag,
    output wire        overFlowFlag,
    output wire        signFlag
);

    // -------------------- ALU Opcodes --------------------
    localparam ALU_ADD   = 4'b0000,
               ALU_SUB   = 4'b0001,
               ALU_AND   = 4'b0010,
               ALU_OR    = 4'b0011,
               ALU_XOR   = 4'b0100,
               ALU_NOR   = 4'b0101,
               ALU_NAND  = 4'b0110,
               ALU_SLL   = 4'b0111,
               ALU_SRL   = 4'b1000,
               ALU_SRA   = 4'b1001,
               ALU_PASSB = 4'b1010,
               ALU_MUL   = 4'b1011,
               ALU_DIV   = 4'b1100,
               ALU_MAX   = 4'b1101,
               ALU_MIN   = 4'b1110,
               ALU_CLZ   = 4'b1111,
               ALU_CTZ   = 4'b10000,
               ALU_ROT   = 4'b10001,
               ALU_SLT   = 4'b10010,
               ALU_SLTU  = 4'b10011;

    // -------------------- Internal Wires --------------------
    wire [31:0] neg_input2 = ~input2;
    wire [32:0] sum33 = (ALUSel == ALU_SUB) ? ({1'b0,input1} + {1'b0,neg_input2} + 33'd1)
                                             : ({1'b0,input1} + {1'b0,input2});
    wire [31:0] addTemp = sum33[31:0];

    assign carryFlag = sum33[32];
    assign zeroFlag  = (addTemp == 32'd0);
    assign signFlag  = addTemp[31];
    assign overFlowFlag = ((ALUSel==ALU_ADD)  && (input1[31]==input2[31]) && (addTemp[31] != input1[31]))
                       || ((ALUSel==ALU_SUB)  && (input1[31]!=input2[31]) && (addTemp[31] != input1[31]));

    // -------------------- Rotate Function --------------------
    function [31:0] rol; input [31:0] a; input [4:0] sh; begin
        rol = (a << sh) | (a >> (32-sh));
    end endfunction

    // -------------------- CLZ / CTZ --------------------
    reg [31:0] clz_result, ctz_result;
    reg done;
    integer i; // module-scope index

    always @(*) begin
        // CLZ
        clz_result = 32'd32;
        done = 1'b0;
        for (i=0; i<32; i=i+1) begin
            if (!done && input1[31-i]) begin
                clz_result = i;
                done = 1'b1;
            end
        end

        // CTZ
        ctz_result = 32'd32;
        done = 1'b0;
        for (i=0; i<32; i=i+1) begin
            if (!done && input1[i]) begin
                ctz_result = i;
                done = 1'b1;
            end
        end
    end

    // -------------------- Main ALU Operation --------------------
    always @(*) begin
        case(ALUSel)
            ALU_ADD:   result = addTemp;
            ALU_SUB:   result = addTemp;
            ALU_AND:   result = input1 & input2;
            ALU_OR:    result = input1 | input2;
            ALU_XOR:   result = input1 ^ input2;
            ALU_NOR:   result = ~(input1 | input2);
            ALU_NAND:  result = ~(input1 & input2);
            ALU_SLL:   result = input1 << shiftValue;
            ALU_SRL:   result = input1 >> shiftValue;
            ALU_SRA:   result = input1 >>> shiftValue;
            ALU_PASSB: result = input2;
            ALU_MUL:   result = input1 * input2;
            ALU_DIV:   result = (input2 != 0) ? input1 / input2 : 32'd0;
            ALU_MAX:   result = (input1 > input2) ? input1 : input2;
            ALU_MIN:   result = (input1 < input2) ? input1 : input2;
            ALU_CLZ:   result = clz_result;
            ALU_CTZ:   result = ctz_result;
            ALU_ROT:   result = rol(input1, shiftValue);
            ALU_SLT:   result = ($signed(input1) < $signed(input2)) ? 32'd1 : 32'd0;
            ALU_SLTU:  result = (input1 < input2) ? 32'd1 : 32'd0;
            default:   result = 32'd0;
        endcase
    end

endmodule


