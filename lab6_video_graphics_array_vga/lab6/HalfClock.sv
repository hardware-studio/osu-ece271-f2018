module HalfClock(
    input logic clk_in,
    output logic clk_out
);

logic out = 0;

always_ff @(posedge clk_in)
    out <= ~out;

assign clk_out = out;

endmodule
