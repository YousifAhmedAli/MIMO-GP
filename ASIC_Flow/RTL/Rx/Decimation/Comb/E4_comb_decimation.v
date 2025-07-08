


module E4_comb_decimation #(parameter coff2 = 161 ,coff3 = 315 ,coff4 = 35)( 

input wire signed [7:0]in_comb,
input wire clk,rst_n,

output reg signed [16:0]out_E4
);

 
 reg signed [7:0]ff1;
 reg signed [14:0]ff2;
 reg signed [16:0]ff3;
 
 always @(posedge clk or negedge rst_n) begin 
	
	if (!rst_n) begin 
		out_E4 <=0;
		ff1 <=0;
		ff2 <=0;
		ff3 <=0;
		end 
	else begin
		ff1 <= in_comb ;
		ff2 <= ff1 + (in_comb * coff2);
		ff3 <= ff2 + (in_comb * coff3);
		
		out_E4 <= ff3 + (coff4 * in_comb); //correct output will appear @fourth clk cycle
		end

end 

endmodule 		