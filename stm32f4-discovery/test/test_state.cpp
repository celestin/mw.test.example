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
#include <mw/test/calltrace.hpp>
#include <mw/wrap.hpp>

#include <BlinkLed.hpp>
#include <state.hpp>

std::array<bool, 4> states;

MW_WRAP_MEM_FIX_NO_ARGS(BlinkLed, is_on, bool)
{
    MW_CHECKPOINT();
    auto pos = this_ - blinkLeds.data();
    return states[pos];
}

MW_WRAP_MEM_FIX_NO_ARGS(BlinkLed, turnOn, void)
{
    MW_CHECKPOINT();
    auto pos = this_ - blinkLeds.data();
    states[pos] = true;

}

MW_WRAP_MEM_FIX_NO_ARGS(BlinkLed, turnOff, void)
{
    MW_CHECKPOINT();
    auto pos = this_ - blinkLeds.data();
    states[pos] = false;
}


int main(int argc, char * argv[])
{

    auto & leds = blinkLeds;

    for (auto & led : leds)
        led.turnOff();

    MW_ASSERT(!leds[0].is_on());
    MW_ASSERT(!leds[1].is_on());
    MW_ASSERT(!leds[2].is_on());
    MW_ASSERT(!leds[3].is_on());

    state s;

    auto st = s.get_state();
    MW_ASSERT_EQUAL_BITWISE(st, 0);

    {
        mw::test::calltrace<5> ct{
                &state::set,
                mw::test::mem_fn<>(&std::array<BlinkLed, 4>::data),
                &BlinkLed::is_on,
                &BlinkLed::is_on,
                &BlinkLed::is_on,
                &BlinkLed::is_on
                    };

        s.set(leds);
        MW_ASSERT(ct);
    }

    s.advance();
    st = s.get_state();
    MW_ASSERT_EQUAL_BITWISE(st, 1);

    {
        mw::test::calltrace<6> ct{
                &state::set,
                mw::test::mem_fn<>(&std::array<BlinkLed, 4>::data),
                &BlinkLed::is_on, &BlinkLed::turnOn,
                &BlinkLed::is_on,
                &BlinkLed::is_on,
                &BlinkLed::is_on
                    };

        s.set(leds);
        MW_ASSERT(ct);
    }

    MW_ASSERT( leds[0].is_on());
    MW_ASSERT(!leds[1].is_on());
    MW_ASSERT(!leds[2].is_on());
    MW_ASSERT(!leds[3].is_on());

    s.advance();

    st = s.get_state();
    MW_ASSERT_EQUAL_BITWISE(st, 2);

    {
        mw::test::calltrace<7> ct{
                &state::set,
                mw::test::mem_fn<>(&std::array<BlinkLed, 4>::data),
                &BlinkLed::is_on, &BlinkLed::turnOff,
                &BlinkLed::is_on, &BlinkLed::turnOn,
                &BlinkLed::is_on,
                &BlinkLed::is_on
                    };

        s.set(leds);
        MW_ASSERT(ct);
    }

    MW_ASSERT(!leds[0].is_on());
    MW_ASSERT( leds[1].is_on());
    MW_ASSERT(!leds[2].is_on());
    MW_ASSERT(!leds[3].is_on());

    s.advance();

    st = s.get_state();
    MW_ASSERT_EQUAL_BITWISE(st, 3);

    {
        mw::test::calltrace<6> ct{
                &state::set,
                mw::test::mem_fn<>(&std::array<BlinkLed, 4>::data),
                &BlinkLed::is_on, &BlinkLed::turnOn,
                &BlinkLed::is_on, //no need to turn it on
                &BlinkLed::is_on,
                &BlinkLed::is_on
                    };

        s.set(leds);
        MW_ASSERT(ct);
    }

    MW_ASSERT( leds[0].is_on());
    MW_ASSERT( leds[1].is_on());
    MW_ASSERT(!leds[2].is_on());
    MW_ASSERT(!leds[3].is_on());

    ///alright the basis seems to work, we'll put only another test int.
    s.advance();
    s.set(leds);

    st = s.get_state();
    MW_ASSERT_EQUAL_BITWISE(st, 4);
    MW_ASSERT(!leds[0].is_on());
    MW_ASSERT(!leds[1].is_on());
    MW_ASSERT( leds[2].is_on());
    MW_ASSERT(!leds[3].is_on());

    s.advance();
    s.set(leds);

    st = s.get_state();
    MW_ASSERT_EQUAL_BITWISE(st, 5);
    MW_ASSERT( leds[0].is_on());
    MW_ASSERT(!leds[1].is_on());
    MW_ASSERT( leds[2].is_on());
    MW_ASSERT(!leds[3].is_on());

    s.advance();
    s.set(leds);

    st = s.get_state();
    MW_ASSERT_EQUAL_BITWISE(st,6);
    MW_ASSERT(!leds[0].is_on());
    MW_ASSERT( leds[1].is_on());
    MW_ASSERT( leds[2].is_on());
    MW_ASSERT(!leds[3].is_on());

    s.advance();

    s.set(leds); //for next change

    st = s.get_state();
    MW_ASSERT_EQUAL_BITWISE(st, 7);

    s.set(leds);

    MW_ASSERT( leds[0].is_on());
    MW_ASSERT( leds[1].is_on());
    MW_ASSERT( leds[2].is_on());
    MW_ASSERT(!leds[3].is_on());

    s.advance(); //8
    st = s.get_state();
    MW_ASSERT_EQUAL_BITWISE(st, 8);
    {
         mw::test::calltrace<9> ct{
                 &state::set,
                 mw::test::mem_fn<>(&std::array<BlinkLed, 4>::data),
                 &BlinkLed::is_on, &BlinkLed::turnOff,
                 &BlinkLed::is_on, &BlinkLed::turnOff,
                 &BlinkLed::is_on, &BlinkLed::turnOff,
                 &BlinkLed::is_on, &BlinkLed::turnOn
                     };

         s.set(leds);
         MW_ASSERT(ct);
    }


    s.set(leds);

    MW_ASSERT(!leds[0].is_on());
    MW_ASSERT(!leds[1].is_on());
    MW_ASSERT(!leds[2].is_on());
    MW_ASSERT( leds[3].is_on());


    return MW_REPORT();
}
