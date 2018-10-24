module Multiplexer(
    input logic [9:0] switches,
    input logic [1:0] buttons,
    output logic [16:0] out
);

    always_comb
        case(buttons)
            0: out = switches * 128;
            1: out = switches * 8;
            2: out = switches * 2;
            3: out = switches;
        endcase

endmodule
