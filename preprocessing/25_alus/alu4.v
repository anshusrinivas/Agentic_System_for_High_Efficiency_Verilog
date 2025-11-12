// --------------------------- ALU 4 : Multiply + MAX -------------------------
module alu4 (
    input [31:0] input1, input2,
    input [4:0]  shiftValue,
    input [3:0]  ALUSel,
    output reg [31:0] result,
    output wire carryFlag, zeroFlag, overFlowFlag, signFlag
);
    localparam ADD=4'b0000, SUB=4'b0001, MUL=4'b1010, MAX=4'b1011;

    wire [32:0] sum33 = (ALUSel==SUB)? ({1'b0,input1}+{1'b0,~input2}+33'd1)
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
            MUL: result = input1 * input2;
            MAX: result = (input1>input2)? input1:input2;
            default: result = 32'd0;
        endcase
    end
endmodule

