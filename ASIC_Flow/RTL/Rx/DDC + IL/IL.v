module INTER_LEAVER (
                        input wire   CLK_1,CLK_2,RST,
                        input wire   ADC_OUT,
                        output reg   ODD_I,EVEN_Q
                         );
    

                               reg   TEMP_I,TEMP_Q ;


            
            always @(posedge CLK_1 or negedge RST )
              begin
                    
                    if (!RST)
                      begin
                            TEMP_Q <= 1'b0 ;
                      end
                     else
                      begin
                            TEMP_Q <= ADC_OUT ;
                        
                      end
              end


            always @(posedge CLK_2 or negedge RST )
              begin
                    
                    if (!RST)
                      begin
                            TEMP_I <= 1'b0 ;
                            ODD_I  <= 1'b0 ;
                            EVEN_Q <= 1'b0 ;
                      end
                     else
                      begin
                            TEMP_I <= ADC_OUT ;
                            ODD_I  <= TEMP_I ;
                            EVEN_Q <= TEMP_Q ;
                        
                      end
              end
    
endmodule
