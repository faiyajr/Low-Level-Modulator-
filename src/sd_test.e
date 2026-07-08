loop                cp sd_write sd_reading
                    cp sd_address current_addr
                    call sd sd_ra
                    cp 0x80000001 sd_data_read
                    add current_addr current_addr num_1_test
                    bne loop current_addr max_addr

sd_reading 0
current_addr 0
max_addr 211
num_1_test 1
num_8192_test 8192 

#include sd.e

