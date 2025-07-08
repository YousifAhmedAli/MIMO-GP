module duc(
input wire clk,rst,         //fastest clk
input wire signed [5:0] I_DUC,Q_DUC,
output reg signed [6:0] OUT_DUC
);

//////////////////////internal signal///////////////////
reg signed [5:0] TEMP_I,TEMP_Q;
reg signed [1:0] NCOS,NSIN;  //update here 
integer i;

//////////////////////registered output////////////////
always @(posedge clk,negedge rst) 
     begin
         if(!rst)
         OUT_DUC <=7'sd0;
     else
         OUT_DUC <= TEMP_I+TEMP_Q;
     end

/////////////////////counter for make cos and sin////////	 
always @(posedge clk,negedge rst) begin
if(!rst)
i<=0;
else begin
     if(i==3)
         i<=0;
     else
         i<=i+1;
end
end	 

///////////////////////////////////////// 
always @(*) begin
     if(i==0) begin
         NSIN=2'sd1;
         NCOS=2'sd0;
	 end
	 else if(i==1) begin
	     NSIN=2'sd0;
         NCOS=-2'sd1;
	 end
	 else if(i==2) begin
	     NSIN=-2'sd1;
         NCOS=2'sd0;
	 end	 
	 else if(i==3) begin
	     NSIN=2'sd0;
         NCOS=2'sd1;
	 end
     else begin
	     NSIN=2'bxx;
         NCOS=2'bxx;         
     end	 
end

//////////////////////////////////////
always @(*)
     begin
         case(NCOS)
		 2'sb00:TEMP_I=0;
		 2'sb01:TEMP_I=I_DUC;
		 2'sb11:TEMP_I= -I_DUC;
		 2'sb10:TEMP_I=5'sbx;
		 endcase

         case(NSIN)
		 2'sb00:TEMP_Q=0;
		 2'sb01:TEMP_Q=Q_DUC;
		 2'sb11:TEMP_Q= -Q_DUC;
		 2'sb10:TEMP_Q=5'sbx;
		 endcase		 
     end	 
endmodule 

