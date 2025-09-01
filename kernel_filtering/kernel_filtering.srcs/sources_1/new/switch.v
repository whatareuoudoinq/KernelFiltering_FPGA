module switch(
input clk, rst,
input FRAMESTART, BUFFER,
input [3:0] SEL,

output frame_start, buffer_sel,
output [3:0] sel,
output reg led_f, led_b,
output reg [1:0] led_1, led_2
    );
    
assign frame_start = FRAMESTART;
assign buffer_sel = BUFFER;
assign sel = SEL;

always @ (posedge clk or negedge rst) begin
    if(!rst) begin
        led_f <= 1'b0;
        led_b <= 1'b0;
        led_1 <= 2'b00;
        led_2 <= 2'b00;
    end
    else begin
        led_f <= FRAMESTART;
        led_b <= BUFFER;
        led_1 <= SEL[1:0];
        led_2 <= SEL[3:2];

    end   
 end
    
endmodule
