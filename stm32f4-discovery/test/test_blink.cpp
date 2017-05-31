/**
 * @file   test_state.cpp
 * @date   23.05.2017
 * @author Klemens D. Morgenstern
 *
 * Published under [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)
  <pre>
    /  /|  (  )   |  |  /
   /| / |   \/    | /| /
  / |/  |   /\    |/ |/
 /  /   |  (  \   /  |
               )
 </pre>
 */

#include <mw/test/backend.hpp>

#include <BlinkLed.hpp>
#include "stm32f4xx.h"


void led0()
{
    auto & led = blinkLeds[0];

    MW_ASSERT(!led.is_on());

    led.turnOn();

    MW_ASSERT(led.is_on());

    auto reg_state = GPIOD->ODR & (1 << 12);
    MW_ASSERT_NOT_EQUAL(reg_state, 0);


    led.toggle();
    MW_ASSERT(!led.is_on());
    reg_state = GPIOD->ODR & (1 << 12);
    MW_ASSERT_EQUAL(reg_state, 0);
}
void led1()
{
    auto & led = blinkLeds[1];

    MW_ASSERT(!led.is_on());

    led.turnOn();

    MW_ASSERT(led.is_on());
    volatile auto reg_state = GPIOD->ODR & (1 << 13);
    MW_ASSERT_NOT_EQUAL(reg_state, 0);

    led.toggle();
    MW_ASSERT(!led.is_on());
    reg_state = GPIOD->ODR & (1 << 13);
    MW_ASSERT_EQUAL(reg_state, 0);
}
void led2()
{
    auto & led = blinkLeds[2];

    MW_ASSERT(!led.is_on());

    led.turnOn();

    MW_ASSERT(led.is_on());
    auto reg_state = GPIOD->ODR & (1 << 14);
    MW_ASSERT_NOT_EQUAL(reg_state, 0);

    led.toggle();
    MW_ASSERT(!led.is_on());
    reg_state = GPIOD->ODR & (1 << 14);
    MW_ASSERT_EQUAL(reg_state, 0);
}
void led3()
{
    auto & led = blinkLeds[3];

    MW_ASSERT(!led.is_on());

    led.turnOn();


    MW_ASSERT(led.is_on());
    auto reg_state = GPIOD->ODR & (1 << 15);
    MW_ASSERT_NOT_EQUAL(reg_state, 0);

    led.toggle();
    MW_ASSERT(!led.is_on());
    reg_state = GPIOD->ODR & (1 << 15);
    MW_ASSERT_EQUAL(reg_state, 0);
}

int main(int argc, char * argv[])
{
    for (auto & led : blinkLeds)
        led.powerUp();

    for (auto & led : blinkLeds)
        led.turnOff();

    uint32_t reg_state = GPIOD->ODR & (0b1111u << 12u);

    MW_CRITICAL(MW_ASSERT_EQUAL_BITWISE(reg_state, 0));

    MW_CALL(&led0, "led 0 test");
    MW_CALL(&led1, "led 1 test");
    MW_CALL(&led2, "led 2 test");
    MW_CALL(&led3, "led 3 test");

    return MW_REPORT();
}
