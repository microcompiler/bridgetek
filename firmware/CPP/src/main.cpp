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
        if (count < 32767) count++; else count = 0;                      
            gpio_toggle(GPIO_NUM); 
    }
}

int main(void) 
{    
    first_namespace::setup();
    for(;;) second_namespace::loop();
    return 0;
}                                                                                                       