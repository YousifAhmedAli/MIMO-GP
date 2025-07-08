

module E6_comb_interpolation #(parameter coff1 = 84, coff2 = 344 )(

input wire signed [10:0]in_comb,
input wire clk,rst_n,

output reg signed [19:0]out_E6
);
 
 
 reg signed [16:0]ff1;
 reg signed [19:0]ff2;

 
 always @(posedge clk or negedge rst_n) begin 
	
	if (!rst_n) begin 
		out_E6 <=0;
		ff1 <=0;
		ff2 <=0;
		
		end 
	else begin
		ff1 <= in_comb * coff1;
		ff2 <= ff1 + (in_comb * coff2);
		
		
		out_E6 <= ff2 + (coff1 * in_comb); //correct output will appear @fourth clk cycle
		end

end 

endmodule 		