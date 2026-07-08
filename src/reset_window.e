reset_window            cp box_draw_x1 reset_top_x1
                        cp box_draw_y1 reset_top_y1
                        cp box_draw_x2 reset_top_x2
                        cp box_draw_y2 reset_top_y2
                        cp box_draw_color_write reset_color_write
                        call box_draw box_draw_ra

                       
						cp box_draw_x1 reset_bottom_x1
                        cp box_draw_y1 reset_bottom_y1
                        cp box_draw_x2 reset_bottom_x2
                        cp box_draw_y2 reset_bottom_y2
                        cp box_draw_color_write reset_color_write
                        call box_draw box_draw_ra
		


						cp box_draw_x1 reset_right_x1
                        cp box_draw_y1 reset_right_y1
                        cp box_draw_x2 reset_right_x2
                        cp box_draw_y2 reset_right_y2
                        cp box_draw_color_write reset_color_write
                        call box_draw box_draw_ra




						cp box_draw_x1 reset_left_x1
                        cp box_draw_y1 reset_left_y1
                        cp box_draw_x2 reset_left_x2
                        cp box_draw_y2 reset_left_y2
                        cp box_draw_color_write reset_color_write
                        call box_draw box_draw_ra


						cp box_draw_x1 reset_x1
                        cp box_draw_y1 reset_y1
                        cp box_draw_x2 reset_x2
                        cp box_draw_y2 reset_y2
                        cp box_draw_color_write reset_color_frame
                        call box_draw box_draw_ra
                        ret reset_window_ra

reset_top_x1			0
reset_top_x2			639
reset_top_y1			0
reset_top_y2			59
reset_right_x1			580
reset_right_x2			639
reset_right_y1			0
reset_right_y2			479
reset_bottom_x1			0
reset_bottom_x2			639
reset_bottom_y1			420
reset_bottom_y2			479
reset_left_x1			0
reset_left_x2			59
reset_left_y1			0
reset_left_y2			479

reset_x1 60
reset_y1 60
reset_x2 579
reset_y2 419
reset_color_frame 0
reset_color_write 13794605
reset_window_ra 0
