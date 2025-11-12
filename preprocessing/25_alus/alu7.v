// --------------------------- ALU7 : Arithmetic + Logic ----------------------
module alu7 (
    input  [31:0] input1, input2,
    input  [4:0]  shiftValue,
    input  [3:0]  ALUSel,
    output reg [31:0] result,
    output wire carryFlag, zeroFlag, overFlowFlag, signFlag
);
    localparam ADD=4'b0000, SUB=4'b0001, MUL=4'b0010, DIV=4'b0011,
               AND=4'b0100, OR=4'b0101, XOR=4'b0110, NOR=4'b0111,
               MAX=4'b1000, MIN=4'b1001;

    wire [32:0] sum33 = (ALUSel==SUB)? ({1'b0,input1}+{1'b0,~input2}+33'd1) : ({1'b0,input1}+{1'b0,input2});
    wire [31:0] addTemp = sum33[31:0];
    assign carryFlag = sum33[32];
    assign zeroFlag  = (result==0);
    assign signFlag  = result[31];
    assign overFlowFlag = ((ALUSel==ADD) && (input1[31]==input2[31]) && (addTemp[31]!=input1[31]))
                        || ((ALUSel==SUB) && (input1[31]!=input2[31]) && (addTemp[31]!=input1[31]));

    always @(*) begin
        case(ALUSel)
            ADD : result = addTemp;
            SUB : result = addTemp;
            MUL : result = input1*input2;
            DIV : result = (input2!=0)? input1/input2 : 32'd0;
            AND : result = input1 & input2;
            OR  : result = input1 | input2;
            XOR : result = input1 ^ input2;
            NOR : result = ~(input1 | input2);
            MAX : result = (input1>input2)? input1:input2;
            MIN : result = (input1<input2)? input1:input2;
            default : result = 32'd0;
        endcase
    end
endmodule

