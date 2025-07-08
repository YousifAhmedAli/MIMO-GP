

module HB_interpolation (

 input signed [14:0]in_HB,
 input clk,rst_n,clk_2,
 output signed [22:0]out_HB

);

 wire signed [22:0]out_E0;
 wire signed [22:0]out_E1;
 reg  signed [22:0]E1_ff;
 wire signed [22:0]up_out_0;
 wire signed [22:0]up_out_1;
 
 up_sampler_HB #(2,23) up0 (.clk(clk_2), .rst_n(rst_n), .din(out_E0), .dout(up_out_0));
 up_sampler_HB #(2,23) up1 (.clk(clk_2), .rst_n(rst_n), .din(out_E1), .dout(up_out_1)); 
 
 E0_HB DUT0(.in_E0(in_HB), .clk(clk), .rst_n(rst_n), .out_E0(out_E0));
 E1_HB DUT1(.in_E1(in_HB), .clk(clk), .rst_n(rst_n), .out_E1(out_E1));
 
 assign out_HB = E1_ff + up_out_0;
 
    always @(posedge clk_2 or negedge rst_n )begin
        if (!rst_n) begin
            E1_ff  <=0;
		end 
			
		else begin 
		 E1_ff  <= up_out_1;
		end 
	end 
endmodule 	