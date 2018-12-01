module half_clock(
    input logic oldclk,
    output logic newclk
);

logic count = 0;

always_ff @(posedge oldclk)
    if (count == 1)
        begin
            newclk <= 1;
            count <= 0;
        end
    else
        begin
            newclk <= 0;
            count <= count + 1;
        end

endmodule
