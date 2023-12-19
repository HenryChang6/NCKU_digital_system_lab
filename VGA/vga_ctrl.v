module vga_ctrl(
    input         vga_clk;
    input         sys_rst_n;
    input  [15:0] pix_data;
    output [9:0]  pix_x;
    output [9:0]  pix_y;
    output        hsync;
    output        vsync;
);

wire rgb_valid;
wire pix_data_req;

reg [9:0] cnt_h;
reg [9:0] cnt_v;

parameter H_SYNC    =   10'd96  ,   //行同步时钟周期数           
          H_BACK    =   10'd40  ,   //行时序后沿           
          H_LEFT    =   10'd8   ,   //行时序左边框           
          H_VALID   =   10'd640 ,   //行有效数据           
          H_RIGHT   =   10'd8   ,   //行时序右边框           
          H_FRONT   =   10'd8   ,   //行时序前沿           
          H_TOTAL   =   10'd800 ;   //行扫描周期 

parameter V_SYNC    =   10'd2   ,   //场同步           
          V_BACK    =   10'd25  ,   //场时序后沿     
          V_TOP     =   10'd8   ,   //场时序上边框       
          V_VALID   =   10'd480 ,   //场有效数据
          V_BOTTOM  =   10'd8   ,   //场时序下边框    
          V_FRONT   =   10'd2   ,   //场时序前沿       
          V_TOTAL   =   10'd525 ;   //场扫描周期

//cnt_h: 行同步信號計數器
always @(posedge vga_clk or negedge sys_rst_n) begin 
    if(!sys_rst_n)
        cnt_h <= 10'd0;
    else if(cnt_h == H_TOTAL - 1'd1)    
        cnt_h <= 10'd0;
    else 
        cnt_h <= cnt_h + 1'd1;
end

//hsync: 行同步信號
assign hsync = (cnt_h <= H_SYNC - 1'd1) ? 1'b1 : 1'b0;

//rgb_valid: VGA有效顯示區域 
assign  rgb_valid = ((cnt_h >= H_SYNC + H_BACK + H_LEFT)
                     && (cnt_h < H_SYNC + H_BACK + H_LEFT + H_VALID)
                     &&(cnt_v >= V_SYNC + V_BACK + V_TOP)                     
                     && (cnt_v < V_SYNC + V_BACK + V_TOP + V_VALID))       
                     ? 1'b1 : 1'b0;

assign pix_x = (pix_data_req) ? (cnt_h - (H_SYNC + H_BACK + H_LEFT - 1'b1)) : 10'h3ff;

assign pix_y = (pix_data_req) ? (cnt_v - (V_SYNC + V_BACK + V_TOP)) : 10'h3ff;

assign rgb = (rgb_valid) ? pix_data : 16'b0;

endmodule
