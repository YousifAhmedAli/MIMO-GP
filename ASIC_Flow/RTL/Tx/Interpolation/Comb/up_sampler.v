


module up_sampler #( parameter L = 8 , parameter width = 20 )     // L : Upsampling factor
(  
    input clk,                     // L times faster than input sample rate
    input rst_n,
    input signed [width-1 :0] din,        // Input sample
    output reg signed [width -1 :0] dout  // Upsampled output
);

    reg [$clog2(L)-1:0] count ;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 0;
            dout <= 0;
        end
        else begin
            if (count == 0) begin
                    dout <= din;
                    count <= count + 1;
            end
            else begin
                dout <= 0;
                count <= count + 1;
            end
        end
     end
     
endmodule
