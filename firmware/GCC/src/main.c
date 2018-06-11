#include "main.h"

#define GPIO_NUM (16)

static uint16_t count;

void setup() {     
    gpio_dir(GPIO_NUM, pad_dir_output);
}

void loop() {
    for (uint8_t x=0; x < 3; x++){
        delayms(1);
    }

    if (count < 65535) {
        count++; 
        gpio_toggle(GPIO_NUM);
        delayms(250);
    }
    else{
        count = 0;
    }
}

int main(void)  {    
    setup();
    for(;;) loop();
    return 0;
}