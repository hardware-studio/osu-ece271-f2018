// IR module for RC5 code

module ir
			#(parameter UP = 2, DOWN = 8, LEFT = 4, RIGHT = 6)
			(input logic data, clk,
			 output logic[1:0] dir_x, dir_y);
	// Count for slowing clock and new clock
	logic[10:0] clkCount = 0;
	logic newclk = 0;
	
	// Complete data word and its update status
	logic[5:0] dataWord = 0;
	logic newDataWord = 0;
	
	// Internal x/y movement 
	logic[1:0] x = 2;
	logic[1:0] y = 2;
	
	// Used for handling pulses
	logic pusleVal = 0;
	logic newPulseVal = 0;
	logic waitForRepeat = 0;
	
	// Slow clock from 50MHz to 36KHz as is used for RC5
	always_ff @(posedge clk)
		if (clkCount < 1388)
				clkCount <= clkCount + 1;
		else
			begin
				clkCount <= 0;
				newclk = ~newclk;
			end
			
	// Converts from encoded pulse to binary
	irConvertPulse cp(
		.data(data),
		.clk(newclk),
		.val(pusleVal),
		.newval(newPulseVal),
		.waitForRepeat(waitForRepeat)
	);
	
	// Converts from encoded binary to data word
	irReadWord rw(
		.val(pulseVal),
		.clk(newPulseVal),
		.waitForRepeat(waitForRepeat),
		.data(dataWord),
		.finished(newDataWord)
	);
	
	// Translate from data word to movement value
	always_ff @(posedge newDataWord)
		begin
			if (dataWord == UP) 			y <= 0;
			else if (dataWord == DOWN) y <= 1;
			else								y <= 2;
			
			if (dataWord == LEFT) 		 x <= 0;
			else if (dataWord == RIGHT) x <= 1;
			else								 x <= 2;
		end
			
	assign dir_x = x;
	assign dir_y = y;
endmodule


module irReadWord(input logic val, clk, waitForRepeat,
					   output logic[5:0] data,
						output logic finished);
	// Stores output and counts bits
	logic[5:0] out = 0;
	logic[4:0] count = 0;
	
	// Tracks previous toggle -- not used in this implementation
	// but necessary for certain controls so it will be tracked
	// anyway
	logic prevToggle = 1;
	
	always_ff @(posedge clk, negedge waitForRepeat)
		begin
			if (~waitForRepeat)	// Reset if time limit for repeating signal is up
				begin
					out <= 0;
					count <= 0;
					finished <= 1;
				end
			else if (count == 13)	// Reset count, store final value, and signal finished transmission
				begin
					out <= (out << 1) + val;
					finished <= 1;
					count <= 0;
				end
			else if (count == 2 && val != prevToggle)	// Set toggle and reset value if different button press
				begin
					prevToggle <= val;
					out <= 0;
					count <= count + 1;
					finished <= 0;
				end
			else if (count > 7)	// If in data word, add to output
				begin
					out <= (out << 1) + val;
					count <= count + 1;
					finished <= 0;
				end
			else
				begin
					count <= count + 1;
					finished <= 0;
				end
		end
		
	assign data = out;
endmodule


module irConvertPulse(input logic data, clk,
							 output logic val, newval, waitForRepeat);
	// Tracks two sections with potential to have pulses
	logic[5:0] dataCounterOne = 0;
	logic[5:0] dataCounterTwo = 0;
	
	// Counts time
	logic[5:0] timeCounter = 0;
	
	// Counts time from 
	logic[6:0] waitCounter = 78;
	logic idle = 1;
	logic out = 0;
	
	logic tcReset = 0;
	logic dcReset = 0;
	logic dcResetSuccess = 0;
	
	always_ff @(posedge data)
		begin
			if (idle) // Reset time counter if start of a transmission
				begin
					dataCounterOne <= 0;
					dataCounterTwo <= 1;
					tcReset <= 1;
				end
			else if (dcReset)
				begin
					if (timeCounter > 31 && dataCounterTwo < 32) 
						begin
							dataCounterOne <= 0;
							dataCounterTwo <= 1;
						end
					else if (dataCounterOne < 32) 					
						begin
							dataCounterOne <= 1;
							dataCounterTwo <= 0;
						end
						
					dcResetSuccess <= 1;
				end
			else	// Increment data 
				begin
					if (timeCounter > 31 && dataCounterTwo < 32) dataCounterTwo <= dataCounterTwo + 1;
					else if (dataCounterOne < 32) 					dataCounterOne <= dataCounterOne + 1;
					
					tcReset <= 0;
					dcResetSuccess <= 0;
				end
		end
		
	always_ff @(posedge clk)
		begin
			if (tcReset)
				begin
					timeCounter <= 33;
					waitCounter <= 0;
					idle <= 0;
				end
			else if (timeCounter == 63)	// Set output and reset
				begin
					// Increment counter if still in window for additional
					if (idle && dataCounterOne == 0 && dataCounterTwo == 0 && waitCounter < 78)
						waitCounter <= waitCounter + 1;
				
					out <= dataCounterOne == 0 && dataCounterTwo == 32 && ~dcReset;
					newval <= (dataCounterOne == 32 || dataCounterTwo == 32) && ~dcReset;
					idle <= (dataCounterOne == 0 && dataCounterTwo == 0) || ~dcReset;
					dcReset <= 1;
					timeCounter <= 0;
				end
			else	// Increment data
				begin
					timeCounter <= timeCounter + 1;
					newval <= 0;
					
					if (dcResetSuccess)
						dcReset <= 0;
				end
		end
		
	assign val = out;
	
	// Do not wait if outside of continued transmission window
	assign waitForRepeat = waitCounter < 78;
endmodule
