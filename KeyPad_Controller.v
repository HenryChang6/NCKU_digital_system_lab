module KeyPad_Controller(clock, reset, dot_row, dot_column,keypadCol);
input clock, reset, [3:0]keypadCol; 
output [7:0]dot_row, [7:0]dot_column, [3:0]keypadRow;
reg [31:0]keypadDelay, [31:0]DotFD_Counter;
reg [3:0] keypadBuf;
reg DotFD_Clock;
reg [2:0]row_counter;

always @(posedge clk) begin
    if(!reset) begin
        DotFD_Counter <= 32'd0;
        DotFD_Clock <= 1'd0;
    end
    else begin
        if(DotFD_Counter == 32'd2500) begin
            DotFD_Counter <= 32'd0;
            DotFD_Clock <= ~DotFD_Clock;
        end
        else begin
            DotFD_Counter <= DotFD_Counter + 32'd1;
        end
    end
end

always @(posedge clock) begin
    if(!reset) begin
        keypadBuf <= 4'h0;
        keypadRow <= 4'd1110;
    end
    else begin 
        if(keypadDelay == d'250000) begin
            keypadDelay <= 32'd0;
            //判斷哪個當前的row哪個column被按下了
            case({keypadRow,keypadCol}) 
                8'b1110_1110: keypadBuf <= 4'h7;
                8'b1110_1101: keypadBuf <= 4'h4;
                8'b1110_1011: keypadBuf <= 4'h1;
                8'b1110_0111: keypadBuf <= 4'h0;

                8'b1101_1110: keypadBuf <= 4'h8;
                8'b1101_1101: keypadBuf <= 4'h5;
                8'b1101_1011: keypadBuf <= 4'h2;
                8'b1101_0111: keypadBuf <= 4'hA;

                8'b1011_1110: keypadBuf <= 4'h9;
                8'b1011_1101: keypadBuf <= 4'h6;
                8'b1011_1011: keypadBuf <= 4'h3;
                8'b1011_0111: keypadBuf <= 4'hb;

                8'b0111_1110: keypadBuf <= 4'hc;
                8'b0111_1101: keypadBuf <= 4'hd;
                8'b0111_1011: keypadBuf <= 4'he;
                8'b0111_0111: keypadBuf <= 4'hf;
                default: keypadBuf <= keypadBuf;
            endcase
            //切換到下一個row
            case(keypadRow)
                4'b1110: keypadRow <= 4'b1101;
                4'b1101: keypadRow <= 4'b1011;
                4'b1011: keypadRow <= 4'b0111;
                4'b0111: keypadRow <= 4'b1110;
                default: keypadRow <= 4'b1110;
            endcase
        end
        else begin
            keypadDelay <= keypadDelay + 32'd1;
        end
    end
end

always @(posedge DotFD_Clock or negedge reset) begin
    if(!reset) begin
        dot_row <= 8'b0;
        dot_column <= 8'b0;
        row_counter <= 3'd0;
    end
    else begin 
        row_counter <= row_counter + 3'd1;
        case(row_counter) 
            3'd0: dot_row <= 8'b01111111;
            3'd1: dot_row <= 8'b10111111;
            3'd2: dot_row <= 8'b11011111;
            3'd3: dot_row <= 8'b11101111;
            3'd4: dot_row <= 8'b11110111;
            3'd5: dot_row <= 8'b11111011;
            3'd6: dot_row <= 8'b11111101;
            3'd7: dot_row <= 8'b10111110;
        endcase
        case(keypadBuf)
            4'h7:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00000000;
                    3'd1: dot_coulumn <= 8'b00000000;
                    3'd2: dot_coulumn <= 8'b00000000;
                    3'd3: dot_coulumn <= 8'b00000000;
                    3'd4: dot_coulumn <= 8'b00000000;
                    3'd5: dot_coulumn <= 8'b00000000;
                    3'd6: dot_coulumn <= 8'b00000011;
                    3'd7: dot_coulumn <= 8'b00000011;
                endcase
            4'h4:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00000000;
                    3'd1: dot_coulumn <= 8'b00000000;
                    3'd2: dot_coulumn <= 8'b00000000;
                    3'd3: dot_coulumn <= 8'b00000000;
                    3'd4: dot_coulumn <= 8'b00000000;
                    3'd5: dot_coulumn <= 8'b00000000;
                    3'd6: dot_coulumn <= 8'b00001100;
                    3'd7: dot_coulumn <= 8'b00001100;
                endcase
            4'h1:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00000000;
                    3'd1: dot_coulumn <= 8'b00000000;
                    3'd2: dot_coulumn <= 8'b00000000;
                    3'd3: dot_coulumn <= 8'b00000000;
                    3'd4: dot_coulumn <= 8'b00000000;
                    3'd5: dot_coulumn <= 8'b00000000;
                    3'd6: dot_coulumn <= 8'b00110000;
                    3'd7: dot_coulumn <= 8'b00110000;
                endcase
            4'h0:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00000000;
                    3'd1: dot_coulumn <= 8'b00000000;
                    3'd2: dot_coulumn <= 8'b00000000;
                    3'd3: dot_coulumn <= 8'b00000000;
                    3'd4: dot_coulumn <= 8'b00000000;
                    3'd5: dot_coulumn <= 8'b00000000;
                    3'd6: dot_coulumn <= 8'b11000000;
                    3'd7: dot_coulumn <= 8'b11000000;
                endcase
            4'h8:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00000000;
                    3'd1: dot_coulumn <= 8'b00000000;
                    3'd2: dot_coulumn <= 8'b00000000;
                    3'd3: dot_coulumn <= 8'b00000000;
                    3'd4: dot_coulumn <= 8'b00000011;
                    3'd5: dot_coulumn <= 8'b00000011;
                    3'd6: dot_coulumn <= 8'b00000000;
                    3'd7: dot_coulumn <= 8'b00000000;
                endcase
            4'h5:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00000000;
                    3'd1: dot_coulumn <= 8'b00000000;
                    3'd2: dot_coulumn <= 8'b00000000;
                    3'd3: dot_coulumn <= 8'b00000000;
                    3'd4: dot_coulumn <= 8'b00001100;
                    3'd5: dot_coulumn <= 8'b00001100;
                    3'd6: dot_coulumn <= 8'b00000000;
                    3'd7: dot_coulumn <= 8'b00000000;
                endcase
            4'h2:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00000000;
                    3'd1: dot_coulumn <= 8'b00000000;
                    3'd2: dot_coulumn <= 8'b00000000;
                    3'd3: dot_coulumn <= 8'b00000000;
                    3'd4: dot_coulumn <= 8'b00110000;
                    3'd5: dot_coulumn <= 8'b00110000;
                    3'd6: dot_coulumn <= 8'b00000000;
                    3'd7: dot_coulumn <= 8'b00000000;
                endcase
            4'ha:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00000000;
                    3'd1: dot_coulumn <= 8'b00000000;
                    3'd2: dot_coulumn <= 8'b00000000;
                    3'd3: dot_coulumn <= 8'b00000000;
                    3'd4: dot_coulumn <= 8'b11000000;
                    3'd5: dot_coulumn <= 8'b11000000;
                    3'd6: dot_coulumn <= 8'b00000000;
                    3'd7: dot_coulumn <= 8'b00000000;
                endcase
            4'h9:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00000000;
                    3'd1: dot_coulumn <= 8'b00000000;
                    3'd2: dot_coulumn <= 8'b00000011;
                    3'd3: dot_coulumn <= 8'b00000011;
                    3'd4: dot_coulumn <= 8'b00000000;
                    3'd5: dot_coulumn <= 8'b00000000;
                    3'd6: dot_coulumn <= 8'b00000000;
                    3'd7: dot_coulumn <= 8'b00000000;
                endcase
            4'h6:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00000000;
                    3'd1: dot_coulumn <= 8'b00000000;
                    3'd2: dot_coulumn <= 8'b00001100;
                    3'd3: dot_coulumn <= 8'b00001100;
                    3'd4: dot_coulumn <= 8'b00000000;
                    3'd5: dot_coulumn <= 8'b00000000;
                    3'd6: dot_coulumn <= 8'b00000000;
                    3'd7: dot_coulumn <= 8'b00000000;
                endcase
            4'h3:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00000000;
                    3'd1: dot_coulumn <= 8'b00000000;
                    3'd2: dot_coulumn <= 8'b00110000;
                    3'd3: dot_coulumn <= 8'b00110000;
                    3'd4: dot_coulumn <= 8'b00000000;
                    3'd5: dot_coulumn <= 8'b00000000;
                    3'd6: dot_coulumn <= 8'b00000000;
                    3'd7: dot_coulumn <= 8'b00000000;
                endcase
            4'hb:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00000000;
                    3'd1: dot_coulumn <= 8'b00000000;
                    3'd2: dot_coulumn <= 8'b11000000;
                    3'd3: dot_coulumn <= 8'b11000000;
                    3'd4: dot_coulumn <= 8'b00000000;
                    3'd5: dot_coulumn <= 8'b00000000;
                    3'd6: dot_coulumn <= 8'b00000000;
                    3'd7: dot_coulumn <= 8'b00000000;
                endcase
            4'hc:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00000011;
                    3'd1: dot_coulumn <= 8'b00000011;
                    3'd2: dot_coulumn <= 8'b00000000;
                    3'd3: dot_coulumn <= 8'b00000000;
                    3'd4: dot_coulumn <= 8'b00000000;
                    3'd5: dot_coulumn <= 8'b00000000;
                    3'd6: dot_coulumn <= 8'b00000000;
                    3'd7: dot_coulumn <= 8'b00000000;
                endcase
            4'hd:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00001100;
                    3'd1: dot_coulumn <= 8'b00001100;
                    3'd2: dot_coulumn <= 8'b00000000;
                    3'd3: dot_coulumn <= 8'b00000000;
                    3'd4: dot_coulumn <= 8'b00000000;
                    3'd5: dot_coulumn <= 8'b00000000;
                    3'd6: dot_coulumn <= 8'b00000000;
                    3'd7: dot_coulumn <= 8'b00000000;
                endcase
            4'he:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b00110000;
                    3'd1: dot_coulumn <= 8'b00110000;
                    3'd2: dot_coulumn <= 8'b00000000;
                    3'd3: dot_coulumn <= 8'b00000000;
                    3'd4: dot_coulumn <= 8'b00000000;
                    3'd5: dot_coulumn <= 8'b00000000;
                    3'd6: dot_coulumn <= 8'b00000000;
                    3'd7: dot_coulumn <= 8'b00000000;
                endcase
            4'hf:
                case(row_counter)
                    3'd0: dot_coulumn <= 8'b11000000;
                    3'd1: dot_coulumn <= 8'b11000000;
                    3'd2: dot_coulumn <= 8'b00000000;
                    3'd3: dot_coulumn <= 8'b00000000;
                    3'd4: dot_coulumn <= 8'b00000000;
                    3'd5: dot_coulumn <= 8'b00000000;
                    3'd6: dot_coulumn <= 8'b00000000;
                    3'd7: dot_coulumn <= 8'b00000000;
                endcase
        endcase
    end
end

endmodule
