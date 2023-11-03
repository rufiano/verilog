`timescale 1ns/1ns

// (a_re + i *b1_im) * ( a2_re + i * b2_im) 
`define A1_RE -8'sd3
`define B1_IM 8'sd9

`define A2_RE -8'sd10
`define B2_IM 8'sd4


module ymnoj(
input clk,
input signed [7 : 0] a,
input signed [7 : 0] b,
output signed [15 : 0] res);

reg signed res =0;

always @(posedge clk) begin
res <= a*b;
end
endmodule

module tb();


 reg clk = 0;

initial
    forever #5 clk = ~clk;
    
reg signed [7 : 0] a1 = 8'sd0;
reg signed [7 : 0] c1 = 8'sd0;


wire signed [15 : 0] res1;


ymnoj ymnoj (
	.clk(clk),
	.a(a1),
	.b(c1),
	.res(res1)
);

reg in_reg = 0;
reg odin_kompleks = 0;
reg dva_kompleks = 0;
reg tri_kompleks = 0; 
reg chet_kompleks = 0;
reg pyat_kompleks = 0;
reg signed [7 : 0] a1re = 0;
reg signed [7 : 0] b1im = 0;
reg signed [7 : 0] a2re = 0;
reg signed [7 : 0] b2im = 0;

initial
begin
    #15
    in_reg <= 1;
	a1re <= -8'sd3; // (a1re+b1im)*(a2re+b2im)=(a1re*a2re - b1im*b2im) + (a1re*b2im + b1im*a2re) = (30 - 36i^2) + (-12i + -90i)
	b1im <= 8'sd9;
	a2re <= -8'sd10;
	b2im <= 8'sd4;     	
	#10
    in_reg <=0;
	#20 
        a1re <= -8'sd8;
	b1im <= 8'sd5;
	a2re <= -8'sd12;
	b2im <= 8'sd2; 
in_reg <= 1;
#10
    in_reg <=0;
end

reg in_reg_d;
reg signed [15 : 0] k1 = 0;
reg signed [15 : 0] realC = 0;
reg signed [15 : 0] imagC = 0;
always @(posedge clk) begin

	odin_kompleks <= in_reg | tri_kompleks;
	dva_kompleks <= odin_kompleks;
	tri_kompleks <= dva_kompleks;
 	chet_kompleks <= tri_kompleks;

end

always @(posedge clk) begin
	if (in_reg) begin
	a1 <= a2re; // c*(a+b); a*(d-c) b*(c+d)
	c1 <= a1re + b1im;
	end
	if (odin_kompleks ) begin

	a1 <= a1re;
	c1 <= b2im - a2re;
	end
	if (dva_kompleks) begin
	k1 <= res1;
	a1 <= b1im;
	c1 <= b2im + a2re;
	end
	if (tri_kompleks) begin
	imagC <= k1 + res1;
	end
	if (chet_kompleks) begin
	realC <= k1 - res1;
	end
end

initial
begin
    $dumpfile("test.vcd");
    $dumpvars(0,tb);
end

endmodule
