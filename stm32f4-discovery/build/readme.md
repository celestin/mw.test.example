# Build definition

## Get started

### Config

In order to setup the build you will need to add a `config.mk` file to the `build` folder , which sets the locations for the used tools.

Name | Description
:----|:-----------
`OPENOCD` | The openocd binary
`OPENOCD_OPT` | The options for the openocd run, the default setting is `--file interface/stlink-v2.cfg --file target/stm32f4x.cfg` for the stm32f4-discovery board.
`MW_TEST_PATH` | The path of the [mw.test](https://github.com/mw-sc/mw.test) release (either in ./bin/release when built or from [bintray](https://bintray.com/mw-sc/mw.test/mw.test)).
`GCC_PATH` | The path of the gcc the compiler is in (the bin folder in most distributions)
`GCC_PREFIX` | The prefix for the compiler, in this example it should be `arm-none-eabi-gcc`
`BOOST_LOCATION` | The location of boost, which is needed for it's preprocess library.
`QEMU` | The qemu binary
`QEMU_OPT` | The obtions for qemu, the default is `-board STM32F4-Discovery`.

The example used on my machine looks as follows.

*Qemu and OpenOcd are forks by the [gnuarmclipse plugin](http://gnuarmeclipse.github.io).*

*Note that `$(QEMU_POT)` can also include extra options, such as `-display none -nographic` the [ci config](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/build/config-travis.mk) so qemu avoids using a gui.

```makefile
OPENOCD := F:\mingw\open-ocd\bin-x64\openocd.exe
OPENOCD_OPT := --file interface/stlink-v2.cfg --file target/stm32f4x.cfg
MW_TEST_PATH := F:\mwspace\mw.test\bin\release
GCC_PATH := F:\mingw\arm-none-eabi-gcc-6\bin
GCC_PREFIX := arm-none-eabi-
BOOST_LOCATION := F:\boost
QEMU := C:\Program Files\GNU ARM Eclipse\QEMU\2.8.0-201612271623-dev\bin\qemu-system-gnuarmeclipse
QEMU_OPT := -board STM32F4-Discovery
```

## Buliding & Running the tests

The makefile defines tree fake-targets to bulid and run the tests.

target | action | subtargets
:------|:-------|:----------
`build`   | Build all binaries | `blinky.elf`, `test_blink.elf`, `test_state.elf`
`openocd` | Run all binaries through openocd | `blinky_openocd`, `test_blink_openocd`, `test_state_openocd`
`qemu`    | Run all binaries through qemu | `blinky_qemu`, `test_blink_qemu`, `test_state_qemu`

*The tests will create a dummy file to verify a succesful run.*



*Example screenshot from running a test.*

![screenshot_qemu](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/doc/qemu_screenshot.png)

## Binaries

All binaries are linked with the linker-scripts in [ldscripts](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/ldscripts) and add the gcov binary with the `--coverage` option.

The sources  [sys/src/newlib/_syscalls.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/newlib/_syscalls.c) and  [src/_write.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/src/_write.c).

### Binky.elf

The blinky.elf is based on [src/main.cpp](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/src/main.cpp) which will iterate through all 16 states twice. Please see the description of [main.cpp](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/src/readme.md#blinky) for more details.


## Modules

To have as little compile time as possible many of the objects are shared. They are however not packaged into static libraries, but passed to the linker as seperate files. The rules are defined in the subfolders as `subdir.mk`

The shared sets of compile units are refered to as modules in this context.

All modules compiled have the flags provided by the stm32f4 template given by gnuarmeclipse.
These are the following:

 - `-mcpu=cortex-m4`
 - `-mthumb`
 - `-mfloat-abi=soft`
 - `-Og`
 - `-fmessage-length=0`
 - `-fsigned-char`
 - `-ffunction-sections`
 - `-fdata-sections`
 - `-fno-move-loop-invariants`


### MW

The mw libraries are those used for the mw.test extensions.

  - [mw](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/mw)
      - [calltrace.c](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/mw/calltrace.c)
      - [mw_newlib_syscalls.c](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/mw/mw_newlib_syscalls.c)
      - [timestamp.c](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/mw/timestamp.c)

All of those files are added for every build, without any extra flags.

### src

The main source environment contains the following sources.

  - [src](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/src)
      - [BlinkLed.c](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/src/BlinkLed.c)
      - [Timer.c](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/src/Timer.c)
      - [_dso_handle.c](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/src/_dso_handle.c)
      - [_initialize_hardware.c](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/src/_initialize_hardware.c)
      - [state.c](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/src/state.c)
      - [stm32f4xx_hal_msp.c](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/src/stm32f4xx_hal_msp.c)

The [main.cpp](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/src/main.cpp) is only used for the `blinky` builds.

All `.cpp` files are compiles with `-finstrument-functions` and `--coverage` enabled. This way we can selectively analyze those, without generateing unneeded overhead by monitoring the system-libraries.

### Syslib

The system-libraries located in [sys](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys) are compiled without `coverage` and `instrument-functions` since they are not part of the user-code. I.e. we minimize the overhead induced by this analysis.

The files used in all binaries for the system-library are given below:

 - [sys/src](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/sys/src)
   - [cmsis](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/sys/src/cmsis)
      - [system_stm32f4xx.c](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/sys/src/cmsis/system_stm32fxx.c)
      - [vectors_stm32f407xx.c](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/sys/src/cmsis/vectors_stm32f407xx.c)
   - [cortexm](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/sys/src/cortexm)
     - [_initialize_hardware.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/cortexm/_initialize_hardware.c)
     - [_reset_hardware.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/cortexm/_reset_hardware.c)
     - [exception_handlers.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/cortexm/exception_handlers.c)
   - [diag](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/sys/src/diag)
     - [Trace.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/diag/Trace.c)
     - [trace_impl.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/diag/trace_impl.c)
   - [newlib](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/sys/src/newlib)
     - [_cxx.cpp](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/newlib/_cxx.cpp)
     - [_exit.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/newlib/_exit.c)
     - [_sbrk.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/newlib/_sbrk.c)
     - [_startup.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/newlib/_startup.c)
     - [assert.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/newlib/assert.c)
   - [stm32f4-hal](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery/sys/src/stm32f4-hal)
     - [stm32f4xx_hal.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/stm32f4xx_hal/stm32f4xx_hal.c)
     - [stm32f4xx_hal_cortex.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/stm32f4xx_hal/stm32f4xx_hal_cortex.c)
     - [stm32f4xx_hal_flash.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/stm32f4xx_hal/stm32f4xx_hal_flash.c)
     - [stm32f4xx_hal_gpio.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/stm32f4xx_hal/stm32f4xx_hal_gpio.c)
     - [stm32f4xx_hal_iwdg.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/stm32f4xx_hal/stm32f4xx_hal_iwdg.c)
     - [stm32f4xx_hal_pwr.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/stm32f4xx_hal/stm32f4xx_hal_pwr.c)
     - [stm32f4xx_hal_rcc.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/stm32f4xx_hal/stm32f4xx_hal_rcc.c)

Note that [_startup.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/newlib/_startup.c) has a modification for to enable the usage of `gcov`. We insert `__gcov_flush` at [line 192](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/newlib/_startup.c#L192) which is conditional. The condition is used in eclipse, but `USE_GCOV` is defined for all build in the makefiles.

The file [_syscalls.c](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys/src/newlib/_syscalls.c) is only used for the *semihosting* build in eclipse.