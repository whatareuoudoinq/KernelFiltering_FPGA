module Filtering_Flow (
    input framestart,     
    input buffer_sel,     
    output wire filtering1,     
    output wire filtering2     
);
    assign filtering1 = (framestart == 1 && buffer_sel == 0) ? 1 : 0;
    assign filtering2 = (framestart == 1 && buffer_sel == 1) ? 1 : 0;

endmodule