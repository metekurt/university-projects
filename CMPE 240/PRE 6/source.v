`timescale 1ns/1ns


module source(x,y,s,f,cout,cin);


input [0:0]cin;
input [4:0]x;
input [4:0]y;
input [1:0]s;
output reg [4:0]f;
output reg cout;


reg [4:0]tmp_y;
reg [4:0]temp;


always @(x,y,s,cin) begin
	if(s == 2'b00) begin
		cout = x <= y;
		f = 5'b00000;
		
	end
	else if(s == 2'b01) begin
		
		tmp_y[0] = y[1];
        tmp_y[1] = y[2];
        tmp_y[2] = y[2];
        tmp_y[3] = y[2];
        tmp_y[4] = y[2];
		
		
		{cout, f} = x * tmp_y;
		
	end
	else if(s == 2'b10) begin
	
		{cout, f} = x[4:2] * y[2:0];
		
		
	end
	else begin
	    if (cin == 1'b1)begin
		
		temp = ~y + 5'b00001;
		
		{cout, f} = x + temp + 5'b00001;
		end
		else
		{cout, f} = x + temp;
	end
end



endmodule