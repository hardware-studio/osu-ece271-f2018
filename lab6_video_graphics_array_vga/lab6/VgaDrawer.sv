module VgaDrawer(
    input logic [9:0] x, y,
    output logic [3:0] r, g, b
);

assign {r, g, b} = {4'b0, 4'b1, 4'b0};

endmodule
