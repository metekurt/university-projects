`timescale 1ns/1ns

module decoder2_4(y1,y0,i0,i1,i2,i3);
//Behavioral level verilog kod yazıldı
input y1, y0;
output reg i0, i1, i2, i3;

always@* begin

 if(y0==0 && y1==0)
  begin
  i3 <= 0; i2 <= 0; i1 <= 0; i0 <= 1;
  end
 else if(y0==1 && y1==0)
  begin
  i3 <= 0; i2 <= 0; i1 <= 1; i0 <= 0;
  end
 else if(y0==0 && y1==1)
  begin
  i3 <= 0; i2 <= 1; i1 <= 0; i0 <= 0;
  end
 else
  begin
  i3 <= 1; i2 <= 0; i1 <= 0; i0 <= 0;
  end

end
endmodule

///////////////////////////////////
//////////////////////////////////////

module mux8_1(y,m0,m1,m2,m3,m4,m5,m6,m7,s0,s1,s2);

input m0,m1,m2,m3,m4,m5,m6,m7;
input s0,s1,s2;
output reg y;

always@* begin

 if(s2==0 && s1==0 & s0==0 )
  y <= m0;
 else if( s2==0 && s1==0 & s0==1  )
  y <= m1;
 else if( s2==0 && s1==1 &  s0==0)
  y <= m2;
 else if( s2==0 && s1==1 &  s0==1)
  y <= m3;
 else if(s2==1  && s1==0 & s0==0 )
  y <= m4;
 else if( s2==1  && s1==0 & s0==1)
  y <= m5;
 else if(s2==1  && s1==1 & s0==0 )
  y <= m6;
 else
  y <= m7;

end

endmodule
////////////////////////////////////////

module source(y,x);

input wire [4:0] x;
output wire [0:0] y;


wire [3:0] temp;
decoder2_4  deca(x[1],x[0],temp[0],temp[1],temp[2],temp[3] );


wire not_e,not_d,ornot_ed,ornot_de;

not(not_e,x[0]);
not(not_d,x[1]);
or(ornot_ed,not_e,x[1]);
or(ornot_de,not_d,x[0]);




mux8_1  muxa(y,x[1],temp[2],temp[1],temp[1],ornot_ed,temp[1],not_d,ornot_de,x[2],x[3],x[4]);

endmodule

