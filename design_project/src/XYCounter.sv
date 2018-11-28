module XYCounter(input logic clk,
					  output logic vs, hs,
					  output logic[9:0] x, y);
	// Track current x and y
	logic[9:0] xpos = 0;
	logic[9:0] ypos = 0;
	
	always_ff @(posedge clk)
		begin
			// Generate HSync and VSync signals when in sync section
			hs <= ~((xpos > 640 + 16) && (xpos < 640 + 16 + 96));
			vs <= ~((ypos > 480 + 11) && (ypos < 480 + 11 + 2));
			
			if(xpos == 800 && ypos == 524)	// Reset when at end of screen
				begin
					ypos <= 0;
					xpos <= 0;
				end
			else if(xpos == 800) 	// Increment y and reset x at end of line
				begin
					ypos <= ypos + 1;
					xpos <= 0;
				end
			else	// Otherwise increment x 
				xpos <= xpos + 1;
		end
		
	assign x = xpos;
	assign y = ypos;
		
endmodule