`define TimeExpire 32'd25000000 

module Frequency_Divider(clk, reset, div_clk);
input clk, reset;
output div_clk;

reg div_clk;
reg[31:0] count;

always @(posedge clk)begin
	if(!reset) begin
		count <= 32'd0;
		div_clk <= 1'b0;
	end
	else begin
		if(count == `TimeExpire) begin
			count <= 32'd0;
			div_clk <= ~div_clk;
		end
		else begin
			count <= count + 32'd1;
		end
	end
end

endmodule
