module NC #(
    parameter IN_WIDTH = 13,
    parameter fractional_bits = 9
)
(
input wire clk,
input wire rst,
input wire  [1:0] St1,St2,St3,
output wire [3:0] OUT
);

//internal signals

reg signed  [1:0] St3_1,St3_2;                      // stage 3 delayed registers
wire signed [2:0] St3_sub;                          // stage 3 feedback
reg signed  [2:0] St3_sub_1;                        // stage 3 feedback delayed
reg signed  [1:0] St2_1,St2_2,St2_3;                // stage 2 delayed registers
wire signed [2:0] St2_St3;                          // stage 2 + stage 3
reg signed  [2:0] St2_St3_1;                        // stage 2 + stage 3 delayed register
wire signed [3:0] St2_St3_sub;                      // stage 2 + stage 3 feedback
reg signed  [3:0] St2_St3_sub_1;                    // stage 2 + stage 3 feedback delayed register
reg signed  [1:0] St1_1,St1_2,St1_3,St1_4,St1_5;    // stage 1 delayed registers

/////////////////////////////////////////////////////////////////////////////////////////////

always @(posedge clk, negedge rst)
begin
    if (!rst) begin
        St3_1 <= 0;
        St3_2 <= 0;
        St3_sub_1 <= 0;
        St2_1 <= 0;
        St2_2 <= 0;
        St2_3 <= 0;
        St2_St3_1 <= 0;
        St2_St3_sub_1 <= 0;
        St1_1 <= 0;
        St1_2 <= 0;
        St1_3 <= 0;
        St1_4 <= 0;
        St1_5 <= 0;
    end else begin
        St3_1 <= St3;
        St3_2 <= St3_1;
        St3_sub_1 <= St3_sub;
        St2_1 <= St2;
        St2_2 <= St2_1;
        St2_3 <= St2_2;
        St2_St3_1 <= St2_St3;
        St2_St3_sub_1 <= St2_St3_sub;
        St1_1 <= St1;
        St1_2 <= St1_1;
        St1_3 <= St1_2;
        St1_4 <= St1_3;
        St1_5 <= St1_4;
    end
end

assign St3_sub = $signed(St3_1) - $signed(St3_2);
assign St2_St3 = $signed(St2_3) + $signed(St3_sub_1);
assign St2_St3_sub = $signed(St2_St3) - $signed(St2_St3_1);
assign OUT = $signed(St1_5) + $signed(St2_St3_sub_1);

endmodule 