module VGA_top(
    input clk,           
    input clk_25,
    input clk_50,
    input rst,    
    input frame_start, 
    input buffer_sel, 
    input [3:0] sel, 
    output reg [3:0] VGA_R,
    output reg [3:0] VGA_G,
    output reg [3:0] VGA_B,
    output wire hsync,        
    output wire vsync         
);
    wire done;
    
    wire [9:0] pixel_x;
    wire [9:0] pixel_y;

    wire video_on;         
    wire [15:0] address;   
    
    wire [2:0] one;
    assign one = {pixel_y[8], pixel_x[9:8]};
    
    assign address = {pixel_y[7:0], pixel_x[7:0]};

    VGA_controller U1 (
        .clk(clk_25),         
        .rst(rst), 
        .video_on(video_on),
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        .hsync(hsync),
        .vsync(vsync)
    );

    wire [3:0] VGA;
    
    VGA_out v1 (
        .clk(clk),
        .clk_25(clk_25),
        .clk_50(clk_50),
        .rst(rst),
        .frame_start(frame_start),
        .buffer_sel(buffer_sel),
        .sel(sel),
        .addr(address),
        .vga_out(VGA)
        );
        
    always @(posedge clk_25) begin
    if(!rst) begin
        VGA_R <= 4'b0000;
        VGA_G <= 4'b0000;
        VGA_B <= 4'b0000;
    end
    else begin    
        if (video_on) begin
            if(one == 000) begin
                VGA_R <= VGA[3:0];
                VGA_G <= VGA[3:0];
                VGA_B <= VGA[3:0];
            end
            else begin
                VGA_R <= 4'b0;
                VGA_G <= 4'b0;
                VGA_B <= 4'b0;
            end
       end
       else begin
            VGA_R <= 4'b0;
            VGA_G <= 4'b0;
            VGA_B <= 4'b0;
       end
    end
end
endmodule