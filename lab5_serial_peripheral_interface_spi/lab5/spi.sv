module SPI(
    input logic clk,
    input logic data,
    output logic [7:0] out_parser
);
   
    always_ff @(posedge clk) begin
        out_parser <= (out_parser << 1) + data;
    end
    
endmodule