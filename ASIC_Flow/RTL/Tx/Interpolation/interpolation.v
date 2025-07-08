
module interpolation (
input wire clk , clk_2 , clk_8 , rst_n ,
input wire signed [17:0] in_interpolation ,
output wire signed [19:0] out_interpolation
);

wire signed [22:0] out_HB ;
wire signed [10:0] in_comb ;
wire signed [12:0] out ;
wire signed [14:0] in_HB;

assign in_comb = out_HB >>> 12 ;  // must use arthimatic shift right because we deal with signed numbers

assign in_HB = in_interpolation[14:0] ;

assign out = {out_interpolation[19],out_interpolation[19],out_interpolation[19:9]} ;

HB_interpolation dut_HB (
.in_HB(in_HB),
.clk(clk),
.rst_n(rst_n),
.clk_2(clk_2),
.out_HB(out_HB)
);

comb_interpolation dut_comb(
.in_comb(in_comb),
.clk(clk_2),
.clk_8(clk_8),
.rst_n(rst_n),
.out_comb(out_interpolation)
);

endmodule
