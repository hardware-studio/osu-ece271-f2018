module Decoder(
    input logic [3:0] num_in,
    output logic [6:0] segments
);
    always_ff @(*)
        case(num_in)
            0: segments = 7'b100_0_000;
            1: segments = 7'b111_1_001;
            2: segments = 7'b010_0_100;
            3: segments = 7'b011_0_000;
            4: segments = 7'b001_1_001;
            5: segments = 7'b001_0_010;
            6: segments = 7'b000_0_010;
            7: segments = 7'b111_1_000;
            8: segments = 7'b000_0_000;
            9: segments = 7'b001_1_000;
            default: segments =  7'b111_1111;
        endcase

endmodule
