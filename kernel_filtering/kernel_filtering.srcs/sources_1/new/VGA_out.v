module VGA_out (
    input clk,
    input clk_25,
    input clk_50,
    input rst,
    input frame_start,
    input buffer_sel,
    input [3:0] sel,
    input [15:0] addr,
    output [3:0] vga_out
    );

    wire filtering1, filtering2;           
    wire [15:0] addr1, addr2;              
    wire [3:0] data_out1, data_out2;        
    wire done1, done2;                     
    wire counter_enable1, counter_enable2; 
    wire next_count1, next_count2;
    wire wr1, wr2;                         
    wire [3:0] vga_out1, vga_out2;         
    wire [3:0] sel1, sel2;                  
    wire [3:0] lu1, cu1, ru1, lc1, cc1, rc1, lb1, cb1, rb1; 
    wire [3:0] lu2, cu2, ru2, lc2, cc2, rc2, lb2, cb2, rb2; 
    
    Filtering_Flow FF (
        .framestart(frame_start),      
        .buffer_sel(buffer_sel),     
        .filtering1(filtering1),     
        .filtering2(filtering2)      
    );
        
     assign counter_enable2 = (done1 == 0) ? (sel[0] ^ sel[1]) : 0;
     assign counter_enable1 = (done2 == 0) ? (sel[2] ^ sel[3]) : 0;
     
    Counter c1 (
        .clk(clk),
        .rst(rst),      
        .count_enable(counter_enable1),    
        .next_count(next_count1),
        .addr(addr1), 
        .done(done1)        
    );
    
    Counter c2 (
        .clk(clk),
        .rst(rst),         
        .count_enable(counter_enable2),   
        .next_count(next_count2),
        .addr(addr2), 
        .done(done2)        
    );
    
    Buffer1 b1 (
        .clk(clk),
        .clk_25(clk_25),
        .clk_50(clk_50),
        .rst(rst),
        .filtering(filtering2),     
        .vga(done1),            
        .wr(wr1),             
        .addr(addr1),    
        .addr_fil(addr2),
        .addr_vga(addr),
        .filtered(data_out1), 
        .next_count(next_count1),
        .vga_out(vga_out1),  
        .lu(lu2), .cu(cu2), .ru(ru2), 
        .lc(lc2), .cc(cc2), .rc(rc2), 
        .lb(lb2), .cb(cb2), .rb(rb2) 
    );
    
    Buffer2 b2 (
        .clk(clk),
        .clk_25(clk_25),
        .clk_50(clk_50),
        .rst(rst),
        .filtering(filtering1),     
        .vga(done2),            
        .wr(wr2),             
        .addr(addr2),    
        .addr_fil(addr1),
        .addr_vga(addr),
        .filtered(data_out2), 
        .next_count(next_count2),
        .vga_out(vga_out2),  
        .lu(lu1), .cu(cu1), .ru(ru1), 
        .lc(lc1), .cc(cc1), .rc(rc1), 
        .lb(lb1), .cb(cb1), .rb(rb1) 
    );
    
    Filtering_Top F1(
      .clk(clk),                  
      .rst(rst),    
      .sel_f(sel[1:0]),             
      .lu(lu1), .cu(cu1), .ru(ru1),      
      .lc(lc1), .cc(cc1), .rc(rc1),        
      .lb(lb1), .cb(cb1), .rb(rb1),        
      
      .data_out(data_out1),        
      .wr(wr1)                    
    );
    
    Filtering_Top F2(
      .clk(clk),                  
      .rst(rst),             
      .sel_f(sel[3:2]),             
      .lu(lu2), .cu(cu2), .ru(ru2),      
      .lc(lc2), .cc(cc2), .rc(rc2),         
      .lb(lb2), .cb(cb2), .rb(rb2),         
      
      .data_out(data_out2),        
      .wr(wr2)                    
    );
    
    assign vga_out = buffer_sel ? vga_out2 : vga_out1;  
    

endmodule