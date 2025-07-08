

module comb_interpolation (
     input signed [10:0]in_comb, 
     input clk, clk_8, rst_n,               // clk_8 is 8 times faster than clk
     output signed [19:0]out_comb
     );
    
     reg signed [19:0]E0_ff;
     reg signed [19:0]E1_ff;
     reg signed [19:0]E2_ff;
     reg signed [19:0]E3_ff;
     reg signed [19:0]E4_ff;
     reg signed [19:0]E5_ff;
     reg signed [19:0]E6_ff;
     
     wire signed [19:0]up_out_0;
     wire signed [19:0]up_out_1;
     wire signed [19:0]up_out_2;
     wire signed [19:0]up_out_3;
     wire signed [19:0]up_out_4;
     wire signed [19:0]up_out_5;
     wire signed [19:0]up_out_6; 
     wire signed [19:0]up_out_7;
      
     wire signed [19:0]out_E0;
     wire signed [19:0]out_E1;
     wire signed [19:0]out_E2;
     wire signed [19:0]out_E3;
     wire signed [19:0]out_E4;
     wire signed [19:0]out_E5;
     wire signed [19:0]out_E6;
     wire signed [19:0]out_E7;
     
    
   
    up_sampler #(8,20) up0 (.clk(clk_8), .rst_n(rst_n), .din(out_E0), .dout(up_out_0)); 
    up_sampler #(8,20) up1 (.clk(clk_8), .rst_n(rst_n), .din(out_E1), .dout(up_out_1)); 
    up_sampler #(8,20) up2 (.clk(clk_8), .rst_n(rst_n), .din(out_E2), .dout(up_out_2));  
	up_sampler #(8,20) up3 (.clk(clk_8), .rst_n(rst_n), .din(out_E3), .dout(up_out_3));  
	up_sampler #(8,20) up4 (.clk(clk_8), .rst_n(rst_n), .din(out_E4), .dout(up_out_4));  
	up_sampler #(8,20) up5 (.clk(clk_8), .rst_n(rst_n), .din(out_E5), .dout(up_out_5)); 
	up_sampler #(8,20) up6 (.clk(clk_8), .rst_n(rst_n), .din(out_E6), .dout(up_out_6));  
	up_sampler #(8,20) up7 (.clk(clk_8), .rst_n(rst_n), .din(out_E7), .dout(up_out_7)); 
    
    
     E0_comb_interpolation ddu0(.in_comb(in_comb), .clk(clk), .rst_n(rst_n), .out_E0(out_E0));
     E1_comb_interpolation ddu1(.in_comb(in_comb), .clk(clk), .rst_n(rst_n), .out_E1(out_E1));
     E2_comb_interpolation ddu2(.in_comb(in_comb), .clk(clk), .rst_n(rst_n), .out_E2(out_E2));
     E3_comb_interpolation ddu3(.in_comb(in_comb), .clk(clk), .rst_n(rst_n), .out_E3(out_E3)); 
     E4_comb_interpolation ddu4(.in_comb(in_comb), .clk(clk), .rst_n(rst_n), .out_E4(out_E4));
     E5_comb_interpolation ddu5(.in_comb(in_comb), .clk(clk), .rst_n(rst_n), .out_E5(out_E5)); 
	 E6_comb_interpolation ddu6(.in_comb(in_comb), .clk(clk), .rst_n(rst_n), .out_E6(out_E6));
     E7_comb_interpolation ddu7(.in_comb(in_comb), .clk(clk), .rst_n(rst_n), .out_E7(out_E7));
     
     
     always @(posedge clk_8 or negedge rst_n )begin
        if (!rst_n) begin
            E6_ff <=0;
            E5_ff <=0;
            E4_ff <=0;
            E3_ff <=0;
            E2_ff <=0;
            E1_ff <=0;
            E0_ff <=0;
            
            end 
         else begin 
            E6_ff <= up_out_7 ;
            E5_ff <= E6_ff + up_out_6 ;
            E4_ff <= E5_ff + up_out_5 ;
            E3_ff <= E4_ff + up_out_4 ;
            E2_ff <= E3_ff + up_out_3 ;
            E1_ff <= E2_ff + up_out_2 ;
            E0_ff <= E1_ff + up_out_1 ;
            
        end
    end
    
    assign out_comb = E0_ff + up_out_0;
  
endmodule