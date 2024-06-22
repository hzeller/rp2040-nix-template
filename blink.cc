#include <cstdio>
#include <cstdint>

#include "pico/stdlib.h"

int main() {
  constexpr uint kLEDPin = 25;
  gpio_init(kLEDPin);
  gpio_set_dir(kLEDPin, GPIO_OUT);

  stdio_init_all();  // Init serial, such as uart or usb

  for (uint8_t t; /* forever */; ++t) {
    const bool on = t % 2 == 0;
    printf("Blink %s\n", on ? "on" : "off");
    gpio_put(kLEDPin, on);
    sleep_ms(500);
  }
}
