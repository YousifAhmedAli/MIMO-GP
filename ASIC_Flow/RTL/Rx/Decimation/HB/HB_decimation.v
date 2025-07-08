

module HB_decimation(

 input signed [9:0]in_HB,
 input  clk,rst_n,clk_2,   
 output signed [18:0]out_HB

);

 wire signed [17:0]out_E0;
 wire signed [17:0]out_E1;
 reg  signed [9:0]ff_1;       // at branch 1 
 wire signed [9:0]down_out_0;
 wire signed [9:0]down_out_1;
 
 
down_sampler #(2,10) up0 (.clk(clk), .rst_n(rst_n), .din(in_HB), .dout(down_out_1));
down_sampler #(2,10) up1 (.clk(clk), .rst_n(rst_n), .din(ff_1), .dout(down_out_0)); 
 
E0_HB DUT0(.in_E0(down_out_0), .clk(clk), .rst_n(rst_n), .out_E0(out_E0));
E1_HB DUT1(.in_E1(down_out_1), .clk(clk), .rst_n(rst_n), .out_E1(out_E1));

assign out_HB = out_E0 + out_E1 ;
 
    always @(posedge clk_2 or negedge rst_n )begin  // at fast clock
        if (!rst_n) begin
            ff_1 <=0;
		end 
			
		else begin 
		 ff_1  <= in_HB;
		end 
	end 
endmodule 
