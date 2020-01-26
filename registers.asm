;
; registers.asm
;
; Created: 16Nov2019
; Updated: 16Nov2019
; Author : JSRagman
;

; MCU:     ATxmega32E5
;
; Description:
;     General-Purpose Register definitions and usage.


; GPIO Registers
.equ  GPIO_OPSTAT        = GPIO_GPIOR0      ; Operation Status
.equ      RTC_DING_bp    = 0                ; RTC time out flag
.equ      PROC_CANCEL_bp = 1                ; Process cancel flag


; Named Registers:
; -----------------------------------------------------------------------------

; r0 - r15: Low Registers
.def  rZero      = r3                       ; Constant: A big fat zero.
.def  rCentisecs = r4                       ; Ten Millisecond count. Used with RTC



; r16 - r31: Working Registers

