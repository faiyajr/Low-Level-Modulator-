modulator                   sub     modulatori                  modulatori          modulatori
                            sub     modulatori_shifted          modulatori_shifted  modulatori_shifted
//                          ^ Make sure iterators are reset
//                          Fetch values for selected base wave/mod wave/carrier wave
fetch_base_wave             be      fetch_base_saw              modulator_one       modulator_base_wave_select
                            be      fetch_base_square           modulator_two       modulator_base_wave_select

fetch_base_sine             be      fetch_base_done             modulatori          sine_arrl
                            cpfa    sine_arr_val                sine_arr            modulatori
                            cpta    sine_arr_val                mod_arr             modulatori
                            add     modulatori                  modulatori          modulator_one
                            be      fetch_base_sine             modulator_zero      modulator_zero
fetch_base_saw              be      fetch_base_done             modulatori          saw_arrl
                            cpfa    saw_arr_val                 saw_arr             modulatori
                            cpta    saw_arr_val                 mod_arr             modulatori
                            add     modulatori                  modulatori          modulator_one
                            be      fetch_base_saw              modulator_zero      modulator_zero
fetch_base_square           be      fetch_base_done             modulatori          square_arrl
                            cpfa    square_arr_val              square_arr          modulatori
                            cpta    square_arr_val              mod_arr             modulatori
                            add     modulatori                  modulatori          modulator_one
                            be      fetch_base_square           modulator_zero      modulator_zero
fetch_base_done             sub     modulatori                  modulatori          modulatori
//                          Reset from here after here so that the correct values are passed
                            be      modulator_reset             modulator_one       modulator_select_reset
//                          Copy the first value from the base wave to modulate
                            cpfa    mod_arr_val                 mod_arr             modulatori
//                          Fetch values for selected modulating wave
fetch_mod_wave              be      fetch_mod_saw              modulator_one       modulator_wave_select
                            be      fetch_mod_square           modulator_two       modulator_wave_select

fetch_mod_sine              be      fetch_mod_done             modulatori          sine_arrl
                            cpfa    sine_arr_val               sine_arr            modulatori
                            cpta    sine_arr_val               mod_wave_arr        modulatori
                            add     modulatori                 modulatori          modulator_one
                            be      fetch_mod_sine             modulator_zero      modulator_zero
fetch_mod_saw               be      fetch_mod_done             modulatori          saw_arrl
                            cpfa    saw_arr_val                saw_arr             modulatori
                            cpta    saw_arr_val                mod_wave_arr        modulatori
                            add     modulatori                 modulatori          modulator_one
                            be      fetch_mod_saw              modulator_zero      modulator_zero
fetch_mod_square            be      fetch_mod_done             modulatori          square_arrl
                            cpfa    square_arr_val             square_arr          modulatori
                            cpta    square_arr_val             mod_wave_arr        modulatori
                            add     modulatori                 modulatori          modulator_one
                            be      fetch_mod_square           modulator_zero      modulator_zero
fetch_mod_done              sub     modulatori                 modulatori          modulatori
//  
//  phase_mod //time_var_amp is constant, while phase dev is controlled
//  freq_mod  //time_var_amp constant, freq and amp controlled  
//  amp_mod   //angle term constant
//
modulating_wave_loop        be      modulator_end               modulatori          mod_arrl
//                          Initialize the iterator and wave values (do nothing) to default if no options selected
                            add     modulatori_shifted          modulator_zero      modulatori
//                          Branch to frequency modulation if phase not selected
                            be      wave_loop_freq              modulator_zero      modulator_select_pm
//                          Start with phase shift of phi and copy from modulating wave
wave_loop_phase             add     modulatori_shifted          modulatori          phase_deviation_phase
//                          Shift index if it goes over length of modulating array length
                            blt     phase_loop_continue_one     modulatori_shifted  mod_wave_arrl
                            sub     modulatori_shifted          modulatori_shifted  mod_wave_arrl
phase_loop_continue_one     cpfa    mod_wave_arr_val            mod_wave_arr        modulatori_shifted
                            sub     modulator_sum               modulator_zero      phase_deviation_amp
//                          Branch if amplitude is negative (inverse scaling) otherwise, scale modulating wave
                            sub     modulatori_shifted          modulatori_shifted  modulatori_shifted
                            blt     inverse_amplitude           modulator_zero      modulator_sum
                            mult    modulator_prod              mod_wave_arr_val    phase_deviation_amp
                            be      phase_loop_continue_two     modulator_zero      modulator_zero
