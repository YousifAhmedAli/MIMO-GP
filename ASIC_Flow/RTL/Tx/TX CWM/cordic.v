//----------------------------------------------------------------------//
//                              CORDIC                                  //
//----------------------------------------------------------------------//

//---------------------------------------------------------------------//
//X and Y is the cos and sin it will be  (1 sign, 1 integer, 14 fraction)

//K as X,Y because X start as K          (1 sign, 1 integer, 14 fraction)

//Theta and ARC_TAN it will be           (1 sign, 2 integer, 13 fraction)
//---------------------------------------------------------------------//

module cordic (
    input wire clk, rst,                     
    input wire signed [15:0] theta,         // Q2.13: 1 sign, 2 integer, 13 fraction
    output reg signed [15:0] cos_theta,     // Q1.14: 1 sign, 1 integer, 14 fraction   
    output reg signed [15:0] sin_theta      
);

    parameter iteration = 16;
    parameter signed [15:0] K = 16'h26DD; // 1/K ˜ 0.607252935 in Q1.14
	
    reg signed [15:0] x, y, z;
    reg signed [15:0] x_next, y_next, z_next,
	                  decision;  
					  
	reg signed [15:0] theta_reduced;     //for making quarter 2,3 
    reg cos_sign,sin_sign;               // 1 negtive ,0 positive
	
	integer h;
	
    ////////////////////////////table of values////////////////////////////////
    wire [15:0] atan_table [0:15];    // Arctangent table in Q2.13
	
    assign atan_table[0]  = 16'h1922; // atan(2^0)  ˜ 0.785400 rad (45.0°)
    assign atan_table[1]  = 16'h0ED7; // atan(2^-1) ˜ 0.463623 rad (26.565°)
    assign atan_table[2]  = 16'h07D7; // atan(2^-2) ˜ 0.244995 rad (14.036°)
    assign atan_table[3]  = 16'h03FB; // atan(2^-3) ˜ 0.124390 rad (7.125°)
    assign atan_table[4]  = 16'h01FF; // atan(2^-4) ˜ 0.062378 rad (3.576°)
    assign atan_table[5]  = 16'h0100; // atan(2^-5) ˜ 0.031250 rad (1.790°)
    assign atan_table[6]  = 16'h0080; // atan(2^-6) ˜ 0.015625 rad (0.895°)
    assign atan_table[7]  = 16'h0040; // atan(2^-7) ˜ 0.007812 rad (0.448°)
    assign atan_table[8]  = 16'h0020; // atan(2^-8) ˜ 0.003906 rad (0.224°)
    assign atan_table[9]  = 16'h0010; // atan(2^-9) ˜ 0.001953 rad (0.112°)
    assign atan_table[10] = 16'h0008; // atan(2^-10) ˜ 0.000977 rad (0.056°)
    assign atan_table[11] = 16'h0004; // atan(2^-11) ˜ 0.000488 rad (0.028°)
    assign atan_table[12] = 16'h0002; // atan(2^-12) ˜ 0.000244 rad (0.014°)
    assign atan_table[13] = 16'h0001; // atan(2^-13) ˜ 0.000122 rad (0.007°)
    assign atan_table[14] = 16'h0001; // atan(2^-14) ˜ 0.000122 rad (0.0035°)
    assign atan_table[15] = 16'h0001; // atan(2^-15) ˜ 0.000122 rad

    ////////////////////////////////////////////////////////////////////////////
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            cos_theta <= 16'h0000;
            sin_theta <= 16'h0000;
        end 
		else begin
		     if(cos_sign && !sin_sign) begin
			     cos_theta <= -x;
                 sin_theta <= y;
			 end
			 else if(cos_sign && sin_sign) begin
			     cos_theta <= -x;
                 sin_theta <= -y;
			 end
			 else begin
			     cos_theta <= x;
                 sin_theta <= y;
			 end

        end
    end

	always @(*) begin
	     if(theta>16'h3243 && theta<16'h6487) begin  // more than pi/2 and less than pi
		     theta_reduced = 16'h6487 - theta;
			 cos_sign=1;
			 sin_sign=0;
		 end 
		 else if(theta>16'h6487 && theta<16'h96CB) begin		 //more than pi and less than 3pi/2
			 theta_reduced = theta - 16'h6487;
			 cos_sign=1;
			 sin_sign=1;
		 end 
		 else begin
		     theta_reduced=theta;
			 cos_sign=0;
			 sin_sign=0;
		 end	
	end
	
    always @(*) begin
        x = K;      
        y = 16'h0000;  
        z = 16'd0;      

        for (h = 0; h < iteration; h = h + 1) begin
		    decision=theta_reduced-z;
            if (decision>0) begin 
                x_next = x - (y >>> h);
                y_next = y + (x >>> h);
                z_next = z + atan_table[h]; 
            end else begin 
                x_next = x + (y >>> h);
                y_next = y - (x >>> h);
                z_next = z - atan_table[h]; 
            end
            x = x_next;
            y = y_next;
            z = z_next;
        end
    end

endmodule
/*
always @(posedge clk or posedge reset) begin
    if (reset) begin
        h <= 0;
        x <= K;
        y <= 16'h0000;
        z <= 16'd0;
    end else if (h < iteration) begin
        decision = theta - z;
        if (decision > 0) begin
            x <= x - (y >>> h);
            y <= y + (x >>> h);
            z <= z + atan_table[h];
        end else begin
            x <= x + (y >>> h);
            y <= y - (x >>> h);
            z <= z - atan_table[h];
        end
        h <= h + 1;
    end
end
*/