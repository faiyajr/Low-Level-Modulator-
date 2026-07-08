module control(
    input wire clock,
    input wire reset,
    input wire isZero_out,
    input wire greaterThan122_out,

    output reg element_write,
    output reg element_drive,
    output reg add13_drive,
    output reg minus26_drive,
    output reg i_write,
    output reg i_drive,
    output reg add1_drive,
    output reg memory_write,
    output reg memory_drive,
    output reg address_write);

    parameter state_reset =     4'h0;
    parameter state_address =   4'h1;
    parameter state_read0 =     4'h2;
    parameter state_loop =      4'h3;
    parameter state_write0 =    4'h4;
    parameter state_read1 =     4'h5;
    parameter state_wrap =      4'h6;
    parameter state_increment = 4'h7;
    parameter state_write1 =    4'h8;
    parameter state_end =       4'h9;

    reg [4:0] state;
    reg [4:0] next_state;

    always @* begin
        element_write = 1'b0;
        element_drive = 1'b0;
        add13_drive = 1'b0;
        minus26_drive = 1'b0;
        i_write = 1'b0;
        i_drive = 1'b0;
        add1_drive = 1'b0;
        memory_write = 1'b0;
        memory_drive = 1'b0;
        address_write = 1'b0;
        next_state = state_reset;

        case (state)

            state_reset: begin
                next_state = state_address;
            end

            state_address: begin
                // let address read what is in i
                address_write = 1'b1;
                i_drive = 1'b1;
                next_state = state_read0;
            end

            state_read0: begin
                // read memory[i]
                element_write = 1'b1;
                memory_drive = 1'b1;
                next_state = state_loop;
            end

            state_loop: begin
                // do we end or alter this value?
                if (isZero_out == 1'b1) begin
                    next_state = state_end;
                end else begin
                    next_state = state_write0;
                end
            end

            state_write0: begin
                // shift element by 13 spaces
                element_write = 1'b1;
                add13_drive = 1'b1;
                next_state = state_read1;
            end

            state_read1: begin
                // check if value in range
                if (greaterThan122_out == 1'b1) begin
                    next_state = state_wrap;
                end else begin
                    next_state = state_write1;
                end
            end

            state_wrap: begin
                // wrap out of range value back to beginning
                element_write = 1'b1;
                minus26_drive = 1'b1;
                next_state = state_write1;
            end

            state_increment: begin
                // increment i
                add1_drive = 1'b1;
                i_write = 1'b1;
                next_state = state_address;
            end

            state_write1: begin
                //set memory values
                memory_write = 1'b1;
                element_drive = 1'b1;
                next_state = state_increment;
            end

            state_end: begin
                next_state = state_end;
            end
            
        endcase
    end

    always @(posedge clock) begin
        if (reset == 1'b1) begin
            state <= state_reset;
        end else begin
            state <= next_state;
        end
    end

endmodule
