module ps2_top_level(input logic clk, data,
							output logic vs, hs, latch_out, clk_out,
							output logic[3:0] r, g, b);
	// Track x and y and slow clock
	logic[9:0] xpos, ypos;
	logic slowclk;
	
	// Get direction input
	logic[1:0] dir_x, dir_y;
	
	// Track box info
	logic[3:0] box_r, box_g, box_b;
	logic[9:0] box_x, box_y, box_size;
	
	// Slow clock
	half_clock hc (
		.oldclk(clk),
		.newclk(slowclk)
	);
	
	// Generate position and vs/hs signals
	XYCounter c (
		.clk(slowclk),
		.vs(vs),
		.hs(hs),
		.x(xpos),
		.y(ypos)
	);
	
	// Get nes input for direction
	nes N (
		.clk(clk),
		.data(data),
		.dir_x(dir_x),
		.dir_y(dir_y),
		.latch_out(latch_out),
		.clk_out(clk_out)
	);
	
	// Move box
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
	
	// Draw box
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