module exampleHalfClk(input logic clk,output logic halfclk);	// This module takes in a clock signal, and outputs a clock signal with half the frequncy
always_ff@(posedge clk)														// at every single positive edge of the clock,
	halfclk = ~halfclk																// the slow clock flips. This means that for each two cycles of the clock, the half clock is cycled. 
endmodule																			//this produces a duty cycle of 50%

module exampleCounterMax(input logic clk,output logic slowclk);		//this module takes in a clk signal, and outputs a slower clock
logic [7:0] counter = 0;							//it has an 8 bit counter, which counts the 256 values from 0-255
always_ff@ (posedge clk)					//every positive edge, 
begin
	counter <= counter + 1;						//the counter is incrimented. 

if(counter == 255)						//when we hit the max value, we are going to flip the clock
	slowclk <= ~slowclk;				//because we are still flipping the value every positive value, the 1/2 Hz effect of the first module is still there.
else													// this compounds with the counter to 255 and produces a slowclk that has the period 512 times longer.  
	slowclk <= slowclk;				//this line is added for synthesis purposes, and is not strictly needed.
end
endmodule

module exampleCounterModulus(input logic clk,output logic clk_2, clk_4, clk_16, clk_32, clk_500, clk_max);	
logic [15:0] counter;																						//this module takes in a clock signal, and outputs several slower clocks					
always_ff@ (posedge clk)
begin
	counter <= counter + 1;																	//the counter is incrimented every positive edge of the original clock
end
always_ff@(*)													
begin																//anything %0 is 0, so all these will happen and go high at the start
if (counter % 2  == 0)											//if the count is even, two cycles have passed, 
	clk_4 <= ~clk_4;										//two perods per not make for a fourth the Hz 
if(counter % 8 == 0)
	clk_16 <= ~clk_16;
if(counter %16 ==0)
	clk_32 <= ~clk_32;
if(counter % 250 ==0)
	clk_500 = ~clk_500;				// 500 times larger period, 1/500 times the Hz. so with a 50 MhZ clock, this is now a 10KHz clock. 
if(counter == 0)
	clk_max = ~clk_max;
end
endmodule


module DoNotUseThisModule (input logic clk, output logic clk_3);		//this counter present possible hardware issues with timing delays. 
logic [7:0] ncounter, pcounter;
logic [8:0] count; //needs to be twice as big to hold both.  will also gain an additional 4th run through when one of the values first overflows
always_ff @ (posedge clk)
	begin
	pcounter <= pcounter + 1;
	end
always_ff@ (negedge clk)
	begin
	ncounter <= ncounter + 1;
	end
assign count = pcounter + ncounter;	//count now goes up twice a clock cycle, but has the chance to be odd
always_ff@(*)
	begin
	if(count%3==0)
		clk_3 <= ~clk_3;
end
endmodule