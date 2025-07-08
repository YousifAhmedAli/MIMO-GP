module cwm_tx_top(
     input wire                     clk,
	 input wire                     rst,
	 input wire  signed  [15:0]     I_processor,
	                                Q_processor,
	 input wire  signed  [15:0]     phi,
	 output wire signed  [17:0]     I_cwm,
	                                Q_cwm 
);
/////////////////internal signals///////////////
wire signed [15:0] cos_16b,sin_16b;
wire signed [5:0]  cos_6b,sin_6b;

//////////////////////////////////////////
assign cos_6b = cos_16b[15:10];    //floor im simulink
assign sin_6b = sin_16b[15:10] + (sin_16b[9] ? 6'd1 : 6'd0); //round in simulink

////////////////////////////////////////////
cwm_tx DUT_cwm(
.clk(clk),
.rst(rst),
.I_processor(I_processor),
.Q_processor(Q_processor),
.I_cwm(I_cwm),
.Q_cwm(Q_cwm),
.cos_ph(cos_6b),
.sin_ph(sin_6b)
);

cordic DUT_cordic(
.clk(clk),
.rst(rst),
.theta(phi),
.cos_theta(cos_16b),
.sin_theta(sin_16b)
);

endmodule