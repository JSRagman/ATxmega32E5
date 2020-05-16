## Purpose
Basic exploration of the ATxmega32E5 MCU
- I2C Interface
- SPI
- ADC
- Timer/Counters
- External interrupts
- If I figure out what the Custom Logic Module is good for, we'll cover that too.

## Status
#### Where in the Wide World of Sports Have You Been?
Alas, this project is growing so rapidly it was beginning to look like the Edith Finch
house. I have been organizing files and functions, imposing some parameter discipline,
and generally whacking things into shape.

As for the XMEGA E5 Xplained board - void the warranty. Cut straps were cut.
The light sensor is gone and the board controller controls nothing. The user pushbuttons
are still there, but you don't want to push either of them. Perhaps I should have removed
the resistors. Ports are a scarce commodity and I needed more.

I did, however, retain the rotary encoder and the on-board graphic OLED display.
They will be useful.

I must say the whole thing is looking pretty good. Soon, I will post an update that replaces
almost everything. You will like it. Trust me.
## Development Tools
#### Atmel Studio 7 - AVR Assembler
#### Atmel ICE - Program and Debug Interface (PDI)
#### Atmel XMEGA E5 Xplained Board

## Extra Hardware
- TWI-connected character OLED display (2)
- TWI-connected real-time clock/calendar
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
