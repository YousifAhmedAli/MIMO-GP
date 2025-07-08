module E1_HB #(parameter  coeff0=1,coeff1=-4 ,coeff2=13,coeff3=-40,coeff4=158)(

input      signed  [9:0]in_E1,
input                clk,rst_n,
output reg signed  [17:0]out_E1
);

reg signed [9:0]ff_0; 
reg signed [11:0]ff_1; 
reg signed [13:0]ff_2; 
reg signed [14:0]ff_3; 
reg signed [17:0]ff_4; 
reg signed [17:0]ff_5; 
reg signed [17:0]ff_6; 
reg signed [17:0]ff_7; 
reg signed [17:0]ff_8; 

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
         	ff_0 <= coeff0* in_E1;
         	ff_1 <= ff_0 + (coeff1* in_E1);
         	ff_2 <= ff_1 + (coeff2* in_E1);
         	ff_3 <= ff_2 + (coeff3* in_E1);
         	ff_4 <= ff_3 + (coeff4* in_E1);
         	// lower chain
         	ff_5 <= ff_4 + (coeff4* in_E1);
         	ff_6 <= ff_5 + (coeff3* in_E1);
         	ff_7 <= ff_6 + (coeff2* in_E1);
         	ff_8 <= ff_7 + (coeff1* in_E1);
         	out_E1 <= ff_8 + (coeff0* in_E1);
			
        end
    end

endmodule



