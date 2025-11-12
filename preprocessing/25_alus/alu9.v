// --------------------------- ALU9 : Comparison + Arithmetic ----------------
module alu9 (
    input  [31:0] input1, input2,
    input  [4:0]  shiftValue,
    input  [3:0]  ALUSel,
    output reg [31:0] result,
    output wire carryFlag, zeroFlag, overFlowFlag, signFlag
);
    localparam ADD=4'b0000, SUB=4'b0001, SLT=4'b0010, SLTU=4'b0011,
               EQ=4'b0100, NEQ=4'b0101, MAX=4'b0110, MIN=4'b0111;

    wire [32:0] sum33 = (ALUSel==SUB)? ({1'b0,input1}+{1'b0,~input2}+33'd1) : ({1'b0,input1}+{1'b0,input2});
    wire [31:0] addTemp = sum33[31:0];
    assign carryFlag = sum33[32];
    assign zeroFlag=(result==0);
    assign signFlag=result[31];
    assign overFlowFlag = ((ALUSel==ADD) && (input1[31]==input2[31]) && (addTemp[31]!=input1[31]))
                        || ((ALUSel==SUB) && (input1[31]!=input2[31]) && (addTemp[31]!=input1[31]));

    always @(*) begin
        case(ALUSel)
            ADD : result = addTemp;
            SUB : result = addTemp;
            SLT : result = ($signed(input1)<$signed(input2))? 32'd1:32'd0;
            SLTU: result = (input1<input2)? 32'd1:32'd0;
            EQ  : result = (input1==input2)? 32'd1:32'd0;
            NEQ : result = (input1!=input2)? 32'd1:32'd0;
            MAX : result = (input1>input2)? input1:input2;
            MIN : result = (input1<input2)? input1:input2;
            default: result = 32'd0;
        endcase
    end
endmodule

