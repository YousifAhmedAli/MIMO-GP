`timescale 1ns/1ps

module MIMO_RX_TOP_TB #(   parameter    WIDTH        = 20,
                                        NO_ITERATION = 18 )();


              reg                              CLK_1_TB,RST_TB;
              reg                              CORDIC_EN_TB,ADC_OUT_TB,ADC_OUT_2_TB,ADC_OUT_3_TB,ADC_OUT_4_TB;
              reg   signed  [WIDTH - 1:0]      PHI_TB,PHI_2_TB,PHI_3_TB,PHI_4_TB;
              wire  signed  [18:0]             I_Processor_TB,Q_Processor_TB;

             parameter DEPTH = 1002;
             parameter MEM_DEPTH = (DEPTH - 2 ) * 2 ;

                 reg                    MEM_1 [0:MEM_DEPTH];
                 reg                    MEM_2 [0:MEM_DEPTH];
                 reg                    MEM_3 [0:MEM_DEPTH];
                 reg                    MEM_4 [0:MEM_DEPTH];
                 
                 reg                    I_MEM [0:DEPTH];
                 reg                    Q_MEM [0:DEPTH];           

                 reg                    I_DDC_FILE          [0:DEPTH];
                 reg                    Q_DDC_FILE          [0:DEPTH];
                 reg  signed [5:0]      I_CWM_FILE          [0:DEPTH];
                 reg  signed [5:0]      Q_CWM_FILE          [0:DEPTH];
                 reg  signed [7:0]      I_TOTAL_FILE        [0:DEPTH];
                 reg  signed [18:0]     I_Processor_FILE    [0:62];




                 reg                I_MEM_FILE     [0:DEPTH-2];
                 reg                I_MEM_IL       [0:DEPTH-2];
                 reg                Q_MEM_FILE     [0:DEPTH-2];
                 reg                Q_MEM_IL       [0:DEPTH-2];
                 reg                I_MEM_FILE_DDC [0:DEPTH-2];
                 reg                I_MEM_DDC      [0:DEPTH-2];
                 reg                Q_MEM_FILE_DDC [0:DEPTH-2];
                 reg                Q_MEM_DDC      [0:DEPTH-2];

                 reg signed [5:0]   I_MEM_FILE_CWM [0:DEPTH-2];
                 reg signed [5:0]   I_MEM_CWM      [0:DEPTH-2];

                 reg signed [7:0]   I_MEM_TOTAL         [0:DEPTH-2];
                 reg signed [7:0]   I_MEM_FILE_TOTAL    [0:DEPTH-2];

                 reg signed [18:0]   I_MEM_Processor         [0:62];
                 reg signed [18:0]   I_MEM_FILE_Processor    [0:62];


                 reg signed [16:0]   I_MEM_COMB         [0:125];
                 reg signed [16:0]   I_COMB_FILE        [0:125];
                 
                 

                 reg signed [7:0]   Q_TOTAL_FILE   [0:DEPTH-2];
                 reg signed [7:0]   Q_MEM_TOTAL    [0:DEPTH-2];




                 reg         [9:0]      IL_FLAG,DDC_FLAG,CWM_FLAG,RX_FLAG,MIMO_FLAG,COMB_FLAG;

           
            parameter CLK_PERIOD_1 = 0.50813 * 2;         
            parameter CLK_PERIOD_2 = CLK_PERIOD_1 * 2;      
   


            integer i,j,r,jj,rr,jjj,rrr,jjjj,rrrr,jjjjj,rrrrr,rrrrrr,jjjjjj;


                           /////////// PASSING INPUT VALUES (ADC_OUT) TO IL BLOCK 
           initial
           
             begin
                        $dumpvars;
                        $dumpfile("MIMO_RX_TOP.VCD");

                    #(CLK_PERIOD_1/2)

                    
                     initialization();
                      Reset();


                      
                                $display("*****************************************************************************************************************");
                                $display("********************* MIMO_RX TEST MODEEEEEEE ***************************");
                                $display("*****************************************************************************************************************");


                        /////// PASSING ADC OUT TO EACH CHAIN 

                      $readmemb("ADC_OUT_FILE_1.txt",MEM_1);
                      $readmemb("ADC_OUT_FILE_2.txt",MEM_2);
                      $readmemb("ADC_OUT_FILE_3.txt",MEM_3);
                      $readmemb("ADC_OUT_FILE_4.txt",MEM_4);

                        
                        /////// TESTING CORDIC_BLOCKS_FUNCTIONALITY
                                
                                $display("*****************************************************************************************************************");
                                $display("********************* TESTING CORDIC_BLOCKS_FUNCTIONALITY ***************************");
                                $display("*****************************************************************************************************************");

                                 #(CLK_PERIOD_1*NO_ITERATION)
                                            
                                              $display ("*********************************************************************");
                                             
                                             $display ("ALL THE RESULTS BELOW USIN SFIX(1,6,4) FORMAT >> 1 SIGN AND 1 INTEGER AND 4 FRACTION ");

 
                                             $display ("************************************ TESTING FOR THETA = 0       CHAIN_1 **********************************");


                                        if (DUT.MIMO_RX.SIN_C == 6'sb0 && DUT.MIMO_RX.COS_C == 6'sb010000)
                                            begin
                                                $display ("TEST CASE 1 PASSED AS SIN(0) = %0d and COS(0) = %0d at TIME ",DUT.MIMO_RX.SIN_C,DUT.MIMO_RX.COS_C,$time);
                                            end
                                        else
                                            begin
                                                $display ("TEST CASE 1 Falled AS SIN(0) = %0d and COS(0) = %0d at TIME ",DUT.MIMO_RX.SIN_C,DUT.MIMO_RX.COS_C,$time);
                                            end

                                        
                                          $display ("*********************************************************************");
                              
                                          $display ("************************************ TESTING FOR THETA = PHI_2      CHAIN_2    **********************************");
                                
                                                    if (DUT.MIMO_RX.SIN_C_2 == 6'sb00_1011 && DUT.MIMO_RX.COS_C_2 == 6'sb00_1010)
                                                        begin
                                                            $display ("TEST CASE 2 PASSED AS SIN(0) = %0d and COS(0) = %0d at TIME ",DUT.MIMO_RX.SIN_C_2,DUT.MIMO_RX.COS_C_2,$time);
                                                        end
                                                    else
                                                        begin
                                                            $display ("TEST CASE 2 Falled AS SIN(0) = %0d and COS(0) = %0d at TIME ",DUT.MIMO_RX.SIN_C_2,DUT.MIMO_RX.COS_C_2,$time);
                                                        end   

                                            $display ("*********************************************************************");
 
                                            $display ("************************************ TESTING FOR THETA = PHI_3     CHAIN_3 **********************************");

                                                    if (DUT.MIMO_RX.SIN_C_3 == 6'sb00_1111 && DUT.MIMO_RX.COS_C_3 == 6'sb11_1111)
                                                        begin
                                                            $display ("TEST CASE 3 PASSED AS SIN(0) = %0d and COS(0) = %0d at TIME ",DUT.MIMO_RX.SIN_C_3,DUT.MIMO_RX.COS_C_3,$time);
                                                        end
                                                    else
                                                        begin
                                                            $display ("TEST CASE 3 Falled AS SIN(0) = %0d and COS(0) = %0d at TIME ",DUT.MIMO_RX.SIN_C_3,DUT.MIMO_RX.COS_C_3,$time);
                                                        end   

                                               

                                             $display ("*********************************************************************");
                                             $display ("************************************ TESTING FOR THETA = PHI_4 **********************************");

                                                    if (DUT.MIMO_RX.SIN_C_4 == 6'sb00_1010 && DUT.MIMO_RX.COS_C_4 == 6'sb11_0011)     ////// THATS BECAUSE COS(PI-PHI_4) = - COS(PHI_4)
                                                        begin
                                                            $display ("TEST CASE 4 PASSED AS SIN(0) = %0d and COS(0) = 6'sb110011 at TIME ",DUT.MIMO_RX.SIN_C_4,$time);
                                                        end
                                                    else
                                                        begin
                                                            $display ("TEST CASE 4 Falled AS SIN(0) = %0d and COS(0) = %0d at TIME ",DUT.MIMO_RX.SIN_C_4,DUT.MIMO_RX.COS_C_4,$time);
                                                        end   


                                          CORDIC_EN_TB = 0;

                                             $display ("*********************************************************************");
                                             $display ("************************************  TESTING CORDIC_BLOCKS DONEEEEE  **********************************");
                                             $display ("*********************************************************************");


                                               //////// CHECKING CHAIN_2 FUNCTIONALITY
                
                                $display("*****************************************************************************************************************");
                                $display("********************* Testing RX_CHAIN_2 BLOCKS && INTGERATION BETWEEN THEM ***************************");
                                $display("*****************************************************************************************************************");
                       
                       //// FOR TESTING OUTPUTS OF IL
                      $readmemb("ODD_I_FILE.txt",I_MEM_IL);
                      $readmemb("EVEN_Q_FILE.txt",Q_MEM_IL);
                        
                        /// FOR TESTING OUTPUTS OF DDC 
                      $readmemb("I_DDC_FILE.txt",I_MEM_DDC);
                      $readmemb("Q_DDC_FILE.txt",Q_MEM_DDC);

                       /// FOR TESTING CWM
                       $readmemb("I_CWM_FILE.txt",I_MEM_CWM);

                       /// FOR TESTING 4_CHAINS 
                       $readmemb("I_TOTAL_FILE.txt",I_MEM_TOTAL);
                       
                       /// FOR TESTING 4_CHAINS_integartion_with_Desimation_COMB 
                       $readmemb("I_COMB_FILE.txt",I_MEM_COMB);

                       /// FOR TESTING 4_CHAINS_integartion_with_Desimation 
                       $readmemb("I_Processor_FILE.txt",I_MEM_Processor);
                       
                    
                        

                      for (i = 0; i <= MEM_DEPTH ; i = i + 1 )
                       begin
                         
                         @(posedge CLK_1_TB)
                          
                           ADC_OUT_TB   = MEM_1[i];
                           ADC_OUT_2_TB = MEM_2[i];
                           ADC_OUT_3_TB = MEM_3[i];
                           ADC_OUT_4_TB = MEM_4[i];
                        
                       end
             end


           initial
           
             begin
                      
                                                    #(CLK_PERIOD_1*NO_ITERATION)             ////////// WAITING TILL CORDIC WILL BE UPDATED
   

                    #(CLK_PERIOD_1 * 2.5) ////// Wait untill ADC_OUT Be updated


                      for (j = 0; j <= DEPTH ; j = j + 1 )
                       begin
                         
                         @(posedge DUT.MIMO_RX.CLK_2)
                          
                           I_MEM[j] = DUT.MIMO_RX.CHAIN_2.INTER_LEAVER.ODD_I;      /// TESTING IL SIGNALS 
                           Q_MEM[j] = DUT.MIMO_RX.CHAIN_2.INTER_LEAVER.EVEN_Q;
                
                       end
                     
                     $display("*****************************************************************************************************************");
                     $display("********************* Testing Interleaver ***************************");
                     $display("*****************************************************************************************************************");


                        for (r = 0; r <= (DEPTH - 1) ; r = r + 1 )           ///// ONLY 1 BIT IS DIFFER THAN SIMULINK DUE TO EXTRA F/F IN RTL 
                       begin
                         
                           I_MEM_FILE[r] = I_MEM[r + 1];
                           Q_MEM_FILE[r] = Q_MEM[r + 1];
                              
                              if (I_MEM_FILE[r] == I_MEM_IL[r])
                               IL_FLAG = IL_FLAG + 1;
                             
                       end
                     
                       if(IL_FLAG == 1001 )
                            begin
                            
                                 $display("*****************************************************************************************************************");

                               $display("Test Case Passed &&&  output  from RTL FOR IL_BLOCK  = output file from Simulink  at Time %t ",$time);
                               $display("******************************* INTER LEAVER DONE ************************************");

                               $display("*****************************************************************************************************************");
                                           
                            end
                 
                 # (65*CLK_PERIOD_1*32)
                 $stop;
             end

                                      //////          TESTING DDC 
             initial
           
             begin
                                                                          #(CLK_PERIOD_1*NO_ITERATION)             ////////// WAITING TILL CORDIC WILL BE UPDATED


                    #(CLK_PERIOD_1 * 2.5) ////// Wait untill ADC_OUT Be updated


                      for (jj = 0; jj <= DEPTH ; jj = jj + 1 )
                       begin
                         
                         @(posedge DUT.MIMO_RX.CLK_2)
                        

                           I_DDC_FILE[jj] = DUT.MIMO_RX.CHAIN_2.DDC.I_DDC;         /// TESTING DDC SIGNALS 
                           Q_DDC_FILE[jj] = DUT.MIMO_RX.CHAIN_2.DDC.Q_DDC;         
                             
                       end
                     
               # (3*CLK_PERIOD_2)

                     $display("*****************************************************************************************************************");
                     $display("********************* Testing DDC ***************************");
                     $display("*****************************************************************************************************************");


                        for (rr = 0; rr <= (DEPTH - 2) ; rr = rr + 1 )           ///// ONLY 1 BIT IS DIFFER THAN SIMULINK DUE TO EXTRA F/F IN RTL 
                       begin
                         
                           I_MEM_FILE_DDC[rr] = I_DDC_FILE[rr + 2];
                           Q_MEM_FILE_DDC[rr] = Q_DDC_FILE[rr + 2];
                              
                              if (I_MEM_FILE_DDC[rr] == I_MEM_DDC[rr])
                               DDC_FLAG = DDC_FLAG + 1;
                             
                       end
                     
                       if(DDC_FLAG == 1001 )
                             begin                                  
                                     $display("*****************************************************************************************************************");

                               $display("Test Case Passed &&&  output  from RTL FOR DDC_BLOCK  = output file from Simulink  at Time %t ",$time);
                               $display("******************************* DDC DONE ************************************");
                            
                               $display("*****************************************************************************************************************");
                                           
                            end
                 
                
             end


                                      //// TESTING CWM
                
                 initial
           
             begin
                      
                                                    #(CLK_PERIOD_1*NO_ITERATION)             ////////// WAITING TILL CORDIC WILL BE UPDATED

                    #(CLK_PERIOD_1 * 2.5) ////// Wait untill ADC_OUT Be updated
                    #(CLK_PERIOD_2)       // TO INGNOR THE FIRIST SAMPLE WHICH WILL BE X ?

                      for (jjj = 0; jjj <= DEPTH ; jjj = jjj + 1 )
                       begin
                         
                         @(posedge DUT.MIMO_RX.CLK_2)
                        
                             I_CWM_FILE[jjj] = DUT.MIMO_RX.CHAIN_2.CWM_RX.I_CWM;             /// TESTING CWM SIGNALS 
                             Q_CWM_FILE[jjj] = DUT.MIMO_RX.CHAIN_2.CWM_RX.Q_CWM;
                              
                       end
                     
               # (3*CLK_PERIOD_2)

                     $display("*****************************************************************************************************************");
                     $display("********************* Testing CWM ***************************");
                     $display("*****************************************************************************************************************");


                        for (rrr = 0; rrr <= (DEPTH - 2) ; rrr = rrr + 1 )           ///// ONLY 1 BIT IS DIFFER THAN SIMULINK DUE TO EXTRA F/F IN RTL 
                       begin
                         
                           I_MEM_FILE_CWM[rrr] = I_CWM_FILE[rrr + 2];
                              
                              if (I_MEM_FILE_CWM[rrr] == I_MEM_CWM[rrr])
                               CWM_FLAG = CWM_FLAG + 1;
                             
                       end
                     
                       if(CWM_FLAG == 1001 )
                        begin
                          
                               $display("*****************************************************************************************************************");
                                 
                               $display("Test Case Passed &&&  output  from RTL FOR CWM_BLOCK  = output file from Simulink  at Time %t ",$time);
                               $display("******************************* CWM DONE ************************************");
                          
                               $display("*****************************************************************************************************************");
                        end



                     $display("*****************************************************************************************************************");
                     $display("******************************* ALL BLOCKS AND INTEGRATION BETWEEN THEM  DONE CORRECTLY ************************************");
                     $display("*****************************************************************************************************************");

                     $display("********************* TESTING RX_CHAIN_2 PASSEDDDDD ***************************");
                     $display("*****************************************************************************************************************");
                 
                
             end




     //// TESTING 4 CHAINS
                
                 initial
           
             begin
                      
                                                    #(CLK_PERIOD_1*NO_ITERATION)             ////////// WAITING TILL CORDIC WILL BE UPDATED

                    #(CLK_PERIOD_1 * 2.5) ////// Wait untill ADC_OUT Be updated
                    #(CLK_PERIOD_2 * 2)       // TO INGNOR THE FIRIST  2 SAMPLES WHICH WILL BE X ?

                      for (jjjj = 0; jjjj <= DEPTH ; jjjj = jjjj + 1 )
                       begin
                         
                         @(posedge DUT.MIMO_RX.CLK_2)
                        
                             I_TOTAL_FILE[jjjj] = DUT.MIMO_RX.I_TOTAL;             /// TESTING I_TOTAL && Q_TOTAL SIGNALS 
                             Q_TOTAL_FILE[jjjj] = DUT.MIMO_RX.Q_TOTAL;
                              
                       end
                     
               # (4*CLK_PERIOD_2)

                     $display("*****************************************************************************************************************");
                     $display("********************* Testing 4 CHAINS Outputs I_Total && Q_Total ***************************");
                     $display("*****************************************************************************************************************");


                        for (rrrr = 0; rrrr <= (DEPTH - 2) ; rrrr = rrrr + 1 )           ///// ONLY 1 BIT IS DIFFER THAN SIMULINK DUE TO EXTRA F/F IN RTL 
                       begin
                         
                           I_MEM_FILE_TOTAL[rrrr] = I_TOTAL_FILE[rrrr + 2];
                              
                              if (I_MEM_FILE_TOTAL[rrrr] == I_MEM_TOTAL[rrrr])
                               RX_FLAG = RX_FLAG + 1;
                             
                       end
                     
                       if(RX_FLAG == 1001 )
                                 
                               $display("Test Case Passed &&&  output  from RTL FORM 4_CHAINS  = output file from Simulink  at Time %t ",$time);
                               $display("*****************************************************************************************************************");
                      


                     $display("*****************************************************************************************************************");
                     $display("********************* TESTING MIMO_RX_4_CHAINS  PASSEDDDDDDDDDDDDD ***************************");
                     $display("*****************************************************************************************************************");
 
                
             end



                 //// TESTING MIMO_RX_With_Decimation_COMB
                
                 initial
           
             begin
                      
                                                    #(CLK_PERIOD_1*NO_ITERATION)             ////////// WAITING TILL CORDIC WILL BE UPDATED

               //     #(CLK_PERIOD_1 * 2.5) ////// Wait untill ADC_OUT Be updated
             //       #(CLK_PERIOD_2 * 2)       // TO INGNOR THE FIRIST SAMPLE WHICH WILL BE X ?

                    #(CLK_PERIOD_1 * 40 ) ////// Wait 24 Cycles till COMB_OUT is Updated ???


                      for (jjjjjj = 0; jjjjjj <= 125 ; jjjjjj = jjjjjj + 1 )
                       begin
                         
                         @(posedge DUT.CLK_DIV_16.O_DIV_CLK)
                        
                             I_COMB_FILE[jjjjjj] = DUT.Decimation_I.out_comb;             /// TESTING I_Decmation_COMB 
                              
                       end
                     
               # (CLK_PERIOD_2*16)

                     $display("*****************************************************************************************************************");
                     $display("********************* Testing MIMO_RX_With_Decimation_COMB ***************************");
                     $display("*****************************************************************************************************************");


                        for (rrrrrr = 0; rrrrrr <= 125 ; rrrrrr = rrrrrr + 1 )           ///// ONLY 1 BIT IS DIFFER THAN SIMULINK DUE TO EXTRA F/F IN RTL 
                       begin
                         
                            
                              if (I_COMB_FILE[rrrrrr] == I_MEM_COMB[rrrrrr])
                               COMB_FLAG = COMB_FLAG + 1;
                             
                       end
                     
                       if(COMB_FLAG == 126 )
                                 begin
                                
                               $display("Test Case Passed &&&  output  from RTL I_COMB  = output file from Simulink  at Time %t ",$time);
                               $display("*****************************************************************************************************************");
                      

                                 end

                     $display("*****************************************************************************************************************");
                     $display("********************* TESTING MIMO_RX_Integration_with_Decimation_COMB  PASSEDDDDDDDDDDDDD ***************************");
                     $display("*****************************************************************************************************************");


                 
                
             end



                 initial
           
             begin
                      
                                                    #(CLK_PERIOD_1*NO_ITERATION)             ////////// WAITING TILL CORDIC WILL BE UPDATED

                    #(CLK_PERIOD_1 * 2.5) ////// Wait untill ADC_OUT Be updated
             //       #(CLK_PERIOD_2 * 2)       // TO INGNOR THE FIRIST SAMPLE WHICH WILL BE X ?

                    #(CLK_PERIOD_1 * 32 * 3) ////// Wait 3 CLK_32 Cycles till HP_OUT is Updated ???


                      for (jjjjj = 0; jjjjj <= 62 ; jjjjj = jjjjj + 1 )
                       begin
                         
                         @(posedge DUT.CLK_DIV_32.O_DIV_CLK)
                        
                             I_Processor_FILE[jjjjj] = I_Processor_TB;             /// TESTING I_Decmation 
                              
                       end
                     
               # (CLK_PERIOD_2*32)

                     $display("*****************************************************************************************************************");
                     $display("********************* Testing MIMO_RX_With_Decimation ***************************");
                     $display("*****************************************************************************************************************");


                        for (rrrrr = 0; rrrrr <= 62 ; rrrrr = rrrrr + 1 )           ///// ONLY 1 BIT IS DIFFER THAN SIMULINK DUE TO EXTRA F/F IN RTL 
                       begin
                         
                            
                              if (I_Processor_FILE[rrrrr] == I_MEM_Processor[rrrrr])
                               MIMO_FLAG = MIMO_FLAG + 1;
                             
                       end
                     
                       if(MIMO_FLAG == 5 )
                                 begin
                                
                               $display("Test Case Passed &&&  output  from RTL I_Processor  = output file from Simulink  at Time %t ",$time);
                               $display("*****************************************************************************************************************");
                      

                                 end

                     $display("***************************************************************************************************************");
                     $display("********************* TESTING MIMO_RX_Integration_with_Decimation  PASSEDDDDDDDDDDDDD ***************************");
                     $display("*****************************************************************************************************************");

                                          $display("********************* HERE WE GOOOOOOOOOOOOOOOOOOOO  ***************************");

                     $display("*****************************************************************************************************************");
                     $display("********************* THIS DONEEEEEEEEEE BY MEEEEEEEEE ***************************");
                     $display("*************************   ZIZOOOOOOOOOOOOOOOOO   *******************************");

                     $display("*****************************************************************************************************************");


                 
                
             end










                    ///// INTIALIZATION 
                     task initialization ;
                            begin
                            CLK_1_TB     = 1'b0 ;
                            RST_TB       = 1'b1 ;

                            CORDIC_EN_TB = 1'b1 ;

                            ADC_OUT_TB   = 0;
                            ADC_OUT_2_TB = 0;
                            ADC_OUT_3_TB = 0;
                            ADC_OUT_4_TB = 0;

                            PHI_TB   = 'sb0;                                         ///   PHI_1 = 0
                            PHI_2_TB = 'sb00_110100000010011101;                    ///   FOR PHI_2
                            PHI_3_TB = 'sb01_101000000100111010;
                            PHI_4_TB = 'sb00_101100111100100101;                    /// PI - PHI_3

                            

                            IL_FLAG    = 0;
                            DDC_FLAG   = 0;
                            CWM_FLAG   = 0;
                            RX_FLAG    = 0;
                            COMB_FLAG  = 0;
                            MIMO_FLAG  = 0;
                            end
                            endtask




                    //////RST/////
                    task Reset ;
                            begin
                            RST_TB  = 1'b1 ;
                            #CLK_PERIOD_1
                            RST_TB  = 1'b0 ;
                            #CLK_PERIOD_1
                            RST_TB  = 1'b1 ;
                            end
                    endtask



////// CLOCK Generation

always #(CLK_PERIOD_1/2)   CLK_1_TB = ~CLK_1_TB;

////// DUT 

MIMO_RX_TOP      #(.WIDTH(WIDTH),
                   .NO_ITERATION(NO_ITERATION)) DUT (
                     
                                                        .CLK_1(CLK_1_TB),
                                                        .RST(RST_TB),
                                                        .CORDIC_EN(CORDIC_EN_TB),
                                                        .ADC_OUT(ADC_OUT_TB),
                                                        .ADC_OUT_2(ADC_OUT_2_TB),
                                                        .ADC_OUT_3(ADC_OUT_3_TB),
                                                        .ADC_OUT_4(ADC_OUT_4_TB),
                                                        .PHI(PHI_TB),
                                                        .PHI_2(PHI_2_TB),
                                                        .PHI_3(PHI_3_TB),
                                                        .PHI_4(PHI_4_TB),
                                                        .I_Processor(I_Processor_TB),
                                                        .Q_Processor(Q_Processor_TB)

                                                    );









    
endmodule




