module traffic_light_system(clk,reset,dot_row,dot_column,seven_display);
input clk;
input reset;
output reg [7:0] dot_row;
output reg [7:0] dot_column;
output reg [6:0] seven_display;

parameter S_green = 2'b00, S_yellow = 2'b01, S_red = 2'b10;
// for frequency divider
reg [31:0] DividerTimeCounter1, DividerTimeCounter2;
reg clk_div1, clk_div2;
// for seven display 
reg [3:0] TimeCounter;
//for FSM
reg [1:0] state;
reg [2:0] row_counter;


// define frequency divider: 1 for counting of seven display, 2 for dot matrix display
always @(posedge clk) begin
    if(!reset) begin
        DividerTimeCounter1 <= 32'd0;
        DividerTimeCounter2 <= 32'd0;
        clk_div1 <= 1'd0;
        clk_div2 <= 1'd0;
    end
    else begin
        if(DividerTimeCounter1 == 32'd25000000) begin
            DividerTimeCounter1 <= 32'd0;
            clk_div1 <= ~clk_div1;
            DividerTimeCounter2 <= 32'd0;
            clk_div2 <= ~clk_div2;
        end
        else if(DividerTimeCounter2 == 32'd2500) begin
            DividerTimeCounter2 <= 32'd0;
            clk_div2 <= ~clk_div2;
        end
        
        else begin
            DividerTimeCounter1 <= DividerTimeCounter1 + 32'd1;
            DividerTimeCounter2 <= DividerTimeCounter2 + 32'd1;
        end
    end
end


// define FSM state control 
always @(posedge clk_div1 or negedge reset) begin
    if(!reset) begin
        state <= S_green;
        TimeCounter <= 4'd10;
        row_counter <= 3'b0;
        dot_row <= 8'b00000000;
        dot_column <= 8'b11111111;
    end
    else begin
        if(TimeCounter == 4'd0) begin
            case(state)
                S_green: 
                    begin 
                        state = S_yellow;
                        TimeCounter <= 4'd3;
                    end 
                S_yellow: 
                    begin
                        state = S_red;
                        TimeCounter <= 4'd15;
                    end
                S_red: 
                    begin
                    state = S_green;
                    TimeCounter <= 4'd10;
                    end
            endcase
        end
        else begin
            TimeCounter <= TimeCounter - 4'd1; 
        end
    end
end


//define dot_matrix display
always @(posedge clk_div2) begin

    if(state == S_green) begin 
        case(row_counter)
            3'd0:
                begin
                    dot_row <= 8'b01111111; 
                    dot_column <= 8'b00110000;
                end
            3'd1:
                begin
                    dot_row <= 8'b10111111; 
                    dot_column <= 8'b00110000;
                end
            3'd2:
                begin
                    dot_row <= 8'b11011111; 
                    dot_column <= 8'b10011000;
                end
            3'd3:
                begin
                    dot_row <= 8'b11101111; 
                    dot_column <= 8'b01111110;
                end
            3'd4:
                begin
                    dot_row <= 8'b11110111; 
                    dot_column <= 8'b00011001;
                end
            3'd5:
                begin
                    dot_row <= 8'b11111011; 
                    dot_column <= 8'b00011000;
                end
            3'd6:
                begin
                    dot_row <= 8'b11111101; 
                    dot_column <= 8'b00010100;
                end
            //row_counter == 3'd7
            default:
                begin
                    dot_row <= 8'b11111110; 
                    dot_column <= 8'b00010010;
                end
        endcase
    end
    else if(state == S_yellow) begin
        case(row_counter)
            3'd0:
                begin
                    dot_row <= 8'b01111111; 
                    dot_column <= 8'b00000000;
                end
            3'd1:
                begin
                    dot_row <= 8'b10111111; 
                    dot_column <= 8'b00100100;
                end
            3'd2:
                begin
                    dot_row <= 8'b11011111; 
                    dot_column <= 8'b00111100;
                end
            3'd3:
                begin
                    dot_row <= 8'b11101111; 
                    dot_column <= 8'b10111101;
                end
            3'd4:
                begin
                    dot_row <= 8'b11110111; 
                    dot_column <= 8'b11111111;
                end
            3'd5:
                begin
                    dot_row <= 8'b11111011; 
                    dot_column <= 8'b00111100;
                end
            3'd6:
                begin
                    dot_row <= 8'b11111101; 
                    dot_column <= 8'b00111100;
                end
            //row_counter == 3'd7
            default:
                begin
                    dot_row <= 8'b11111110; 
                    dot_column <= 8'b00000000;
                end
        endcase
    end
    // state == S_Red
    else begin
        case(row_counter)
            3'd0:
                begin
                    dot_row <= 8'b01111111; 
                    dot_column <= 8'b00011000;
                end
            3'd1:
                begin
                    dot_row <= 8'b10111111; 
                    dot_column <= 8'b00011000;
                end
            3'd2:
                begin
                    dot_row <= 8'b11011111; 
                    dot_column <= 8'b00111100;
                end
            3'd3:
                begin
                    dot_row <= 8'b11101111; 
                    dot_column <= 8'b00111100;
                end
            3'd4:
                begin
                    dot_row <= 8'b11110111; 
                    dot_column <= 8'b01011010;
                end
            3'd5:
                begin
                    dot_row <= 8'b11111011; 
                    dot_column <= 8'b00011000;
                end
            3'd6:
                begin
                    dot_row <= 8'b11111101; 
                    dot_column <= 8'b00011000;
                end
            //row_counter == 3'd7
            default:
                begin
                    dot_row <= 8'b11111110; 
                    dot_column <= 8'b00100100;
                end
        endcase
    end

    //問一下老大 why上次沒有寫這個會對
    if(row_counter == 3'd7) begin
        row_counter <= 3'd0;
    end
    else begin
        row_counter <= row_counter + 3'd1;
    end
end


//define Seven Display
always @(TimeCounter) begin
    case(TimeCounter)
		4'd0 : seven_display = 7'b1000000;
		4'd1 : seven_display = 7'b1111001;
		4'd2 : seven_display = 7'b0100100;
		4'd3 : seven_display = 7'b0110000;
		4'd4 : seven_display = 7'b0011001;
		4'd5 : seven_display = 7'b0010010;
		4'd6 : seven_display = 7'b0000010;
		4'd7 : seven_display = 7'b1111000;
		4'd8 : seven_display = 7'b0000000;
		4'd9 : seven_display = 7'b0010000;
		4'd10 : seven_display = 7'b0001000;
		4'd11 : seven_display = 7'b0000011;
		4'd12 : seven_display = 7'b1000110;
		4'd13 : seven_display = 7'b0100001;
		4'd14 : seven_display = 7'b0000110;
        //4'd15 --> default
		default : seven_display = 7'b0001110;
	endcase
end

endmodule

