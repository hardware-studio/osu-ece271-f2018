module nes #(parameter
    UP = 5, DOWN = 6, LEFT = 7, RIGHT = 8
)(
    input logic data, clk,
    output logic latch_out, clk_out,
    output logic[1:0] dir_x, dir_y
);

// Track status of x and y direction and if a directional button was pressed
logic[1:0] x = 2;
logic[1:0] y = 2;
logic x_btn_press = 0;
logic y_btn_press = 0;

// Track when to poll controller for button presses
logic[19:0] pollClkCount = 0;
logic pollClk = 0;

// Track when to pulse clock
logic[9:0] pulseClkCount = 0;
logic pulseClk = 0;

// Track info about latch and clock pulse
logic latch_inner = 0;
logic new_pulse = 0;
logic start_pulse_out = 0;
logic[3:0] pulseCounter = 0;

// Convert clk from 50MHz to 60Hz for polling controller
// and to 83kHz to produce clock pulses
always_ff @(posedge clk)
    begin
        if (pollClkCount == 416666)
            begin
                // Start polling controller by resetting pulse data, starting latch,
                // and signaling start of new pulse
                if (~pollClk)
                    begin
                        latch_inner <= 1;
                        new_pulse <= 1;
                        pulseClkCount <= 0;
                        pulseClk <= 0;
                        pulseCounter <= 0;
                    end

                pollClkCount <= 0;
                pollClk <= ~pollClk;
            end
        else
            pollClkCount <= pollClkCount + 1;

        if (pulseClkCount == 301)
            begin
                if (new_pulse && ~pulseClk)  // Only update if controller poll has started
                    begin
                        // Track beginning of clock pulse to controller (after latch)
                        if (pulseCounter > 0 && latch_inner == 0)
                            start_pulse_out <= 1;

                        // Count pulse
                        pulseCounter <= pulseCounter + 1;
                    end

                if (new_pulse && pulseClk)  // Only update if controller poll has started
                    begin
                        // Reset latch once its 12us have passed
                        if (pulseCounter > 0 && latch_inner)
                            latch_inner <= 0;

                        // Reset pulse data if all buttons have been accounted
                        if (pulseCounter == 9)
                            begin
                                new_pulse <= 0;
                                start_pulse_out <= 0;
                                y_btn_press <= 0;
                                x_btn_press <= 0;
                            end
                        else
                            begin
                                // Check for UP or DOWN buttons being pressed and track that
                                // a button in y direction has been pressed
                                if (pulseCounter == UP && data == 0)
                                    begin
                                        y <= 0;
                                        y_btn_press <= 1;
                                    end
                                else if (pulseCounter == DOWN && data == 0)
                                    begin
                                        y <= 1;
                                        y_btn_press <= 1;
                                    end
                                else if (pulseCounter >= UP && pulseCounter >= DOWN && y_btn_press == 0)  // Reset if no y button press
                                    y <= 2;

                                // Check for RIGHT or LEFT buttons being pressed and track that
                                // a button in x direction has been pressed
                                if (pulseCounter == LEFT && data == 0)
                                    begin
                                        x <= 0;
                                        x_btn_press <= 1;
                                    end
                                else if (pulseCounter == RIGHT && data == 0)
                                    begin
                                        x <= 1;
                                        x_btn_press <= 1;
                                    end
                                else if (pulseCounter >= LEFT && pulseCounter >= RIGHT && y_btn_press == 0)  // Reset if no x button press
                                    x <= 2;
                            end
                    end

                pulseClkCount <= 0;
                pulseClk <= ~pulseClk;
            end
        else
            pulseClkCount <= pulseClkCount + 1;
    end

// Assign outputs, and only set clock if part of pulse output
assign latch_out = latch_inner;
assign clk_out = start_pulse_out && pulseClk;
assign dir_x = x;
assign dir_y = y;

endmodule

