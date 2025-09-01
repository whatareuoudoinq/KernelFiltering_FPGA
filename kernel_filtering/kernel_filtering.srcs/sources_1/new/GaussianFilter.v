module GaussianFilter(
  input [3:0] lu, cu, ru,  
              lc, cc, rc,  
              lb, cb, rb,  
  input [1:0] sel,         
  output reg [3:0] blurred 
);

  reg [6:0] cc4; 
  reg [5:0] lc2, cu2, rc2, cb2; 
  reg [8:0] sum; 

  always @(*) begin
    if (sel == 2'b01) begin
      cc4 = cc << 2; 
      lc2 = lc << 1; 
      cu2 = cu << 1; 
      rc2 = rc << 1; 
      cb2 = cb << 1; 

      sum = cc4 + lc2 + cu2 + rc2 + cb2 + lu + ru + lb + rb;

      blurred = sum[8:5];
    end else begin
      cc4 = 7'd0;
      lc2 = 6'd0;
      cu2 = 6'd0;
      rc2 = 6'd0;
      cb2 = 6'd0;
      sum = 9'd0;
      blurred = 4'd0;
    end
  end

endmodule