// define top module
module main(input clk, input reset, input in, output [6:0]out);

wire [2:0] mm_out;
wire clk_div;

frequency_divider fd(
    .clk(clk),
    .reset(reset),
    .clk_div(clk_div),
);

moore_machine mm(
    .clk_div(clk_div),
    .in(in),
    .reset(reset),
    .out(mm_out),
);

seven_display sd(
    .tmp(mm_out),
    .out(out),
);

endmodule


// define Frequency Divider
module frequency_divider(input wire clk, input wire reset, output reg clk_div);
reg [31:0] TimeCounter;
parameter TimeExpire = 32'd25000000;

always @(posedge clk) begin
    if(!reset) begin
        TimeCounter <= 32'd0;
        clk_div <= 1'd0;
    end
    else begin
        if(TimeCounter == TimeExpire) begin
            TimeCounter <= 32'd0;
            clk_div <= ~clk_div;
        end
        else begin
            TimeCounter <= TimeCounter + 32'd1;
        end
    end
end

endmodule



// define moore_machine
module moore_machine(input wire clk_div, input wire in, input wire reset, output reg [2:0]out);
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
parameter S5 = 3'b101;
always @(posedge clk_div or negedge reset) begin
    if(!reset) begin
        out <= S0;
    end
    else begin
        case(out)
            S0: out <= in ? S3 : S1;
            S1: out <= in ? S5 : S2;
            S2: out <= in ? S0 : S3;
            S3: out <= in ? S1 : S4;
            S4: out <= in ? S5 : S2;
            default: out <= in ? S4 : S0;
        endcase
    end
            
end

endmodule



// define Seven Display
module seven_display(input wire [2:0] tmp, output reg[6:0] out);
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
parameter S5 = 3'b101;
always @(*) begin
    case(tmp)
        S0: out = 7'b1000000;
        S1: out = 7'b1111001;
        S2: out = 7'b0100100;
        S3: out = 7'b0110000;
        S4: out = 7'b0011001;
        default: out = 7'b0010010;
    endcase
end

endmodule
