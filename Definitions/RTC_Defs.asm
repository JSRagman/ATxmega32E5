;
; RTC_Defs.asm
;
; Created: 17Jan2020
; Updated: 18Jan2020
; Author : JSRagman
;

; Description:
;     Real-Time Counter (RTC) and Related Definitions

; Organization:
;     1.  Oscillator Registers    (RTC-related)
;     2.  Clock System Registers  (RTC-related)
;     3.  RTC Registers
;     4.  RTC Interrupt Vectors

; Number Formats:
;     1.  Register Addresses    16-bit hex
;     2.  Bit Positions         decimal (0-7)
;     3.  Bit Masks             8-bit hex
;     4.  Constants             8-bit hex

; References:
;     1.  XMEGA E5 Data Sheet,  DS40002059A, Rev A - 08/2018
;     2.  XMEGA E MANUAL,       Atmel–42005E–AVR–XMEGA E–11/2014
;     3.  ATxmega32E5def.inc,   Version 1.00, 2012-11-02 13:32




; OSC - Oscillator Registers (RTC-Related)
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ OSC_CTRL                   = 0x0050    ; Oscillator Control
.equ OSC_STATUS                 = 0x0051    ; Oscillator Status
.equ OSC_XOSCCTRL               = 0x0052    ; External Oscillator Control
.equ OSC_XOSCFAIL               = 0x0053    ; Oscillator Failure Detection
.equ OSC_RC32KCAL               = 0x0054    ; 32.768 kHz Internal Oscillator Calibration


; OSC_CTRL Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ OSC_XOSCEN_bp              =    3      ; External Oscillator Enable
.equ OSC_RC32KEN_bp             =    2      ; Internal 32.768 kHz RC Oscillator Enable


; OSC_STATUS Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ OSC_XOSCRDY_bp             =    3      ; External Oscillator Ready
.equ OSC_RC32KRDY_bp            =    2      ; Internal 32.768 kHz RC Oscillator Ready

; Bit Masks
.equ OSC_XOSCRDY_bm             = 0x08      ; External Oscillator Ready
.equ OSC_RC32KRDY_bm            = 0x04      ; Internal 32.768 kHz RC Oscillator Ready


; RTC External Oscillator Configurations:
; -----------------------------------------------------------------------------
; To use any of these, the OSC_CTRL.OSC_XOSCEN bit must be set.
;
; NOTE:
;     TOSC1, TOSC2, XTAL1, and XTAL2 are four names for just two pins
;         TOSC1 = XTAL1 = PR1
;         TOSC2 = XTAL2 = PR0
;     You can look at Reference 1, Figure 11-1 for a long time and still not
;     know this.
;     (Ref 1, Table 32-4, PORT R - Alternate Functions)
;
; 1.  32.768 kHz Crystal Oscillator
;       a. A crystal (with appropriate load capacitors) is connected between
;          the TOSC1 and TOSC2 pins.
;       b. A low-power mode can be selected (OSC_X32KLPM_bp).
;          (Ref 1, Sect. 11.3.3)
; 3.  External Clock Input
;       a. Roll your own clock signal and apply it to  TOSC1 or PC4.
;          (Ref 1, Sect. 11.3.7) Note: The referenced paragraph is a bit misleading.
;       b. TOSC2 (XTAL2) can be used as a general I/O pin.
;          (Ref 2, Sect. 7.4.2.2)


; OSC_XOSCCTRL Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ OSC_X32KLPM_bp             =    5      ; 32.768 kHz XTAL OSC Low-power Mode

; Crystal Oscillator Selection
.equ OSC_XOSCSEL_EXTCLK_gc      = 0x00      ; External Clock from PR1 (XTAL1) -  6  CLK
.equ OSC_XOSCSEL_EXTCLK_C4_gc   = 0x14      ; External Clock from PC4         -  6  CLK
.equ OSC_XOSCSEL_32KHz_gc       = 0x02      ; 32.768 kHz Crystal              - 32K CLK


; OSC_XOSCFAIL Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ OSC_XOSCFDIF_bp         =    1         ; XOSC Failure Detection Interrupt Flag
.equ OSC_XOSCFDEN_bp         =    0         ; XOSC Failure Detection Enable

; Bit Masks
.equ OSC_XOSCFDIF_bm         = 0x02         ; XOSC Failure Detection Interrupt Flag



