draw_sample         sub draw_sample_x1 draw_sample_x num_1
                    add draw_sample_x2 draw_sample_x num_1

                    sub draw_sample_y1 draw_sample_y num_1
                    add draw_sample_y2 draw_sample_y num_1

                    sub draw_sample_reset_y1 draw_sample_y1 num_1
                    add draw_sample_reset_y2 draw_sample_y2 num_1

                    cp box_draw_x1 draw_sample_x1
                    cp box_draw_x2 draw_sample_x2

                    // Draw the sample
                    // cp box_draw_y1 draw_sample_y1
                    // cp box_draw_y2 draw_sample_y2
						
				    // cp box_draw_color_write draw_sample_color_write

                    // call box_draw box_draw_ra

                    // cp box_draw_color_write create_window_frame_color_write

                    // Clear above
                    // cp box_draw_y1 num_60
                    // cp box_draw_y2 draw_sample_reset_y1

                    // call box_draw box_draw_ra

                    // Clear below
                    // cp box_draw_y1 draw_sample_reset_y2
                    // cp box_draw_y2 num_419

                    // call box_draw box_draw_ra

                    ret draw_sample_ra

// take in sample value, take in previous sample x, draw new one on the next x

draw_sample_one     1
draw_sample_359     359
draw_sample_419     419
draw_sample_bignum  2147483647
draw_sample_bignumn -2147483647
draw_sample_x       0
draw_sample_y       0
draw_sample_x1      0
draw_sample_y1      0
draw_sample_x2      0
draw_sample_y2      0
draw_sample_ra      0
draw_sample_color_write 3800852
draw_sample_reset_y1 0
draw_sample_reset_y2 0
