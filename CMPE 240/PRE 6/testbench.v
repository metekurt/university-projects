`timescale 1ns/1ns
module testbench();

reg [4:0]x;
reg [4:0]y;
reg [1:0]s;
wire [4:0]f;
reg [0:0]cin;
wire cout;


source ss(.x(x),.y(y),.s(s), .f(f), .cout(cout), .cin(cin));

initial begin
    $dumpfile("TimingDiagram.vcd");
    $dumpvars(0, x,y,s,f,cout,cin);

	s = 2'b00;
	    cin = 1'b0;
		
        x = 5'b10010;
        y = 5'b00010;
	
	#20
	s = 2'b01;
        x = 5'b10100;
        y = 5'b00111;
		
	
	#20
	s = 2'b10;
        x = 5'b01010;
        y = 5'b01111;
	
	#20
	s = 2'b11;
	    cin = 1'b1;
		#10
		cin = 1'b0;
		#10
        x = 5'b00010;
        y = 5'b01110;
		
		#10
		
	s = 2'b00;	
	#20
    $finish;
end

endmodule