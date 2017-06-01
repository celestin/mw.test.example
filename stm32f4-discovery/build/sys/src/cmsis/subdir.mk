################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../sys/src/cmsis/system_stm32f4xx.c \
../sys/src/cmsis/vectors_stm32f407xx.c 

OBJS += \
./sys/src/cmsis/system_stm32f4xx.o \
./sys/src/cmsis/vectors_stm32f407xx.o 

C_DEPS += \
./sys/src/cmsis/system_stm32f4xx.d \
./sys/src/cmsis/vectors_stm32f407xx.d 


# Each subdirectory must supply rules for building sources it contributes
sys/src/cmsis/%.o: ../sys/src/cmsis/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	$(CC) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -DNO_INITIALIZE_ARGS -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


