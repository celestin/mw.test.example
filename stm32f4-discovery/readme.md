# Project Structure

The given project is mainly derived from the project templates of the [gnuarmeclipse plugin](http://gnuarmeclipse.github.io/) but adds different things. The project structure is the same for the eclipse and the makefile project. As a matter of fact, the standalone makefiles are based on the generated ones.


## Subdir overview

Folder | Description
:------|:-----------
[build](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/build) | The makefiles for buliding without an IDE
[include](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/include) | The top-level header files, i.e. belonging to `./src`
[ldscripts](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/ldscripts) | The linker scripts, dereived from the gnuarmeclipse plugin.
[mw](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/mw) | The extension copied from [mw.test](https://github.com/mw-sc/mw.test)
[src](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/src) | The top-level sources
[sys](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys) | The system libraries, derived from the gnuarmeclipse plugin.
[test](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/test) | The files with the tests.


## Modules

The main application is a timed version of blinky, which was restructured to be easily testable. It mainly consists of an array of `BlinkLed` wrappers and a `Timer` which uses the `Systick_Handler` to time the led switching. The LEDs will display the number 0-16 as binary.


### BlinkLed

 - [BlinkLed.hpp](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/include/BlinkLed.hpp)
 - [BlinkLed.cpp](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/src/BlinkLed.cpp)

```
//BlinkLed.hpp
class BlinkLed
{
public:
  BlinkLed (unsigned int port, unsigned int bit, bool active_low);

  void powerUp ();
  void turnOn ();
  void turnOff ();
  void toggle ();
  bool is_on ();
};

extern std::array<BlinkLed, 4> blinkLeds;
```

The constructor takes the port and position in the port to construct. This is done in the definition of `blinkLeds` which can be found in [BlinkLed.cpp](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/src/BlinkLed.cpp#L94).

The `powerUp` needs to be called before using the LED, which than can be turned on, off or toggled.

The unit test can be found in the [test_blink.cpp](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/test/test_blink.cpp), see the [Test Blink](#test-blink) section.


### Timer

 - [Timer.hpp](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/include/Timer.hpp)
 - [Timer.cpp](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/src/Timer.cpp)

```
//Timer.hpp
class Timer
{
public:
  static constexpr ticks_t FREQUENCY_HZ = 1000u;
  // Default constructor
  Timer() = default;
  inline void start()
  {
    SysTick_Config(SystemCoreClock / FREQUENCY_HZ);
  }
  static void sleep(ticks_t ticks);
  static void tick(void) __attribute__((no_instrument_function));
};

extern "C" void SysTick_Handler();
```

The `start` function will initialize the `Systick` which we will be utilized by `sleep`. The `FREQUENCY_HZ` member can be used to set the time to be waited. When waiting the function `sleep` will set a number of ticks, which the `SysTick_Handler` will decrement until the value is zero. At this point it will return.

Note that the attribute is added to the `tick`and `SysTick_Handler` functions - this is because we do not want that to be traced unlike `sleep` and `start`. The reason is, that thoes functions will be called very often so that tracing is with the `dbg-runner` will be a major slowdown.

The class it not tested outside of the execution of [main.cpp](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/src/main.cpp), i.e. has no unit test.


## Tests

### Test Blink
### Test State