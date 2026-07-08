module top(
    input wire OSC_50,
    input wire [3:0] KEY,               // ~KEY[0] toggles reset
                                        // ~KEY[1] is manual clock
    output wire [6:0] HEX0,             // HEX1-HEX0 shows bus value
    output wire [6:0] HEX1,
    output wire [6:0] HEX2,             // HEX3-HEX2 shows current maximum
    output wire [6:0] HEX3,
    output wire [8:0] LED_GREEN);       // LED_GREEN[8] shows reset

    wire reset;
    wire clock;                         // clock signal for circuit

    wire [7:0] bus;

    wire [7:0] element_out;
    wire element_write, element_drive;

    wire [7:0] i_out;
    wire i_write, i_drive;

    wire [7:0] plus1_out;
    wire plus1_drive;

    wire [7:0] add13_out;
    wire add13_drive;

    wire [7:0] minus26_out;
    wire minus26_drive;

    wire [7:0] greatThan122_out;

    wire [7:0] isZero_out;

    wire address_write;
    wire memory_write;
    wire [7:0] memory_out;
    wire memory_drive;

    reset_toggle u1 (OSC_50, ~KEY[0], 1'b0, reset, LED_GREEN[8]); // maintains the reset signal
    clocks u2 (OSC_50, ~KEY[1], clock);

    register u3 (clock, reset, element_write, bus, element_out);
    register u4 (clock, reset, max_write, bus, max_out);
    register u5 (clock, reset, i_write, bus, i_out);

    greaterThan122 u6 (element_out, greatThan122_out);
    isZero u7 (element_out, isZero_out);
    add13 u8 (element_out, add13_out);
    subtract_26 u9 (element_out, minus26_out);
    plus1 u10 (i_out, plus1_out);

    ram u22 (bus, ~address_write, clock, bus, memory_write, memory_out);

    tristate u11 (element_out, bus, element_drive);
    tristate u12 (minus26_out, bus, minus26_drive);
    tristate u13 (add13_out, bus, add13_drive);
    tristate u14 (plus1_out, bus, plus1_drive);
    tristate u15 (i_out, bus, i_drive);
    tristate u16 (memory_out, bus, memory_drive);

    hexdigit u17 (bus[3:0], HEX0);      // display bus on HEX0, HEX1 for debugging
    hexdigit u18 (bus[7:4], HEX1);

    control u21 (clock, reset, isZero_out, greatThan122_out, element_write,
             element_drive, add13_drive, minus26_drive, i_write, i_drive, plus1_drive,
             memory_write, memory_drive, address_write); 
endmodule
