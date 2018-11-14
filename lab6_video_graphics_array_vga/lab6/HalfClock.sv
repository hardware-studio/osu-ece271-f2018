module HalfClock(
    input logic clk_in,
    output logic clk_out
);

always_ff @(posedge clk_in)
    clk_out <= ~clk_out;

endmodule
