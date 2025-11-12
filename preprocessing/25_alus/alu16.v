`timescale 1ns / 1ps

module alu16 (
    input  [31:0] input1, input2,
    input  [4:0]  shiftValue,
    input  [3:0]  ALUSel,
    output reg [31:0] result,
    output wire carryFlag, zeroFlag, overFlowFlag, signFlag
);

    localparam ADD=4'b0000, SUB=4'b0001, CLZ=4'b0010, CTZ=4'b0011,
               MAX=4'b0100, MIN=4'b0101, AND=4'b0110, OR=4'b0111;

    wire [32:0] sum33 = (ALUSel==SUB) ? ({1'b0,input1} + {1'b0,~input2} + 33'd1)
                                       : ({1'b0,input1} + {1'b0,input2});
    wire [31:0] addTemp = sum33[31:0];

    assign carryFlag    = sum33[32];
    assign zeroFlag     = (result==32'd0);
    assign signFlag     = result[31];
    assign overFlowFlag = ((ALUSel==ADD) && (input1[31]==input2[31]) && (addTemp[31]!=input1[31]))
                        || ((ALUSel==SUB) && (input1[31]!=input2[31]) && (addTemp[31]!=input1[31]));

    integer i;
    reg found;

    always @(*) begin
        result = 32'd0;
        case(ALUSel)
            ADD : result = addTemp;
            SUB : result = addTemp;
            AND : result = input1 & input2;
            OR  : result = input1 | input2;
            MAX : result = (input1>input2)? input1 : input2;
            MIN : result = (input1<input2)? input1 : input2;

            CLZ : begin
                result = 32'd32;
                found = 0;
                for(i=31; i>=0; i=i-1) begin
                    if(!found && input1[i]) begin
                        result = 31 - i;
                        found = 1;
                    end
                end
            end

            CTZ : begin
                result = 32'd32;
                found = 0;
                for(i=0; i<32; i=i+1) begin
                    if(!found && input1[i]) begin
                        result = i;
                        found = 1;
                    end
                end
            end

            default: result = 32'd0;
        endcase
    end
endmodule

