module VgaController #(parameter
    HACTIVE = 10'd640,                    // horizontal active resolution
    HFP = 10'd16,                         // horizontal front porch
    HSYN = 10'd96,                        // horizontal sync
    HBP = 10'd48,                         // horizontal back porch
    HMAX = HACTIVE + HFP + HSYN + HBP,    // horizontal max resolution

    VACTIVE = 10'd480,                    // verical active resolution
    VFP = 10'd10,                         // vertical front porch
    VSYN = 10'd2,                         // vertical sync
    VBP = 10'd33,                         // vertical back porch
    VMAX = VACTIVE + VFP + VSYN + VBP     // verical max resolution
)(
    input logic vgaclk,
    output logic hsync, vsync, isdisplayed,
    output logic [9:0] x, y  // 10 bits to cover all 640x480
);

logic hsync_hi = 0, vsync_hi = 0, displayed = 0;
logic [9:0] xcnt = 0, ycnt = 0;

// count the horizontal and vertical positions, wrap around max resolutions
always_ff @(posedge vgaclk) begin
    // displayed  changes from HIGH to LOW at x == HACTIVE && y == VACTIVE
    // and changes back from LOW to HIGH at x == 0 && y == 0
    displayed <= (xcnt < HACTIVE) && (ycnt < VACTIVE);

    // compute sync signals (change to active-low later)
    // and ends right before the beginning of horizontal back porch
    hsync_hi <= (HACTIVE + HFP <= xcnt) && (xcnt < HACTIVE + HFP + HSYN);

    // vsync pulse starts right at the end of vertical front porch
    // and ends right before the beginning of horizontal back porch
    vsync_hi <= (VACTIVE + VFP <= ycnt) && (ycnt < VACTIVE + VFP + VSYN);

    // move to the next pixel. Wrap x around HMAX and y around VMAX
    if (xcnt == HMAX - 1) ycnt <= (ycnt + 1) % VMAX;
    xcnt <= (xcnt + 1) % HMAX;
end

// produce the outputs
assign {hsync, vsync, isdisplayed} = {~hsync_hi, ~vsync_hi, displayed};
assign {x, y} = {xcnt, ycnt};

endmodule
