`timescale 1ns / 1ns
module testbench();

reg [3:0] x;
wire [0:0] y;

source s(y, x);

initial begin
    $dumpfile("TimingDiagram.vcd");
    $dumpvars(0, y, x);
    
    // Fill here
	x=4'b0000;

	#20 x=4'b0001;	
	
	 #20 x=4'b0010;
	
	#20 x=4'b0011;
	
	#20 x=4'b0100;
	
	#20 x=4'b0101;
	
    #20	x=4'b0110;
	
	#20 x=4'b0111;
	
	#20 x=4'b1000;
	
#20	x=4'b1001;
	
#20	x=4'b1010;
	
#20	x=4'b1011;
	
#20	x=4'b1100;
	
#20	x=4'b1101;
	
#20	x=4'b1110;
	
#20	x=4'b1111;
	
#20	;
    
    $finish;
end

endmodule
