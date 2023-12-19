// 640 x 480 @60
module main (
input         sys_rst_n,
input         sys_clk,
input         red,
input         green,
input         black,
output        hsync,  //控制換行
output        vsync, //控制換幀
output [15:0] rgb,
);

 wire            vga_clk ;   //VGA工作時鐘, 频率25MHz
 wire            locked  ;   //PLL locked訊號
 wire    [9:0]   pix_x   ;   //VGA有效顯示區域X軸座標
 wire    [9:0]   pix_y   ;   //VGA有效顯示區域Y軸座標
 wire    [15:0]  pix_data;   //VGA像素點色彩信息

// Hsync行同步訊號 共800個週期  有效圖像range 145 ~ 785 
// Vsync場同步訊號（控制換幀） 共525個「Hsync週期」


//**********// //**** Instantiation ***// //************//

//這個怎麼做rrr
clk_gen clk_gen_inst(
    // Input //
    .reset(sys_rst_n), //輸入復位訊號, High-Activated, 1bit
    .clock(sys_clk),    //輸入50MHz時鐘, 1 bit
    // Output//     
    .fd_clock(vga_clk),        //輸出VGA工作時鐘, 頻率25MHz   
);

vga_ctrl vga_ctrl_inst(
    // Input //
    .vga_clk    (vga_clk),   //輸入工作時鐘, 频率25MHz, 1bit     
    .sys_rst_n  (rst_n),     //輸入復位訊號, Low_Actived, 1bit
    .pix_data   (pix_data),  //輸入像素点色彩信息,16bit
    // Output//
    .pix_x      (pix_x),     //輸出VGA有效顯示區域像素點 X 軸座標, 10bit
    .pix_y      (pix_y),     //輸出VGA有效顯示區域像素點 Y 軸座標, 10bit
    .hsync      (hsync),     //輸出行同步訊號, 1bit
    .vsync      (vsync),     //輸出場同步訊號, 1bit 
    .rgb        (rgb)        //輸出像素點色彩訊號, 16bit
);

vga_pic vga_pic_inst(
    // Input //
    .vga_clk    (vga_clk),  //輸入工作時鐘, 频率25MHz, 1bit
    .sys_rst_n  (rst_n),    //輸入复位訊號, Low_Actived, 1bit
    .pix_x      (pix_x),    //輸入VGA有效顯示區域像素點X軸座標, 10bit
    .pix_y      (pix_y),    //輸入VGA有效顯示區域像素點Y軸座標, 10bit
    .red        (red),
    .green      (green),
    .black      (black),
    // Output//
    .pix_data   (pix_data)  //輸出像素点色彩信息,16bit
);



endmodule