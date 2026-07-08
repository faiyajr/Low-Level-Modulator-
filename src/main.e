main				    
main_loop				

// welcome screen main_state = 0
main_welcome			cp main_state num_0
						cp screen_index num_0
						call screen_display screen_display_ra

main_welcome_loop		call update update_ra
						bne main_welcome_loop update_current_ascii key_enter 	

main_selection			cp update_current_ascii num_0
						cp main_state num_1
						cp screen_index num_1
						call screen_display screen_display_ra

main_selection_loop		call update update_ra
						be main_welcome update_current_ascii key_backspace
						be main_select_sine	update_current_ascii key_1	
						be main_select_square update_current_ascii key_2
						be main_select_saw update_current_ascii key_3
						be main_selection_loop 0 0

main_select_sine	
						and main_which_wave 0x80000000 num_1					
						add main_state main_which_wave num_2
	
						cp main_targeti num_0
main_target_sine_lp		be main_target_sine_end main_targeti num_9
						cpfa main_targetv target8 main_targeti
						cpta main_targetv modulator_base_wave_select main_targeti
						add main_targeti main_targeti num_1
						be main_target_sine_lp 0 0
main_target_sine_end	call modulator modulator_ra

						cp modulator_select_reset num_1
						cp modulate_arr_select num_0
						call modulator modulator_ra

						
						be main_game_start 0 0

main_select_saw	
						and main_which_wave 0x80000000 num_1					
						add main_state main_which_wave num_2
						
						cp main_targeti num_0
main_target_saw_lp		be main_target_saw_end main_targeti num_9
						cpfa main_targetv target4 main_targeti
						cpta main_targetv modulator_base_wave_select main_targeti
						add main_targeti main_targeti num_1
						be main_target_saw_lp 0 0
main_target_saw_end		call modulator modulator_ra
						cp modulator_select_reset num_1
						cp modulate_arr_select num_0
						call modulator modulator_ra

						

						be main_game_start 0 0						

main_select_square	
						and main_which_wave 0x80000000 num_1					
						add main_state main_which_wave num_2
			
						cp main_targeti num_0
main_target_square_lp	be main_target_square_end main_targeti num_9
						cpfa main_targetv target3 main_targeti
						cpta main_targetv modulator_base_wave_select main_targeti
						add main_targeti main_targeti num_1
						be main_target_square_lp 0 0
main_target_square_end	call modulator modulator_ra
						cp modulator_select_reset num_1
						cp modulate_arr_select num_0
						call modulator modulator_ra

						be main_game_start 0 0
	
main_game_start			be main_game_start_user main_state num_2
						cp screen_index num_2
						call screen_display screen_display_ra
						be main_game_loop 0 0	
main_game_start_user	cp screen_index num_3
						call screen_display screen_display_ra

//happens when main_state = 2
main_game_loop			call play_wave play_wave_ra
						call draw_wave draw_wave_ra
						
						call update update_ra

						be main_selection update_current_ascii key_backspace	
						be main_amp_up update_current_ascii key_Q
main_amp_up_ra		   	be main_amp_down update_current_ascii key_A
main_amp_down_ra		be main_freq_up update_current_ascii key_W
main_freq_up_ra			be main_freq_down update_current_ascii key_S
main_freq_down_ra		be main_phase_amp_up update_current_ascii key_E
main_phase_amp_up_ra	be main_phase_amp_down update_current_ascii key_D
main_phase_amp_down_ra	be main_phase_shift_up update_current_ascii key_T
main_phase_shift_up_ra	be main_phase_shift_down update_current_ascii key_G
main_phase_shft_down_ra be main_mod_wave_up update_current_ascii key_Y
main_wave_up_ra			be main_mod_wave_down update_current_ascii key_H
main_wave_down_ra		be main_wave_reset update_current_ascii key_R
						
						be main_post_mod 0 0

main_amp_up				cp update_current_ascii num_0
						be main_post_mod amplitude num_2
						add amplitude amplitude num_1
						be main_post_mod 0 0
main_amp_down			cp update_current_ascii num_0
						be main_post_mod amplitude num_n3
						sub amplitude amplitude num_1
						be main_post_mod 0 0
main_freq_up			cp update_current_ascii num_0
						be main_post_mod angular_freq num_10	
						add angular_freq angular_freq num_1
						be main_post_mod 0 0
main_freq_down			cp update_current_ascii num_0
						be main_post_mod angular_freq num_0
						sub angular_freq angular_freq num_1
						be main_post_mod 0 0
main_phase_amp_up		cp update_current_ascii num_0
						be main_post_mod phase_deviation_amp num_2
						add phase_deviation_amp phase_deviation_amp num_1
						be main_post_mod 0 0
main_phase_amp_down		cp update_current_ascii num_0
						be main_post_mod phase_deviation_amp num_n3
						sub phase_deviation_amp phase_deviation_amp num_1   
						be main_post_mod 0 0
main_phase_shift_up		cp update_current_ascii num_0
						be main_post_mod phase_deviation_phase num_7
						add phase_deviation_phase phase_deviation_phase num_1
						be main_post_mod 0 0
main_phase_shift_down	cp update_current_ascii num_0
						be main_post_mod phase_deviation_phase num_0
						sub phase_deviation_phase phase_deviation_phase num_1
						be main_post_mod 0 0
main_mod_wave_up		cp update_current_ascii num_0
						be main_wave_up_loop modulator_wave_select num_2
						add modulator_wave_select modulator_wave_select num_1
						be main_post_mod 0 0
main_wave_up_loop		cp update_current_ascii num_0
						cp modulator_wave_select num_0
						be main_post_mod 0 0
main_mod_wave_down		cp update_current_ascii num_0
						be main_wave_down_loop modulator_wave_select num_0
						sub modulator_wave_select modulator_wave_select num_1
						be main_post_mod 0 0
main_wave_down_loop		cp update_current_ascii num_0
						cp modulator_wave_select num_2
						be main_post_mod 0 0
main_wave_reset			cp update_current_ascii num_0
						cp modulator_select_reset num_1


main_post_mod			call modulator modulator_ra

						be main_game_loop_user main_state num_2
						
						and main_which_wave 0x80000000 num_1					
						add main_state main_which_wave num_2	

						be main_switch_user	main_state num_2
						be main_game_loop 0 0
main_switch_user		cp screen_i num_3
						cp last_pixel_index num_19988
						call popup_display popup_ra
						be main_game_loop 0 0	

main_game_loop_user		and main_which_wave 0x80000000 num_1					
						add main_state main_which_wave num_2	
	
						be main_switch_goal main_state num_3
						be main_game_loop 0 0
main_switch_goal		cp screen_i num_2
						cp last_pixel_index num_19937
						call popup_display popup_ra
						be main_game_loop 0 0	
							
						be main_game_loop 0 0

main_end				halt






main_state				0
// if 0, welcome, if 1 selection, if 2 user wave, if 3 goal wave.
main_audio				1
main_which_wave			0
main_targeti			0
main_targetv			0

#include play_wave.e
#include draw_wave.e
#include num.e
#include screen_display.e
#include update.e
#include key.e
#include modulator.e
#include target_settings.e
#include popup_display.e
