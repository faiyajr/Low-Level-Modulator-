/*
 * Copyright (c) 2006-2025 Peter M. Chen.  All rights reserved.  This software is
 * supplied as is without expressed or implied warranties of any kind.
 */

/*
 * I/O device register for a "turn" register.  This register can be set to 1
 * by the E100, or cleared to 0 by an I/O device.  This register communicates
 * to an I/O device via the standard command-response protocol.
 *     when turn goes from 0 -> 1, the turn register raises command
 *     when the I/O device raises response, the turn register completes the
 *         command-response protocol (i.e., lower command, wait for response to
 *         be lowered), then sets turn=0.
 * turn is set to 1 when the E100 writes to it
 * turn is cleared to 0 when the last command-response transaction is completed
 * turn can be read by the E100 anytime
 */
module turn_port (
    input wire [31:0] port_number,
    input wire clock,
    input wire clock_io,
    input wire clock_valid,
    input wire reset,
    input wire [31:0] address,
    input wire memory_drive,
    input wire memory_write,
    inout wire [31:0] bus,
    output wire command_io,
    input wire response_io);

    reg turn, next_turn;
    reg command, next_command;

    wire response;

    reg port_selected;          // this port is being selected by the current address

    parameter state_reset = 2'h0;
    parameter state_idle = 2'h1;
    parameter state_start = 2'h2;
    parameter state_ack = 2'h3;
    reg [1:0] state, next_state;

    always @* begin
	if (address == port_number) begin
	    port_selected = 1'b1;
	end else begin
	    port_selected = 1'b0;
	end
    end

    // output to bus
    tristate u1 ( {{31{1'b0}}, turn}, bus, memory_drive & port_selected);

    // interface to/from I/O controller
    synchronizer #(.WIDTH(1)) u2 (clock_io, command, command_io);
    synchronizer #(.WIDTH(1)) u3 (clock, response_io, response);

    // main state machine
    always @* begin
        // default values
	next_turn = 1'b0;
	next_command = 1'b0;
        next_state = state_reset;

        case (state)
	    state_reset: begin
	        next_state = state_idle;
	    end

	    state_idle: begin
	        if (memory_write & port_selected) begin
		    next_state = state_start;
		end else begin
		    next_state = state_idle;
		end
	    end

	    state_start: begin
		next_turn = 1'b1;
		next_command = 1'b1;
		if (response == 1'b1) begin
		    next_state = state_ack;
		end else begin
		    next_state = state_start;
		end
	    end

	    state_ack: begin
		next_turn = 1'b1;
	        next_command = 1'b0;
		if (response == 1'b0) begin
		    next_state = state_idle;
		end else begin
		    next_state = state_ack;
		end
	    end
	endcase
    end

    always @(posedge clock) begin
	if (clock_valid == 1'b0) begin
	end else if (reset == 1'b1) begin
	    state <= state_reset;
        end else begin
	    turn <= next_turn;
	    command <= next_command;
	    state <= next_state;
	end
    end

endmodule
