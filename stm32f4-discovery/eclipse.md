# Eclipse

We provide eclipse projects files that can be imported into your workspace (File->Import->Existing Projects into Workspace).

It provides build descriptions for all elfs, a debug sessins using semihosting and execution for qemu & openocd.

## String substitutions

In order to keep the settings outside of the project settings, they are placed in the workspace settings. You will have to add `string replacements` which can be found in Window->Preferences->Run/Debug->String Substitution. 

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

*More details will follow soon.*

## Not for the Wrap functionality

In order to use the eclipse build system while having generated source, we added the [`test/test_state_wrap_gen.hpp`](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/test/test_state_wrap_gen.cpp)