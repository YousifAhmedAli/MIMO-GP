module E1_HB #(parameter  coff0=1,coff1=-4 ,coff2=13,coff3=-40,coff4=158)(

input      signed  [14:0]in_E1,
input                clk,rst_n,
output reg signed  [22:0]out_E1
);

reg signed [14:0]ff_0; 
reg signed [16:0]ff_1; 
reg signed [18:0]ff_2; 
reg signed [19:0]ff_3; 
reg signed [21:0]ff_4; 
reg signed [22:0]ff_5; 
reg signed [22:0]ff_6; 
reg signed [22:0]ff_7; 
reg signed [22:0]ff_8; 

always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out_E1 <= 0;
            ff_0   <=0;
            ff_1   <=0;
            ff_2   <=0;
            ff_3   <=0;
            ff_4   <=0;
            ff_5   <=0;
            ff_6   <=0;
            ff_7   <=0;
            ff_8   <=0;
			
        end else begin
        	// upper chain
         	ff_0 <= coff0* in_E1;
         	ff_1 <= ff_0 + (coff1* in_E1);
         	ff_2 <= ff_1 + (coff2* in_E1);
         	ff_3 <= ff_2 + (coff3* in_E1);
         	ff_4 <= ff_3 + (coff4* in_E1);
         	// lower chain
         	ff_5 <= ff_4 + (coff4* in_E1);
         	ff_6 <= ff_5 + (coff3* in_E1);
         	ff_7 <= ff_6 + (coff2* in_E1);
         	ff_8 <= ff_7 + (coff1* in_E1);
         	out_E1 <= ff_8 + (coff0* in_E1);
			
        end
    end

endmodule



