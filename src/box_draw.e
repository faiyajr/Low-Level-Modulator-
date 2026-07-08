box_draw			cp vga_x1 box_draw_x1
				    cp vga_y1 box_draw_y1
					cp vga_x2 box_draw_x2
					cp vga_y2 box_draw_y2

					cp vga_color_write box_draw_color_write
				
					call vga vga_ra

					ret box_draw_ra

//variables must be set before called


box_draw_x1 80
box_draw_y1 559
box_draw_x2 60
box_draw_y2 419
box_draw_color_write 10066431

box_draw_ra 0
