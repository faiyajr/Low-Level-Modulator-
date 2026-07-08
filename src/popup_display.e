popup_display           mult pixel_i screen_total_pix screen_i
                        add screen_end_i pixel_i screen_total_pix
                        cp row_i num_0
                        cp vga_x1 0
                        cp vga_x2 170
                        cp vga_y1 0
                        cp vga_y2 50 
                        cp vga_color_write 0
black_vga_wait          cp vga_turn 0x80000060
                        bne black_vga_wait vga_turn vga_zero
                        call vga vga_ra


frst_loop               be end_screen row_i screen_h
                        cp column_i num_0

nested_scnd_loop        be rowIterate column_i screen_w
                        be end_screen pixel_i last_pixel_index
                        cp sd_write screen_bin_read
                        cp sd_address pixel_i
popup_wait_sd           cp sd_turn 0x80000080
                        bne wait_sd sd_turn sd_zero
                        call sd sd_ra
                        be skip_black_pixel sd_data_read num_0
                        cp vga_x1 column_i
                        cp vga_x2 column_i
                        cp vga_y1 row_i
                        cp vga_y2 row_i
                        cp vga_color_write sd_data_read
popup_vga_wait          cp vga_turn 0x80000060
                        bne popup_vga_wait vga_turn vga_zero
                        call vga vga_ra

skip_black_pixel        add column_i column_i num_1
                        add pixel_i pixel_i num_1
                        bne nested_scnd_loop num_0 num_1

rowIterate              add row_i row_i num_1
                        bne frst_loop num_0 num_1

end_screen              ret popup_ra

// variables
screen_h 480
screen_w 640
screen_total_pix 307200
screen_i 0
screen_end_i 0
pixel_i 0
row_i 0
column_i 0
screen_bin_read 0
popup_ra 0
last_pixel_index 0

// last index for audio_play is at index 21446
// last index for goal is at index 19937
// last index for current is at index 19988







