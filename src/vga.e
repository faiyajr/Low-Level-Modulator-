vga			    // cp vga_turn 0x80000060
                // bne vga vga_turn vga_zero

				// set to write mode
				cp 0x80000061 vga_write 

                // set cooridnate parameters
                cp 0x80000062 vga_x1
                cp 0x80000063 vga_y1
                cp 0x80000064 vga_x2
                cp 0x80000065 vga_y2

                // write color 
                cp 0x80000066 vga_color_write

                // make vga_turn 1
				cp vga_turn vga_one
                cp 0x80000060 vga_turn

                 // return address
                ret vga_ra
// variables
vga_turn 0
vga_zero 0
vga_one 1 
vga_write 1
vga_x1 0
vga_x2 0
vga_y1 0
vga_y2 0
vga_color_write 0
vga_ra 0
vga_ret 0
