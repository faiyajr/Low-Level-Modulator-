play_wave				bne play_wave_start play_wave_i play_wave_l
						cp play_wave_i num_0

play_wave_start			be play_wave_user main_state num_2	
						// Else play the goal wave
						cpfa speaker_sample target_arr play_wave_i
						
						be play_wave_end 0 0						

play_wave_user			cpfa speaker_sample mod_arr play_wave_i
									


play_wave_end			ret play_wave_ra











play_wave_i				0
play_wave_l				36
play_wave_ra			0
