module VgaDrawer#(parameter
    HACTIVE = 10'd640,                    // horizontal active resolution
    VACTIVE = 10'd480,                    // verical active resolution
    BOXW = 10'd320,                       // box width
    BOXH = 10'd240                        // box height
)(
    input logic clk,
    input logic isdisplayed,
    input logic [9:0] x, y,
    output logic [3:0] r, g, b
);

logic [3:0] r_out = 0, g_out = 0, b_out = 0;

always_ff @(posedge clk)
    if (isdisplayed)
        if ((HACTIVE - BOXW) / 2 <= x && x < (HACTIVE - BOXW) / 2 + BOXW
            && (VACTIVE - BOXH) / 2 <= y && y < (VACTIVE - BOXH) / 2 + BOXH)
            {r_out, g_out, b_out} <= {4'b1111, 4'b0, 4'b0};
        else
            {r_out, g_out, b_out} <= {4'b0, 4'b0, 4'b1111};
    else
        {r_out, g_out, b_out} <= {4'b0, 4'b0, 4'b0};

assign {r, g, b} = {r_out, g_out, b_out};

endmodule
