// --------------------------- ALU8 : Shift + Rotate + Logic ------------------
module alu8 (
    input  [31:0] input1, input2,
    input  [4:0]  shiftValue,
    input  [3:0]  ALUSel,
    output reg [31:0] result,
    output wire carryFlag, zeroFlag, overFlowFlag, signFlag
);
    localparam SLL=4'b0000, SRL=4'b0001, SRA=4'b0010, ROL=4'b0011, ROR=4'b0100,
               AND=4'b0101, OR=4'b0110, XOR=4'b0111, MAX=4'b1000, MIN=4'b1001;

    assign carryFlag=0;
    assign zeroFlag=(result==0);
    assign signFlag=result[31];
    assign overFlowFlag=0;

    function [31:0] rol(input [31:0] a, input [4:0] sh); begin rol=(a<<sh)|(a>>(32-sh)); end endfunction
    function [31:0] ror(input [31:0] a, input [4:0] sh); begin ror=(a>>sh)|(a<<(32-sh)); end endfunction

    always @(*) begin
        case(ALUSel)
            SLL : result = input1 << shiftValue;
            SRL : result = input1 >> shiftValue;
            SRA : result = $signed(input1) >>> shiftValue;
            ROL : result = rol(input1, shiftValue);
            ROR : result = ror(input1, shiftValue);
            AND : result = input1 & input2;
            OR  : result = input1 | input2;
            XOR : result = input1 ^ input2;
            MAX : result = (input1>input2)? input1:input2;
            MIN : result = (input1<input2)? input1:input2;
            default : result = 32'd0;
        endcase
    end
endmodule

