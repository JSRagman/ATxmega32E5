;
; MCP7940N_defs.asm
;
; Created: 25Feb2020
; Updated: 26Apr2020
; Author : JSRagman
;

; References:
;     1. Battery-Backed I2C Real-Time Clock/Calendar datasheet,
;        Microchip DS20005010G (07/2018)


#ifndef _mcp7940n_defs
#define _mcp7940n_defs



; MCP7940N Real-Time Clock Constants:
; -----------------------------------------------------------------------------

.equ MCP7940_SLAW_c = 0xDE                  ; MCP7940 TWI address

.equ MCP7940_DTREGS_c        =  7           ; date/time registers count
.equ MCP7940_DATEBYTES_c     =  4           ; date bytes (wkday, date, month, year)
.equ MCP7940_TIMEREGS_c      =  3           ; time bytes (sec, min, hour)
.equ MCP7940_ALMBYTES_c      =  6           ; registers for alarm 0 or alarm 1
.equ MCP7940_PWRBYTES_c      =  4           ; power failure registers
.equ MCP7940_MASKBYTES_c     = 14

; Timekeeping Registers
.equ MCP7940_SEC   = 0x00
.equ MCP7940_MIN   = 0x01
.equ MCP7940_HOUR  = 0x02
.equ MCP7940_WKDAY = 0x03
.equ MCP7940_DATE  = 0x04
.equ MCP7940_MTH   = 0x05
.equ MCP7940_YEAR  = 0x06
.equ MCP7940_CTRL  = 0x07
.equ MCP7940_TRIM  = 0x08

; Alarm Registers
.equ MCP7940_ALM0SEC   = 0x0A
.equ MCP7940_ALM0MIN   = 0x0B
.equ MCP7940_ALM0HOUR  = 0x0C
.equ MCP7940_ALM0WKDAY = 0x0D
.equ MCP7940_ALM0DATE  = 0x0E
.equ MCP7940_ALM0MTH   = 0x0F

.equ MCP7940_ALM1SEC   = 0x11
.equ MCP7940_ALM1MIN   = 0x12
.equ MCP7940_ALM1HOUR  = 0x13
.equ MCP7940_ALM1WKDAY = 0x14
.equ MCP7940_ALM1DATE  = 0x15
.equ MCP7940_ALM1MTH   = 0x16

.equ MCP7940_PWRDNMIN  = 0x18
.equ MCP7940_PWRDNHOUR = 0x18
.equ MCP7940_PWRDNDATE = 0x18
.equ MCP7940_PWRDNMTH  = 0x18

.equ MCP7940_PWRUPMIN  = 0x1C
.equ MCP7940_PWRUPHOUR = 0x1D
.equ MCP7940_PWRUPDATE = 0x1E
.equ MCP7940_PWRUPMTH  = 0x1F

; Time Register Offsets
.equ MCP7940_SEC_offset  = 0
.equ MCP7940_MIN_offset  = 1
.equ MCP7940_HOU_offset  = 2
.equ MCP7940_DAY_offset  = 3
.equ MCP7940_DAT_offset  = 4
.equ MCP7940_MTH_offset  = 5
.equ MCP7940_YEA_offset  = 6


; Register Bits
; ------------------------
; RTCSEC
.equ   MCP7940_SEC_bm       = 0b_0111_1111  ; Seconds bits [6:0]
.equ   MCP7940_ST_bp        = 7             ; RW  Oscillator Start bit

; RTCMIN
.equ   MCP7940_MIN_bm       = 0b_0111_1111  ; minutes bits [6:0]

; RTCHOUR
.equ   MCP7940_HR_bm        = 0b_0011_1111  ; hour bits [5:0] 
.equ   MCP7940_HOUR_12_bp   = 6             ; RW  Time Format bit
.equ   MCP7940_HOUR_PM_bp   = 5

