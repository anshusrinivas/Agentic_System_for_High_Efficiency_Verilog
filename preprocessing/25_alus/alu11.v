// --------------------------- ALU11 : Rotate + Arithmetic + MAX/MIN ----------
module alu11 (
    input  [31:0] input1, input2,
    input  [4:0]  shiftValue,
    input  [3:0]  ALUSel,
    output reg [31:0] result,
    output wire carryFlag, zeroFlag, overFlowFlag, signFlag
);
    localparam ADD=4'b0000, SUB=4'b0001, MUL=4'b0010, ROL=4'b0011, ROR=4'b0100,
               NEG=4'b0101, ABS=4'b0110, MAX=4'b0111, MIN=4'b1000;

    wire [32:0] sum33 = (ALUSel==SUB) ? ({1'b0,input1}+{1'b0,~input2}+33'd1) : ({1'b0,input1}+{1'b0,input2});
    wire [31:0] addTemp = sum33[31:0];
    assign carryFlag = sum33[32];
    assign zeroFlag  = (result==0);
    assign signFlag  = result[31];
    assign overFlowFlag = ((ALUSel==ADD) && (input1[31]==input2[31]) && (addTemp[31]!=input1[31]))
                        || ((ALUSel==SUB) && (input1[31]!=input2[31]) && (addTemp[31]!=input1[31]));

    function [31:0] rol(input [31:0] a, input [4:0] sh); begin rol=(a<<sh)|(a>>(32-sh)); end endfunction
    function [31:0] ror(input [31:0] a, input [4:0] sh); begin ror=(a>>sh)|(a<<(32-sh)); end endfunction

    always @(*) begin
        case(ALUSel)
            ADD : result = addTemp;
            SUB : result = addTemp;
            MUL : result = input1*input2;
            ROL : result = rol(input1,shiftValue);
            ROR : result = ror(input1,shiftValue);
            NEG : result = -input1;
            ABS : result = (input1[31])?-input1:input1;
            MAX : result = (input1>input2)?input1:input2;
            MIN : result = (input1<input2)?input1:input2;
            default: result = 32'd0;
        endcase
    end
endmodule
