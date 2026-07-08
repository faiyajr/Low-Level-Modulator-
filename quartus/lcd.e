lcd_write cp 0x80000011 lcd_x
    cp 0x80000012 lcd_y
    cp 0x80000013 lcd_ascii
    cp 0x80000010 lcd_one
lcd_wait2 cp turn 0x80000010
    bne lcd_wait2 turn lcd_zero
    ret lcd_ra

lcd_ra      0
lcd_zero    0
lcd_one     1
lcd_x       0
lcd_y       0
lcd_ascii    0
lcd_turn    0x80000010
turn 0
//bne lcd_write lcd_turn lcd_zero