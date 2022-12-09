module addmant(input logic signa, signb,
                input logic[24:0] signeda, signedb,
                input logic[7:0] exp_pre,
                output logic[22:0] mant,
                output logic[7:0] exp,
					 output logic sign, flow);
					 
	 logic signa_eq_signb, is_signed_addval_ive, OF, preXp_less_mantXp, is_zero_mant;
	 logic[7:0] mant_exp, exp_inc, exp_dec, non_zero_exp;
	 logic[24:0] signed_addval, addval_ive,addresult, addresult_msone,normalized_shift_mant;
      
	 assign signa_eq_signb = ~(signa^signb);
	 assign sign = (signa_eq_signb) ? signa : signed_addval[24] ;	 
	 assign signed_addval = signeda + signedb;
	 assign addval_ive = ~signed_addval + 1;
	 assign is_signed_addval_ive = ~signa_eq_signb & signed_addval[24];
	 assign addresult = (is_signed_addval_ive)? addval_ive : signed_addval;
	 
	 pr_circuit_25x25 prc(addresult,addresult_msone);
	 encoder_25x5 enc(addresult_msone,mant_exp);
	 
	 assign preXp_less_mantXp = exp_pre < (mant_exp - 1);
	 ///***************///
	 assign exp_dec = exp_pre - (mant_exp - 1);
	 ///**************///
	 assign {OF , exp_inc } = exp_pre + 1;
	 assign non_zero_exp = (signa_eq_signb)? exp_inc : exp_dec;
	 assign normalized_shift_mant = addresult << mant_exp;
	 
	 assign is_zero_mant = ~|addresult_msone;
	 assign flow = (signa_eq_signb) ? OF    : preXp_less_mantXp ;
	 assign exp  = (is_zero_mant)   ? 8'd0  : non_zero_exp;
    assign mant = (is_zero_mant)   ? 23'd0 : normalized_shift_mant[23:1];
	
endmodule