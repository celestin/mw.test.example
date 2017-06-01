################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../sys/src/stm32f4-hal/stm32f4xx_hal.c \
../sys/src/stm32f4-hal/stm32f4xx_hal_cortex.c \
../sys/src/stm32f4-hal/stm32f4xx_hal_flash.c \
../sys/src/stm32f4-hal/stm32f4xx_hal_gpio.c \
../sys/src/stm32f4-hal/stm32f4xx_hal_iwdg.c \
../sys/src/stm32f4-hal/stm32f4xx_hal_pwr.c \
../sys/src/stm32f4-hal/stm32f4xx_hal_rcc.c 

OBJS += \
./sys/src/stm32f4-hal/stm32f4xx_hal.o \
./sys/src/stm32f4-hal/stm32f4xx_hal_cortex.o \
./sys/src/stm32f4-hal/stm32f4xx_hal_flash.o \
./sys/src/stm32f4-hal/stm32f4xx_hal_gpio.o \
./sys/src/stm32f4-hal/stm32f4xx_hal_iwdg.o \
./sys/src/stm32f4-hal/stm32f4xx_hal_pwr.o \
./sys/src/stm32f4-hal/stm32f4xx_hal_rcc.o 

C_DEPS += \
./sys/src/stm32f4-hal/stm32f4xx_hal.d \
./sys/src/stm32f4-hal/stm32f4xx_hal_cortex.d \
./sys/src/stm32f4-hal/stm32f4xx_hal_flash.d \
./sys/src/stm32f4-hal/stm32f4xx_hal_gpio.d \
./sys/src/stm32f4-hal/stm32f4xx_hal_iwdg.d \
./sys/src/stm32f4-hal/stm32f4xx_hal_pwr.d \
./sys/src/stm32f4-hal/stm32f4xx_hal_rcc.d 


# Each subdirectory must supply rules for building sources it contributes
sys/src/stm32f4-hal/%.o: ../sys/src/stm32f4-hal/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	$(CC) -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F407xx -DUSE_HAL_DRIVER -DHSE_VALUE=8000000 -DNO_INITIALIZE_ARGS -I"../include" -I"../sys/include" -I"../sys/include/cmsis" -I"../sys/include/stm32f4-hal" -std=gnu11 -Wno-bad-function-cast -Wno-conversion -Wno-sign-conversion -Wno-unused-parameter -Wno-sign-compare -Wno-missing-prototypes -Wno-missing-declarations -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


