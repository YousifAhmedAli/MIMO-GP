
module comb_decimation (
     input wire signed [7:0] in_comb ,
     input wire clk , clk_8 , rst_n ,
     output wire signed [16:0] out_comb
     );


     reg signed [7:0]ff_0;
     reg signed [7:0]ff_1;
     reg signed [7:0]ff_2;
     reg signed [7:0]ff_3;
     reg signed [7:0]ff_4;
     reg signed [7:0]ff_5;
     reg signed [7:0]ff_6;
	 
	 wire signed [7:0]up_out_0;
     wire signed [7:0]up_out_1;
     wire signed [7:0]up_out_2;
     wire signed [7:0]up_out_3;
     wire signed [7:0]up_out_4;
     wire signed [7:0]up_out_5;
     wire signed [7:0]up_out_6; 
     wire signed [7:0]up_out_7;
	 
	 wire signed [16:0]out_E0;
     wire signed [16:0]out_E1;
     wire signed [16:0]out_E2;
     wire signed [16:0]out_E3;
     wire signed [16:0]out_E4;
     wire signed [16:0]out_E5;
     wire signed [16:0]out_E6;
     wire signed [16:0]out_E7;
     
    down_sampler #(8,8) up0 (.clk(clk), .rst_n(rst_n), .din(in_comb), .dout(up_out_0)); 
    down_sampler #(8,8) up1 (.clk(clk), .rst_n(rst_n), .din(ff_0), .dout(up_out_1)); 
    down_sampler #(8,8) up2 (.clk(clk), .rst_n(rst_n), .din(ff_1), .dout(up_out_2));  
	down_sampler #(8,8) up3 (.clk(clk), .rst_n(rst_n), .din(ff_2), .dout(up_out_3));  
	down_sampler #(8,8) up4 (.clk(clk), .rst_n(rst_n), .din(ff_3), .dout(up_out_4));  
	down_sampler #(8,8) up5 (.clk(clk), .rst_n(rst_n), .din(ff_4), .dout(up_out_5)); 
	down_sampler #(8,8) up6 (.clk(clk), .rst_n(rst_n), .din(ff_5), .dout(up_out_6));  
	down_sampler #(8,8) up7 (.clk(clk), .rst_n(rst_n), .din(ff_6), .dout(up_out_7)); 
	
	
	E0_comb_decimation ddu0 (.in_comb(up_out_0), .clk(clk), .rst_n(rst_n), .out_E0(out_E0)) ;
	E1_comb_decimation ddu1 (.in_comb(up_out_1), .clk(clk), .rst_n(rst_n), .out_E1(out_E1)) ;
	E2_comb_decimation ddu2 (.in_comb(up_out_2), .clk(clk), .rst_n(rst_n), .out_E2(out_E2)) ;
	E3_comb_decimation ddu3 (.in_comb(up_out_3), .clk(clk), .rst_n(rst_n), .out_E3(out_E3)) ;
	E4_comb_decimation ddu4 (.in_comb(up_out_4), .clk(clk), .rst_n(rst_n), .out_E4(out_E4)) ;
	E5_comb_decimation ddu5 (.in_comb(up_out_5), .clk(clk), .rst_n(rst_n), .out_E5(out_E5)) ;
	E6_comb_decimation ddu6 (.in_comb(up_out_6), .clk(clk), .rst_n(rst_n), .out_E6(out_E6)) ;
	E7_comb_decimation ddu7 (.in_comb(up_out_7), .clk(clk), .rst_n(rst_n), .out_E7(out_E7)) ;
	
	always @(posedge clk_8 or negedge rst_n )begin
        if (!rst_n)
		begin
		ff_0 <= 0 ;
		ff_1 <= 0 ;
		ff_2 <= 0 ;
		ff_3 <= 0 ;
		ff_4 <= 0 ;
		ff_5 <= 0 ;
		ff_6 <= 0 ;
        end 
         else
		 begin 
         ff_0 <= in_comb ;
         ff_1 <= ff_0 ;
         ff_2 <= ff_1 ;
         ff_3 <= ff_2 ;
		 ff_4 <= ff_3 ;
		 ff_5 <= ff_4 ;
		 ff_6 <= ff_5 ;
        end
    end
	
	
	assign out_comb = out_E0 + out_E1 + out_E2 + out_E3 + out_E4 + out_E5 + out_E6 + out_E7 ;
	
	
	endmodule
	
	
	
	
	
	
	