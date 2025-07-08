
module E0_comb_interpolation #(parameter coff1 = 35 , coff2 = 315 , coff3 = 161 )(

input wire signed[10:0]in_comb,
input wire clk,rst_n,

output reg signed [19:0]out_E0
);

 
 reg signed [15:0] ff1;
 reg signed [19:0] ff2;
 reg signed [19:0] ff3;
 
 always @(posedge clk or negedge rst_n) 
 begin 
	if (!rst_n)
	begin 
		out_E0 <=0;
		ff1 <=0;
		ff2 <=0;
		ff3 <=0;
	end 
	else 
	begin
		ff1 <= in_comb * coff1;
		ff2 <= ff1 + (in_comb * coff2);
		ff3 <= ff2 + (in_comb * coff3);
		
		out_E0 <= ff3 + in_comb; //correct output will appear @fourth clk cycle
	end

end 

endmodule 		