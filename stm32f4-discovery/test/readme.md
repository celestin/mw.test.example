# Tests

## Test Blink

 - [test_blink.cpp](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/test/test_blink.hpp)

The blnk test has four tests that test the the proper output registers are set given the proper input. For Led1 it looks as following:

```cpp
void led0()
{
    auto & led = blinkLeds[0];

    MW_ASSERT(!led.is_on());

    led.turnOn();

    MW_ASSERT(led.is_on());

    auto reg_state = GPIOD->ODR & (1 << 12);
    MW_ASSERT_NOT_EQUAL(reg_state, 0);


    led.toggle();
    MW_ASSERT(!led.is_on());
    reg_state = GPIOD->ODR & (1 << 12);
    MW_ASSERT_EQUAL(reg_state, 0);
}
```

The test executes a test-case for every led in the array, which is done with the following [code]

```cpp
int main(int argc, char * argv[])
{
    for (auto & led : blinkLeds)
        led.powerUp();

    for (auto & led : blinkLeds)
        led.turnOff();

    uint32_t reg_state = GPIOD->ODR & (0b1111u << 12u);

    MW_CRITICAL(MW_ASSERT_EQUAL_BITWISE(reg_state, 0));

    MW_CALL(&led0, "led 0 test");
    MW_CALL(&led1, "led 1 test");
    MW_CALL(&led2, "led 2 test");
    MW_CALL(&led3, "led 3 test");

    return MW_REPORT();
}
```


## Test State

 - [test_state.cpp](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/src/test_state.cpp)


The test state function will test out the statemachine, i.e. step through it an check if the right functions are called.
In addition it will demonstrate the usage of [mw-wrap](mw-sc.github.io/wrap/index.html) so we can test without triggering the hardware and usage of the calltrace.

### State 0

Since the test is rather long, we will only take a look at it partially. Here's the first step, i.e. the initial set when  the state is zero:

```cpp

int main(int argc, char * argv[])
{

    auto & leds = blinkLeds; //for shortening the thing

    for (auto & led : leds)
        led.turnOff(); //turn them all of, so the state is defined

    state s;
    auto st = s.get_state();
    MW_ASSERT_EQUAL_BITWISE(st, 0);

    {
        mw::test::calltrace<5> ct{
                &state::set,
                mw::test::mem_fn<>(&std::array<BlinkLed, 4>::data),
                &BlinkLed::is_on,
                &BlinkLed::is_on,
                &BlinkLed::is_on,
                &BlinkLed::is_on
                    };

        s.set(leds);
        MW_ASSERT(ct);
    }
```

Now as you can see, we check that the state is set correctly, but the calltrace is the interesting part. We implemented the [`state::set`](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/src/state.cpp#L26) function to obtain a pointer to the array through `data` and then not use any more methods. The reason we do that, is so the calltrace is easier.

The calltrace is declared inside the scope, so it only applies to the call of `set`in the same scope. Since we already turned all leds off and, the `set` function will only check all and then not have anything to do, thus our calltrace.

### State 7-8

The setting from state 7 (`0b0111`) to 8 (`0b1000`) is tested in the following way.

```cpp
    s.advance(); //8
    st = s.get_state();
    MW_ASSERT_EQUAL_BITWISE(st, 8);
    {
         mw::test::calltrace<9> ct{
                 &state::set,
                 mw::test::mem_fn<>(&std::array<BlinkLed, 4>::data),
                 &BlinkLed::is_on, &BlinkLed::turnOff,
                 &BlinkLed::is_on, &BlinkLed::turnOff,
                 &BlinkLed::is_on, &BlinkLed::turnOff,
                 &BlinkLed::is_on, &BlinkLed::turnOn
                     };

         s.set(leds);
         MW_ASSERT(ct);
    }
```

Since all states need to be changed, we have the corresponding call after the set function checks for `set_on`.

### Wrappers

To test without actually using the hardware we use the [wrap tool](mw-sc.github.io/wrap/index.html) to avoid the actual use of hardware. This might be necessary, because periphery connected to the controller might take damage due to inproper usage during testing. It of course also allows a clear separation between unit and integration tests.

```cpp
std::array<bool, 4> states;

MW_WRAP_MEM_FIX_NO_ARGS(BlinkLed, is_on, bool)
{
    MW_CHECKPOINT();
    auto pos = this_ - blinkLeds.data();
    return states[pos];
}

MW_WRAP_MEM_FIX_NO_ARGS(BlinkLed, turnOn, void)
{
    MW_CHECKPOINT();
    auto pos = this_ - blinkLeds.data();
    states[pos] = true;

}

MW_WRAP_MEM_FIX_NO_ARGS(BlinkLed, turnOff, void)
{
    MW_CHECKPOINT();
    auto pos = this_ - blinkLeds.data();
    states[pos] = false;
}
```

As part of the wrapped functions, we put the states into an array of bools and calculate the position from `this` and `blinkLeds`.