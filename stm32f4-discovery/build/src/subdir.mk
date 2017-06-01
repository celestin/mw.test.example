# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/_dso_handle.c \
../src/_initialize_hardware.c \
../src/stm32f4xx_hal_msp.c 

CPP_SRCS += \
../src/BlinkLed.cpp \
../src/Timer.cpp \
../src/state.cpp 

SRC_OBJS := \
./src/BlinkLed.o \
./src/Timer.o \
./src/_dso_handle.o \
./src/_initialize_hardware.o \
./src/state.o \
./src/stm32f4xx_hal_msp.o 


BLINKY_OBJS += $(SRC_OBJS) ./src/main.o
TEST_STATE_OBJS += $(SRC_OBJS)
TEST_BLINK_OBJS += $(SRC_OBJS)

C_DEPS += \
./src/_dso_handle.d \
./src/_initialize_hardware.d \
./src/stm32f4xx_hal_msp.d 

CPP_DEPS += \
./src/BlinkLed.d \
./src/Timer.d \
./src/state.d 


# Each subdirectory must supply rules for building sources it contributes

./src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C++ Compiler'
	$(CXX) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-move-loop-invariants -finstrument-functions -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DOS_USE_SEMIHOSTING -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=gnu++11 -fabi-version=0 -fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/BlinkLed.o: ../src/BlinkLed.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C++ Compiler'
	$(CXX) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -finstrument-functions -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=gnu++11 -fabi-version=0 -fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics --coverage -MMD -MP -MF"$(@:%.o=%.d)" -MT"src/BlinkLed.d" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/Timer.o: ../src/Timer.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C++ Compiler'
	$(CXX) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -finstrument-functions -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=gnu++11 -fabi-version=0 -fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics --coverage -MMD -MP -MF"$(@:%.o=%.d)" -MT"src/Timer.d" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	$(CC) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -DNO_INITIALIZE_ARGS -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/state.o: ../src/state.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C++ Compiler'
	$(CXX) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -finstrument-functions -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=gnu++11 -fabi-version=0 -fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics --coverage -finstrument-functions -MMD -MP -MF"$(@:%.o=%.d)" -MT"src/state.d" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/stm32f4xx_hal_msp.o: ../src/stm32f4xx_hal_msp.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	$(CC) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -DNO_INITIALIZE_ARGS -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=gnu11 -Wno-missing-prototypes -Wno-missing-declarations -MMD -MP -MF"$(@:%.o=%.d)" -MT"src/stm32f4xx_hal_msp.d" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


