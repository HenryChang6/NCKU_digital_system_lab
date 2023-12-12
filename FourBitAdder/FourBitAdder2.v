module lab2(
    input [3:0] a,
    input [3:0] b,
    input select,
    output reg [3:0] out,
    output reg overflow
);

always @(a, b, select)
begin
    if (select) 
    begin
        // 加法
        {overflow, out} = a + b;
    end 
    else 
    begin
        // 減法
        {overflow, out} = a - b;
    end
end

