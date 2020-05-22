## Purpose
Basic exploration of the ATxmega32E5 MCU, using assembly language.

This is not intended to be an application that can be installed, although I have built
and run the thing. It is meant to give specific functions related to each of the
ATxmega32E5 peripherals.

Take the Two-Wire Interface, for example. TWI-related functions are in twi.asm.
If you are stuck trying to read sequential registers from a device, the TwiRd_Regs function
does just that. You can use it as it is or adapt the code for your own needs - the intent
is to show one method of getting the job done.

## Status
#### Change of Plan
A keypad! Why didn't I think of a keypad?

I've been trying to create a real-time clock interface using five buttons and a rotary
encoder. Forget that. I'm adding a 12-button keypad to the project. When I receive it
from Digi-Key (shameless plug), I'll update the schematics and start writing the interface.

I'm tempted to add another MCU to be responsible only for the keypad and real-time clock.
We'll see. This is a case of mission creep gone wild.
#### XMEGA E5 Xplained Board
Void the warranty. Cut straps were cut, the light sensor is gone, and the board controller
controls nothing. The user pushbuttons are still there, but you don't want to push either
of them. Perhaps I should have removed the resistors.
Ports are a scarce commodity and I needed more.

I did, however, retain the rotary encoder and the on-board graphic OLED display.
They will be useful.
## Development Tools
#### Atmel Studio 7 - AVR Assembler
#### Atmel ICE - Program and Debug Interface (PDI)
#### Atmel XMEGA E5 Xplained Board

## Extra Hardware
- TWI-connected character OLED display (2)
- TWI-connected real-time clock/calendar
- Illuminated pushbutton switches (emphatically debounced)
- A 12-button keypad

## References
1. ATxmega32E5/16E5/8E5 XMEGA E5 Data Sheet,
   - DS40002059A, 08/2018
2. XMEGA E Manual,
   - Atmel–42005E–AVR–XMEGA E–11/2014
3. AT02667: XMEGA-E5 Xplained Hardware User's Guide,
   - Atmel-42084B-XMEGA-E5-Xplained_AT02667_Application Note-08/2016
4. AVR Instruction Set Manual,
   - Atmel-0856L-AVR-Instruction-Set-Manual_Other-11/2016
