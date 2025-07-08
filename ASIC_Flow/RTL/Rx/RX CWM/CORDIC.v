module CORDIC #( parameter  WIDTH        = 20,
                            NO_ITERATION = 18)( 
                                                input wire                        CLK,RST,CORDIC_EN,
                                                input wire signed [WIDTH - 1 : 0] PHI,
                                                output reg signed [5 : 0]         SIN_C,COS_C 
                                              ); 


                                //// DEFINE THE X,Y,Z, LUT OF TAN  ARRAYS 

                                                       reg signed [WIDTH - 1 : 0] TAN_LUT [0 : NO_ITERATION - 1 ];
                                                       reg signed [WIDTH - 1 : 0] X       [0 : NO_ITERATION - 1 ];
                                                       reg signed [WIDTH - 1 : 0] Y       [0 : NO_ITERATION - 1 ];
                                                       reg signed [WIDTH - 1 : 0] Z       [0 : NO_ITERATION - 1 ];

                                                       reg signed [WIDTH - 1 : 0] Y_FINAL,X_FINAL;

                                                       reg         [4:0] j;

                                                       integer  i;
            

            always @(posedge CLK or negedge RST )
              begin
                        if (!RST)
                          begin
                                 ///// Storing LUT OF TAN_INVERSE(2^-I)

                                              TAN_LUT[0]  <= 20'sb00110010010000111111;              //// tan-1(2^0) in RADDD 
                                              TAN_LUT[1]  <= 20'sb00011101101011000110;
                                              TAN_LUT[2]  <= 20'sb00001111101011011100;
                                              TAN_LUT[3]  <= 20'sb00000111111101010111;
                                              TAN_LUT[4]  <= 20'sb00000011111111101011;
                                              TAN_LUT[5]  <= 20'sb00000001111111111101;
                                              TAN_LUT[6]  <= 20'sb00000001000000000000; 
                                              TAN_LUT[7]  <= 20'sb00000000100000000000;
                                              TAN_LUT[8]  <= 20'sb00000000010000000000;
                                              TAN_LUT[9]  <= 20'sb00000000001000000000;
                                              TAN_LUT[10] <= 20'sb00000000000100000000;
                                              TAN_LUT[11] <= 20'sb00000000000010000000;
                                              TAN_LUT[12] <= 20'sb00000000000001000000;
                                              TAN_LUT[13] <= 20'sb00000000000000100000;
                                              TAN_LUT[14] <= 20'sb00000000000000010000;
                                              TAN_LUT[15] <= 20'sb00000000000000001000;
                                              TAN_LUT[16] <= 20'sb00000000000000000100;
                                              TAN_LUT[17] <= 20'sb00000000000000000010;


                                                for ( i = 1 ; i < NO_ITERATION ; i = i + 1 )
                                                  begin
                                                        X[i]       <= 20'sb0;
                                                        Y[i]       <= 20'sb0;
                                                        Z[i]       <= 20'sb0;
                                                        
                                                  end

                                                   X[0]        <= 20'sb00100110110111010100;   // CONST K instead of multiplication at the end 
                                                   Y[0]        <= 20'sb0;

                                                   SIN_C <= 0;
                                                   COS_C <= 0;
                                                   j     <= 0;
                                                   
                          end
                      
                        else
                         begin
                                if(CORDIC_EN)        
                                 begin
                                           

                                    if (j == NO_ITERATION - 1)
                                      begin
                                                j <= 0;
                                      end
                                    else
                                      begin
                                                j <= j + 1;
                                      end
                                 end
                                else
                                  begin
                                                j <= 0;
                                  end

                                         
                         end 
                         
              end
               


               always @(*)
                 begin
                               
                                       Z[0]        = PHI;                        ///// Passing PHI to intial Z When EN is high ???????
                                                                                            
                                               if (Z[j] >= 0) ////// di IS +
                                                 begin

                                                          X[j + 1]   = X[j] - (Y[j] >>> j); 
                                                          Y[j + 1]   = Y[j] + (X[j] >>> j); 

                                                          Z[j + 1]   = Z[j] - TAN_LUT[j]; 

                                                 end 
                                               else
                                                 begin     ///// di is - 

                                                          X[j + 1]   = X[j] + (Y[j] >>> j); 
                                                          Y[j + 1]   = Y[j] - (X[j] >>> j); 

                                                          Z[j + 1]   = Z[j] + TAN_LUT[j]; 

                                                 end
                                                       
                                                         Y_FINAL = Y[NO_ITERATION - 1];
                                                         X_FINAL = X[NO_ITERATION - 1];

                                                    ////// ASSIGN 6 MSB OF COORDINATES TO THE OUTPUT
                                                         /*
                                                         SIN_C = Y_FINAL[WIDTH - 1 : WIDTH - 6 ] + Y_FINAL[WIDTH - 7 ] ; ///////// MAKING ROUND INSTEAD OF TRUNCKATION 
                                                         COS_C = X_FINAL[WIDTH - 1 : WIDTH - 6 ] + X_FINAL[WIDTH - 7 ] ;  
                                                         */
                                                         SIN_C = Y_FINAL[WIDTH - 1 : WIDTH - 6 ] ; ///////// MAKING TRUNCKATION AS THAT'S WHAT WE USE IN SIMULINK  
                                                         COS_C = X_FINAL[WIDTH - 1 : WIDTH - 6 ] ;  
                                             
                 end

    
endmodule
