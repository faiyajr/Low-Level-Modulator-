clear_display	cp vga_x1 clear_display_x1
				cp vga_y1 clear_display_y1
				cp vga_x2 clear_display_x2
				cp vga_y2 clear_display_y2

				cp vga_color_write clear_display_color_write
				
				call vga vga_ra

				ret clear_display_ra

//variables
clear_display_x1 0
clear_display_y1 0
clear_display_x2 639
clear_display_y2 479

clear_display_color_write 13794605
clear_display_ra 0

//#include vga.e