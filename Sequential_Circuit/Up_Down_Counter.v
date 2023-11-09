module Up_Down_Counter(clk, reset, updown,count);

input clk, reset, updown;
output reg [3:0] count;

always @(posedge clk or negedge reset)
begin
	if(!reset) begin
		count <= 4'd0;
	end
	else begin
		if(updown == 0) begin
			count <= count - 4'd1;
		end
		else begin
			count <= count + 4'd1;
		end
	end
end
endmodule

	
	
