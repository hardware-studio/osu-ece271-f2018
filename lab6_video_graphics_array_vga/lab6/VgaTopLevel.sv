module VgaTopLevel (
    input logic clk,
    output logic hsync, vsync,
    output logic [3:0] red, green, blue
);

logic vgaclk, isdisplayed;
logic [9:0] x, y;

HalfClock clock(
    .clk_in(clk),
    .clk_out(vgaclk)
);

VgaController vga(
    .vgaclk(vgaclk),
    .hsync(hsync),
    .vsync(vsync),
    .isdisplayed(isdisplayed),
    .x(x),
    .y(y)
);

VgaDrawer drawer(
    .clk(vgaclk),
    .isdisplayed(isdisplayed),
    .x(x),
    .y(y),
    .r(red),
    .g(green),
    .b(blue)
);

endmodule
