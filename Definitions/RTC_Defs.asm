; RTC_Defs.asm
; 
; Created: 17Jan2020
; Updated: 17Jan2020
; Author : JSRagman
;
; Description:
;     Constants relating to Real-Time Clock (RTC) configuration.



; CLK - Clock System Registers (RTC-Related)
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

.equ CLK_RTCCTRL = 0x0043                   ; RTC Control Register


; CLK - Clock System Constants (RTC-Related)
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

; CLK_RTCCTRL
; -----------------------------------------------------------------------------
; RTC Clock Source
.equ CLK_RTCSRC_ULP_gc      = 0x0           ; 1     kHz from internal 32kHz ULP
.equ CLK_RTCSRC_TOSC_gc     = 0x2           ; 1.024 kHz from 32.768 kHz crystal oscillator on TOSC
.equ CLK_RTCSRC_RCOSC_gc    = 0x4           ; 1.024 kHz from internal 32.768 kHz RC oscillator
.equ CLK_RTCSRC_TOSC32_gc   = 0xA           ; 32.768 kHz from 32.768 kHz crystal oscillator on TOSC
.equ CLK_RTCSRC_RCOSC32_gc  = 0xC           ; 32.768 kHz from internal 32.768 kHz RC oscillator
.equ CLK_RTCSRC_EXTCLK_gc   = 0xE           ; External Clock from TOSC1


; CLK - Bit Positions / Masks (RTC-Related)
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

; CLK_RTCCTRL bits
.equ CLK_RTCSRC2_bp = 3                     ; Clock Source bit 2
.equ CLK_RTCSRC1_bp = 2                     ; Clock Source bit 1
.equ CLK_RTCSRC0_bp = 1                     ; Clock Source bit 0
.equ CLK_RTCEN_bp   = 0                     ; Clock Source Enable




; RTC - Real-Time Counter Registers
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

.equ RTC_CTRL     = 0x0400                   ; Control
.equ RTC_STATUS   = 0x0401                   ; Status
.equ RTC_INTCTRL  = 0x0402                   ; Interrupt Control
.equ RTC_INTFLAGS = 0x0403                   ; Interrupt Flags
.equ RTC_TEMP     = 0x0404                   ; Temporary Register
.equ RTC_CALIB    = 0x0406                   ; Calibration
.equ RTC_CNT      = 0x0408                   ; Count
.equ RTC_PER      = 0x040A                   ; Period
.equ RTC_COMP     = 0x040C                   ; Compare



; RTC - Interrupt Vectors
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ RTC_OVF_vect  = 0x000E                 ; Overflow
.equ RTC_COMP_vect = 0x0010                 ; Compare



; RTC - Constants
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

; RTC_CTRL Register
; -----------------------------------------------------------------------------
; RTC Prescaler Factor
.equ RTC_PRESCALER_OFF_gc     = 0           ; RTC Off
.equ RTC_PRESCALER_DIV1_gc    = 1           ; RTC Clock / 1
.equ RTC_PRESCALER_DIV2_gc    = 2           ; RTC Clock / 2
.equ RTC_PRESCALER_DIV8_gc    = 3           ; RTC Clock / 8
.equ RTC_PRESCALER_DIV16_gc   = 4           ; RTC Clock / 16
.equ RTC_PRESCALER_DIV64_gc   = 5           ; RTC Clock / 64
.equ RTC_PRESCALER_DIV256_gc  = 6           ; RTC Clock / 256
.equ RTC_PRESCALER_DIV1024_gc = 7           ; RTC Clock / 1024


; RTC_INTCTRL Register
; -----------------------------------------------------------------------------
; Compare Interrupt level
.equ RTC_COMPINTLVL_OFF_gc    = (0<<2)      ; Interrupt Disabled
.equ RTC_COMPINTLVL_LO_gc     = (1<<2)      ; Low
.equ RTC_COMPINTLVL_MED_gc    = (2<<2)      ; Medium
.equ RTC_COMPINTLVL_HI_gc     = (3<<2)      ; High

; Overflow Interrupt level
.equ RTC_OVFINTLVL_OFF_gc     = 0           ; Interrupt Disabled
.equ RTC_OVFINTLVL_LO_gc      = 1           ; Low
.equ RTC_OVFINTLVL_MED_gc     = 2           ; Medium
.equ RTC_OVFINTLVL_HI_gc      = 3           ; High




; RTC - Bit Positions / Masks
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

; RTC_CTRL bits
.equ RTC_CORREN_bp      = 3                 ; Correction Enable
.equ RTC_PRESCALER2_bp  = 2                 ; Prescaling Factor bit 2
.equ RTC_PRESCALER1_bp  = 1                 ; Prescaling Factor bit 1
.equ RTC_PRESCALER0_bp  = 0                 ; Prescaling Factor bit 0

; RTC_STATUS bits
.equ RTC_SYNCBUSY_bm    = 1                 ; Sync Busy Flag bit mask
.equ RTC_SYNCBUSY_bp    = 0                 ; Sync Busy Flag bit position

; RTC_INTCTRL bits
.equ RTC_COMPINTLVL1_bp = 3                 ; Compare Match Interrupt Level bit 1
.equ RTC_COMPINTLVL0_bp = 2                 ; Compare Match Interrupt Level bit 0
.equ RTC_OVFINTLVL1_bp  = 1                 ; Overflow Interrupt Level bit 1
.equ RTC_OVFINTLVL0_bp  = 0                 ; Overflow Interrupt Level bit 0

; RTC_INTFLAGS
.equ RTC_COMPIF_bp      = 1                 ; Compare Match Interrupt
.equ RTC_OVFIF_bp       = 0                 ; Overflow Interrupt

