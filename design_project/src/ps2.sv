module ps2 
				#(parameter UP = 8'h1D, DOWN = 8'h1B, LEFT = 8'h1C, RIGHT = 8'h23)
				(input logic clk, data,
				output logic[1:0] dir_x, dir_y);
	// Track data input
	logic[7:0] bits = 8'd0;
	
	// Track count of bits coming in and number of ones
	logic[3:0] count = 0;
	logic[3:0] even_odd = 0;
	
	// Hold output values
	logic[1:0] x = 2;
	logic[1:0] y = 2;
	
	// Track valid input and whether past input was F0 (indicating key release)
	logic valid = 0;
	logic fo = 0;
	
	always_ff @(negedge clk)
		begin
			if (count == 10)	// Ending bit
				begin
					if (valid)
						begin
							// Translate directions to movement
							if (~fo && y == 2 && bits == UP) y <= 0;
							else if (fo && y == 0 && bits == UP) y <= 2;
							else if (~fo && y == 2 && bits == DOWN) y <= 1;
							else if (fo && y == 1 && bits == DOWN) y <= 2;
					
							if (~fo && x == 2 && bits == LEFT) x <= 0;
							else if (fo && x == 0 && bits == LEFT) x <= 2;
							else if (~fo && x == 2 && bits == RIGHT) x <= 1;
							else if (fo && x == 1 && bits == RIGHT) x <= 2;
					
							// Get code for key release
							if (bits == 8'hF0) fo <= 1;
							else					 fo <= 0;
						end
					
					even_odd <= 0;
					count <= 0;
					bits <= 8'd0;
					valid <= 0;
				end
			else if (count == 9)	// Check parity bit
				begin
					count <= count + 1;
					
					// Check validity based on number of ones and parity bit (odd total)
					valid <= even_odd[0] == ~data;
				end
			else if (count == 0)	// Start bit -- do nothing but advance count
				count <= count + 1;
			else
				begin
					// Track count and number of odd
					even_odd <= even_odd + data;
					count <= count + 1;
					
					// Load data
					bits <= (bits >> 1) + (data * 128);
				end	
		end
	
	// Set output
	assign dir_x = x;
	assign dir_y = y;
endmodule