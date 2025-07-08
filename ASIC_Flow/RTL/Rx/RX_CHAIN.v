module RX_CHAIN (
                   input wire                    CLK_1,CLK_2,RST,
                   input wire                    ADC_OUT,
                   input wire  signed  [5:0]     SIN_C,COS_C,
                   output wire signed  [5:0]     I_CWM,Q_CWM
                );
     
                          wire                   ODD_I,EVEN_Q,I_DDC,Q_DDC;
                        
            //// INSTANSTION
              
                ///// IL 

                INTER_LEAVER INTER_LEAVER (
                                                .CLK_1(CLK_1),
                                                .CLK_2(CLK_2),
                                                .RST(RST),
                                                .ADC_OUT(ADC_OUT),
                                                .ODD_I(ODD_I),
                                                .EVEN_Q(EVEN_Q)
                                          );


                /// DDC

                DDC                  DDC (
                                                .CLK_2(CLK_2),
                                                .RST(RST),
                                                .ODD_I(ODD_I),
                                                .EVEN_Q(EVEN_Q),
                                                .I_DDC(I_DDC),
                                                .Q_DDC(Q_DDC)
                                        );


               //// CWM_RX

               CWM_RX         CWM_RX (

                                                .CLK_2(CLK_2),
                                                .RST(RST),
                                                .SIN_C(SIN_C),
                                                .COS_C(COS_C),
                                                .I_DDC(I_DDC),
                                                .Q_DDC(Q_DDC),
                                                .I_CWM(I_CWM),
                                                .Q_CWM(Q_CWM)

                                     );





endmodule
