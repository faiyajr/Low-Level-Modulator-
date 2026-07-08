screen_display          mult pixel_index screen_total_pixels screen_index
                        add screen_end_index pixel_index screen_total_pixels
                        cp row_index num_0

first_loop              be screen_end row_index screen_height
                        cp column_index num_0

nested_second_loop      cp sd_write screen_binary_read
                        cp sd_address pixel_index
wait_sd                 cp sd_turn 0x80000080
                        bne wait_sd sd_turn sd_zero
                        call sd sd_ra
                        cp vga_x1 column_index
                        cp vga_x2 column_index
                        cp vga_y1 row_index
                        cp vga_y2 row_index
                        cp vga_color_write sd_data_read
wait_vga                cp vga_turn 0x80000060
                        bne wait_vga vga_turn vga_zero
                        call vga vga_ra
                        add column_index column_index num_1
                        add pixel_index pixel_index num_1
                        bne nested_second_loop column_index screen_width

row_iterate             add row_index row_index num_1
                        bne first_loop num_0 num_1

screen_end              ret screen_display_ra

// variables
screen_height 480
screen_width 640
screen_total_pixels 307200
screen_index 0
screen_end_index 0
pixel_index 0
row_index 0
column_index 0
screen_binary_read 0
screen_display_ra 0
