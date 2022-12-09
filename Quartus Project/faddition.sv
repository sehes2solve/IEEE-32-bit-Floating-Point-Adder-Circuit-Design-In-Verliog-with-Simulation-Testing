module faddition(input logic [31:0] a,b,
                 output logic [31:0] s);
               
    logic [7:0] expa, expb , exp_pre,exp,shift;
    logic alessb, sign, signa, signb,flow;
	 logic [24:0] signeda, signedb;
    logic [23:0] manta,mantb,shifted_mant;
    logic [22:0] mant;  
	 
	 assign {signa,expa,manta} = {a[31],a[30:23],1'b1,a[22:0]};
    assign {signb,expb,mantb} = {b[31],b[30:23],1'b1,b[22:0]};
 
    expcomp expcomp1(expa, expb, alessb, exp_pre, shift);
    shiftmant shiftmant1(alessb, manta, mantb, shift, shifted_mant);
	 normalize_sign normalize_sign1(alessb, signa, signb, manta, mantb, shifted_mant, signeda, signedb);
	 addmant addmant1(signa, signb, signeda, signedb, exp_pre, mant, exp, sign, flow);
	 
	 assign s = {sign,exp,mant};
endmodule