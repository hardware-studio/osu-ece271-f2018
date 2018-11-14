module VgaTopLevel (
    input logic clk,
    output logic hsync, vsync,
    output logic [3:0] red, green, blue
);

logic vgaclk, sync_b, blank_b;
logic [9:0] x, y;

HalfClock clock(
    .clk_in(clk),
    .clk_out(vgaclk)
);

VgaController vga(
    .vgaclk(vgaclk),
    .hsync(hsync),
    .vsync(vsync),
    .sync_b(sync_b),
    .blank_b(blank_b),
    .x(x),
    .y(y)
);

VgaDrawer drawer(
    .x(x),
    .y(y),
    .r(red),
    .g(green),
    .b(blue)
);

endmodule
