`timescale 1ns/1ns


module source(y,x,rst,clk);

output reg [2:0] y;
reg [3:0] s;

input wire x;
input wire rst;
input wire clk;

// Fill here
parameter S0 = 4'b0000,S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011,
	  S4 = 4'b0100, S5 = 4'b0101, S6 = 4'b0110, S7 = 4'b0111, S8 = 4'b1000, S9 = 4'b1001;
	  
initial begin

	y <= 3'b000;
	s <= S0;

end
	  
always @(s) begin

	case(s)

		S3: y <= 3'b001;

		S5: y <= 3'b010;
		S7: y <= 3'b011;
		S9: y <= 3'b111;

		default: y <= 3'b000;

	endcase

end


always @(posedge clk) begin

	if(rst == 1'b1) begin

		s <= S0;

	end

	else begin

		if(s == S0) begin

			if(x == 1'b1) begin

				s <= S1;

			end

			else begin

				s <= S0;

			end

		end

		else if(s == S1) begin

			if(x == 1'b1) begin

				s <= S1;

			end

			else begin

				s <= S2;

			end

		end

		else if(s == S2) begin

			if(x == 1'b1) begin

				s <= S3;

			end

			else begin

				s <= S4;

			end

		end
		else if(s == S3) begin

			if(x == 1'b1) begin

				s <= S1;

			end

			else begin

				s <= S0;

			end

		end
		else if(s == S4) begin

			if(x == 1'b1) begin

				s <= S5;

			end

			else begin

				s <= S6;

			end

		end
		else if(s == S5) begin

			if(x == 1'b1) begin

				s <= S1;

			end

			else begin

				s <= S0;

			end

		end
		else if(s == S6) begin

			if(x == 1'b1) begin

				s <= S7;

			end

			else begin

				s <= S8;

			end

		end
		
		else if(s == S7) begin

			if(x == 1'b1) begin

				s <= S1;

			end

			else begin

				s <= S0;

			end

		end
		
		else if(s == S8) begin

			if(x == 1'b1) begin

				s <= S9;

			end

			else begin

				s <= S8;

			end

		end

		else if(s == S9)begin

			if(x == 1'b1) begin

				s <= S1;

			end

			else begin

				s <= S0;

			end

		end

	end

end




endmodule