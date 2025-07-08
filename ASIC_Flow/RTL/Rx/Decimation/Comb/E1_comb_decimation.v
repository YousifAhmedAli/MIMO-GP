
module E1_comb_decimation # (parameter coff1 = 20 , coff2 = 284 , coff3 = 204 , coff4 = 4)(

input wire signed [7:0]in_comb,
input wire clk,rst_n,

output reg signed [16:0]out_E1
);

 
 reg signed [11:0]ff1;
 reg signed [15:0]ff2;
 reg signed [16:0]ff3;
 
 always @(posedge clk or negedge rst_n) begin 
	
	if (!rst_n) begin 
		out_E1 <=0;
		ff1 <=0;
		ff2 <=0;
		ff3 <=0;
		end 
	else begin
		ff1 <= in_comb * coff1;
		ff2 <= ff1 + (in_comb * coff2);
		ff3 <= ff2 + (in_comb * coff3);
		
		out_E1 <= ff3 + (coff4*in_comb); 
		end

end 

endmodule 		