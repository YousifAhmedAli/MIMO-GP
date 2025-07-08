module MIMO_RX  //#( parameter N = 4)   /// NO OF CHAINS 
                                    (
                                        input wire                    CLK_1,CLK_2,RST,
                                        input wire                    ADC_OUT,ADC_OUT_2,ADC_OUT_3,ADC_OUT_4,
                                        input wire  signed  [5:0]     SIN_C,COS_C,SIN_C_2,COS_C_2,SIN_C_3,COS_C_3,SIN_C_4,COS_C_4,
                                        output reg  signed  [7:0]     I_TOTAL,Q_TOTAL
                                    );

                            wire signed   [5:0]     I_CWM,Q_CWM,I_CWM_2,Q_CWM_2,I_CWM_3,Q_CWM_3,I_CWM_4,Q_CWM_4;
                            reg  signed   [7:0]     I_COMB,Q_COMB;


                  /// Instanstion FOR  CHAIN_1

                   RX_CHAIN          CHAIN_1                (

                                                            .CLK_1(CLK_1),
                                                            .CLK_2(CLK_2),
                                                            .RST(RST),
                                                            .ADC_OUT(ADC_OUT),
                                                            .SIN_C(SIN_C),
                                                            .COS_C(COS_C),
                                                            .I_CWM(I_CWM),
                                                            .Q_CWM(Q_CWM)

                                                            );

                  /// Instanstion FOR  CHAIN_2

                   RX_CHAIN          CHAIN_2                (

                                                            .CLK_1(CLK_1),
                                                            .CLK_2(CLK_2),
                                                            .RST(RST),
                                                            .ADC_OUT(ADC_OUT_2),
                                                            .SIN_C(SIN_C_2),
                                                            .COS_C(COS_C_2),
                                                            .I_CWM(I_CWM_2),
                                                            .Q_CWM(Q_CWM_2)

                                                            );

                   /// Instanstion FOR  CHAIN_3

                   RX_CHAIN          CHAIN_3                (

                                                            .CLK_1(CLK_1),
                                                            .CLK_2(CLK_2),
                                                            .RST(RST),
                                                            .ADC_OUT(ADC_OUT_3),
                                                            .SIN_C(SIN_C_3),
                                                            .COS_C(COS_C_3),
                                                            .I_CWM(I_CWM_3),
                                                            .Q_CWM(Q_CWM_3)

                                                            );

                /// Instanstion FOR  CHAIN_4

                   RX_CHAIN          CHAIN_4                (

                                                            .CLK_1(CLK_1),
                                                            .CLK_2(CLK_2),
                                                            .RST(RST),
                                                            .ADC_OUT(ADC_OUT_4),
                                                            .SIN_C(SIN_C_4),
                                                            .COS_C(COS_C_4),
                                                            .I_CWM(I_CWM_4),
                                                            .Q_CWM(Q_CWM_4)

                                                            );


                 always @(posedge CLK_2 or negedge RST )
                   begin
                        if (!RST)
                          begin
                                     I_TOTAL <= 8'bx;
                                     Q_TOTAL <= 8'bx;
                          end
                        else
                          begin
                                     I_TOTAL <= I_COMB;
                                     Q_TOTAL <= Q_COMB;
                          end
                        
                   end

                  always @(*)
                    begin
                                 I_COMB = (I_CWM + I_CWM_2) + (I_CWM_3 + I_CWM_4) ;     //////// USING ONLY 3 ADDERS AND DECREASE THE CRTICAL PATH
                                 Q_COMB = (Q_CWM + Q_CWM_2) + (Q_CWM_3 + Q_CWM_4) ;

                    end


                   




                   /*
                  /// Instanstion FOR 4 CHAINS


                  genvar i;

                  generate
                      
                      for ( i= 0; i < N ; i = i + 1)
                      
                            begin
                                        RX_CHAIN          (

                                                            .CLK_1(CLK_1[i]),
                                                            .CLK_2(CLK_2[i]),
                                                            .RST(RST[i]),
                                                            .ADC_OUT(ADC_OUT[i]),
                                                            .SIN_C(SIN_C[i]),
                                                            .COS_C(COS_C[i]),
                                                            .I_CWM(I_CWM[i]),
                                                            .Q_CWM(Q_CWM[i])

                                                            );
                            end

                  endgenerate
 */





    
endmodule
