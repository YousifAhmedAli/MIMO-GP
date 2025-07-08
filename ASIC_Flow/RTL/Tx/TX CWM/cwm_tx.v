module cwm_tx(
input wire clk,rst,
input wire signed [15:0] I_processor,
                         Q_processor,
input wire signed [5:0]  cos_ph,
                         sin_ph,
output reg signed [17:0] I_cwm,
                         Q_cwm						 
);
/////////////////////////////////////////////
reg signed [31:0] temp_icos,temp_qnsin,
                  temp_isin,temp_qcos;

reg signed [15:0] icos,
                  qnsin,
				  isin,
				  qcos;

reg signed [17:0] qnsin_foradd;

reg signed [17:0] temp_I_cwm,
                  temp_Q_cwm;	
///////////////////////////////////////////////
always @(posedge clk,negedge rst) 
     begin
         if(!rst) begin
		     I_cwm<=18'sd0;
			 Q_cwm<=18'sd0;
		 end
         else begin
		     I_cwm<=temp_I_cwm;
			 Q_cwm<=temp_Q_cwm;
		 end
     end
///////////////////////////////////////////////
always @(*) begin 
temp_icos=I_processor*cos_ph;
temp_isin=I_processor*sin_ph;
temp_qcos=Q_processor*cos_ph;
temp_qnsin=Q_processor*(-sin_ph);

icos={temp_icos[31],temp_icos[16:11],temp_icos[10:2]};
isin={temp_isin[31],temp_isin[16:11],temp_isin[10:2]};
qcos={temp_qcos[31],temp_qcos[16:11],temp_qcos[10:2]};
qnsin={temp_qnsin[31],temp_qnsin[18:11],temp_qnsin[10:4]};

qnsin_foradd={qnsin,2'b00};

temp_I_cwm=icos+qnsin_foradd;
temp_Q_cwm=isin+qcos;
end
endmodule