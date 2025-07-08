module CLK_DIV (
                 
   input  wire        RST_EN,I_REF_CLK,CLK_EN,
   input  wire  [7:0] DIV_RATIO,
   output wire        O_DIV_CLK 
    
                );
    
    wire          odd;
    wire [7:0]    toggle;
    wire          div_en;
    reg  [7:0]    counter;
    reg           flag;
    reg           out_clk;

assign   odd = DIV_RATIO[0];
assign   div_en = ((CLK_EN)&&(DIV_RATIO != 0)&&(DIV_RATIO != 1)); 
assign   toggle =  DIV_RATIO >> 1;   
 

  always @(posedge I_REF_CLK or negedge RST_EN)               // counter reset condition 
 begin : counter_proc
  if(!RST_EN)
   begin
    counter <= 0 ;
	  out_clk <= 1 ;	/////////////////////////////////////////////// because the IL desiged using this approch
    flag <= 1 ;
   end
    else if(div_en) 
     begin
      if (DIV_RATIO == 2)
      begin
            out_clk <= ~out_clk ;    
      end
      else if(!odd && (counter == toggle))              // even edge flip condition 
       begin
        counter <= 0 ;                                        // reset counter
        out_clk <= ~out_clk ;                               // clock inversion		
       end
      else if((odd && (counter == toggle) && flag ) || (odd && (counter == toggle + 1) && !flag ))  // odd edge flip condition
       begin  
        counter <= 0 ;                                          // reset counter
        out_clk <= ~out_clk ;                        // clock inversion
         flag <= !flag;                   
       end
    else
       counter <= counter + 1;  
   end
 end
 /*
 always @(posedge I_REF_CLK or negedge RST_EN)               // counter reset condition 
 begin 
  if(!RST_EN)
   begin
      counter <= 0 ;
	  out_clk <= 1 ;	
      
   end
   else
   begin
         if(counter == 0)
         begin
         out_clk <= ~out_clk;
         counter <= 0;
         end
         else
         begin
         counter <= counter + 1;
         end
   end
 end
 */
assign  O_DIV_CLK  = div_en ? out_clk : I_REF_CLK ;  



endmodule
    



