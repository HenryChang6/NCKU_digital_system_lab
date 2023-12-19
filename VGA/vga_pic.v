module vga_pic(
    input vga_clk,
    input sys_rst_n,
    input [9:0] pix_x,
    input [9:0] pix_y,
    input red,
    input green,
    input black,
    output reg [15:0] pix_data,
);

always(posedge vga_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        pix_data <= 16'd0;
        red <= 1'b0;
        green <= 1'b0;
        black <= 1'b0;
    end
    else begin
        
    end

end


endmodule