################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../sys/src/diag/Trace.c \
../sys/src/diag/trace_impl.c 

OBJS += \
./sys/src/diag/Trace.o \
./sys/src/diag/trace_impl.o 

C_DEPS += \
./sys/src/diag/Trace.d \
./sys/src/diag/trace_impl.d 


# Each subdirectory must supply rules for building sources it contributes
sys/src/diag/%.o: ../sys/src/diag/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	$(CC) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -DNO_INITIALIZE_ARGS -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


