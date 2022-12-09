module shiftmant(input logic alessb,
                    input logic [23:0] manta, mantb,
                    input logic [7:0] shift,
                    output logic [23:0] shifted_mant);
 
    logic [23:0] shifted_val;
    assign shifted_val = alessb ? (manta >> shift): (mantb >> shift);
 
    always_comb
        if (shift[7] | shift[6] | shift[5] | (shift[4] & shift[3]))
            shifted_mant = 24'b0;
        else
            shifted_mant = shifted_val;
endmodule