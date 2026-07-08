update					cp update_state main_state
						
						cp speaker_turn 0x80000040
						cp vga_turn 0x80000060
						cp ps2_turn 0x80000020
//						cp sd_turn 0x80000080
//						cp lcd_turn 0x80000010

						// speaker logic
						be update_post_vga main_state num_0
						be update_post_vga main_state num_1
						be update_post_speaker main_audio num_0
						bne update_post_speaker speaker_turn num_0
						call speaker speaker_ra
						add play_wave_i play_wave_i num_1 
update_post_speaker			
						// VGA logic
						bne update_post_vga vga_turn num_0
						call vga vga_ra	

						be update_post_vga main_state num_0
						be update_post_vga main_state num_1
						
						add draw_wave_ctr draw_wave_ctr num_1

update_post_vga		
						// Keyboard logic	
						bne update_post_ps2 ps2_turn num_0
						call ps2 ps2_ra
						cp update_keyboard_called num_1
update_post_ps2			
//						bne update_post_sd sd_turn num_0
//						call sd sd_ra
//update_post_sd			bne update_end lcd_turn num_0
//						call lcd lcd_ra

update_end				ret update_ra



update_state			0
update_ra				0
update_keyboard_called	0
update_current_ascii	0

#include vga.e
#include speaker.e
#include sd.e
#include keyboard.e
