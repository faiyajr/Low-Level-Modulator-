module greater(
    input wire [7:0] in1,
    input wire [7:0] in2,
    output reg out);

    always @* begin
        if (in1 > in2) begin
            out = 1'b1;
        end else begin
            out = 1'b0;
        end
    end

endmodule
