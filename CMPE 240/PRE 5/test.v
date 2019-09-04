`timescale 1ns/1ns
module test();

wire [1:0] y;
wire [1:0] n;
wire [1:0] s;

reg clk;
initial clk = 1;
always #10 clk = ~clk;

reg reset;
initial reset = 1;

reg x;
initial x = 0;

mysource source(y, n, s, x, reset, clk);

initial begin
    $dumpfile("TimingDiagram.vcd");
    $dumpvars(0, y, n, s, x, reset, clk);

    #30
    reset = 0;

    x = 1;

    #25

    x = 1;

    #25

    x = 0;

    #25

  x = 1;

    #25

  x = 0;

    #25

  x = 0;

    #25

    x = 1;

    #25

    x = 1;

    #25

    x = 1;

    #85
    $finish;
end


endmodule
