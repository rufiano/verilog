`timescale 1ns/1ns


module tb();


reg clk_wr = 0;
reg clk_r = 0;


initial
    forever 
	begin
	#5 clk_wr = ~clk_wr;

	end
    
initial
    forever 
	begin
	#7 clk_r = ~clk_r;

	end

reg in_reg1 = 0;
reg empty = 0;
reg full = 0;

reg [7 : 0] data_in = 8'sd0;

reg [7 : 0] data_out = 8'sd0;
reg [7:0] mem [1023:0];
reg [10:0] point_wr =0, point_r = 0;

reg [10:0] point_wr_rclk_1reg =0, point_r_wrclk_1reg = 0;
reg [10:0] point_wr_rclk_2reg =0, point_r_wrclk_2reg = 0;
reg [10:0] point_wr_rclk_3reg =0, point_r_wrclk_3reg = 0;

reg wr_en = 0;
reg r_en = 0;

initial
begin
	#15
	in_reg1 <= 1;
	wr_en <= 1;
	r_en <= 1;
	data_in <= -8'sd3;
	
	#10
	data_in <= 8'sd9;
	in_reg1 <=0;
	#10
	data_in <= 8'sd4;  
	#10
	data_in <= -8'sd8; 
	#10
	data_in <= 8'sd11; 
	#10
	data_in <= 8'sd5;  
	#10
	r_en <= 0;
	data_in <= -8'sd8; 
	#10
	data_in <= 8'sd1; 
	#10
	data_in <= 8'sd12;  
	#10
	r_en <= 1;
	data_in <= -8'sd8; 
	#10
	data_in <= 8'sd2; 
	#10
	data_in <= -8'sd8; 
	#10
	data_in <= 8'sd11; 
	#10
	data_in <= 8'sd5;  
end

always @(posedge clk_wr) begin	
	if (wr_en && !full) begin
		mem[point_wr[9:0]] <= data_in;
		point_wr <= point_wr + 1;
	end
	
	point_r_wrclk_1reg <= point_r; // Регистры для исключения метастабильности
	point_r_wrclk_2reg <= point_r_wrclk_1reg;
	point_r_wrclk_3reg <= point_r_wrclk_2reg;
end

always @(posedge clk_r) begin	
	if (r_en && !empty) begin
		data_out <= mem[point_r[9:0]];
		point_r <= point_r + 1;
	end

	point_wr_rclk_1reg <= point_wr; // Регистры для исключения метастабильности
	point_wr_rclk_2reg <= point_wr_rclk_1reg;
	point_wr_rclk_3reg <= point_wr_rclk_2reg;
end

always @(*) begin

	if ((point_wr[9:0] == point_r_wrclk_3reg[9:0]) && (point_wr[10] != point_r_wrclk_3reg[10])) begin
	full = 1;
	end

	else begin
	full = 0;
	end

	if ((point_r[9:0] == point_wr_rclk_3reg[9:0]) && (point_r[10] == point_wr_rclk_3reg[10])) begin
	empty = 1; 
	end
	
	else begin
	empty =0;
	end
end



initial
begin
    $dumpfile("test.vcd");
    $dumpvars(0,tb);
end

integer idx; 
   initial 
   begin
     for (idx = 0; idx < 8; idx = idx + 1) $dumpvars(0, mem[idx]);
   end

endmodule