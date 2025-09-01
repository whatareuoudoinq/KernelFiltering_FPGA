module Filtering_Top(
  input clk,                 
  input rst,               
  input wire [1:0] sel_f,            
  input wire [3:0] lu, cu, ru,     
                lc, cc, rc,         
                lb, cb, rb,         
  output reg [3:0] data_out,        
  output reg wr                    
);

  wire [3:0] gaussian_out;
  wire [3:0] sobel_out;

  GaussianFilter gaussian_filter (
    .lu(lu), .cu(cu), .ru(ru),
    .lc(lc), .cc(cc), .rc(rc),
    .lb(lb), .cb(cb), .rb(rb),
    .sel(sel_f),
    .blurred(gaussian_out)
  );

  SobelFilter sobel_filter (
    .lu(lu), .cu(cu), .ru(ru),
    .lc(lc), .rc(rc),
    .lb(lb), .cb(cb), .rb(rb),
    .sel(sel_f),
    .result(sobel_out)
  );

  always @(posedge clk) begin
    if (!rst) begin
      data_out <= 4'd0;
      wr <= 1'b0;
    end else begin
      case (sel_f)
        2'b01: begin
          data_out <= gaussian_out;
          wr <= 1'b1;    
        end
        2'b10: begin
          data_out <= sobel_out;
          wr <= 1'b1;       
        end
        default: begin
          data_out <= 4'd0;
          wr <= 1'b0;
        end
      endcase
    end
  end

endmodule