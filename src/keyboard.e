ps2                         add ps2_called ps2_called num_1  
						   // read 
						    be ps2_prompt update_keyboard_called num_0 

						    cp ps2_pressed 0x80000021
                            cp ps2_ascii 0x80000022

						    be ps2_prompt ps2_pressed num_0
						    cp update_current_ascii ps2_ascii

ps2_prompt		            cp 0x80000020 num_1 

                            // return
                            ret ps2_ra


ps2_zero 0
ps2_one 1
ps2_pressed 0
ps2_ascii 0
ps2_ra 0
ps2_turn 0
ps2_called 450000000
