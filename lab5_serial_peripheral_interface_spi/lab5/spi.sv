module Spi(
    input logic clk,
    input logic data_in,
    output logic [7:0] out_parser
);

    always_ff @(posedge clk)
        out_parser <= (out_parser << 1) + data_in;

endmodule
