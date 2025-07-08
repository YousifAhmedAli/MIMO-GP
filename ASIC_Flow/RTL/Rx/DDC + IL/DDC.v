module DDC (
              input wire CLK_2,RST,
              input wire ODD_I,EVEN_Q,
              output reg I_DDC,Q_DDC
            );
                     reg Local_Oscillator,I_TEMP,Q_TEMP;
                
                always @(posedge CLK_2 or negedge RST)
                   begin
                          if (!RST)
                            begin
                                     Local_Oscillator <= 1'b1;          ////////// incase of CLOCK GENERATOR AS THE FIRIST INPUT ARRIVES WITH EDGE SO LO SHOULD BE 1
                               //      Local_Oscillator <= 1'b0;          ////////// incase of TB AS THE FIRIST INPUT ARRIVES AFTER 1 EDGE SO LO SHOULD BE 0 initialy to avoid the firist sample 
                 
                                     I_DDC <= 1'bx;
                                     Q_DDC <= 1'bx;
                            end
                         else 
                            begin
                                     Local_Oscillator <= ~Local_Oscillator;   /// Generating LO
                                     I_DDC <= I_TEMP;
                                     Q_DDC <= Q_TEMP;
                            end
                   end
                
                
                always @(*)
                  begin
                           I_TEMP = (ODD_I) ~^ (Local_Oscillator) ;
                           Q_TEMP = EVEN_Q ~^ (Local_Oscillator) ;
                  end



endmodule
