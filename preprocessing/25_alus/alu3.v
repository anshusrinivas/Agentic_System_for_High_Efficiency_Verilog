module alu3 (
    input  [31:0] input1, input2,
    input  [4:0]  shiftValue,
    input  [3:0]  ALUSel,
    output reg [31:0] result,
    output wire carryFlag, zeroFlag, overFlowFlag, signFlag
);
    localparam ADD=4'b0000, SUB=4'b0001, AND=4'b0010, OR=4'b0011, XOR=4'b0100,
               SLL=4'b0101, SRL=4'b0110, SRA=4'b0111, SLT=4'b1000, SLTU=4'b1001,
               PASSB=4'b1010, MAX=4'b1011;

    wire [32:0] sum33 = (ALUSel==SUB) ? ({1'b0,input1}+{1'b0,~input2}+33'd1)
                                      : ({1'b0,input1}+{1'b0,input2});
    wire [31:0] addTemp = sum33[31:0];

    assign carryFlag = sum33[32];
    assign zeroFlag  = (addTemp==0);
    assign signFlag  = addTemp[31];
    assign overFlowFlag = ((ALUSel==ADD) && (input1[31]==input2[31]) && (addTemp[31]!=input1[31]))
                       || ((ALUSel==SUB) && (input1[31]!=input2[31]) && (addTemp[31]!=input1[31]));

    always @(*) begin
        case(ALUSel)
            ADD: result = addTemp;
            SUB: result = addTemp;
            AND: result = input1 & input2;
            OR : result = input1 | input2;
            XOR: result = input1 ^ input2;
            SLL: result = input1 << shiftValue;
            SRL: result = input1 >> shiftValue;
            SRA: result = input1 >>> shiftValue;
            SLT: result = ($signed(input1) < $signed(input2)) ? 32'd1 : 32'd0;
            SLTU: result = (input1 < input2) ? 32'd1 : 32'd0;
            PASSB: result = input2;
            MAX: result = (input1>input2)? input1 : input2;
            default: result = 32'd0;
        endcase
    end
endmodule

