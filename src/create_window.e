create_window           call clear_display clear_display_ra
                        cp box_draw_x1 create_window_frame_x1
                        cp box_draw_y1 create_window_frame_y1
                        cp box_draw_x2 create_window_frame_x2
                        cp box_draw_y2 create_window_frame_y2
                        cp box_draw_color_write create_window_frame_color_write
                        call box_draw box_draw_ra
                        ret create_window_ra


//call create_window create_window_ra

create_window_frame_x1 60
create_window_frame_y1 60
create_window_frame_x2 579
create_window_frame_y2 419
create_window_frame_color_write 657434
create_window_ra 0

//makes the space, basic and maybe add a frame

#include clear_display.e
