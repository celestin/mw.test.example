# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../mw/calltrace.c \
../mw/mw_newlib_syscalls.c \
../mw/timestamp.c 

OBJS += \
./mw/calltrace.o \
./mw/mw_newlib_syscalls.o \
./mw/timestamp.o 

C_DEPS += \
./mw/calltrace.d \
./mw/mw_newlib_syscalls.d \
./mw/timestamp.d 


# Each subdirectory must supply rules for building sources it contributes
mw/%.o: ../mw/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	$(CC) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -DNO_INITIALIZE_ARGS -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -I$(MW-INCLUDE) -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

