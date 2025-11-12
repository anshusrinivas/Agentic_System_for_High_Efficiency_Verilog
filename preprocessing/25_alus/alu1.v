`timescale 1ns / 1ps

module ALU(
    input  wire [4:0]  opcode,     // currently unused
    input  wire [31:0] input1,     
    input  wire [31:0] input2,
    input  wire [4:0]  shiftValue, 
    input  wire [3:0]  ALUSel,     // operation select
    input  wire        inst_25,    // currently unused
    output reg  [31:0] result,
    output wire        carryFlag, 
    output wire        zeroFlag,  
    output wire        overFlowFlag, 
    output wire        signFlag
);

    // ALU operation codes (local to this module)
    localparam ALU_ADD  = 4'b0000,
               ALU_SUB  = 4'b0001,
               ALU_PASS = 4'b0010,
               ALU_OR   = 4'b0011,
               ALU_AND  = 4'b0100,
               ALU_XOR  = 4'b0101,
               ALU_SRL  = 4'b0110,
               ALU_SRA  = 4'b0111,
               ALU_SLL  = 4'b1000,
               ALU_SLT  = 4'b1001,
               ALU_SLTU = 4'b1010;

    // Internal wires
    wire [31:0] addTemp, negInput2;    
    assign negInput2 = ~input2;
    
    // ADD/SUB logic (with carry)
    assign {carryFlag, addTemp} = (ALUSel == ALU_SUB) ? 
                                  (input1 + negInput2 + 1'b1) : 
                                  (input1 + input2);
    
    // Flags
    assign zeroFlag     = (addTemp == 32'd0);
    assign signFlag     = addTemp[31];
    assign overFlowFlag = ((ALUSel == ALU_ADD) && (input1[31] == input2[31]) && (addTemp[31] != input1[31])) ||
                          ((ALUSel == ALU_SUB) && (input1[31] != input2[31]) && (addTemp[31] != input1[31]));
    
    // Main ALU operation
    always @(*) begin
        result = 32'b0;
        case (ALUSel)
            ALU_ADD  : result = addTemp;
            ALU_SUB  : result = addTemp;
            ALU_PASS : result = input2;

            ALU_OR   : result = input1 | input2;
            ALU_AND  : result = input1 & input2;
            ALU_XOR  : result = input1 ^ input2;

            ALU_SRL  : result = input1 >> shiftValue;
            ALU_SRA  : result = input1 >>> shiftValue;
            ALU_SLL  : result = input1 << shiftValue;

            ALU_SLT  : result = {31'b0, (signFlag != overFlowFlag)};
            ALU_SLTU : result = {31'b0, ~carryFlag};

            default  : result = 32'b0;
        endcase
    end

endmodule

