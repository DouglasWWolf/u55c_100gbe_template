module blinky # (FREQ_HZ = 100000000)
(
    input clk,
    output reg led
);

reg[31:0] counter = 0;

always @(posedge clk) begin
    
    if (counter == 0) begin
        led <= ~led;
        counter <= FREQ_HZ/8;
    end

    else counter <= counter - 1;
end

endmodule
