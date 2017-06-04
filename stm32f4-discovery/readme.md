# Project Structure

The given project is mainly derived from the project templates of the [gnuarmeclipse plugin](http://gnuarmeclipse.github.io/) but adds different things. The project structure is the same for the eclipse and the makefile project. As a matter of fact, the standalone makefiles are based on the generated ones.

## Subdir overview

Folder | Description
:------|:-----------
[build](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/build) | Makefiles for buliding without an IDE
[include](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/include) | Header files, i.e. belonging to `./src`
[ldscripts](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/ldscripts) | Linker scripts, dereived from the gnuarmeclipse plugin.
[mw](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/mw) | Extension copied from [mw.test](https://github.com/mw-sc/mw.test)
[src](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/src) | Top-level sources
[sys](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/sys) | System libraries, derived from the gnuarmeclipse plugin.
[test](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/test) | Test files

## Modules

For a detailed description of the modules see the [src folder](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/src) and the [test folder](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/test). A more detailed build description can be found in the [build folder](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/bulid) or the [eclipse tutorial](https://github.com/mw-sc/mw.test.example/blob/master/stm32f4-discovery/eclipse.md). *Please note that the makefile will demonstrate how to build, while eclipse is only about the integration into eclipse*.
