`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IPEECS
// Engineer: WEI CHENG
//////////////////////////////////////////////////////////////////////////////////

module Lab_4(clk, n_rst, hsync, vsync, vga_r, vga_g, vga_b);  //,lightctrl didn't know what for
    input           clk;
    input           n_rst;
    //input [6:0]lightctrl;
   
    output          hsync,vsync;
    output [3:0]    vga_r, vga_g, vga_b;
    
    wire            pclk;
    wire            valid; 
    wire [9:0]      h_cnt,v_cnt;
    reg [11:0]      vga_data;
    wire [11:0]     cherry_dout, ghost_dout, pac_man_dout;
    reg [11:0]      cherry_addr, ghost_addr; //4095
    reg [12:0]      pac_man_addr;             //8191
    wire            cherry_area, ghost_area, pac_man_area, edge_area, wall_area, test_area;
    reg [9:0]      cherry_x,cherry_y, ghost_x,ghost_y,next_ghost_x,next_ghost_y,
    pac_man_x,pac_man_y,next_pac_man_x,next_pac_man_y;   
    //reg [7:0]       speed_cnt;
    //wire            speed_ctrl;
    //reg [3:0]       flag_edge;
    wire rst;
    assign rst = !n_rst;
    
    parameter [9:0] pac_man_length=7'd70;
    parameter [9:0] pac_man_height=7'd70;
    
    parameter [9:0] cherry_length=6'd60;
    parameter [9:0] cherry_height=6'd60;
    
    parameter [9:0] ghost_length=6'd60;
    parameter [9:0] ghost_height=6'd60;
    
    dcm_25M u0 (
        // Clock in ports
        .clk_in1(clk),      // input clk_in1
        // Clock out ports
        .clk_out1(pclk),     // output clk_out1
        // Status and control signals
        .reset(rst));

    pac_man_rom u1 (
        .clka(pclk),
        .addra(pac_man_addr),
        .douta(pac_man_dout)
        );
    
    ghost_rom u2 (
        .clka(pclk),
        .addra(ghost_addr),
        .douta(ghost_dout)
        );
    
    cherry_rom u3 (
        .clka(pclk),
        .addra(cherry_addr),
        .douta(cherry_dout)
        );
    
    SyncGeneration u4 (
		.pclk(pclk), 
		.reset(rst), 
		.hSync(hsync), 
		.vSync(vsync), 
		.dataValid(valid), 
		.hDataCnt(h_cnt), 
		.vDataCnt(v_cnt)
		);

    assign pac_man_area = ((v_cnt >= pac_man_y) & (v_cnt <= pac_man_y + pac_man_height - 1) & (h_cnt >= pac_man_x) & (h_cnt <= pac_man_x + pac_man_length - 1)) ? 1'b1 : 1'b0;
    assign ghost_area = ((v_cnt >= ghost_y) & (v_cnt <= ghost_y + ghost_height - 1) & (h_cnt >= ghost_x) & (h_cnt <= ghost_x + ghost_length - 1)) ? 1'b1 : 1'b0;
    assign cherry_area = ((v_cnt >= cherry_y) & (v_cnt <= cherry_y + cherry_height - 1) & (h_cnt >= cherry_x) & (h_cnt <= cherry_x + cherry_length - 1)) ? 1'b1 : 1'b0;
    assign edge_area = (((v_cnt < 10'd6 || v_cnt > 10'd475) & (h_cnt <= 10'd80 || h_cnt > 10'd160)) || (h_cnt < 10'd6 || h_cnt > 10'd635)) ? 1'b1 : 1'b0;
    assign wall_area = ((v_cnt >= 10'd161) & (v_cnt <= 10'd320) & (h_cnt >= 10'd1) & (h_cnt <= 10'd80)) |
    ((v_cnt >= 10'd81) & (v_cnt <= 10'd160) & (h_cnt >= 10'd161) & (h_cnt <= 10'd320)) |
    ((v_cnt >= 10'd241) & (v_cnt <= 10'd320) & (h_cnt >= 10'd161) & (h_cnt <= 10'd320)) |
    ((v_cnt >= 10'd1) & (v_cnt <= 10'd80) & (h_cnt >= 10'd401) & (h_cnt <= 10'd560)) |
    ((v_cnt >= 10'd321) & (v_cnt <= 10'd400) & (h_cnt >= 10'd401) & (h_cnt <= 10'd560)) |
    ((v_cnt >= 10'd161) & (v_cnt <= 10'd320) & (h_cnt >= 10'd561) & (h_cnt <= 10'd640)) ? 1'b1 : 1'b0;
    //assign test_area = !(h_cnt % 80) | !(v_cnt % 80) ?1'b1 : 1'b0;
    
    always @(posedge pclk or posedge rst)
    begin: pic_display
        if (rst == 1'b1) begin
            pac_man_addr<=13'd0;
            ghost_addr<=12'd0;
            cherry_addr<=12'd0;
            vga_data <= 12'h000;      
        end
        else begin
            if (valid == 1'b1) begin
                /*if (test_area == 1'b1) begin
                    vga_data <= 12'hfff;
                end
                else */if (pac_man_area == 1'b1) begin
                    pac_man_addr <= pac_man_addr + 13'd1;
                    vga_data <= pac_man_dout;
                end
                else if (ghost_area == 1'b1) begin
                    ghost_addr <= ghost_addr + 12'd1;
                    vga_data <= ghost_dout;
                end
                else if (cherry_area == 1'b1) begin
                    cherry_addr <= cherry_addr + 12'd1;
                    vga_data <= cherry_dout;
                end
                else if (edge_area == 1'b1) begin
                    vga_data <= 12'h00f;
                end
                else if (wall_area == 1'b1) begin
                    vga_data <= 12'h00f;
                end
                else begin
                    pac_man_addr <= pac_man_addr;
                    ghost_addr <= ghost_addr;
                    cherry_addr <= cherry_addr;
                    vga_data <= 12'b000000000000;
                end
            end
            else begin
                vga_data <= 12'h000;
                if (v_cnt == 0) begin
                    pac_man_addr<=14'd0;
                    ghost_addr<=14'd0;
                    cherry_addr<=14'd0;
                end
                else begin
                    pac_man_addr <= pac_man_addr;
                    ghost_addr <= ghost_addr;
                    cherry_addr <= cherry_addr;
                end
            end
        end
    end
   
    assign {vga_r,vga_g,vga_b} = vga_data;
    /**
    always@(*)  begin
        if (speed_ctrl == 1'b1) begin
            case (flag_add_sub)
            2'b00 : begin
            next_logo_x = logo_x + 10'd1;
            next_logo_y = logo_y + 10'd1;
            end
            2'b01 : begin
            next_logo_x = logo_x + 10'd1;
            next_logo_y = logo_y - 10'd1;
            end
           2'b10 : begin
           next_logo_x = logo_x - 10'd1;
           next_logo_y = logo_y + 10'd1;
           end
           2'b11 : begin
           next_logo_x = logo_x - 10'd1;
           next_logo_y = logo_y - 10'd1;
           end
           default : begin
           next_logo_x = logo_x + 10'd1;
           next_logo_y = logo_y + 10'd1;
           end
           endcase
           end
        else begin
            next_logo_x=logo_x;
            next_logo_y=logo_y;       end
        end **/
       
    always@(posedge pclk or posedge rst)  begin
        if (rst) begin
            pac_man_x <= 10'd6;
            pac_man_y <= 10'd406;
            ghost_x <= 10'd91;
            ghost_y <= 10'd331;
            cherry_x <= 10'd571;
            cherry_y <= 10'd11;
        end
        else begin
           //pac_man_x <= next_pac_man_x;
           //pac_man_y <= next_pac_man_y;
           //ghost_x <= next_ghost_x;
           //ghost_y <= next_ghost_y;   
           //cherry_x <= next_cherry_x;
           //cherry_y <= next_cherry_y;       
        end
    end
   
endmodule
