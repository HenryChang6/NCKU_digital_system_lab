module lab2(
    input [3:0] a,
    input [3:0] b,
    input select,
    output [3:0] out,
    output overflow
);
    wire [4:0] sum;
    wire [4:0] sub;
    
    // 加法
    assign sum = a + b;
    // 減法
    assign sub = a - b;
    
    // 選擇加法或減法
    assign out = select ? sum[3:0] : sub[3:0];
    
    // 檢查溢位
    assign overflow = (select && sum[4]) || (!select && sub[4]);
endmodule

