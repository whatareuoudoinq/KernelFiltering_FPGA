module Buffer2 (
    input clk,
    input clk_25,
    input clk_50,
    input rst,
    input filtering,        
    input vga,              
    input wr,                
    input [15:0] addr,       
    input [15:0] addr_fil,   
    input [15:0] addr_vga,
    input [3:0] filtered,    
    output reg [3:0] vga_out,
    output reg [3:0] lu, cu, ru, lc, cc, rc, lb, cb, rb, 
    output reg next_count   
);            

    reg [15:0] ram_addr;     
    wire [3:0] aram_dout;     
    wire [3:0] bram_dout; 
    reg ram_en;            

    reg [15:0] addra; 

    always @(*) begin
     if (filtering == 1'b0) begin
        addra = addr_fil; 
     end else begin
        addra = ram_addr;  
     end
    end

    
    buffer_ram_2 buffer_ram_2(
    .addra(addra),
    .clka(clk_50),
    .douta(aram_dout),
    .dina(filtered),
    .ena(ram_en),
    .wea(wr),
    
    .addrb(addr_vga),
    .clkb(clk),
    .doutb(bram_dout),
    .dinb(filtered),
    .enb(next_count),
    .web(wr)    
    );

parameter READ_LU = 4'd0, READ_CU = 4'd1, READ_RU = 4'd2, READ_LC = 4'd3, 
          READ_CC = 4'd4, READ_RC = 4'd5, READ_LB = 4'd6, READ_CB = 4'd7, READ_RB = 4'd8;

    reg [3:0] state;
    
    always @(posedge clk) begin
        if (!rst) begin
            next_count <= 1'b0;
            state <= READ_LU;
            ram_en <= 1'b0;
            lu <= 4'b0; cu <= 4'b0; ru <= 4'b0;
            lc <= 4'b0; cc <= 4'b0; rc <= 4'b0;
            lb <= 4'b0; cb <= 4'b0; rb <= 4'b0;                 
        end else begin
            next_count <= 1'b0;
            ram_en <= 1'b1;
            case (state)
                READ_LU: begin
                    ram_addr <= (addr - 257)  & 16'hFFFF;
                    lu <= aram_dout;
                    state <= READ_CU;
                end
                READ_CU: begin
                    next_count <= 0;
                    ram_addr <= (addr - 256)  & 16'hFFFF;
                    cu <= aram_dout;
                    state <= READ_RU;
                end
                READ_RU: begin
                    ram_addr <= (addr - 255)  & 16'hFFFF;
                    ru <= aram_dout;
                    state <= READ_LC;
                end
                READ_LC: begin
                    ram_addr <= (addr - 1)  & 16'hFFFF;
                    lc <= aram_dout;
                    state <= READ_CC;
                end
                READ_CC: begin
                    ram_addr <= (addr)  & 16'hFFFF;
                    cc <= aram_dout;
                    state <= READ_RC;
                end
                READ_RC: begin
                    ram_addr <= (addr + 1)  & 16'hFFFF;
                    rc <= aram_dout;
                    state <= READ_LB;
                end
                READ_LB: begin
                    ram_addr <= (addr + 255)  & 16'hFFFF;
                    lb <= aram_dout;
                    state <= READ_CB;
                end
                READ_CB: begin
                    ram_addr <= (addr + 256)  & 16'hFFFF;
                    cb <= aram_dout;
                    state <= READ_RB;
                end
                READ_RB: begin
                    ram_addr <= (addr + 257)  & 16'hFFFF;
                    rb <= aram_dout;
                    next_count <= 1'b1; 
                    state <= READ_LU;  
                end
                default: begin
                    // 기본 상태로 초기화
                    state <= READ_LU;
                    next_count <= 1'b0;
                    ram_en <= 1'b0;
                    lu <= 4'b0; cu <= 4'b0; ru <= 4'b0;
                    lc <= 4'b0; cc <= 4'b0; rc <= 4'b0;
                    lb <= 4'b0; cb <= 4'b0; rb <= 4'b0;
                end
            endcase
        end
    end

    always @(posedge clk_25) begin
        if (!rst) begin
            vga_out <= 4'b0000; 
        end else begin
            vga_out <= bram_dout; 
        end
    end
    
endmodule