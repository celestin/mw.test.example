################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../test/test_state.cpp \
../test/test_blink.cpp

TEST_STATE_OBJS += ./test/test_state.o test/wrap_gen.o
TEST_BLINK_OBJS += ./test/test_blink.o

CPP_DEPS += \
./test/test_state.d \
./test/test_blink.d 


# Each subdirectory must supply rules for building sources it contributes
test/test_state.o: ../test/test_state.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C++ Compiler'
	$(CXX) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -I$(BOOST-LOCATION) -I$(MW-INCLUDE) -std=gnu++11 -fabi-version=0 -fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics -finstrument-functions  -MMD -MP -MF"$(@:%.o=%.d)" -MT"test/test_state.d" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

test/%.o: ../test/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C++ Compiler'
	$(CXX) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -I$(BOOST-LOCATION) -I$(MW-INCLUDE) -std=gnu++11 -fabi-version=0 -fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics -finstrument-functions -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

test/test_state.nm : test/test_state.o
	@echo 'Reading outline from test_state.o'
	$(NM) test/test_state.o --no-demangle > test/test_state.nm
	@echo ' '
	

test/test_state.dem : test/test_state.o
	@echo 'Reading outline from test_state.o'
	$(NM) test/test_state.o --demangle > test/test_state.dem
	@echo ' '

test/wrap_gen.cpp : test/test_state.dem test/test_state.nm ../test/test_state_wrap_tpl.cpp
	@echo 'Generating wrapper'
	$(MW-WRAP) --output test/wrap_gen.cpp --wrapper-out wrap.opt --indirect --outline test/test_state.nm --dem-outline test/test_state.dem --template ../test/test_state_wrap_tpl.cpp
	@echo ' '


test/wrap_gen.o: test/wrap_gen.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C++ Compiler'
	$(CXX) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -I$(BOOST-LOCATION) -I$(MW-INCLUDE) -std=gnu++11 -fabi-version=0 -fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '