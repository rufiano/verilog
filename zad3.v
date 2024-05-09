`timescale 1ns/1ns

// yk+1 = a * yk + b * x k+1

module multi(
input clk,
input signed [7 : 0] a,
input signed [23 : 0] b,
output signed [31 : 0] resz,
output signed [31 : 0] res);
reg signed res =0;
reg signed resz =0;
always @(posedge clk) begin

res <= a*b;
resz <= res;
end
endmodule

module multi2(
input clk,
input signed [63 : 0] a,
input signed [23 : 0] b,
output signed [63 : 0] resz,
output signed [63 : 0] res);
reg signed res =0;
reg signed resz =0;
always @(posedge clk) begin

res <= a*b;
resz <= res;
end
endmodule

module tb();


 reg clk = 0;

initial
    forever #5 clk = ~clk;
    

wire signed [31 : 0] resb;
wire signed [31 : 0] resab;
wire signed [31 : 0] resaab;
wire signed [63 : 0] resaaa;

// y(n) = a1^3 * y(n - 3) + a^2 * b * x(n - 2) + a * b * x(n - 1) + b * x(n)
multi multib(
	.clk(clk),
	.a(x),
	.b(bk),
	.resz(resb)
);

multi multiab (
	.clk(clk),
	.a(x1),
	.b(ab),
	.resz(resab)
);

multi multiaab (
	.clk(clk),
	.a(x2),         
	.b(a2b),
	.resz(resaab)
);

multi2 multiaaa (
	.clk(clk),
	.a(y),
	.b(aaa),
	.resz(resaaa)
);

reg in_reg1 = 0;


reg signed [7 : 0] x = 8'sd0;
reg signed [7 : 0] x1 = 8'sd0;
reg signed [7 : 0] x2 = 8'sd0;
reg signed [7 : 0] x3 = 8'sd0;

reg signed [23 : 0] ak = 8'sd2; // a
reg signed [23 : 0] bk = -8'sd4; // b
reg signed [23 : 0] aaa = 8'sd8; // a^3
reg signed [23 : 0] a2b = -8'sd16; // a^2*b
reg signed [23 : 0] ab = -8'sd8;  // a*b

initial
begin
	#15
	in_reg1 <= 1;
	x <= -8'sd3;
	
	#10
	x <= 8'sd9;
	in_reg1 <=0;
	#10
	x <= 8'sd4;  
	#10
	x <= -8'sd8; 
	#10
	x <= 8'sd11; 
	#10
	x <= 8'sd5;  
	#10
	x <= -8'sd8; 
	#10
	x <= 8'sd1; 
	#10
	x <= 8'sd12;  
	#10
	x <= -8'sd8; 
	#10
	x <= 8'sd2; 
	#10
	x <= -8'sd8; 
	#10
	x <= 8'sd11; 
	#10
	x <= 8'sd5;  
end

reg signed [63 : 0] y = 0;
// yk+1 = a1*yk + b*xk1
// y(n) = a1^3 * y(n - 3) + a^2 * b * x(n - 2) + a * b * x(n - 1) + b * x(n)
always @(posedge clk) begin	
	x1 <= x;	
	x2 <= x1;
	x3 <= x2;
	//
	y <= resb + resab + resaab + resaaa;
end

initial
begin
    $dumpfile("test.vcd");
    $dumpvars(0,tb);
end

endmodule
