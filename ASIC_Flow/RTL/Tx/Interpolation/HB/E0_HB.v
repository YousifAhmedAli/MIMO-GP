
module E0_HB #(parameter coff = 256)(

input  signed  [14:0]in_E0,
input    clk,rst_n,
output reg signed  [22:0]out_E0
);

reg  signed [22:0]delay_line [0:4]; 
wire signed [22:0]gain_out;
integer i; 
assign gain_out = in_E0 * coff; 


always @(posedge clk or negedge rst_n) begin 

        if (!rst_n)begin
			out_E0 <=0;
			
            for (i = 0; i < 5; i = i + 1) begin
                delay_line[i] <= 0;
            end
			
        end else begin
            delay_line[0] <= gain_out;
            for (i = 1; i < 5 ; i = i + 1) begin
                delay_line[i] <= delay_line[i - 1];
            end
			
		out_E0 <= delay_line[4];
        end
end 
endmodule 


