draw_wave				bne draw_wave_start draw_wave_ctr num_3

		    			cp draw_wave_ctr num_0
						add draw_wave_i draw_wave_i num_1
						add draw_wave_x draw_wave_x num_16 

						bne draw_wave_i_incr draw_wave_x draw_wave_x_l
						cp draw_wave_x num_16

draw_wave_i_incr		bne draw_wave_start draw_wave_i num_36
						cp draw_wave_i num_0

draw_wave_start			be draw_wave_user main_state num_2	
						// Else play the goal wave
						cpfa draw_wave_val vis_target_arr draw_wave_i

						be draw_wave_x_calc 0 0

draw_wave_user			cpfa draw_wave_val vis_mod_arr draw_wave_i



draw_wave_x_calc		sub vga_x1 draw_wave_x num_1
						add vga_x2 draw_wave_x num_1

		      			be draw_wave_sample draw_wave_ctr num_1
						be draw_wave_lower draw_wave_ctr num_2
draw_wave_upper			cp vga_y1 draw_wave_min_y
						sub vga_y2 draw_wave_val num_2	
						cp vga_color_write num_0

						be draw_wave_end 0 0
draw_wave_sample		sub vga_y1 draw_wave_val num_1
						add vga_y2 draw_wave_val num_1
						cp vga_color_write draw_wave_sample_color

						be draw_wave_end 0 0
draw_wave_lower			add vga_y1 draw_wave_val num_2
						cp vga_y2 draw_wave_max_y
						
						cp vga_color_write num_0

draw_wave_end			ret draw_wave_ra


draw_wave_i				0
draw_wave_l				36
draw_wave_x				16
draw_wave_x_l			640
draw_wave_val			0
draw_wave_ctr			0

draw_wave_min_y			90
draw_wave_max_y			389

draw_wave_ra			0	

draw_wave_sample_color	16629250
