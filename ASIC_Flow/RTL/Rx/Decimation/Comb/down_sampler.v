`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2025 05:58:27 PM
// Design Name: 
// Module Name: down_sampler
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module down_sampler #( parameter L = 2 , parameter width = 10)   // down sampling factor
(  
    input clk,                                  // L times slower than input sample rate
    input rst_n,
    input signed [width-1 :0] din,            // Input sample
    output reg signed [width -1 :0] dout     // Upsampled output
);


    always @(posedge clk or negedge rst_n) 
        
		if (!rst_n) 
     		dout <= 0;
        else 
	    	dout <= din;
endmodule
