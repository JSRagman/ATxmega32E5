## Purpose
Basic exploration of the ATxmega32E5 MCU
- I2C Interface
- SPI
- ADC
- Timer/Counters
- External interrupts
- If I figure out what the Custom Logic Module is good for, we'll cover that too.

## Status
#### Woohoo
System clock, RTC, and TWI configuration good to go. Displaying a message
from EEPROM to a TWI-connected display.

## Development Tools
#### Atmel Studio 7 - AVR Assembler
#### Atmel ICE - Program and Debug Interface (PDI)
#### XMEGA E5 Xplained
- Forget the board controller
- Say goodbye to the demo application
- Onboard 128 x 32 OLED... might come in handy
- Rotary encoder with push-switch... that too
- User buttons and LEDs... you can never have too many
- Ambient light sensor... red-headed stepchild - I'm sure we can think of something
#### Tightly Wrapped
around the axle...
The Xplained board makes me give up more IO pins than I would like for the on-board, um... stuff.

Having boards made, however, is expensive. Also, I'm not confident in my ability to hand-solder a 32TQFP package.
What to do... what to do.

## Extra Hardware
- TWI-connected character OLED display
- Illuminated pushbutton switches (emphatically debounced)

## References
1. ATxmega32E5/16E5/8E5 XMEGA E5 Data Sheet,
   - DS40002059A, 08/2018
2. XMEGA E Manual,
   - Atmel–42005E–AVR–XMEGA E–11/2014
3. AT02667: XMEGA-E5 Xplained Hardware User's Guide,
   - Atmel-42084B-XMEGA-E5-Xplained_AT02667_Application Note-08/2016
4. AVR Instruction Set Manual,
   - Atmel-0856L-AVR-Instruction-Set-Manual_Other-11/2016
