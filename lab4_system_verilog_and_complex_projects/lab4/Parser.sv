module Parser(
    input logic [16:0] in,
    output logic [3:0] out0, out1, out2, out3, out4, out5
);

    always_comb begin
        out0 = in % 10;
        out1 = (in / 10) % 10;
        out2 = (in / 100) % 10;
        out3 = (in / 1000) % 10;
        out4 = (in / 10000) % 10;
        out5 = (in / 100000) % 10;
    end

endmodule
