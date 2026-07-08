main			cp 		modulator_base_wave_select		main_num1
				cp		modulator_wave_select			main_num0
				cp		modulate_arr_select				main_num0
				cp 		angular_freq					main_num6
				cp		amplitude						main_num2
				cp		phase_deviation_amp				main_num3
				cp		phase_deviation_phase			main_num2
				cp		modulator_select_pm				main_num1
				cp		modulator_select_fm				main_num1
				cp		modulator_select_am				main_num1
				cp 		modulator_select_reset			main_num0
				call	modulator		modulator_ra
main_loop		be 		main_reseti 	maini 	mod_arrl
				cpfa 	speaker_sample 	mod_arr maini
poll_speaker    cp      speaker_turn    0x80000040
                bne     poll_speaker    speaker_turn    main_num0
				call	speaker			speaker_ra
main_ra			add 	maini 			maini 	main_num1
				be 		main_loop		0 		0
main_reseti		cp 		maini 			main_num0
				be 		main_loop 		0 		0

maini			0

main_numn2		-2 
main_numn1		-1
main_num0		0
main_num1		1
main_num2		2
main_num3		3
main_num4		4
main_num5		5
main_num6		6
main_num7		7

#include speaker.e
#include modulator.e
