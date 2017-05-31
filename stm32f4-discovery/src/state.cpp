/**
 * @file   /blinky/src/state.cpp/state.cpp
 * @date   22.05.2017
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
#include <state.hpp>

void state::advance()
{
    //now this is unnecessary, but we weill demonstrate a bit of coverage
    if (_state == 15)
        _state = 0;
    else
        _state++;
}

void state::set(std::array<BlinkLed, 4> & leds)
{
    //to minimize tracing
    const auto size = 4; //I know that.
    auto ptr = leds.data();

    for (auto i = 0u; i < 4; i++)
    {
        auto & led = ptr[i];

        auto pos = (1 << i);
        auto state = pos & _state; //check if this one is supposed to be on.
        auto is_on = led.is_on();
        if (is_on && !state)
            led.turnOff();
        else if (!is_on && state)
            led.turnOn();
    }
}
