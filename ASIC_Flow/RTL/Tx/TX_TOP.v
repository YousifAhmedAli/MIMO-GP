module TX_TOP #(
    parameter IN_WIDTH = 13,
    parameter fractional_bits = 9,
	parameter IN_WIDTH_CWM = 16,
	parameter fractional_bits_CWM = 7
)(
	input wire clk,rst,
	input wire [IN_WIDTH_CWM-1:0] in_data_1,in_data_2,phi,
	output wire signed [6:0] OUT_DUC
);

/////////////internal///////////
wire clk_2,clk_4,clk_8,clk_16,clk_32;
wire [5:0] out_ddsm_i_duc,out_ddsm_q_duc;
wire [17:0] CWM_out_1, CWM_out_2;
wire [19:0] out_interpolation_1, out_interpolation_2;
wire [12:0] ddsm_in_1, ddsm_in_2;
////////////////////////////////

assign ddsm_in_1 = {out_interpolation_1[19],out_interpolation_1[19],out_interpolation_1[19:9]};
assign ddsm_in_2 = {out_interpolation_2[19],out_interpolation_2[19],out_interpolation_2[19:9]};
/////////////////////////////////

cwm_tx_top cwm_1 (
	.clk(clk_32),
	.rst(rst),
	.I_processor(in_data_1),
	.Q_processor(in_data_2),
	.phi(phi),
	.I_cwm(CWM_out_1),
	.Q_cwm(CWM_out_2)
);


interpolation  interpolation_1 (
	.clk(clk_32),
	.clk_2(clk_16),
	.clk_8(clk_2),
	.rst_n(rst),
	.in_interpolation(CWM_out_1),
	.out_interpolation(out_interpolation_1)
);

interpolation interpolation_2 (
	.clk(clk_32),
	.clk_2(clk_16),
	.clk_8(clk_2),
	.rst_n(rst),
	.in_interpolation(CWM_out_2),
	.out_interpolation(out_interpolation_2)
);

Top #(
.IN_WIDTH(IN_WIDTH),
.fractional_bits(fractional_bits)
) ddsm1 (
.clk(clk_2),
.rst(rst),
.in_data(ddsm_in_1),
.out_ddsm_i_duc(out_ddsm_i_duc)
);

Top #(
.IN_WIDTH(IN_WIDTH),
.fractional_bits(fractional_bits)
) ddsm2 (
.clk(clk_2),
.rst(rst),
.in_data(ddsm_in_2),
.out_ddsm_i_duc(out_ddsm_q_duc)
);

clk_div clk_dut(
.rst(rst),
.clk(clk),
.clk_2(clk_2),
.clk_4(clk_4),
.clk_8(clk_8),
.clk_16(clk_16),
.clk_32(clk_32)
);

duc duc_dut(
.clk(clk),
.rst(rst),
.I_DUC(out_ddsm_i_duc),
.Q_DUC(out_ddsm_q_duc),
.OUT_DUC(OUT_DUC)
);
endmodule