module IEEE32float_adder(input logic [31:0] a,b,
                         output logic [31:0] s);
	logic full_expa, full_expb, zero_manta ,zero_mantb;
	logic[31:0] addition,NAN;
	logic[30:0] INF;
	
	faddition faddition1(a,b,addition);
	assign NAN = 32'hffff_ffff;
	assign INF = {8'hff,3'b000,20'h00000};
	assign full_expa  = &a[30:23];
	assign full_expb  = &b[30:23];
	assign zero_manta = ~|a[22:0];
	assign zero_mantb = ~|b[22:0];
	
	
	always_comb
		casez({full_expa,full_expb,zero_manta,zero_mantb})
			4'b00??: s = addition;
			4'b01?0: s = NAN;
			4'b01?1: s = {b[31],INF};
			4'b100?: s = NAN;
			4'b101?: s = {a[31],INF};
			4'b110?: s = NAN;
			4'b1110: s = NAN;
			4'b1111: s = (a[31]^b[31])? NAN : {a[31],INF};
		endcase
endmodule