vgatest			cp vga_x1 vgatest_x1
    				cp vga_y1 vgatest_y1
    				cp vga_x2 vgatest_x2
    				cp vga_y2 vgatest_y2

    				cp vga_color_write vgatest_color_write
            
testloop    add vgatest_color_write vgatest_color_write vgatest_one
            cp vga_color_write vgatest_color_write
            call vga vga_ra
            be end  vgatest_color_write  vgatest_max
            be  testloop  0  0
end        	halt

//variables
vgatest_x1 10
vgatest_y1 10
vgatest_x2 629
vgatest_y2 469
vgatest_one   65793
vgatest_max   16777215
vgatest_color_write 0 

#include vga.e
