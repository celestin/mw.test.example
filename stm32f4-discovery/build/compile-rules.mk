## Each subdirectory must supply rules for building sources it contributes
bin/%.o: ../%.cpp bin
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C++ Compiler'
	$(CXX) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og --coverage -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-move-loop-invariants -Wall -Wextra -g3 -DDEBUG -DUSE_FULL_ASSERT -DOS_USE_SEMIHOSTING -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -I$(MW_TEST_PATH)/include -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=gnu++11 -fabi-version=0 -fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

bin/%.o: ../%.c bin
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	$(CC) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft  -Og --coverage -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DOS_USE_SEMIHOSTING -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -I$(MW_TEST_PATH)/include -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=gnu11 -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
	
## Rules with function instrumentation

bin/instrumented/%.o : ../%.cpp bin
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C++ Compiler'
	$(CXX) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og --coverage -fmessage-length=0 -fsigned-char -finstrument-functions -ffunction-sections -fdata-sections -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DOS_USE_SEMIHOSTING -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -I$(MW_TEST_PATH)/include -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=gnu++11 -fabi-version=0 -fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

bin/instrumented/%.o : ../%.c bin
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	$(CC) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft  -Og --coverage -fmessage-length=0 -fsigned-char -finstrument-functions -ffunction-sections -fdata-sections -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DOS_USE_SEMIHOSTING -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -I$(MW_TEST_PATH)/include -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=gnu11 -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

bin/%.hex : bin/%.elf
	@echo 'Invoking: Creating flash image'
	$(OBJCOPY) -O ihex $<  $@
	$(SIZE) --format=berkeley $@
	@echo 'Finished building: $@'
	@echo ' '