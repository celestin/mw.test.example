
[![MW.Test Logo](https://raw.githubusercontent.com/mw-sc/mw.test/master/mw.test.png)](https://github.com/mw-sc/mw.test)

# mw.test.example


This repository demonstrates our test-toolchain [mw.test](https://github.com/mw-sc/mw.test). We demonstrate how to use it with the following tools. Currently we only have an example with the [stm32f4-discovery](http://www.st.com/en/evaluation-tools/stm32f4discovery.html) board.

## Eclipse

We have a full integration into the eclipse build system, including running the artifacts with openocd and qemu. You can import the project files in [stm32f4-discovery](https://github.com/mw-sc/mw.test.example/tree/master/stm32f4-discovery) and look at the [tutorial](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/eclipse.md).

## Makefile / Continuous Integration

In addition we have a custom makefile solution which also runs on Travis CI (using qemu) and reports the coverage. This will allow you to automatically report your build result with every commit, like this:

| Build Status | Coverage |
|--------------|----------|
| [![Build Status](https://travis-ci.org/mw-sc/mw.test.example.svg?branch=master)](https://travis-ci.org/mw-sc/mw.test.example) | [![Coverage Status](https://coveralls.io/repos/github/mw-sc/mw.test.example/badge.svg?branch=master)](https://coveralls.io/github/mw-sc/mw.test.example?branch=master) |

For more details on that see the corresponding [.travis.yml](https://github.com/mw-sc/mw.test.example/blob/master/.travis.yml) or the [tutorial](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/makefile.md)

## Used libraries & tools

The following tools are used for the examples:

 - [mw.test](https://bintray.com/mw-sc/mw.test/mw.test)
 - [arm-none-eabi-gcc](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads)
 - [qemu](http://gnuarmeclipse.github.io/qemu)
 - [openocd](http://gnuarmeclipse.github.io/openocd)
 - [gnuarmeclipse](http://gnuarmeclipse.github.io)


## Note for linux users

We currently have no proper setup for linux environments, which means that all binaries are just put into one folder. This means that you will have to modify the `LD_LIBRARY_PATH` environment variable to include the `mw.test` folder.

```sh
export LD_LIBRARY_PATH=$HOME/mw.test:$LD_LIBRARY_PATH;
```