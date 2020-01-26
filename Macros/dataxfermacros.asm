;
; dataxfermacros.asm
;
; Created: 12Dec2019
; Updated: 17Jan2020
; Author:  JSRagman

; Description:
;     Macros dealing with data transfer between registers.

; Macro List:
;     clriw        - Clears a 16-bit I/O register
;     ldli         - Loads an immediate value into a low register (r0 to r15)
;     stsi         - Writes an immediate value to an 8-bit I/O register
;     stsp         - Writes to a CCP protected I/O register
;     stsw         - Writes a 16-bit value from r25:r24 to a 16-bit I/O register
;     stswi        - Writes a 16-bit immediate value to a 16-bit I/O register


; Notes:
;     1. rZero - I have found it useful to keep a general-purpose register
;                constant with a big fat zero.


#ifndef _atxm32e5_dxfer_macros
#define _atxm32e5_dxfer_macros


; clriw                                                               15Dec2019
; -----------------------------------------------------------------------------
; Description:
;     Clears a 16-bit I/O register.
; Parameters:
;     @0  - 16-bit I/O register address (low byte)
; General-Purpose Registers:
;     Named    - rZero
;     Modified - r16
; Constants:
;     CPU_I_bp - SREG_I bit position
; Usage:
;     clriw  RTC_CNT
.macro clriw
    in     r16,    CPU_SREG                 ; Preserve SREG_I in r16
    cli                                     ; clear SREG_I
    sts    @0,     rZero                    ; clear I/O register low byte
    sts    @0+1,   rZero                    ; clear I/O register high byte
    sbrc   r18,    CPU_I_bp                 ; restore SREG_I to its original value
    sei
.endmacro



; ldli                                                                22Dec2019
; -----------------------------------------------------------------------------
; Description:
;     Loads an immediate value into a low register (r0 to r15).
; Parameters:
;     @0  A low register (r0 - r15)
;     @1  An 8-bit immediate value
; General-Purpose Registers:
;     Modified  - r16
; Usage:
;     m_ldli  r0, 0xFF
.macro ldli
    ldi    r16,    @1
    mov    @0,     r16
.endmacro




; stsi                                                                20Dec2019
; -----------------------------------------------------------------------------
; Description:
;     Writes an immediate value to an 8-bit I/O register.
; Parameters:
;     @0  - I/O register address
;     @1  - an 8-bit value to be written
; General-Purpose Registers:
;     Modified  - r16
; Usage:
;     stsi  RTC_INTCTRL, RTC_OVFINTLVL_MED_gc
.macro stsi
    ldi    r16,    @1
    sts    @0,     r16
.endmacro



; stsp                                                                17Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Writes to a Configuration Change Protected (CCP) register.
; Replaces:
;   CPU_CCP  (0x0034) - Configuration Change Protection (CCP)
;   CLK_CTRL (0x0040) - Clock Control Register
;    ldi    r16,       CCP_IOREG_gc          ; CCP - Write to protected I/O register
;    ldi    r17,       CLK_SCLKSEL_RC8M_gc   ; CLK - Internal 8 MHz RC Oscillator
;    sts    CPU_CCP,   r16
;    sts    CLK_CTRL,  r17
; Parameters:
;     @0  The targeted I/O register
;     @1  An 8-bit immediate value
; General-Purpose Registers:
;     Modified  - r16, r17
; I/O Registers Affected:
;     CPU_CCP  (0x0034)   - Configuration Change Protection (CCP) register
; Constants:
;     CCP_IOREG_gc (0xD8) - Enable writing to a protected I/O register
; Usage:
;     stsp CLK_CTRL, CLK_SCLKSEL_RC8M_gc
.macro stsp
    ldi    r16,      CCP_IOREG_gc
    ldi    r17,      @1
    sts    CPU_CCP,  r16
    sts    @0,       r17
.endmacro



; stsw                                                                15Dec2019
; -----------------------------------------------------------------------------
; Description:
;     Writes a 16-bit value from r25:r24 to a 16-bit I/O register.
; Assumptions:
;     The 16-bit I/O register high byte address is obtained by incrementing
;     the low byte address by one.
; Parameters:
;     @0       - 16-bit I/O register address (low byte)
; General-Purpose Registers:
;     Modified - r18
; Constants:
;     CPU_I_bp - SREG_I bit position
; Usage:
;     ldi   r24,      low(0x12AB)
;     ldi   r25,     high(0x12AB)
;     stsw  RTC_PER
.macro stsw
    in     r18,    CPU_SREG                 ; Preserve SREG in r16
    cli                                     ; clear SREG_I
    sts    @0,     r24                      ; write low byte
    sts    @0+1,   r25                      ; write high byte
    sbrc   r18,    CPU_I_bp                 ; restore SREG_I to its original value
    sei
.endmacro



; stswi                                                               15Dec2019
; -----------------------------------------------------------------------------
; Description:
;     Writes a 16-bit immediate value to a 16-bit I/O register.
; Assumptions:
;     The 16-bit I/O register high byte address is obtained by incrementing
;     the low byte address by one.
; Parameters:
;     @0  - 16-bit I/O register address (low byte)
;     @1  - 16-bit value to be written
; General-Purpose Registers:
;     Modified   - r16, r17, r18
; Constants:
;     CPU_I_bp - SREG_I bit position
.macro stswi
    in     r18,    CPU_SREG                 ; Preserve SREG in r18
    cli                                     ; clear SREG_I
    ldi    r16,    low(@1)                  ; r16 = low byte
    ldi    r17,   high(@1)                  ; r17 = high byte
    sts    @0,     r16                      ; write low byte
    sts    @0+1,   r17                      ; write high byte
    sbrc   r18,    CPU_I_bp                 ; restore SREG_I to its original value
    sei
.endmacro


#endif

