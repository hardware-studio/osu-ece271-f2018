module Spi(
    input logic clk,
    input logic data_in,
    output logic [7:0] out_parser
);

    logic [7:0] out = 0;

    always_ff @(posedge clk)
        out <= (out << 1) + data_in;

    assign out_parser = out;

endmodule
