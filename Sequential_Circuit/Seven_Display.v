module Seven_Display(IN,OUT);

input [3:0] IN;
output reg [6:0] OUT;

always @(IN)
begin
	case(IN)
		4'b0000 : OUT = 7'b1000000;
		4'b0001 : OUT = 7'b1111001;
		4'b0010 : OUT = 7'b0100100;
		4'b0011 : OUT = 7'b0110000;
		4'b0100 : OUT = 7'b0011001;
		4'b0101 : OUT = 7'b0010010;
		4'b0110 : OUT = 7'b0000010;
		4'b0111 : OUT = 7'b1111000;
		4'b1000 : OUT = 7'b0000000;
		4'b1001 : OUT = 7'b0010000;
		4'b1010 : OUT = 7'b0001000;
		4'b1011 : OUT = 7'b0000011;
		4'b1100 : OUT = 7'b1000110;
		4'b1101 : OUT = 7'b0100001;
		4'b1110 : OUT = 7'b0000110;
		4'b1111 : OUT = 7'b0001110;
	endcase
end
endmodule
