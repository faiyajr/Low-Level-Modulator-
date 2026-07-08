sd                  // waiting for turn    
                    //cp sd_turn 0x80000080
                    //bne sd sd_turn sd_zero     
                    

                    // set to write mode
                    cp 0x80000081 sd_write

                    // set the command parameters
                    cp 0x80000082 sd_address
                    cp 0x80000083 sd_data_write

                    // set turn to 1
                    cp 0x80000080 sd_one

                    // wait for sd card to be free
sd_wait             cp sd_turn 0x80000080
                    bne sd_wait sd_turn sd_zero

                    // read
                    cp sd_data_read 0x80000084
                    
                    // return
                    ret sd_ra

sd_turn 0
sd_one 1
sd_zero 0
sd_write 0
sd_address 0
sd_data_write 0
sd_data_read 0
sd_ra 0
