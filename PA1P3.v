
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module PA1P3(

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// SW //////////
	input 		     [9:0]		SW
);



//=======================================================
//  REG/WIRE declarations
//=======================================================

wire [4:0]v;
wire z;
wire [3:0]out;
wire [3:0]dv1,dv0;
wire [3:0]s;
wire [3:1]c;


//=======================================================
//  Structural coding
//=======================================================
display displayA(.b3(SW[3]),.b2(SW[2]),.b1(SW[1]),.b0(SW[0]),.h(HEX4));
display displayB(.b3(SW[7]),.b2(SW[6]),.b1(SW[5]),.b0(SW[4]),.h(HEX5));

fulladder fa0(.b(SW[0]),.a(SW[4]),.c(SW[8]),.c_out(c[1]),.s(v[0]));
fulladder fa1(.b(SW[1]),.a(SW[5]),.c(c[1]),.c_out(c[2]),.s(v[1]));
fulladder fa2(.b(SW[2]),.a(SW[6]),.c(c[2]),.c_out(c[3]),.s(v[2]));
fulladder fa3(.b(SW[3]),.a(SW[7]),.c(c[3]),.c_out(v[4]),.s(v[3]));

comparator Comparator9(.v(v),.z(z)); 

multiplexer2_1 sub1(.v(4'b00000),.a(4'b00001),.z(z),.out(dv1));
multiplexer2_1 sub2(.v(4'b00000),.a(4'b00110),.z(z),.out(s));

subtract sub(.a(v),.b(s),.out(dv0));

display d0(.b3(dv0[3]), .b2(dv0[2]), .b1(dv0[1]), .b0(dv0[0]), .h(HEX0));
display d1(.b3(dv1[3]), .b2(dv1[2]), .b1(dv1[1]), .b0(dv1[0]), .h(HEX1));

endmodule

module subtract(input [4:0]a, b, output [3:0]out);

	assign out = a + b;

endmodule  


module comparator(input [4:0]v, output z);

	assign z = (v[4])||(v[3]&v[2])||(v[3]&v[1]);

endmodule

module multiplexer2_1(input [4:0] v, a, input z, output [3:0] out);

	assign out = z ? a: v;

endmodule

module display(input b3,b2,b1,b0, output [6:0] h);

	assign h[0] = (~b3&b2&~b1&~b0)||(~b3&~b2&~b1&b0);
	assign h[1] = (~b3&b2&~b1&b0)||(~b3&b2&b1&~b0);
	assign h[2] = (~b3&~b2&b1&~b0);
	assign h[3] = (~b3&b2&~b1&~b0)||(~b3&~b2&~b1&b0)||(~b3&b2&b1&b0);
	assign h[4] = (b0)||(b3&b1)||(b2&~b1);
	assign h[5] = (~b3&~b2&b0)||(~b3&b1&b0)||(~b3&~b2&b1);
	assign h[6] = (~b3&~b2&~b1)||(~b3&b2&b1&b0);

endmodule

module fulladder(input a,b,c, output s,c_out);

	assign c_out = (b&a)||(b&c)||(a&c);
	assign s = (~a&b&~c)||(a&~b&~c)||(~a&~b&c)||(a&b&c);

endmodule