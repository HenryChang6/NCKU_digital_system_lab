module sequential_circuit(clk, reset, updown, out);

input clk, reset, updown;
output [6:0] out;
wire [3:0] count;
wire clk_div;


Frequency_Divider u_FreqDiv(.clk(clk), .reset(reset), .div_clk(clk_div));
Up_Down_Counter u_counter(.clk(clk_div), .reset(reset), .updown(updown), .count(count));
Seven_Display u_display (.IN(count), .OUT(out));


endmodule
