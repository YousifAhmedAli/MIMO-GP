module MIMO_RX_TOP #( parameter    WIDTH    = 20,
                                   NO_ITERATION = 18) (  
                                                        input wire                               CLK_1,RST,
                                                        input wire                               CORDIC_EN,ADC_OUT,ADC_OUT_2,ADC_OUT_3,ADC_OUT_4,
                                                        input wire   signed  [WIDTH - 1 : 0]     PHI,PHI_2,PHI_3,PHI_4,
                                                        output wire  signed  [18:0]              I_Processor,Q_Processor
                                                      );  

                            wire                     CLK_2,CLK_16,CLK_32;
                            wire  signed  [5:0]      SIN_C,COS_C,SIN_C_2,COS_C_2,SIN_C_3,COS_C_3,SIN_C_4,COS_C_4;
                            wire  signed  [7:0]      I_TOTAL,Q_TOTAL;



                  /// Instanstion FOR  MIMO_RX        4_CHAINS

                  
                                            MIMO_RX      MIMO_RX (

                                                                    .CLK_1(CLK_1),
                                                                    .CLK_2(CLK_2),
                                                                    .RST(RST),
                                                                    .ADC_OUT(ADC_OUT),
                                                                    .ADC_OUT_2(ADC_OUT_2),
                                                                    .ADC_OUT_3(ADC_OUT_3),
                                                                    .ADC_OUT_4(ADC_OUT_4),
                                                                    .SIN_C(SIN_C),
                                                                    .SIN_C_2(SIN_C_2),
                                                                    .SIN_C_3(SIN_C_3),
                                                                    .SIN_C_4(SIN_C_4),
                                                                    .COS_C(COS_C),
                                                                    .COS_C_2(COS_C_2),
                                                                    .COS_C_3(COS_C_3),
                                                                    .COS_C_4(6'sb110011),              ////////// DUE TO ROUNDING AND TRUCTION ISSUES FOR PHI > 2
                                                                    .I_TOTAL(I_TOTAL),
                                                                    .Q_TOTAL(Q_TOTAL)

                                                                    );






                  /// Instanstion FOR Decimation for I Branch 


                                          Decimation  Decimation_I  (
                                                                     
                                                                     .clk_8(CLK_2),
                                                                     .clk_2(CLK_16),
                                                                     .clk(CLK_32),
                                                                     .rst_n(RST),
                                                                     .in_comb(I_TOTAL),
                                                                     .out_HB(I_Processor)

                                                                      );


                  /// Instanstion FOR Decimation for Q Branch 


                                          Decimation  Decimation_Q  (
                                                                     
                                                                     .clk_8(CLK_2),
                                                                     .clk_2(CLK_16),
                                                                     .clk(CLK_32),
                                                                     .rst_n(RST),
                                                                     .in_comb(Q_TOTAL),
                                                                     .out_HB(Q_Processor)

                                                                      );



                           ///// CORDIC Instanstion 

                  /// Instanstion FOR  CORDIC OF FIRIST CHAIN        

                CORDIC   #(.WIDTH(WIDTH),
                           .NO_ITERATION(NO_ITERATION)) CORDIC_1   (
                            
                                                                    .CLK(CLK_1),
                                                                    .RST(RST),
                                                                    .CORDIC_EN(CORDIC_EN),
                                                                    .PHI(PHI),
                                                                    .SIN_C(SIN_C),
                                                                    .COS_C(COS_C)
 
                                                                    );
                  /// Instanstion FOR  CORDIC OF SECOND CHAIN        

                CORDIC   #(.WIDTH(WIDTH),
                           .NO_ITERATION(NO_ITERATION)) CORDIC_2   (
                            
                                                                    .CLK(CLK_1),
                                                                    .RST(RST),
                                                                    .CORDIC_EN(CORDIC_EN),
                                                                    .PHI(PHI_2),
                                                                    .SIN_C(SIN_C_2),
                                                                    .COS_C(COS_C_2)
 
                                                                    );

                  /// Instanstion FOR  CORDIC OF THIRD CHAIN        

                CORDIC   #(.WIDTH(WIDTH),
                           .NO_ITERATION(NO_ITERATION)) CORDIC_3   (
                            
                                                                    .CLK(CLK_1),
                                                                    .RST(RST),
                                                                    .CORDIC_EN(CORDIC_EN),
                                                                    .PHI(PHI_3),
                                                                    .SIN_C(SIN_C_3),
                                                                    .COS_C(COS_C_3)
 
                                                                    );
                  /// Instanstion FOR  CORDIC OF FOURTH CHAIN        

                CORDIC   #(.WIDTH(WIDTH),
                           .NO_ITERATION(NO_ITERATION)) CORDIC_4   (
                            
                                                                    .CLK(CLK_1),
                                                                    .RST(RST),
                                                                    .CORDIC_EN(CORDIC_EN),
                                                                    .PHI(PHI_4),
                                                                    .SIN_C(SIN_C_4),
                                                                    .COS_C(COS_C_4)      
 
                                                                    );
                
                 ///// CLOCK DIVDERS Instanstion 
                   
                   ///// CLK_DIV BY 2 
 
                CLK_DIV                                CLK_DIV_2    (

                                                                      .I_REF_CLK(CLK_1),
                                                                      .RST_EN(RST),
                                                                      .CLK_EN(1'b1),              /////// CLK_2 ALWAYS WILL BE ON
                                                                      .DIV_RATIO(8'b00000010),          //////  CLK_1 DIVIDED BY 2
                                                                      .O_DIV_CLK(CLK_2)

                                                                      );

                   
                  ///// CLK_DIV BY 16 
 
                CLK_DIV_D                               CLK_DIV_16    (

                                                                      .I_REF_CLK(CLK_1),
                                                                      .RST_EN(RST),
                                                                      .CLK_EN(1'b1),              /////// CLK_2 ALWAYS WILL BE ON
                                                                      .DIV_RATIO(8'b00010000),    //////  CLK_1 DIVIDED BY 16 for COMB block
                                                                      .O_DIV_CLK(CLK_16)

                                                                      );

                  ///// CLK_DIV BY 32
 
                CLK_DIV_D                               CLK_DIV_32    (

                                                                      .I_REF_CLK(CLK_1),
                                                                      .RST_EN(RST),
                                                                      .CLK_EN(1'b1),              /////// CLK_2 ALWAYS WILL BE ON
                                                                      .DIV_RATIO(8'b00100000),     //////  CLK_1 DIVIDED BY 32 For HB block
                                                                      .O_DIV_CLK(CLK_32)

                                                                      );



             



    
endmodule

