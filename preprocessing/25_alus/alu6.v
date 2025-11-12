// --------------------------- ALU6 : Comparison-heavy -----------------------
module alu6 (
    input  [31:0] input1, input2,
    input  [4:0]  shiftValue,
    input  [3:0]  ALUSel,
    output reg [31:0] result,
    output wire carryFlag, zeroFlag, overFlowFlag, signFlag
);
    localparam SLT=4'b0000, SLTU=4'b0001, EQ=4'b0010, NEQ=4'b0011,
               MAX=4'b0100, MIN=4'b0101;

    assign carryFlag=0;
    assign zeroFlag = (result==0);
    assign signFlag = result[31];
    assign overFlowFlag = 0;

    always @(*) begin
        case(ALUSel)
            SLT : result = ($signed(input1)<$signed(input2))? 32'd1:32'd0;
            SLTU: result = (input1<input2)? 32'd1:32'd0;
            EQ  : result = (input1==input2)? 32'd1:32'd0;
            NEQ : result = (input1!=input2)? 32'd1:32'd0;
            MAX : result = (input1>input2)? input1:input2;
            MIN : result = (input1<input2)? input1:input2;
            default : result = 32'd0;
        endcase
    end
endmodule
