/**
 * @file   set_leds.hpp
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
#ifndef STATE_HPP_
#define STATE_HPP_

#include <array>
#include <BlinkLed.hpp>


struct state
{
    void advance();
    void set(std::array<BlinkLed, 4> & leds);

    int get_state() const {return _state;}
private:
    int _state = 0;
};




#endif /* STATE_HPP_ */
