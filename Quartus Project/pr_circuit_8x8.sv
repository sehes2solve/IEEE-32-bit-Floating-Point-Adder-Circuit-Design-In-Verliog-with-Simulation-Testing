module pr_circuit_8x8(input logic[7:0] in
							,output logic[7:0] out);
	always_comb
		casez(in)
			8'b1???_????: out = 8'b1000_0000;
			8'b01??_????: out = 8'b0100_0000;
			8'b001?_????: out = 8'b0010_0000;
			8'b0001_????: out = 8'b0001_0000;
			8'b0000_1???: out = 8'b0000_1000;
			8'b0000_01??: out = 8'b0000_0100;
			8'b0000_001?: out = 8'b0000_0010;
			8'b0000_0001: out = 8'b0000_0001;
			
			8'b0000_0000: out = 0;
			default     : out = 8'b1111_1111;
		endcase
endmodule