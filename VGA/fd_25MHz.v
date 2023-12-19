module fd_25MHz(
    input      clock,
    input      reset,
    output reg fd_clock,
    output     locked    
);

reg count;

always @(posedge clock)begin
	if(!reset) begin
		count <= 1'b0;
		fd_clock <= 1'b0;
	end
	else begin
		if(count == 1'b1) begin
			count <= 32'd0;
			fd_clock <= ~fd_clock;
		end
		else begin
			count <= count + 1'b1;
		end
	end
end

endmodule