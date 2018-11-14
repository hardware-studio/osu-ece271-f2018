module VgaController #(parameter
    HSYN = 10'd96,                        // horizontal sync
    HBP = 10'd48,                         // horizontal back porch
    HACTIVE = 10'd640,                    // horizontal active resolution
    HFP = 10'd16,                         // horizontal front porch
    HMAX = HSYN + HBP + HACTIVE + HFP,    // horizontal max resolution

    VSYN = 10'd2,                         // vertical sync
    VBP = 10'd33,                         // vertical back porch
    VACTIVE = 10'd480,                    // verical active resolution
    VFP = 10'd10,                         // vertical front porch
    VMAX = VSYN + VBP + VACTIVE + VFP    // verical max resolution
)(
    input logic vgaclk,
    output logic hsync, vsync, sync_b, blank_b,
    output logic [9:0] x, y  // 10 bits to cover all 640x480
);

// count the horizontal and vertical positions
always @(posedge vgaclk) begin
    if (x == HMAX - 1) y = (y + 1) % VMAX;
    x = (x + 1) % HMAX;
end

// compute active-low sync signals
assign hsync = ~((x >= HACTIVE + HFP) & x < (HACTIVE + HFP + HSYN));
assign vsync = ~((y >= VACTIVE + VFP) & y < (HACTIVE + VFP + VSYN));
assign sync_b = hsync & vsync;

// force blank output if outside of active area
assign blank_b = (x < HACTIVE) & (y < VACTIVE);

endmodule
