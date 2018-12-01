module top_level(
    input logic clk,
    input logic[1:0] dir_x, dir_y,
    output logic vs, hs,
    output logic[3:0] r, g, b
);

logic[9:0] xpos, ypos;
logic slowclk;

logic[3:0] box_r, box_g, box_b;
logic[9:0] box_x, box_y, box_size;

half_clock hc (
    .oldclk(clk),
    .newclk(slowclk)
);

XYCounter c (
    .clk(slowclk),
    .vs(vs),
    .hs(hs),
    .x(xpos),
    .y(ypos)
);

box_controller box (
    .vs(vs),
    .dir_x(dir_x),
    .dir_y(dir_y),
    .x(xpos),
    .y(ypos),
    .box_r(box_r),
    .box_g(box_g),
    .box_b(box_b),
    .box_x(box_x),
    .box_y(box_y),
    .box_size(box_size)
);

Drawer d (
    .clk(slowclk),
    .box_r(box_r),
    .box_g(box_g),
    .box_b(box_b),
    .x(xpos),
    .y(ypos),
    .box_x(box_x),
    .box_y(box_y),
    .box_size(box_size),
    .r(r),
    .g(g),
    .b(b)
);

endmodule
