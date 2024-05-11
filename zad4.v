`timescale 1ns/1ns

module tb();

reg clk = 0;
initial
    forever 
	begin
	#5 clk = ~clk;
	end
    
reg CS = 0;
reg miso;
output reg [31:0] data_out;
output reg [23:0] address_out;
output reg wr_en_out;

reg [5:0] bit_count = 6'd0;
reg [7:0] command_wr_en = 8'd255; 
reg [63:0] mem;

initial
begin
	#15
	CS <= 1;
	#10
	miso = 1'b1; // №0 бит
	#10 
	miso = 1'b0; // №1 бит
	#10
	miso = 1'b1; // №2 бит
	#10
	miso = 1'b1; // №3 бит
	#10
	miso = 1'b0; // №4 бит
	#10
	miso = 1'b1; // №5 бит
	#10
	miso = 1'b0; // №6 бит
	#10
	miso = 1'b1; // №7 бит 
	#10
	miso = 1'b1; // №8 бит
	#10
	miso = 1'b0; // №9 бит
	#10
	miso = 1'b1; // №10 бит
	#10
	miso = 1'b1; // №11 бит
	#10
	miso = 1'b0; // №12 бит
	#10
	miso = 1'b1; // №13 бит
	#10
	miso = 1'b0; // №14 бит
	#10
	miso = 1'b1; // №15 бит
	#10
	miso = 1'b1; // №16 бит
	#10
	miso = 1'b0; // №17 бит
	#10
	miso = 1'b1; // №18 бит
	#10
	miso = 1'b1; // №19 бит
	#10
	miso = 1'b0; // №20 бит
	#10
	miso = 1'b1; // №21 бит
	#10
	miso = 1'b0; // №22 бит
	#10
	miso = 1'b1; // №23 бит
	#10
	miso = 1'b1; // №24 бит
	#10
	miso = 1'b0; // №25 бит
	#10
	miso = 1'b1; // №26 бит
	#10
	miso = 1'b1; // №27 бит
	#10
	miso = 1'b0; // №28 бит
	#10
	miso = 1'b1; // №29 бит
	#10
	miso = 1'b0; // №30 бит
	#10
	miso = 1'b1; // №31 бит конец адресса 
	#10
	miso = 1'b1; // №32 бит 
	#10
	miso = 1'b0; // №33 бит
	#10
	miso = 1'b1; // №34 бит
	#10
	miso = 1'b1; // №35 бит
	#10
	miso = 1'b0; // №36 бит
	#10
	miso = 1'b1; // №37 бит
	#10
	miso = 1'b0; // №38 бит
	#10
	miso = 1'b1; // №39 бит
	#10
	miso = 1'b1; // №40 бит
	#10
	miso = 1'b0; // №41 бит
	#10
	miso = 1'b1; // №42 бит
	#10
	miso = 1'b1; // №43 бит
	#10
	miso = 1'b0; // №44 бит
	#10
	miso = 1'b1; // №45 бит
	#10
	miso = 1'b0; // №46 бит
	#10
	miso = 1'b1; // №47 бит
	#10
	miso = 1'b1; // №48 бит
	#10
	miso = 1'b0; // №49 бит
	#10
	miso = 1'b1; // №50 бит
	#10
	miso = 1'b1; // №51 бит
	#10
	miso = 1'b0; // №52 бит
	#10
	miso = 1'b1; // №53 бит
	#10
	miso = 1'b0; // №54 бит
	#10
	miso = 1'b1; // №55 бит конец адресса
	#10
	miso = 1'b1; // №56 бит 
	#10
	miso = 1'b1; // №57 бит 
	#10
	miso = 1'b1; // №58 бит
	#10
	miso = 1'b1; // №59 бит
	#10
	miso = 1'b1; // №60 бит
	#10
	miso = 1'b1; // №61 бит
	#10
	miso = 1'b1; // №62 бит
	#10
	miso = 1'b1; // №63 бит конец команды
end

always @(posedge clk) begin	
	if (CS) begin
	if (bit_count == 6'd64 && command_wr_en == mem[63:56]) begin
		address_out <= mem[55:32];
		data_out <= mem[31:0];
		wr_en_out <= 1;
	end
	else begin 
	mem <= {miso, mem[63:1]};
    bit_count <= bit_count + 1;

end
end
	else begin
		bit_count <= 0;
	end
end

initial
begin
    $dumpfile("test.vcd");
    $dumpvars(0,tb);
end


endmodule

