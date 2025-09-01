module VGA_controller(
input clk, rst,
output video_on,
output [9:0] pixel_x, pixel_y,
output hsync, vsync
);

wire done_x;

horizontal_counter U1(
  .clk(clk),
  .reset_n(rst),
  .done_x(done_x),
  .pixel_x(pixel_x)
);

vertical_counter U2(
  .clk(clk),
  .reset_n(rst),
  .enable(done_x),
  .pixel_y(pixel_y)    
);

assign hsync = (pixel_x >= 556) && (pixel_x <= 624) ? 1'b1 : 1'b0;

assign vsync = (pixel_y >= 413) && (pixel_y <=  414) ? 1'b1 : 1'b0;

assign video_on = (pixel_x < 640) && (pixel_y < 480) ? 1'b1 : 1'b0;

endmodule