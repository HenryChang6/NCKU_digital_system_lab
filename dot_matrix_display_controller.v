module main(input wire clk, input wire reset, output reg [7:0] dot_row, output reg [7:0] dot_column);
wire clk_div;

    frequency_divider fd(
        .clk(clk),
        .reset(reset),
        .clk_div(clk_div),
    );
    
    controller con(
        .clk(clk_div),
        .reset(reset),
    );
endmodule




// define Frequency Divider
module frequency_divider(input wire clk, input wire reset, output reg clk_div);
reg [31:0] TimeCounter;

always @(posedge clk) begin
    if(!reset) begin
        TimeCounter <= 32'd0;
        clk_div <= 1'd0;
    end
    else begin
        if(TimeCounter == 32'd2500) begin
            TimeCounter <= 32'd0;
            clk_div <= ~clk_div;
        end
        else begin
            TimeCounter <= TimeCounter + 32'd1;
        end
    end
end

endmodule




// define controller 
module controller(input wire clk, input wire reset, output reg [7:0] dot_row, output reg [7:0] dot_column);
reg [2:0]row_counter;

always @(posedge clk or negedge reset) begin 
    if(!reset) begin
        row_counter <= 3'b0;
        dot_row <= 8'b0;
        dot_column <= 8'b1;
    end
    else begin
        row_counter <= row_counter + 3'b001;
        case(row_counter)
             3'd0: 
				 begin
                dot_row <= 8'b01111111; 
                dot_column <= 8'b00011000;
			    end
             3'd1:
				 begin 
                dot_row <= 8'b10111111;
                dot_column <= 8'b00100100;
				 end
             3'd2:
				 begin
                 dot_row <= 8'b11011111;
                 dot_column <= 8'b01000010;
				 end
             3'd3:
				 begin
                 dot_row <= 8'b11101111;
                 dot_column <= 8'b11000011;
				 end
             3'd4: 
				 begin
                 dot_row <= 8'b11110111;
                 dot_column <= 8'b01000010;
				 end
             3'd5:
				 begin
                 dot_row <= 8'b11111011;
                 dot_column <= 8'b01000010;
				 end
             3'd6:
				 begin
                 dot_row <= 8'b11111101;
                 dot_column <= 8'b01000010;
				 end
             default:
				 begin
                 dot_row <= 8'b11111110;
                 dot_column <= 8'b01111110;
				 end
        endcase
    end
end

endmodule
