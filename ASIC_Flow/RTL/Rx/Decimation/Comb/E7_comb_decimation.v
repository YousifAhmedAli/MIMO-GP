


module E7_comb_decimation #(parameter coff1 = 56 , coff2 = 336 , coff3 = 120)(

input wire signed [7:0]in_comb,
input wire clk,rst_n,

output reg signed [16:0]out_E7
);

 
 reg signed [13:0]ff1;
 reg signed [16:0]ff2;
 
 
 always @(posedge clk or negedge rst_n) begin 
	
	if (!rst_n) begin 
		out_E7 <=0;
		ff1 <=0;
		ff2 <=0;
		
		end 
	else begin
		ff1 <= in_comb * coff1;
		ff2 <= ff1 + (in_comb * coff2);

		
		out_E7 <= ff2 + (coff3 * in_comb); //correct output will appear @fourth clk cycle
		end

end 

endmodule 		