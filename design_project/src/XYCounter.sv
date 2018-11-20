module XYCounter(input logic clk,
					  output logic vs, hs,
					  output logic[9:0] x, y);
					  
	logic[9:0] xpos = 0;
	logic[9:0] ypos = 0;
	
	always_ff @(posedge clk)
		begin
			hs <= ~((xpos > 640 + 16) && (xpos < 640 + 16 + 96));
			vs <= ~((ypos > 480 + 11) && (ypos < 480 + 11 + 2));
			
			if(xpos == 800 && ypos == 524) 
				ypos <= 0;
			else if(xpos == 800) 		    
				begin
					ypos <= ypos + 1;
					xpos <= 0;
				end
			else 				 
				xpos <= xpos + 1;
		end
		
	assign x = xpos;
	assign y = ypos;
		
endmodule