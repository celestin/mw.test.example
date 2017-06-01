bin/test/test_state.o : ../test/test_state.cpp
	@echo 'Compiling test state'
	$(CXX) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og --coverage -fmessage-length=0 -fsigned-char -finstrument-functions -ffunction-sections -fdata-sections -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -I$(BOOST_LOC) -I$(MW_TEST_PATH)/include -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=c++11 -c -o ./bin/test/test_state.o ../test/test_state.cpp 
	@echo ' '

bin/libtest_state.a : bin/test/test_state.o 
	@echo 'Creating libtest_state.a'
	$(AR) rcs "./bin/libtest_blink.a"  ./bin/test/test_state.o
	@echo 'Finished building: $<'
	@echo ' '
	

bin/libtest_blink.a : bin/test/test_blink.o
	@echo 'Creating libtest_blink.a'
	$(AR) rcs "./bin/libtest_blink.a"  ./bin/test/test_blink.o
	@echo 'Finished building: $<'
	@echo ' '

bin/blink_wrap.nm : bin/test/test_blink.o
	@echo Reading outline from test_blink
	$(NM) ./bin/test/test_blink.o > ./bin/blink_wrap.nm
	
bin/blink_wrap.dem : bin/test/test_blink.o
	@echo Reading outline from test_blink
	$(NM) --demangle  ./bin/test/test_blink.o > ./bin/blink_wrap.dem	
	
bin/blink_wrap.opt : bin/test/test_blink.o bin/blink_wrap.nm
	@echo Invoking the mw-wrapper
	$(MW-WRAP) -o ./bin/blink_wrap_impl.cpp --outline ./bin/blink_wrap.nm --dem-outline ./bin/blink_wrap.dem -B ./bin/test/test_blink.o --indirect --wrapper-out ./bin/blink_wrap.out
	@echo Compiling wrap generated file
	$(CXX) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og --coverage -fmessage-length=0 -fsigned-char -finstrument-functions -ffunction-sections -fdata-sections -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -I$(MW_TEST_PATH)/include -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=gnu11 -c -o ./bin/blink_wrap_impl.o ./bin/blink_wrap_impl.cpp
	
bin/libtest_blink_wrapped.a : bin/blink_wrap.opt
	@echo 'Creating libtest_blink.a'
	$(AR) rcs "./bin/libtest_blink.a" ./bin/test/test_blink.o ./bin/blink_wrap_impl.o 
	@echo 'Finished building: $<'
