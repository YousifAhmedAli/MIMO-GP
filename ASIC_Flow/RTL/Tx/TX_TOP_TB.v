`timescale 1ns/1ps
module TX_TOP_TB ();

parameter IN_WIDTH = 13;
parameter clk_period=1.0;
parameter IN_WIDTH_CWM = 16;
parameter phi_0 = 0;
parameter phi_1 = 0.8131;

reg clk=0 ,rst = 1;
reg [IN_WIDTH_CWM-1:0] in_data_1,in_data_2;
wire signed [6:0] OUT_DUC;

wire clk_2;
wire signed [15:0] phi_1_b = 16'h1A04;
integer i,h,m,q,r,v,g,w, r_1, r_2, CWM_1, CWM_2;
///////////////////memories//////////
parameter depth_in_CWM =313;
parameter depth_out_CWM = 313;
parameter depth_out_duc =10001;
parameter depth_interp = 5001;

reg [IN_WIDTH_CWM-1:0] mem_in1 [0:depth_in_CWM-1] ;
reg [IN_WIDTH_CWM-1:0] mem_in2 [0:depth_in_CWM-1] ;


reg [6:0] mem_out_gold_DUC [0:depth_out_duc-1];
reg [6:0] mem_out_design_DUC [0:depth_out_duc-1];


reg [19:0] mem_out_gold_1 [0:depth_interp-1];
reg [19:0] mem_out_gold_2 [0:depth_interp-1];
reg [17:0] mem_out_gold_CWM_1 [0:depth_in_CWM-1];
reg [17:0] mem_out_gold_CWM_2 [0:depth_in_CWM-1];

reg [19:0] mem_out_design_1 [0:depth_interp-1];
reg [19:0] mem_out_design_2 [0:depth_interp-1];
reg [17:0] mem_out_design_CWM_1 [0:depth_in_CWM-1];
reg [17:0] mem_out_design_CWM_2 [0:depth_in_CWM-1];

//////////////////////////////////
TX_TOP  #(
.IN_WIDTH(IN_WIDTH),
.fractional_bits(9),
.IN_WIDTH_CWM(IN_WIDTH_CWM),
.fractional_bits_CWM(7)
)DUT
(
.clk(clk),
.rst(rst),
.in_data_1(in_data_1),
.in_data_2(in_data_2),
.phi(phi_1_b),
.OUT_DUC(OUT_DUC)
);

///////////////////////////////
always #(clk_period/2) clk=~clk;
assign clk_32 = DUT.clk_dut.clk_32;
assign clk_2 = DUT.clk_dut.clk_2;
///////////////////////////////
initial begin
$dumpvars;
$dumpfile("DUC.VCD");
r = 0;
r_1 = 0;
r_2 = 0;
CWM_1=0;
CWM_2=0;
rst=0;
in_data_1=0;
in_data_2=0;
#(32*clk_period)
rst = 1;
#(32*clk_period)


$readmemb("C:/Users/yousi/OneDrive/Desktop/Mer/IN_I.txt",mem_in1);
$readmemb("C:/Users/yousi/OneDrive/Desktop/Mer/IN_Q.txt",mem_in2);
$readmemb("C:/Users/yousi/OneDrive/Desktop/Mer/INTER_O1.txt",mem_out_gold_1);
$readmemb("C:/Users/yousi/OneDrive/Desktop/Mer/INTER_O2.txt",mem_out_gold_2);
$readmemb("C:/Users/yousi/OneDrive/Desktop/Mer/I.txt",mem_out_gold_CWM_1);
$readmemb("C:/Users/yousi/OneDrive/Desktop/Mer/Q.txt",mem_out_gold_CWM_2);
$readmemb("C:/Users/yousi/OneDrive/Desktop/Mer/OUT_DUC.txt",mem_out_gold_DUC);


for(i=0;i<depth_in_CWM;i=i+1) begin
@(posedge clk_32)
in_data_1=mem_in1[i];
in_data_2=mem_in2[i];
end

end

initial begin
#(64*clk_period)
for(q=0;q<depth_in_CWM;q=q+1) begin
@(posedge clk_32)
mem_out_design_CWM_1[q]= DUT.CWM_out_1;
mem_out_design_CWM_2[q]= DUT.CWM_out_2;
end

for (v=0;v<depth_in_CWM;v=v+1) begin
    if (mem_out_design_CWM_1[v+2] != mem_out_gold_CWM_1[v])
        CWM_1=CWM_1+1;
    if (mem_out_design_CWM_2[v+2] != mem_out_gold_CWM_2[v])
        CWM_2=CWM_2+1;
end
$display("Total number of errors in CWM_1 = %d",CWM_1);
$display("Total number of errors in CWM_2 = %d",CWM_2);
end

initial begin
for(g=0;g<depth_out_duc;g=g+1) begin
@(posedge clk)
mem_out_design_DUC[g]= OUT_DUC;
end

for(w=0;w<depth_out_duc;w=w+1) begin
if(mem_out_design_DUC[w+194] != mem_out_gold_DUC[w])
r=r+1;
end
$display("Total number of DUC errors = %d",r);
end



initial begin
#(64*clk_period)

for(h=0;h<depth_interp;h=h+1) begin
@(posedge clk_2)
mem_out_design_1[h]= DUT.out_interpolation_1;
mem_out_design_2[h]= DUT.out_interpolation_2;
end

for(m=0;m<depth_interp;m=m+1) begin
    if (mem_out_design_1[m+65] != mem_out_gold_1[m])
        r_1=r_1+1;
    if (mem_out_design_2[m+65] != mem_out_gold_2[m])
        r_2=r_2+1;
end
$display("Total number of errors in 1 = %d",r_1);
$display("Total number of errors in 2 = %d",r_2);




#(100*clk_period)


$stop;
end
endmodule
