# ATxmega32e5def.inc Definitions
## Applicability
ATxmega32e5def.inc, Created 2012-11-02 13:32, Version 1.00
## Purpose
Do you have a horror of opening and searching the ATxmega32e5def.inc file?

I do.

Here are a great many (not all) definitions from the ATxmega32e5def.inc file,
split into separate files, by function, to simplify lookup.
- Register addresses are formatted as 16-bit hex
- Bit positions are formatted as decimal (0-7)
- Constants are formatted as 8-bit hex
- Bit masks are formatted as 8-bit hex (even though I prefer binary)
- Constant names, as you would expect, are precisely the same as they appear in ATxmega32e5def.inc
- A single constant definition may be duplicated in several different files if it
pertains to more than one interface

**These files are intended for reference only, and not to be included in any project.**

## Illumination
My intention, initially, was only to transcribe definitions into separate files so
that the act of looking up a constant name would be easy (easier, anyway).

But then I started correcting comments that were inconsistent, confusing, or, according to the
datasheet, just plain wrong. As a result, some sections are heavily commented and many
comments diverge markedly from the original .inc file.

I would like you to keep two things in mind:
1. I have not altered any values, only comments and number formats, and
2. Said alterations were to bring comments into line with the datasheet - not as a result of operational testing, and
3. The datasheet itself was muddled more often than I would have guessed, and
4. Additional clarity was needed, and
5. There are never just two things, and, finally,
6. Regarding the Atmel XMEGA E Manual Atmel–42005E–AVR–XMEGA E–11/2014: Did anybody even proof read
that? Did they?

## Update
My definition files are becoming tutorials. Something needs to be done about this.
I'll let you know when I figure out what.

## Take Heed
Great care was taken when creating these files. You should, however, keep in
mind that I am but a mortal man and proceed accordingly.
