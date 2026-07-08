            cp lcd_ptr 0
            cp lcd_x 0
            cp lcd_y 0
loop        be done lcd_size i
            cpfa lcd_ascii msg_start i
            be done lcd_ascii t_zero
            call lcd_write lcd_ra 
            add lcd_x lcd_x t_one
            add i i t_one
            be loop t_zero t_zero
done        halt

t_zero      0
t_one       1
lcd_ptr     0
lcd_size    11
i           0

msg_start   104
            101
            108
            108
            111
            32
            119
            111
            114
            108
            100

#include lcd.e