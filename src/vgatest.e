vgatest			cp vga_x1 vgatest_x1
				cp vga_y1 vgatest_y1
				cp vga_x2 vgatest_x2
				cp vga_y2 vgatest_y2

				cp vga_color_write vgatest_color_write
				
				call vga vga_ra

				halt

//variables
vgatest_x1 10
vgatest_y1 10
vgatest_x2 629
vgatest_y2 469

vgatest_color_write 16750848 

#include vga.e
