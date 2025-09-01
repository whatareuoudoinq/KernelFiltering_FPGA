module Top_Level(
    input clk,           
    input rst,     
    input FRAMESTART,    
    input BUFFER,       
    input [3:0] SEL,     

    output wire [3:0] VGA_R,  
    output wire [3:0] VGA_G,  
    output wire [3:0] VGA_B,  
    output wire hsync,       
    output wire vsync,       
    output wire led_f,        
    output wire led_b,        
    output wire [1:0] led_1,  
    output wire [1:0] led_2 
);

    wire frame_start;
    wire buffer_sel;
    wire [3:0] sel;
    
    wire clk_25;
    clk_25 c25 (
        .resetn(rst),
        .clk_in1(clk),
        .clk_out1(clk_25)
        );
        
    wire clk_50;
    clk_50 c50 (
        .resetn(rst),
        .clk_in1(clk),
        .clk_out1(clk_50)
        );

    switch Data_path (
        .clk(clk),
        .rst(rst),
        .FRAMESTART(FRAMESTART),
        .BUFFER(BUFFER),
        .SEL(SEL),
        .frame_start(frame_start),
        .buffer_sel(buffer_sel),
        .sel(sel),
        .led_f(led_f),
        .led_b(led_b),
        .led_1(led_1),
        .led_2(led_2)
    );

    VGA_top Control_path (
        .clk(clk),
        .clk_25(clk_25),
        .clk_50(clk_50),
        .rst(rst),
        .frame_start(frame_start),
        .buffer_sel(buffer_sel),
        .sel(sel),
        .VGA_R(VGA_R),
        .VGA_G(VGA_G),
        .VGA_B(VGA_B),
        .hsync(hsync),
        .vsync(vsync)
    );

endmodule