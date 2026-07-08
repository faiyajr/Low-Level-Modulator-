/*
 * Copyright (c) 2006, Peter M. Chen.  All rights reserved.  This software is
 * supplied as is without expressed or implied warranties of any kind.
 *
 * Allows the E100 to read a memory-register from an I/O device.
 * Only update the value from the I/O device when update=1.
 */
module in_port #(parameter WIDTH=32) (
    input wire [31:0] port_number,
    input wire clock_io,
    input wire update,
    input wire clock,
    input wire [31:0] address,
    input wire memory_drive,
    output reg [31:0] bus,
    input wire [WIDTH-1:0] port_pins);

    reg [WIDTH-1:0] port_pins_reg;

    wire [WIDTH-1:0] port_pins_sync;

    always @(posedge clock_io) begin
        if (update == 1'b1) begin
	    port_pins_reg <= port_pins;
	end
    end

    // control output to the bus
    synchronizer #(.WIDTH(WIDTH)) u1 (clock, port_pins_reg, port_pins_sync);
    
    always @* begin
        if (memory_drive == 1'b1 && address == port_number) begin
            bus = { {(32-WIDTH){1'b0}}, port_pins_sync };
        end else begin
            bus = {32{1'bz}};
        end
    end

endmodule
