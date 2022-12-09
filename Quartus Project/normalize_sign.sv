module normalize_sign(input logic alessb, signa, signb,
							 input logic[23:0] manta, mantb, shifted_mant,
							 output logic[24:0] signeda, signedb);
							 
	logic[24:0] manta_ive, mantb_ive, shifted_mant_ive,
					sa,sb,s_shifted_mant;
	logic is_conva,is_convb ,signa_eq_signb;
					
	assign signa_eq_signb = ~(signa^signb);
	assign manta_ive = ~manta + 1;
	assign mantb_ive = ~mantb + 1;
	assign shifted_mant_ive = ~shifted_mant + 1;
	
	assign is_conva = ~signb & ~signa_eq_signb;
	assign is_convb = signb & ~signa_eq_signb;
	
	assign sa      = (is_conva)? manta_ive : manta;
	assign sb      = (is_convb)? mantb_ive: mantb;
	always_comb
		case({alessb,signa,signb})
			0: s_shifted_mant = shifted_mant;
			1: s_shifted_mant = shifted_mant_ive;
			2: s_shifted_mant = shifted_mant;
			3: s_shifted_mant = shifted_mant_ive;
			4: s_shifted_mant = shifted_mant;
			5: s_shifted_mant = shifted_mant;
			6: s_shifted_mant = shifted_mant_ive;
			7: s_shifted_mant = shifted_mant_ive;
			default: s_shifted_mant = 0;
		endcase
	assign signedb = (alessb)  ? sb   : sa   ;
	assign signeda = (signa_eq_signb) ? shifted_mant : s_shifted_mant;

endmodule	