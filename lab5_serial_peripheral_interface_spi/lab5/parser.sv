module Parser(
    input logic [7:0] in,
    output logic [3:0] out0, out1, out2
);

    always_comb begin
        out0 = in % 10;
        out1 = (in / 10) % 10;
        out2 = (in / 100) % 10;
    end

endmodule
