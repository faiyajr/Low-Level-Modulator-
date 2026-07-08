module subtract_26 (
  input wire [7:0] in,
  output reg [7:0] out);

  always @* begin
    out = in - 8'd26;
  end
endmodule
