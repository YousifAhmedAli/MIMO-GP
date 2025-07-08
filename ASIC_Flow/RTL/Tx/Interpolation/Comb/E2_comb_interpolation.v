

module E2_comb_interpolation #(parameter coff1 = 10 ,coff2 = 246)(

input wire signed [10:0]in_comb,
input clk,rst_n,

output reg signed [19:0]out_E2
);
 
 
 reg signed [13:0]ff1;
 reg signed [18:0]ff2;
 reg signed [19:0]ff3;
 
 always @(posedge clk or negedge rst_n) begin 
	
	if (!rst_n) begin 
		out_E2 <=0;
		ff1 <=0;
		ff2 <=0;
		ff3 <=0;
		end 
	else begin
		ff1 <= in_comb * coff1;
		ff2 <= ff1 + (in_comb * coff2);
		ff3 <= ff2 + (in_comb * coff2);
		
		out_E2 <= ff3 + (coff1 * in_comb); 
		end

end 

endmodule 		