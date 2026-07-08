module plus1(
    input wire [7:0] in,
    output reg [7:0] out);

    always @* begin
        out = in + 8'h1;
    end

endmodule
