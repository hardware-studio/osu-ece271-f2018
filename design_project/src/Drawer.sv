module Drawer(input logic clk,
				  input logic[3:0] box_r, box_g, box_b,
				  input logic[9:0] x, y, box_x, box_y, box_size,
				  output logic[3:0] r, g, b);
				  
	always_ff @(posedge clk)
		// Draw black if not in box pixels
		if (x > 640 || y > 480 || x < box_x || y < box_y || x > box_x + box_size || y > box_y + box_size)
			begin
				r <= 4'b0;
				g <= 4'b0;
				b <= 4'b0;
			end
		else	// Draw box
			begin
				r <= box_r;
				g <= box_g;
				b <= box_b;
			end
			
endmodule