# Purpose
These are mostly initialization chores that would otherwise
clutter the power-on reset code.
# Files
## init_ports.asm
### Purpose
Port initialization
### Comments
This is presented unfinished, only initializing Port A.

I spent the last two days trying (and failing) to get an interrupt out of Port A.
This, by the way, is my first contact with Atmel's xmega line of MPUs.

Application Note AN 8050 (AVR1313) finally set me straight.

Section 2.4.1 - Configuration of Port Interrupts reads (more or less):
1. Configure input sense in the PINnCTRL register for each [...]
2. Write the bit mask corresponding to the pins that can trigger the interrupt [...]
   [for this project, that would involve the PORTA_INTMASK register]
3. Select the interrupt priority level [...]

I had been omitting Step 2, above. In fact, Step 2 is entirely absent
from datasheet section 12.6 - Port Interrupt.

This macro gets the job done, mostly.
Don't forget to configure the PMIC_CTRL register to enable the appropriate
interrupt level(s) and then, finally, sei.
