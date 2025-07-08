module Top #(
    parameter IN_WIDTH = 13,
    parameter fractional_bits = 9
)(
    input  wire clk,
    input  wire rst,
    input  wire [IN_WIDTH-1:0] in_data,
	output wire [5:0] out_ddsm_i_duc
        //i will make it as internal 
);

// Internal signals
wire signed [IN_WIDTH-1:0] in_data_2;
wire signed [IN_WIDTH-1:0] in_data_3;
wire  [1:0] out_stage_1;
wire  [1:0] out_stage_2;
wire  [1:0] out_stage_3;
wire [IN_WIDTH-1:0] floating_fb;
wire [3:0] DDSM_out;
wire [7:0] temp_out;
//

assign temp_out = {DDSM_out[3],2'b00,DDSM_out[2:0],2'b00}; // gain of 4 in final of ddsm
assign out_ddsm_i_duc = {temp_out[7],temp_out[4:0]}; //convert between ddsm and duc

Stage #(
    .IN_WIDTH(IN_WIDTH),
    .fractional_bits(fractional_bits)
) stage_1 (
    .clk(clk),
    .rst(rst),
    .in_data(in_data),
    .sign_out(out_stage_1),
    .NS_fb(in_data_2)
);

Stage #(
    .IN_WIDTH(IN_WIDTH),
    .fractional_bits(fractional_bits)
) stage_2 (
    .clk(clk),
    .rst(rst),
    .in_data(in_data_2),
    .sign_out(out_stage_2),
    .NS_fb(in_data_3)
);

Stage #(
    .IN_WIDTH(IN_WIDTH),
    .fractional_bits(fractional_bits)
) stage_3 (
    .clk(clk),
    .rst(rst),
    .in_data(in_data_3),
    .sign_out(out_stage_3),
    .NS_fb(floating_fb)
);

NC #(
    .IN_WIDTH(IN_WIDTH),
    .fractional_bits(fractional_bits)
) noise_cancellation (
    .clk(clk),
    .rst(rst),
    .St1(out_stage_1),
    .St2(out_stage_2),
    .St3(out_stage_3),
    .OUT(DDSM_out)
);


endmodule