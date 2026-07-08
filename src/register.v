module register(
    input wire clock,
    input wire reset,
    input wire write,
    input wire [7:0] data_in,
    output reg [7:0] data_out);

    always @(posedge clock) begin
        if (reset == 1'b1) begin
            data_out <= 8'h0;
        end else if (write == 1'b1) begin
            data_out <= data_in;
        end
    end

endmodule
