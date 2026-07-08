vga_start       // set vga turn to 0 and store address
                cp vga_turn 0x80000060
                bne vga_start vga_turn vga_zero

                // make vga's turn one to read color
                //cp 0x80000060 vga_one

vga_end
                // read in the sample
                cp vga_color_read 0x80000067

                // set cooridnate parameters
                cp vga_x1 0x80000062
                cp vga_y1 0x80000063
                cp vga_x2 0x80000064
                cp vga_y2 0x80000065

                // write color 
                cp vga_color_write 0x80000066

                 // make vga turn 1
                cp 0x80000060 vga_one

                // write to vga
                cp vga_write 0x80000061

                 // return address
                ret vga_ra
// variables
vga_turn 0
vga_zero 0
vga_one 1 
vga_write 0
vga_x1 0
vga_x2 0
vga_y1 0
vga_y2 0
vga_color_write 0
vga_ra 0
vga_ret 0
