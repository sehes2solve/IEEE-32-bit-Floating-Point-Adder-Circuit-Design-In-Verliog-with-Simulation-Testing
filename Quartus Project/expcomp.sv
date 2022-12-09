module expcomp(input logic[7:0] expa, expb,
                output logic alessb,
                output logic[7:0] exp, shift);
   
    logic[7:0] aminusb, bminusa;
    assign aminusb = expa - expb;
    assign bminusa = expb - expa;
    assign alessb = aminusb[7];
   
    always_comb
        if (alessb) begin
            exp = expb;
            shift = bminusa;
        end
        else begin
            exp = expa;
            shift = aminusb;
        end
endmodule