inverse_amplitude           be      phase_loop_continue_two     modulatori_shifted  modulator_sum
                            div     mod_wave_arr_val            mod_wave_arr_val    modulator_two
                            add     modulatori_shifted          modulatori_shifted  modulator_one
                            be      inverse_amplitude           modulator_zero      modulator_zero
phase_loop_continue_two     div     mod_wave_arr_val            mod_wave_arr_val    modulator_twopfrtn
                            mult    mod_wave_arr_val            mod_wave_arr_val    modulator_thirtysix
                            div     modulatori_shifted          mod_wave_arr_val    modulator_twopfftn
                            be      wave_loop_freq              modulator_one       modulator_select_fm
                            add     modulatori_shifted          modulatori          modulatori_shifted
                            blt     phase_loop_continue_three   modulatori_shifted  modulator_zero
                            add     modulatori_shifted          mod_arrl            modulatori_shifted
phase_loop_continue_three   blt     phase_loop_end              modulatori_shifted  mod_arrl
                            sub     modulatori_shifted          modulatori_shifted  mod_arrl
phase_loop_end              cpfa    mod_arr_val                 mod_arr             modulatori_shifted
wave_loop_freq              be      wave_loop_amp               modulator_zero      modulator_select_fm
                            mult    modulator_prod              modulatori          angular_freq
                            sub     modulatori_shifted          modulatori_shifted  modulatori
                            add     modulatori_shifted          modulator_prod      modulator_zero
frequency_check             blt     freq_loop_continue          modulatori_shifted  mod_wave_arrl
                            sub     modulatori_shifted          modulatori_shifted  mod_wave_arrl
                            be      frequency_check             modulator_zero      modulator_zero
freq_loop_continue          cpfa    mod_arr_val                 mod_arr             modulatori_shifted
wave_loop_amp               be      modulating_wave_loop_end    modulator_zero      modulator_select_am
                            mult    mod_arr_val                 mod_arr_val         amplitude
modulating_wave_loop_end    be      user_wave                   modulate_arr_select modulator_zero
                            cpta    mod_arr_val                 target_arr          modulatori
                            be      skip1                       modulator_zero      modulator_zero
user_wave                   cpta    mod_arr_val                 mod_arr             modulatori
skip1                       div     modulator_prod              mod_arr_val         modulator_tenpthree
                            mult    modulator_prod              modulator_prod      modulator_sixnineeight
                            div     modulator_prod              modulator_prod      modulator_tenpseven
                            sub     modulator_sum               modulator_ninety    modulator_prod
                            add     vis_mod_arr_val             modulator_onefourty modulator_sum
                            be      user_vis_wave               modulate_arr_select modulator_zero
                            cpta    vis_mod_arr_val             vis_target_arr      modulatori
                            be      modulator_end_cont          modulator_zero      modulator_zero
user_vis_wave               cpta    vis_mod_arr_val             vis_mod_arr         modulatori           
modulator_end_cont          add     modulatori                  modulatori          modulator_one
                            cpfa    mod_arr_val                 mod_arr             modulatori
                            be      modulating_wave_loop        modulator_zero      modulator_zero
modulator_reset             cp      modulator_wave_select       modulator_zero
                            cp      angular_freq                modulator_one
                            cp      amplitude                   modulator_one
                            cp      phase_deviation_amp         modulator_zero
                            cp      phase_deviation_phase       modulator_zero
                            cp      modulator_select_reset      modulator_zero
                            be      modulating_wave_loop        modulator_zero      modulator_zero


modulator_end               ret     modulator_ra
//
modulator_base_wave_select  0 //0-sine,1-saw,2-square
modulator_wave_select       0 //0-sine,1-saw,2-square
modulate_arr_select         0 //0-user,1-target
angular_freq                1 // [0,10]
amplitude                   1 // [-3,2]
phase_deviation_amp         0 // [-3,2]
phase_deviation_phase       0 // [0,7]
modulator_select_pm         1
modulator_select_fm         1
modulator_select_am         1
modulator_select_reset      0

modulator_ra                0
//

//
modulator_zero              0
modulator_one               1
modulator_two               2
modulatori                  0
modulatori_shifted          0
modulator_prod              0
modulator_sum               0
modulator_twopfrtn          16384 //2^14
modulator_twopfftn          32768 //2^15
modulator_tenpthree         1000 //10^3
modulator_sixnineeight      698
modulator_tenpseven         10000000 //10^7
modulator_ninety            90
modulator_onefourty         140
modulator_thirtysix         36
//                          ^There three are used to pull down values to use as indexes into waves (1-36)
//
#include sine.e
#include saw.e
#include square.e
#include mod_wave.e
#include mod_arr.e
#include vis_mod_arr.e
#include target_arr.e
#include vis_target_arr.e