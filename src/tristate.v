module tristate(
    input wire [7:0] in,
    output reg [7:0] out,
    input wire drive);

    always @* begin
        if (drive == 1'b1) begin
            out = in;
        end else begin
            out = {8{1'bz}};
        end
    end

endmodule
