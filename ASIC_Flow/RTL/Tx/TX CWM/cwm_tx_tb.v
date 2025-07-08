`timescale 1ns/1ps
module cwm_tx_tb();
/////////////////input&outputs////////////
reg clk,rst;
reg signed [15:0] I_processor,
                  Q_processor;
reg signed [5:0] cos_ph,sin_ph;				  
wire signed [17:0] I_cwm,
                   Q_cwm;
///////////////////////////////////////////
parameter depth=313;
parameter clk_period=1.0;
integer i,q,n,l,h;
////////////////////memories/////////////
reg signed [15:0] mem_I_processor [0:depth-1];
reg signed [15:0] mem_Q_processor [0:depth-1];	
reg signed [17:0] mem_I_out [0:depth-1];	
reg signed [17:0] mem_Q_out [0:depth-1];	
reg signed [17:0] mem_I_gold [0:depth-1];
reg signed [17:0] mem_Q_gold [0:depth-1];
/////////////////////////initial///////////////
initial begin
$dumpvars;
$dumpfile("cwm_tx.VCD");
l=0;
h=0;
clk=0;
rst=0;
cos_ph=6'sb001010;
sin_ph=6'sb001100;
#(32*clk_period) 
rst=1;

$readmemb("C:/Users/DELL/Documents/MATLAB/massive mimo/files_for_RTL_check/processor_IBINARY.txt",mem_I_processor);
$readmemb("C:/Users/DELL/Documents/MATLAB/massive mimo/files_for_RTL_check/processor_QBINARY.txt",mem_Q_processor);
$readmemb("C:/Users/DELL/Documents/MATLAB/massive mimo/files_for_RTL_check/cwm_IBINARY.txt",mem_I_gold);
$readmemb("C:/Users/DELL/Documents/MATLAB/massive mimo/files_for_RTL_check/cwm_QBINARY.txt",mem_Q_gold);

for(i=0;i<depth;i=i+1) begin
@(posedge clk)
I_processor=mem_I_processor[i];
Q_processor=mem_Q_processor[i];
end
#(100*clk_period)
$stop;
end
////////////////////////////load output///////////////////
initial begin
#(32*clk_period) 
for(q=0;q<depth;q=q+1) begin
@(posedge clk)
mem_I_out[q]=I_cwm;
mem_Q_out[q]=Q_cwm;
end
//////////checking////
for(n=2;n<(depth-2);n=n+1) begin
if(mem_Q_out[n+2]!==mem_Q_gold[n])
l=l+1;
if(mem_I_out[n+2]!==mem_I_gold[n])
h=h+1;
end

$display("number of errors in Q = %d",l);
$display("number of errors in I = %d",h);
end
//////////////////////////////////////////////////
cwm_tx DUT(
.clk(clk),
.rst(rst),
.I_processor(I_processor),
.I_cwm(I_cwm),
.Q_cwm(Q_cwm),
.Q_processor(Q_processor),
.sin_ph(sin_ph),
.cos_ph(cos_ph)
);
/////////////////////clk/////////
always #(clk_period*16) clk=~clk; 

endmodule 