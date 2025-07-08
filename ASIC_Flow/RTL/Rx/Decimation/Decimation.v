
module Decimation (
input wire signed [7:0] in_comb ,
input wire clk , clk_8 , clk_2 ,rst_n ,
output wire signed [18:0] out_HB 
);
// clk_8 is the fastest then clk_2 then clk
reg  signed [7:0] I_TOTAL_1,I_TOTAL_2;
wire signed [16:0] out_comb ;
reg signed [9:0] in_HB ;
reg        [4:0]      counter;


always@(posedge clk_8 or negedge rst_n )
begin
if(!rst_n)
begin
I_TOTAL_1 <= 0 ;
I_TOTAL_2 <= 0 ;
counter   <= 0 ;
end
else if (counter == 13)
begin
    
I_TOTAL_1 <= in_comb;
I_TOTAL_2 <= I_TOTAL_1;
counter <= 13;
        
    end
    else
        begin
    counter  <= counter + 1;
   I_TOTAL_1 <= 0;
   I_TOTAL_2 <= 0;
        
    end

end



always@(posedge clk_2 or negedge rst_n )
begin
if(!rst_n)
in_HB <= 0 ;
else
in_HB = out_comb >>> 7 ;
end


comb_decimation dut_comb (
.in_comb(I_TOTAL_2),
.clk_8(clk_8),
.clk(clk_2),
.rst_n(rst_n),
.out_comb(out_comb)
);

HB_decimation dut_HB (
.in_HB(in_HB),
.clk_2(clk_2),
.clk(clk),
.rst_n(rst_n),
.out_HB(out_HB)
);


endmodule