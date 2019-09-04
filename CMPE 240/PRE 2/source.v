`timescale 1ns / 1ns
module source(y, x);

input wire [3:0] x;
output wire [0:0] y;

// Fill here with gate level verilog code

	wire not_p;
	
	wire randnp;
	wire gorc;
	wire gandc;
	wire secand;
	
	not(not_p, x[0]);   
	and(randnp, not_p, x[3]);
	or(gorc, x[1], x[2]);
	and(gandc, x[1], x[2]);
	and(secand, randnp, gorc);
	or(y, secand, gandc);

endmodule