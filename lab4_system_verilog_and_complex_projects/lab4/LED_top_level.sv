module LED_top_level( //Every SV File starts with module and ends with endmodule
    input logic [9:0] Switches, //after the name of the module, all its inputs and outputs are declared in the ()
    input logic [1:0] Buttons,
    output logic [6:0] Seg70, Seg71, Seg72, Seg73, Seg74, Seg75
);
    /*******************************/
    /* Set internal variables here */
    /*******************************/
    logic [16:0] m_out;
    logic [3:0] p_out0, p_out1, p_out2, p_out3, p_out4, p_out5;

    /********************************************/
    /* Instanciate and Connect all modules here */
    /********************************************/

    Multiplexer M(
        .switches(Switches),
        .buttons(Buttons),
        .out(m_out)
    );

    Parser P(
        .in(m_out),
        .out0(p_out0),
        .out1(p_out1),
        .out2(p_out2),
        .out3(p_out3),
        .out4(p_out4),
        .out5(p_out5),
    );

    Decoder D0(
        .Num(p_out0),
        .segments(Seg70)
    );
    Decoder D1(
        .Num(p_out1),
        .segments(Seg71)
    );
    Decoder D2(
        .Num(p_out2),
        .segments(Seg72)
    );
    Decoder D3(
        .Num(p_out3),
        .segments(Seg73)
    );
    Decoder D4(
        .Num(p_out4),
        .segments(Seg74)
    );
    Decoder D5(
        .Num(p_out5),
        .segments(Seg75)
    );

endmodule
