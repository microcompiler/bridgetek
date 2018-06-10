#include "main.h"

#define GPIO_NUM (16)

namespace first_namespace {
    void setup(){     
        gpio_dir(GPIO_NUM, pad_dir_output);
    }
}

namespace second_namespace {
    void loop(){             
        gpio_toggle(GPIO_NUM);           
        for (int c = 1; c <= 32767; c++)
            delayms(250);
    }
}

int main(void) 
{    
    first_namespace::setup();
    for(;;) second_namespace::loop();
    return 0;
}                                                                                                       