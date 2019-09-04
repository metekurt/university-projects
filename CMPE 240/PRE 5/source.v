`timescale 1ns/1ns
module mysource(y,n,s,x,reset,clk);

output reg [1:0] y;
output reg [1:0] n;
output reg [1:0] s;

input wire x;
input wire reset;
input wire clk;


//comb logic
always @(s, x) begin
    case (s)
        2'b00:
        begin
            if ({x} == 1'b0)
                begin
                    n <= 2'b10;
                    y <= 2'b10;
                end
            else
                begin
                    n <= 2'b00;
                    y <= 2'b11;
                end
        end
        2'b01:
        begin
            if ({x} == 1'b0)
                begin
                    n <= 2'b10;
                    y <= 2'b10;
                end
            else
                begin
                    n <= 2'b00;
                    y <= 2'b11;
                end
        end
        2'b10:
        begin
            if ({x} == 1'b0)
                begin
                    n <= 2'b10;
                    y <= 2'b10;
                end
            else
                begin
                    n <= 2'b11;
                    y <= 2'b10;
                end
        end
        2'b11:
        begin
            if ({x} == 1'b0)
                begin
                    n <= 2'b10;
                    y <= 2'b11;
                end
            else
                begin
                    n <= 2'b11;
                    y <= 2'b01;
                end
        end
    endcase
end

always @(posedge clk) begin
    if (reset)
        s <= 2'b00;
    else
        s <= n;
end

endmodule
