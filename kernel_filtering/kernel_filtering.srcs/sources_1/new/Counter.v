module Counter (
    input clk,             
    input rst,             
    input count_enable,    
    input next_count,      
    output reg [15:0] addr, 
    output reg done         
);

    always @(posedge clk) begin
        if (!rst) begin
            done <= 1'b0;  
        end else if (count_enable) begin
            if (next_count) begin
                if (addr == 16'd65535) begin
                    addr <= 16'b0;    
                    done <= 1'b1;     
                end else begin
                    addr <= addr + 16'b1; 
                    done <= 1'b0;         
                end
            end
        end else if (next_count == 0) begin
            done <= 1'b0; 
        end
    end

endmodule