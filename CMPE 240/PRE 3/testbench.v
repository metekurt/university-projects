`timescale 1ns / 1ns

module testbench();

reg [4:0] x;
wire [0:0] y;
source s(y, x);

initial begin
    $dumpfile("TimingDiagram.vcd");
    $dumpvars(0, y, x);
    
    // Fill Here
    x = 5'b00000;
    #20 
	x = 5'b00001;
    #20
	x = 5'b00010;
    #20 
	x = 5'b00011;
    #20 
	x = 5'b00100;
    #20 
	x = 5'b00101;
    #20
	x = 5'b00110;
    #20 
	x = 5'b00111;
    #20
	x = 5'b01000;
    #20 
	x = 5'b01001;
    #20 
	x = 5'b01010;
    #20
	x = 5'b01011;
    #20 
	x = 5'b01100;
    #20
	x = 5'b01101;
    #20 
	x = 5'b01110;
    #20 
	x = 5'b01111;
    #20
	x = 5'b10000;
    #20 
	x = 5'b10001;
    #20 
	x = 5'b10010;
    #20 
	x = 5'b10011;
    #20
	x = 5'b10100;
    #20 
	x = 5'b10101;
    #20 
	x = 5'b10110;
    #20 
	x = 5'b10111;
    #20
	x = 5'b11000;
    #20 
	x = 5'b11001;
    #20
	x = 5'b11010;
    #20 
	x = 5'b11011;
    #20
	x = 5'b11100;
    #20
	x = 5'b11101;
    #20 
	x = 5'b11110;
    #20 
	x = 5'b11111;
    #20

    $finish;
end
endmodule