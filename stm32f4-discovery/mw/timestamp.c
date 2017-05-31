#include <stm32f407xx.h>
#include <mw/test/calltrace.h>

void __attribute__((constructor)) enable_timestamp()
{
    SysTick->CTRL |= 0b1;
    SysTick->LOAD = 0xFFFFFFFu;

    mw_timestamp_t ts = mw_timestamp();
}

mw_timestamp_t __attribute__((no_instrument_function)) mw_timestamp()
{
    return 0xFFFFFFu - SysTick->VAL;
}
