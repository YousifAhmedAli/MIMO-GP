

module E5_comb_interpolation #(parameter coff1 = 120 , coff2 = 336 , coff3 = 56)(

input wire signed [10:0]in_comb,
input wire clk,rst_n,

output reg signed [19:0]out_E5
);

 
 reg signed [17:0]ff1;
 reg signed [19:0]ff2;
 
 
 always @(posedge clk or negedge rst_n) begin 
	
	if (!rst_n) begin 
		out_E5 <=0;
		ff1 <=0;
		ff2 <=0;
	
		end 
	else begin
		ff1 <= in_comb * coff1;
		ff2 <= ff1 + (in_comb * coff2);
		
		
		out_E5 <= ff2 + (coff3 * in_comb); //correct output will appear @third clk cycle
		end

end 

endmodule 		