#include "main.h"

#define GPIO_NUM (16)

static int count;

namespace first_namespace {
    void setup(){     
        gpio_dir(GPIO_NUM, pad_dir_output);
    }
}

namespace second_namespace {
    void loop(){                
        for (short x=0; x < 3; x++){
            delayms(1);
        }

        if (count < 65535) {
            count++; 
            gpio_toggle(GPIO_NUM);
            delayms(250);
        }
        else {
            count = 0;
        }
    }
}

int main(void) 
{    
    first_namespace::setup();
    for(;;) second_namespace::loop();
    return 0;
}                                                                                                       