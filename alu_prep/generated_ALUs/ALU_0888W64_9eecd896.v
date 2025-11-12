`timescale 1ns / 1ps

// Generated ALU Module
// Style: PIPELINED
// Bit width: 64
// Operations: ADD, SUB, MUL, MAX, XNOR, XOR, PASSB, SLTU, ROL, NOR, OR, MIN
// Flags: carry, zero, overflow

module ALU_0888W64_9eecd896(
    input  wire             clk,
    input  wire             rst,
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam MUL = 4'd2;
    localparam MAX = 4'd3;
    localparam XNOR = 4'd4;
    localparam XOR = 4'd5;
    localparam PASSB = 4'd6;
    localparam SLTU = 4'd7;
    localparam ROL = 4'd8;
    localparam NOR = 4'd9;
    localparam OR = 4'd10;
    localparam MIN = 4'd11;

    // Pipeline registers
    reg [63:0] input1_r, input2_r;
    reg [3:0] opcode_r;
    reg [4:0] shiftValue_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            input1_r <= 64'b0;
            input2_r <= 64'b0;
            opcode_r <= 4'b0;
            shiftValue_r <= 5'b0;
            result <= 64'b0;
            carryFlag <= 1'b0;
            zeroFlag <= 1'b0;
            overFlowFlag <= 1'b0;
        end else begin
            input1_r <= input1;
            input2_r <= input2;
            opcode_r <= opcode;
            shiftValue_r <= shiftValue;

            case (opcode_r)
                ADD: begin
                    {carryFlag, result} <= {1'b0, input1_r} + {1'b0, input2_r};
                    overFlowFlag <= (input1_r[63] == input2_r[63]) && (result[63] != input1_r[63]);
                end
                SUB: begin
                    {carryFlag, result} <= {1'b0, input1_r} - {1'b0, input2_r};
                    overFlowFlag <= (input1_r[63] != input2_r[63]) && (result[63] != input1_r[63]);
                end
                MUL: begin
                    result <= input1_r * input2_r;
                end
                MAX: begin
                    result <= (input1_r > input2_r) ? input1_r : input2_r;
                end
                XNOR: begin
                    result <= ~(input1_r ^ input2_r);
                end
                XOR: begin
                    result <= input1_r ^ input2_r;
                end
                PASSB: begin
                    result <= input2_r;
                end
                SLTU: begin
                end
                ROL: begin
                    result <= rol(input1_r, shiftValue_r);
                end
                NOR: begin
                    result <= ~(input1_r | input2_r);
                end
                OR: begin
                    result <= input1_r | input2_r;
                end
                MIN: begin
                    result <= (input1_r < input2_r) ? input1_r : input2_r;
                end
            default: result <= 64'b0;
        endcase
    end

endmodule