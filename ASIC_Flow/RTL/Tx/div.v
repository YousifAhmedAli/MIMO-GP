module clk_div (
    input wire clk,        // Main clock input
    input wire rst,      // Active-low reset
    output wire clk_2,     // clk/2
    output wire clk_16,    // clk/16
    output wire clk_32     // clk/32
);

    // 5-bit counter for division (need up to 32)
    reg [4:0] clk_div_counter;

    // Counter logic
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            clk_div_counter <= 5'b0;
        end else begin
            clk_div_counter <= clk_div_counter + 1;
        end
    end

    // Combinational clock outputs
    assign clk_2  = clk_div_counter[0];  // Toggles every cycle (clk/2)
    assign clk_16 = clk_div_counter[3];  // Toggles every 8 cycles (clk/16)
    assign clk_32 = clk_div_counter[4];  // Toggles every 16 cycles (clk/32)

endmodule