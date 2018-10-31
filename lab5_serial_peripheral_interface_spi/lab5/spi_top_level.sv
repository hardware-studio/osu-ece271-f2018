module SPItopLevel(
    input logic switch,
    input logic button,
    output logic [6:0] seg70, seg71, seg72, seg73, seg74, seg75
);

    logic [7:0] parser_in;
    logic [3:0] parser_out0, parser_out1, parser_out2;

    SPI s(
        .clk(button),
        .data(switch),
        .out_parser(parser_in)
    );

    Parser p(
        .in(parser_in),
        .out0(parser_out0),
        .out1(parser_out1),
        .out2(parser_out2)
    );

    Decoder d0(
        .num(parser_out0),
        .segments(seg70)
    );
    Decoder d1(
        .num(parser_out1),
        .segments(seg71)
    );
    Decoder d2(
        .num(parser_out2),
        .segments(seg72)
    );
    Decoder d3(
        .num(0),
        .segments(seg73)
    );
    Decoder d4(
        .num(0),
        .segments(seg74)
    );
    Decoder d5(
        .num(0),
        .segments(seg75)
    );

endmodule
