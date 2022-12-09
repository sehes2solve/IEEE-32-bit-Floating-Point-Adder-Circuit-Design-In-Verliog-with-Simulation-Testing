module pr_circuit_25x25(input logic[24:0] in
							 ,output logic[24:0] out);
							 
	logic [8:0] prc1,prc2,prc3;
	
	pr_circuit_8x8 _8x8pr1(in[23:16],prc1);
	pr_circuit_8x8 _8x8pr2(in[15: 8],prc2);
	pr_circuit_8x8 _8x8pr3(in[ 7: 0],prc3);
	
	assign out[24]    = in[24];
	assign out[23:16] = prc1 & {8{~in[24]}};
	assign out[15:8]  = prc2 & {8{~in[24]}} & {8{~|in[23:16]}};
	assign out[7:0]   = prc3 & {8{~in[24]}} & {8{~|in[23:16]}} & {8{~|in[15:8]}};
endmodule
