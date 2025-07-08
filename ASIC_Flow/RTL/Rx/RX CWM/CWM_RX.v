module CWM_RX (
                input wire               CLK_2,RST,
                input wire               I_DDC,Q_DDC,
                input wire signed [5:0]  SIN_C,COS_C,
                output reg signed [5:0]  I_CWM,Q_CWM
                );
                       reg signed [5:0]  I_TEMP_SIN,I_TEMP_COS,Q_TEMP_SIN,Q_TEMP_COS;
                       reg signed [5:0]  I_COMB,Q_COMB;


             
              

              always @(posedge CLK_2 or negedge RST)
                   begin
                          if (!RST)
                            begin
                                
                                     I_CWM <= 1'bx;
                                     Q_CWM <= 1'bx;
                            end
                         else 
                            begin
                                     I_CWM <= I_COMB;
                                     Q_CWM <= Q_COMB;           ///////// NEED TO BE CHECKED AGAIN
                            end
                   end


              always @(*)
                  begin
                           
                           case (I_DDC)

                                    1'b0: begin
                                                    I_TEMP_SIN = (~SIN_C) + 1 ; /// 2'S COMLEMENT OF SIN (-SIN)
                                                    I_TEMP_COS = (~COS_C) + 1 ;
                                        end
                                    1'b1: begin
                                                    I_TEMP_SIN = SIN_C ; 
                                                    I_TEMP_COS = COS_C ;
                                        end
                           endcase
                          
                          case (Q_DDC)

                                    1'b0: begin
                                                    Q_TEMP_SIN =  -SIN_C;                         ///    (~SIN_C) + 1 ; /// 2'S COMLEMENT OF SIN (-SIN)
                                                    Q_TEMP_COS =  -COS_C;                        ///     (~COS_C) + 1 ;
                                        end
                                    1'b1: begin
                                                    Q_TEMP_SIN = SIN_C ; 
                                                    Q_TEMP_COS = COS_C ;
                                        end
                           endcase
  
                             
                                                   I_COMB = I_TEMP_COS + Q_TEMP_SIN;
                                                   Q_COMB = Q_TEMP_COS - I_TEMP_SIN;



                  end









endmodule
