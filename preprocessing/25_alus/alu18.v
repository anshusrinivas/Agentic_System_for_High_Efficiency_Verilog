// --------------------------- ALU18 : Increment/Decrement + Logic + MAX/MIN ----
module alu18 (
    input [31:0] input1,input2,
    input [4:0] shiftValue,
    input [3:0] ALUSel,
    output reg [31:0] result,
    output wire carryFlag, zeroFlag, overFlowFlag, signFlag
);
    localparam INC=4'b0000, DEC=4'b0001, AND=4'b0010, OR=4'b0011, XOR=4'b0100,
               MAX=4'b0101, MIN=4'b0110, ADD=4'b0111, SUB=4'b1000;

    wire [32:0] sum33=(ALUSel==SUB)?({1'b0,input1}+{1'b0,~input2}+33'd1):({1'b0,input1}+{1'b0,input2});
    wire [31:0] addTemp=sum33[31:0];
    assign carryFlag=sum33[32];
    assign zeroFlag=(result==0);
    assign signFlag=result[31];
    assign overFlowFlag=((ALUSel==ADD)&&(input1[31]==input2[31])&&(addTemp[31]!=input1[31]))
                        ||((ALUSel==SUB)&&(input1[31]!=input2[31])&&(addTemp[31]!=input1[31]));

    always @(*) begin
        case(ALUSel)
            INC : result=input1+1;
            DEC : result=input1-1;
            AND : result=input1 & input2;
            OR  : result=input1 | input2;
            XOR : result=input1 ^ input2;
            MAX : result=(input1>input2)?input1:input2;
            MIN : result=(input1<input2)?input1:input2;
            ADD : result=addTemp;
            SUB : result=addTemp;
            default: result=32'd0;
        endcase
    end
endmodule
