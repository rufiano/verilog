`timescale 1ns/1ns

// y=x1*r1+x2*r2+x3*r3

module ymnoj(
input clk,
input signed [7 : 0] a,
input signed [7 : 0] b,
output signed [17 : 0] res);

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

reg signed [7 : 0] a2 = 8'sd0;
reg signed [7 : 0] c2 = 8'sd0;

wire signed [17 : 0] res1;
wire signed [17 : 0] res2;

ymnoj ymnoj1 (
	.clk(clk),
	.a(a1),
	.b(c1),
	.res(res1)
);

ymnoj ymnoj2 (
	.clk(clk),
	.a(a2),
	.b(c2),
	.res(res2)
);

reg in_reg = 0;
reg odin_kompleks = 0;
reg dva_kompleks = 0;
reg tri_kompleks = 0; 
reg chet_kompleks = 0;
reg pyat_kompleks = 0;

reg signed [7 : 0] x = 8'sd0;
reg signed [7 : 0] x1 = 8'sd0;
reg signed [7 : 0] x2 = 8'sd0;
reg signed [7 : 0] x3 = 8'sd0;

reg signed [7 : 0] r1 = 8'sd2;
reg signed [7 : 0] r2 = -8'sd4;
reg signed [7 : 0] r3 = 8'sd7;


initial
begin
    #15
    in_reg <= 1;
	x <= -8'sd3;
		
	#10
    in_reg <=0;
    
	#90
	in_reg <= 1;
	x <= 8'sd9;
	
	#10
	in_reg <=0;
	
	#90
	in_reg <= 1;
	x <= 8'sd4;  
	
	#10
	in_reg <=0;
	
	#90
	in_reg <= 1;
	x <= -8'sd8; 
	
	#10
	in_reg <=0;
	
	#90
	in_reg <= 1;
	x <= 8'sd2; 
	
	#10
	in_reg <=0;
end

reg in_reg_d;
reg signed [17 : 0] k1 = 0;
reg signed [17 : 0] y = 0;
always @(posedge clk) begin

	odin_kompleks <= in_reg;
	dva_kompleks <= odin_kompleks;
	tri_kompleks <= dva_kompleks;
 	chet_kompleks <= tri_kompleks;

end

// y=x1*r1+x2*r2+x3*r3
always @(posedge clk) begin
	if (in_reg) begin
	x1 <= x;
	x2 <= x1;
	x3 <= x2;
	end
	if (odin_kompleks ) begin

	a1 <= x1;
	c1 <= r1;
	a2 <= x2;
	c2 <= r2;

	end
	if (dva_kompleks) begin
	a1 <= x3;
	c1 <= r3;
	end
	if (tri_kompleks) begin
	k1 <= res1 + res2;
	end
	if (chet_kompleks) begin
	y <= k1 + res1;
	end

end

initial
begin
    $dumpfile("test.vcd");
    $dumpvars(0,tb);
end

endmodule
