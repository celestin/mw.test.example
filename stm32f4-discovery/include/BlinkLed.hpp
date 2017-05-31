//
// This file is part of the GNU ARM Eclipse distribution.
// Copyright (c) 2014 Liviu Ionescu.
//

#ifndef BLINKLED_H_
#define BLINKLED_H_

#include <array>

// ----------------------------------------------------------------------------

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpadded"

class BlinkLed
{
public:
  BlinkLed (unsigned int port, unsigned int bit, bool active_low);

  void powerUp ();
  void turnOn ();
  void turnOff ();
  void toggle ();

  bool is_on ();

private:
  unsigned int fPortNumber;
  unsigned int fBitNumber;
  unsigned int fBitMask;
  bool fIsActiveLow;
};

constexpr static auto blink_port_number         = 3;
constexpr static auto blink_pin_number_green    = 12;
constexpr static auto blink_pin_number_orange   = 13;
constexpr static auto blink_pin_number_red      = 14;
constexpr static auto blink_pin_number_blue     = 15;
constexpr static auto blink_active_low          = false;

extern std::array<BlinkLed, 4> blinkLeds;

#pragma GCC diagnostic pop

// ----------------------------------------------------------------------------

#endif // BLINKLED_H_
