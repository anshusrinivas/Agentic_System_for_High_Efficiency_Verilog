`timescale 1ns / 1ps

module alu_32bit (
    input  [31:0] A,      // Operand A
    input  [31:0] B,      // Operand B
    input  [3:0]  ALU_Sel,// Operation select
    output reg [31:0] ALU_Out, // Result
    output reg Zero,      // Zero flag
    output reg CarryOut,  // Carry flag
    output reg Overflow   // Overflow flag
);

wire [32:0] sum;

// Perform addition with carry (used for ADD/SUB)
assign sum = (ALU_Sel == 4'b0001) ? ({1'b0, A} - {1'b0, B}) :
                                    ({1'b0, A} + {1'b0, B});

always @(*) begin
    case (ALU_Sel)
        4'b0000: ALU_Out = A + B;         // ADD
        4'b0001: ALU_Out = A - B;         // SUB
        4'b0010: ALU_Out = A & B;         // AND
        4'b0011: ALU_Out = A | B;         // OR
        4'b0100: ALU_Out = A ^ B;         // XOR
        4'b0101: ALU_Out = ~(A | B);      // NOR
        4'b0110: ALU_Out = (A < B) ? 32'd1 : 32'd0; // SLT
        4'b0111: ALU_Out = A << 1;        // Shift Left
        4'b1000: ALU_Out = A >> 1;        // Shift Right
        4'b1001: ALU_Out = {A[30:0], A[31]}; // Rotate Left
        4'b1010: ALU_Out = {A[0], A[31:1]};  // Rotate Right
        default: ALU_Out = 32'd0;
    endcase

    // Flags
    Zero     = (ALU_Out == 32'd0);
    CarryOut = sum[32]; // MSB of extended result
    Overflow = ( (ALU_Sel==4'b0000 && (A[31]==B[31]) && (ALU_Out[31]!=A[31])) ||
                 (ALU_Sel==4'b0001 && (A[31]!=B[31]) && (ALU_Out[31]!=A[31])) );
end

endmodule

