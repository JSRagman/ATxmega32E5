# ATxmega32E5 Starter Project Schematics
### Purpose
Schematic diagrams in this folder give context to the related code sections.
The diagrams are not complete, intended only to show relevant hardware configuration.
### Notes
#### Rotary Encoder:
The MAX6817 debouncer is not currently implemented between SW102 and
ports PA6, PA7.

Options here vary, depending on how much time you want the MCU to spend
debouncing and decoding:
1. Do it all in software
2. Implement the MAX6817 debouncer, then decode in software
3. Insert an ATtiny85 (or other) to do all the debouncing/decoding, passing along
   only Step and Direction signals
   
