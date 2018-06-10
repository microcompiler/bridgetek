#include "main.h"

#define GPIO_NUM (16)

void setup()
{     
    gpio_dir(GPIO_NUM, pad_dir_output);
}

void loop()
{
    gpio_toggle(GPIO_NUM);
    delayms(250);
}

int main(void) 
{    
    setup();
    for(;;) loop();
    return 0;
}                                                                                                       