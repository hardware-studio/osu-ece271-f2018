module box_controller
						  #(parameter SIZE = 40)
							(input vs,
							 input logic[1:0] dir_x, dir_y,
							 input logic[9:0] x, y,
							 output logic[3:0] box_r, box_g, box_b,
							 output logic[9:0] box_x, box_y, box_size);
							 
	logic[9:0] xpos = 300;
	logic[9:0] ypos = 220;
	logic[3:0] r = 4'b1111;
	logic[3:0] g = 4'b0;
	logic[3:0] b = 4'b0;
	
	always_ff @(posedge vs)
		begin
			if(~(dir_x == 0 && xpos == 0) && ~(dir_x == 1 && xpos == 640 - SIZE))
				begin
					if((xpos - 1 == 0 && dir_x == 0) || (xpos + 1 == 640 - SIZE && dir_x == 1))
						begin
							r <= g;
							g <= b;
							b <= r;
						end
				
					case(dir_x)
						0: xpos <= xpos - 1;
						1: xpos <= xpos + 1;
					endcase
				end
		
			if(~(dir_y == 0 && ypos == 0) && ~(dir_y == 1 && ypos == 480 - SIZE))
				begin
					if((ypos - 1 == 0 && dir_y == 0) || (ypos + 1 == 480 - SIZE && dir_y == 1))
						begin
							r <= g;
							g <= b;
							b <= r;
						end
				
					case(dir_y)
						0: ypos <= ypos - 1;
						1: ypos <= ypos + 1;
					endcase
				end
		end
	
	assign box_x = xpos;
	assign box_y = ypos;
	assign box_size = SIZE;
	assign box_r = r;
	assign box_g = g;
	assign box_b = b;
endmodule