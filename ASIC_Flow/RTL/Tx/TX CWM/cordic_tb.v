`timescale 1ns/1ps
module cordic_tb;
    reg clk, rst;
    reg signed [15:0] theta;
    wire signed [15:0] cos_theta, sin_theta;

	parameter clk_period=1.0;
    // Instantiate CORDIC
    cordic uut (
        .clk(clk),
        .rst(rst),
        .theta(theta),
        .cos_theta(cos_theta),
        .sin_theta(sin_theta)
    );
	
	always #(clk_period/2) clk=~clk;
	
	
	initial begin
	    clk=0;
        rst = 0;
  
        #(clk_period)
        rst = 1;

        // thet Q2.13
        theta = 16'h1922;
        #(clk_period)
        $display("theta=pi/4, cos=%h (%f), sin=%h (%f)", 
                 cos_theta, $itor(cos_theta)/2.0**14, 
                 sin_theta, $itor(sin_theta)/2.0**14);
		
		theta=16'h10C1;
		#(clk_period)
        $display("theta=pi/6, cos=%h (%f), sin=%h (%f)", 
                 cos_theta, $itor(cos_theta)/2.0**14, 
                 sin_theta, $itor(sin_theta)/2.0**14);
		
        theta=16'h1A04;		
		#(clk_period)
        $display("theta2, cos=%h (%f), sin=%h (%f)", 
                 cos_theta, $itor(cos_theta)/2.0**14, 
                 sin_theta, $itor(sin_theta)/2.0**14);	
				 
         theta=16'h3409;		
		#(clk_period)
        $display("theta3, cos=%h (%f), sin=%h (%f)", 
                 cos_theta, $itor(cos_theta)/2.0**14, 
                 sin_theta, $itor(sin_theta)/2.0**14);	
				 
         theta=16'h4E0E;		
		#(clk_period)
        $display("theta4, cos=%h (%f), sin=%h (%f)", 
                 cos_theta, $itor(cos_theta)/2.0**14, 
                 sin_theta, $itor(sin_theta)/2.0**14);				 

         theta=-16'sh10C1;		
		#(clk_period)
        $display("-pi/6, cos=%h (%f), sin=%h (%f)", 
                 cos_theta, $itor(cos_theta)/2.0**14, 
                 sin_theta, $itor(sin_theta)/2.0**14);	
        theta=16'h6FB3;		
		#(clk_period)
        $display("200, cos=%h (%f), sin=%h (%f)", 
                 cos_theta, $itor(cos_theta)/2.0**14, 
                 sin_theta, $itor(sin_theta)/2.0**14);					 
	
        $stop;
    end
endmodule	