; RTCWKDAY
.equ   MCP7940_OSCRUN_bm    = 0b_0010_0000  ; R   Osc Status bit mask0
.equ   MCP7940_OSCRUN_bp    = 5             ; R   Oscillator Status bit
.equ   MCP7940_PWRFAIL_bp   = 4             ; RW  Power Failure bit
.equ   MCP7940_VBATEN_bp    = 3             ; RW  Enable Battery bit

; CONTROL
.equ   MCP7940_OUT_bp       = 7             ; RW  General-Purpose Output logic
.equ   MCP7940_SQWEN_bp     = 6             ; RW  Square Wave Output enable
.equ   MCP7940_ALM1EN_bp    = 5             ; RW  Alarm 1 enable
.equ   MCP7940_ALM0EN_bp    = 4             ; RW  Alarm 0 enable
.equ   MCP7940_EXTOSC_bp    = 3             ; RW  External Oscillator enable
.equ   MCP7940_CRSTRIM_bp   = 2             ; RW  Coarse Trim Mode enable
.equ   MCP7940_SQWFS1_bp    = 1             ; RW  SQW Frequency Select 1
.equ   MCP7940_SQWFS0_bp    = 0             ; RW  SQW Frequency Select 0

; ALM0
.equ   MCP7940_ALM0_POL_bp   = 7            ; RW  Alarm Polarity
.equ   MCP7940_ALM0_MSK2_bp  = 6            ; RW  Alarm 0 Mask Bits
.equ   MCP7940_ALM0_MSK1_bp  = 5
.equ   MCP7940_ALM0_MSK0_bp  = 4
.equ   MCP7940_ALM0_IF_bp    = 3            ; RW  Alarm 0 Interrupt Flag

; ALM1
;      RTCALM1_POL   = 7                    ; R   = ALM0WKDAY ALMPOL
.equ   MCP7940_ALM1_MSK2_bp  = 6            ; Alarm 1 Mask Bits
.equ   MCP7940_ALM1_MSK1_bp  = 5
.equ   MCP7940_ALM1_MSK0_bp  = 4
.equ   MCP7940_ALM1_IF_bp    = 3            ; Alarm 1 Interrupt Flag


; Square Wave Output
; RTCCTRL SQWFS1:SQWFS0 Bits ( 0b_0000_00nn )
;   00  1 Hz
;   01  4.096 kHz
;   10  8.192 kHz
;   11  32.768 kHz
.equ MCP7940_MFP_bm    = 0b_0111_0011       ; MFP configuration bits
.equ MCP7940_SQW_bm    = 0b_0100_0011       ; RTCCTRL - SQWEN, SQWFS1, SQWFS0
.equ MCP7940_SQWDIS_c  = 0
.equ MCP7940_SQWEN_c   = 0x40                 ; 0b_0100_0000
.equ MCP7940_SQW_1_c   = 0
.equ MCP7940_SQW_4_c   = 1
.equ MCP7940_SQW_8_c   = 2
.equ MCP7940_SQW_32_c  = 3


; RTCWKDAY Register Constants
.equ MCP7940_MONDAY    = 1
.equ MCP7940_TUESDAY   = 2
.equ MCP7940_WEDNESDAY = 3
.equ MCP7940_THURSDAY  = 4
.equ MCP7940_FRIDAY    = 5
.equ MCP7940_SATURDAY  = 6
.equ MCP7940_SUNDAY    = 7

; RTCMTH Register Constants (BCD format)
.equ MCP7940_JANUARY   = 1
.equ MCP7940_FEBRUARY  = 2
.equ MCP7940_MARCH     = 3
.equ MCP7940_APRIL     = 4
.equ MCP7940_MAY       = 5
.equ MCP7940_JUNE      = 6
.equ MCP7940_JULY      = 7
.equ MCP7940_AUGUST    = 8
.equ MCP7940_SEPTEMBER = 9
.equ MCP7940_OCTOBER   = 0x10
.equ MCP7940_NOVEMBER  = 0x11
.equ MCP7940_DECEMBER  = 0x12



#endif

