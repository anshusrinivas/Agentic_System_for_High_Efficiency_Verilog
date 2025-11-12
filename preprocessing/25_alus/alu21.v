// --------------------------- ALU21 : Saturating Arithmetic + MAX/MIN + Logic ----
module alu21 (
    input [31:0] input1, input2,
    input [4:0] shiftValue,
    input [3:0] ALUSel,
    output reg [31:0] result,
    output wire carryFlag, zeroFlag, overFlowFlag, signFlag
);
    localparam ADD=4'b0000, SUB=4'b0001, SAT_ADD=4'b0010, SAT_SUB=4'b0011,
               AND=4'b0100, OR=4'b0101, XOR=4'b0110, MAX=4'b0111, MIN=4'b1000;

    wire [32:0] sum33 = (ALUSel==SUB || ALUSel==SAT_SUB) ? ({1'b0,input1}+{1'b0,~input2}+33'd1)
                                                         : ({1'b0,input1}+{1'b0,input2});
    wire [31:0] addTemp = sum33[31:0];
    assign carryFlag = sum33[32];
    assign zeroFlag  = (result==32'd0);
    assign signFlag  = result[31];
    assign overFlowFlag = ((ALUSel==ADD || ALUSel==SUB) && ((input1[31]==input2[31])!=(addTemp[31]==input1[31])));

    // Saturating arithmetic
    function [31:0] saturate(input [32:0] val);
        if(val[32]) saturate = 32'h7FFFFFFF;  // Positive overflow
        else if(val[31]) saturate = 32'h80000000; // Negative overflow
        else saturate = val[31:0];
    endfunction

    always @(*) begin
        case(ALUSel)
            ADD     : result = addTemp;
            SUB     : result = addTemp;
            SAT_ADD : result = saturate(sum33);
            SAT_SUB : result = saturate(sum33);
            AND     : result = input1 & input2;
            OR      : result = input1 | input2;
            XOR     : result = input1 ^ input2;
            MAX     : result = (input1>input2)?input1:input2;
            MIN     : result = (input1<input2)?input1:input2;
            default : result = 32'd0;
        endcase
    end
endmodule

