// --------------------------- ALU20 : Full feature ----------------------------
module alu20 (
    input [31:0] input1,input2,
    input [4:0] shiftValue,
    input [3:0] ALUSel,
    output reg [31:0] result,
    output wire carryFlag, zeroFlag, overFlowFlag, signFlag
);
    localparam ADD=4'b0000, SUB=4'b0001, MUL=4'b0010, DIV=4'b0011, AND=4'b0100,
               OR=4'b0101, XOR=4'b0110, NOR=4'b0111, ROL=4'b1000, ROR=4'b1001,
               MAX=4'b1010, MIN=4'b1011, NEG=4'b1100, ABS=4'b1101, INC=4'b1110, DEC=4'b1111;

    wire [32:0] sum33=(ALUSel==SUB)?({1'b0,input1}+{1'b0,~input2}+33'd1):({1'b0,input1}+{1'b0,input2});
    wire [31:0] addTemp=sum33[31:0];
    assign carryFlag=sum33[32];
    assign zeroFlag=(result==0);
    assign signFlag=result[31];
    assign overFlowFlag=((ALUSel==ADD)&&(input1[31]==input2[31])&&(addTemp[31]!=input1[31]))
                        ||((ALUSel==SUB)&&(input1[31]!=input2[31])&&(addTemp[31]!=input1[31]));

    function [31:0] rol(input [31:0] a,input [4:0] sh); begin rol=(a<<sh)|(a>>(32-sh)); end endfunction
    function [31:0] ror(input [31:0] a,input [4:0] sh); begin ror=(a>>sh)|(a<<(32-sh)); end endfunction

    always @(*) begin
        case(ALUSel)
            ADD : result=addTemp;
            SUB : result=addTemp;
            MUL : result=input1*input2;
            DIV : result=(input2!=0)?input1/input2:32'd0;
            AND : result=input1 & input2;
            OR  : result=input1 | input2;
            XOR : result=input1 ^ input2;
            NOR : result=~(input1|input2);
            ROL : result=rol(input1,shiftValue);
            ROR : result=ror(input1,shiftValue);
            MAX : result=(input1>input2)?input1:input2;
            MIN : result=(input1<input2)?input1:input2;
            NEG : result=-input1;
            ABS : result=(input1[31])?-input1:input1;
            INC : result=input1+1;
            DEC : result=input1-1;
            default: result=32'd0;
        endcase
    end
endmodule
