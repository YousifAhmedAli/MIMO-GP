module clk_div(
     input wire           clk,
	                      rst, 
	 output reg           clk_2,
	                      clk_4,
					      clk_8,
					      clk_16,
					      clk_32
);
     always @(posedge clk,negedge rst) begin
	     if(!rst)
		     clk_2<=0;
		 else 
	     clk_2 <= ~clk_2;
	 end
	 
     always @(posedge clk_2,negedge rst) begin
	     if(!rst)
		     clk_4<=0;
		 else 
	     clk_4 <= ~clk_4;
	 end

     always @(posedge clk_4,negedge rst) begin
	     if(!rst)
		     clk_8<=0;
		 else 
	     clk_8 <= ~clk_8;
	 end

     always @(posedge clk_8,negedge rst) begin
	     if(!rst)
		     clk_16<=0;
		 else 
	     clk_16 <= ~clk_16;
	 end

     always @(posedge clk_16,negedge rst) begin
	     if(!rst)
		     clk_32<=0;
		 else 
	     clk_32 <= ~clk_32;
	 end	 
 
endmodule