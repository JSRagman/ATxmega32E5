# Purpose
These are mostly initialization chores that would otherwise
clutter the power-on reset code.
# Notes
### Use of Constants
I try to stick to the definitions found in ATxmega32e5def.inc,
but in some cases I have re-defined constants in order to shorten
egregiously long names.

Constants re-defined in this way are suffixed with \_c instead of the
\_gc that follows Atmel definitions.

PORT_ISC_INPUT_DISABLE_gc, for example, becomes ISC_DISABLE_c.

PORT_ISC_BOTHEDGES_gc becomes ISC_EDGES_c.

And so on...

Is it better to use the standard definitions? Certainly, but if you
pile up enough 25-character constant identifiers, the whole thing
becomes an unreadable mess.
# Files
### init_ports.asm
#### Purpose
Port initialization
#### Comments
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
