module VgaDrawer(
    input logic clk,
    input logic isdisplayed,
    input logic [9:0] x, y,
    output logic [3:0] r, g, b
);

logic [3:0] r_out = 0, g_out = 0, b_out = 0;

always_ff @(posedge clk)
    if (isdisplayed)
        {r_out, g_out, b_out} <= {4'b0, 4'b0, 4'b1111};
    else
        {r_out, g_out, b_out} <= {4'b0, 4'b0, 4'b0};

assign {r, g, b} = {r_out, g_out, b_out};

endmodule
