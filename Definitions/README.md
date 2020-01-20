# ATxmega32e5def.inc Definitions
## References
1. XMEGA E5 Data Sheet,  DS40002059A, Rev A - 08/2018
2. XMEGA E MANUAL,       Atmel–42005E–AVR–XMEGA E–11/2014
3. ATxmega32E5def.inc,   Version 1.00, 2012-11-02 13:32

## Purpose
Do you have a horror of opening and searching the ATxmega32e5def.inc file?

I do.

Here are many (not all) definitions from ATxmega32e5def.inc, split into separate files to
simplify lookup. Formatting has been applied to improve consistency/readability:
- Register addresses are formatted as 16-bit hex
- Bit positions are formatted as decimal (0-7)
- Constants are formatted as 8-bit hex
- Bit masks are formatted as 8-bit hex (even though I prefer binary)
- Constant names, as you would expect, are unchanged
- A single constant definition may be duplicated in several different files if it
pertains to more than one interface

**These files are intended for reference only, and not to be included in any project.**

## Status
As of right now, I'm going to spend less effort on definitions and more effort on actually
writing code. These definitions will be expanded as time permits.

## Illumination
My intention, initially, was only to transcribe definitions into separate files so
that the act of looking up a constant name would be easy (easier, anyway).

But then I started correcting comments that were inconsistent, confusing, or, according to the
datasheet, just plain wrong. As a result, some sections are heavily commented and many
comments diverge markedly from the originals.

I would like you to keep two things in mind:
1. ~~I have not altered any values, only comments and number formats, and~~
Nevermind. I added an entire section to TWI_Defs.asm
2. Said alterations were to bring comments into line with the datasheet - not as a result of operational testing, and
3. The datasheet itself was muddled more often than I would have guessed, and
4. Additional clarity was needed, and
5. There are never just two things, and, finally,
6. Regarding the Atmel XMEGA E Manual Atmel–42005E–AVR–XMEGA E–11/2014: Did anybody even proof read
that? Did they?
7. PS - If you hate life, amuse yourself with the Conflicts/Omissions section, below.

## Take Heed
Great care was taken when creating these files. You should, however, keep in
mind that I am but a mortal man and proceed accordingly.

## Conflicts/Omissions
#### Conflicts
1. 16-bit Timer/Counter Type 4 and 5
   - CTRLGCLR/CTRLGSET Register, Timer/Counter STOP bit
     - Ref 2 indicates that STOP is in bit position 5 (Sects. 13.12.8, 13.13.9)
     - Ref 3 defines TC4_STOP_bp = 4 and TC5_STOP_bp = 4
     - Ref 3 also defines TC4_STOP_bm = 0x10 and TC5_STOP_bm = 0x10, which correspond to bit position 4
     - Which is it? Bit 4 or bit 5?

#### Omissions
1. TWI SMBUS L1 Compliance
   - Missing register/constant definitions
     - Ref 2 Sects 18 (TWI - Two-Wire Interface) and 19 (TWI SMBUS L1 Compliance) specify a number of
     SMBUS-related constants and registers
     - Ref 3 defines none of it, not even the TIMEOUT_TOS or TIMEOUT_TOCONF register addresses
   - Workaround
     - I added the relevant definitions to TWI_Defs.asm
     - The added definitions were transcribed from Ref 2 but not operationally tested

## Tidbits
#### APB: Technical Writer at Large. Armed with Red and Green Pens. Extremely Dangerous.
A poorly written datasheet cries out to me like a wounded animal. This is a good thing if you are
seeking technical clarity. Not so good if you would like to see some actual code samples.

#### Two Differences
Reference 1, section 13.2, fourth paragraph, begins "There are two differences between
timer/counter type 4 and type 5". It then goes on to list one.

Are you, perhaps, curious as to what the second difference might be?