; CLK - Clock System Registers (RTC-Related)
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ CLK_RTCCTRL             = 0x0043       ; RTC Control Register



; CLK_RTCCTRL Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ CLK_RTCEN_bp            =    0         ; Clock Source Enable

; RTC Clock Source Selection   0b_0000_nnn0
.equ CLK_RTCSRC_ULP_gc       = 0x00         ; 1     kHz from internal 32kHz ULP
.equ CLK_RTCSRC_TOSC_gc      = 0x02         ; 1.024 kHz from 32.768 kHz crystal oscillator on TOSC
.equ CLK_RTCSRC_RCOSC_gc     = 0x04         ; 1.024 kHz from internal 32.768 kHz RC oscillator
.equ CLK_RTCSRC_TOSC32_gc    = 0x0A         ; 32.768 kHz from 32.768 kHz crystal oscillator on TOSC
.equ CLK_RTCSRC_RCOSC32_gc   = 0x0C         ; 32.768 kHz from internal 32.768 kHz RC oscillator
.equ CLK_RTCSRC_EXTCLK_gc    = 0x0E         ; External Clock from TOSC1 (PR1) or PC4




; RTC Registers
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ RTC_CTRL                = 0x0400       ; Control
.equ RTC_STATUS              = 0x0401       ; Status
.equ RTC_INTCTRL             = 0x0402       ; Interrupt Control
.equ RTC_INTFLAGS            = 0x0403       ; Interrupt Flags
.equ RTC_TEMP                = 0x0404       ; Temporary Register
.equ RTC_CALIB               = 0x0406       ; Calibration
.equ RTC_CNT                 = 0x0408       ; Count
.equ RTC_PER                 = 0x040A       ; Period
.equ RTC_COMP                = 0x040C       ; Compare



; RTC_CTRL Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ RTC_CORREN_bp            =    3        ; Correction Enable

; RTC Prescaler Factor      0b_0000_0nnn
.equ RTC_PRESCALER_OFF_gc     = 0x00        ; Off
.equ RTC_PRESCALER_DIV1_gc    = 0x01        ; RTC Clock
.equ RTC_PRESCALER_DIV2_gc    = 0x02        ; /2
.equ RTC_PRESCALER_DIV8_gc    = 0x03        ; /8
.equ RTC_PRESCALER_DIV16_gc   = 0x04        ; /16
.equ RTC_PRESCALER_DIV64_gc   = 0x05        ; /64
.equ RTC_PRESCALER_DIV256_gc  = 0x06        ; /256
.equ RTC_PRESCALER_DIV1024_gc = 0x07        ; /1024


; RTC_STATUS Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ RTC_SYNCBUSY_bp          =    0        ; Sync Busy Flag

; Bit Masks
.equ RTC_SYNCBUSY_bm          = 0x01        ; Sync Busy Flag


; RTC_INTCTRL Register
; -----------------------------------------------------------------------------
; Compare Interrupt level     0b_0000_nn00
.equ RTC_COMPINTLVL_OFF_gc    = 0x00        ; Interrupt Disabled
.equ RTC_COMPINTLVL_LO_gc     = 0x04        ; Low
.equ RTC_COMPINTLVL_MED_gc    = 0x08        ; Medium
.equ RTC_COMPINTLVL_HI_gc     = 0x0C        ; High

; Overflow Interrupt level    0b_0000_00nn
.equ RTC_OVFINTLVL_OFF_gc     = 0x00        ; Interrupt Disabled
.equ RTC_OVFINTLVL_LO_gc      = 0x01        ; Low
.equ RTC_OVFINTLVL_MED_gc     = 0x02        ; Medium
.equ RTC_OVFINTLVL_HI_gc      = 0x03        ; High


; RTC_INTFLAGS Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ RTC_COMPIF_bp            =    1        ; Compare Match Interrupt Flag
.equ RTC_OVFIF_bp             =    0        ; Overflow Interrupt Flag

; Bit Masks
.equ RTC_COMPIF_bm            = 0x02        ; Compare Match Interrupt Flag
.equ RTC_OVFIF_bm             = 0x01        ; Overflow Interrupt Flag



; RTC Interrupt Vectors
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ RTC_OVF_vect            = 0x000E       ; Overflow
.equ RTC_COMP_vect           = 0x0010       ; Compare


