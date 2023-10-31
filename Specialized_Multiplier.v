module lab3 (
    input [3:0] SW,     // 4-bit input from switches SW3 to SW0
    output reg [6:0] HEX    // 7-bit output to HEX06 to HEX00
);


reg [6:0] result;


always @(*) begin
    case (SW)
        4'd0, 4'd1, 4'd2: result = SW;
        4'd3, 4'd4, 4'd5: result = SW * 2 + 1;
        4'd6, 4'd7, 4'd8: result = SW * 2 - 1;
        default: result = 7'b0;
    endcase
end


always @(*) begin
    case(result)
		4'd0: HEX = 7'b1000000; 
		4'd1: HEX = 7'b1111001;
		4'd2: HEX = 7'b0100100;
		4'd3: HEX = 7'b0110000;
		4'd4: HEX = 7'b0011001;
		4'd5: HEX = 7'b0010010;
		4'd6: HEX = 7'b0000010;
		4'd7: HEX = 7'b1111000;
		4'd8: HEX = 7'b0000000;
		4'd9: HEX = 7'b0010000;
		4'd10: HEX = 7'b0001000;
		4'd11: HEX = 7'b0000011;
		4'd12: HEX = 7'b1000110;
		4'd13: HEX = 7'b0100001;
		4'd14: HEX = 7'b0000110;
	   default : HEX = 7'b0001110;
	endcase
		
end


endmodule





