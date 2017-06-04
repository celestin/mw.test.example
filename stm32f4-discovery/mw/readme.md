# M&W Imported

The sources [calltrace.c](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/mw/calltrace.c) and [mw_newlib_syscalls.c](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/mw/mw_newlib_syscalls.c) are taken from [mw.test](https://github.com/mw-sc/mw.test).
The [timestamp.c](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/mw/timestamp.c) implements a function so a timestamp can be obtained. This works in the following way:

```cpp
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
```

The `enable_timestamp` enables the Systick counter which is returned by `mw_timestamp()`. Note that the counter register has 24 bits and is decrementing.