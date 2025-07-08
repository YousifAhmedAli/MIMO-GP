module Stage #(
    parameter IN_WIDTH = 13,
    parameter fractional_bits = 9
)
(
    input  wire clk,
    input  wire rst,
    input  wire [IN_WIDTH-1:0] in_data,
    output wire  [1:0] sign_out,
    output reg [IN_WIDTH-1:0] NS_fb
);

wire signed [IN_WIDTH-1:0] feedback;
wire signed [IN_WIDTH:0] in_plus_feedback;
reg [1:0] internal_sign_out;
always @(posedge clk, negedge rst)
begin
    if (!rst) begin
        NS_fb <= 0;
    end else begin
        NS_fb <= feedback;
    end
end

assign feedback = $signed(in_plus_feedback) - $signed({sign_out, {fractional_bits{1'b0}}});
assign in_plus_feedback = $signed(in_data) + $signed(NS_fb);
assign sign_out = internal_sign_out;
always @(*)
begin
    case ({in_plus_feedback[IN_WIDTH] , |in_plus_feedback[IN_WIDTH-1:0]})
        2'b00: internal_sign_out = 2'sb0; // zero
        2'b01: internal_sign_out = 2'sb1; // positive
        2'b10: internal_sign_out = -2'sb1; // negative
        2'b11: internal_sign_out = -2'sb1; // negative
    endcase
end
    
endmodule 