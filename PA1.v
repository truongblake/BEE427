
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module PA1(

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	//////////// SW //////////
	input 		     [3:0]		SW
);



//=======================================================
//  REG/WIRE declarations
//=======================================================

wire a3,a2,a1,a0,z,out0,out1,out2,out3;


//=======================================================
//  Structural coding
//=======================================================

circuitA Ca(.v3(SW[3]), .v2(SW[2]), .v1(SW[1]), .v0(SW[0]), .a3(a3),.a2(a2),.a1(a1),.a0(a0));
comparator Comparator9(.v3(SW[3]), .v2(SW[2]), .v1(SW[1]), .v0(SW[0]),.z(z)); 
multiplexer2_1(
.v3(SW[3]), .v2(SW[2]), .v1(SW[1]), .v0(SW[0]), 
.a3(a3),.a2(a2),.a1(a1),.a0(a0),
.z(z),
.out3(out3),.out2(out2),.out1(out1),.out0(out0));

display d0(.b3(out3), .b2(out2), .b1(out1), .b0(out0), .h(HEX0));
display d1(.b3(0), .b2(0), .b1(0), .b0(z), .h(HEX1));


endmodule

module display(input b3,b2,b1,b0, output [6:0] h);

assign h[0] = (b2&~b1&~b0)||(~b3&~b2&~b1&b0);
assign h[1] = (b2&~b1&b0)||(b2&b1&~b0);
assign h[2] = (~b2&b1&~b0);
assign h[3] = (b2&~b1&~b0)||(b2&b1&b0)||(~b3&~b2&~b1&b0);
assign h[4] = b0 || (b2&~b1);
assign h[5] = (~b2&b1)||(b1&b0)||(~b3&~b2&b0);
assign h[6] = (~b3&~b2&~b1)||(b2&b1&b0);

endmodule

module circuitA(input v3,v2,v1,v0, output a3,a2,a1,a0);

assign a3 = 0;
assign a2 = v2 & v1;
assign a1 = ~v1;
assign a0 = v0;

endmodule

module comparator(input v3,v2,v1,v0, output z);

assign z = (v3&v2)||(v3&v1);

endmodule

module multiplexer2_1(input v3,v2,v1,v0,a3,a2,a1,a0,z, output out3,out2,out1,out0);

assign out3 = (v3&~z)||(a3&z);
assign out2 = (v2&~z)||(a2&z);
assign out1 = (v1&~z)||(a1&z);
assign out0 = (v0&~z)||(a0&z);

endmodule