module SobelFilter(
  input [3:0] lu, cu, ru,  
              lc, rc,  
              lb, cb, rb,  
  input [1:0] sel,         
  output reg [3:0] result   
);

  reg signed [7:0] grad_x; 
  reg signed [7:0] grad_y; 
  reg [7:0] magnitude;     

  always @(*) begin
    if (sel == 2'b10) begin
      grad_x = -$signed(lu) - ($signed(lc) << 1) - $signed(lb) +
                $signed(ru) + ($signed(rc) << 1) + $signed(rb);

      grad_y = -$signed(lu) - ($signed(cu) << 1) - $signed(ru) +
                $signed(lb) + ($signed(cb) << 1) + $signed(rb);

      magnitude = (grad_x < 0 ? -grad_x : grad_x) + 
                  (grad_y < 0 ? -grad_y : grad_y);

      if (magnitude > 8'h0F)
        result = 4'd15;
      else
        result = magnitude[3:0];
    end else begin
      grad_x = 8'sd0;
      grad_y = 8'sd0;
      magnitude = 8'd0;
      result = 4'd0;
    end
  end

endmodule