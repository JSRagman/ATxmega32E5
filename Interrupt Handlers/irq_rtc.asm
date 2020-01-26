;
; irq_rtc.asm
;
; Created: 20Jan2020
; Updated: 25Jan2020
; Author : JSRagman
;

; Description:
;     Real-Time Counter (RTC) Interrupt Handlers


; Function List:
;     irq_rtc_ovf  - RTC Overflow interrupt
;     irq_rtc_cmp  - RTC Compare Match interrupt



; irq_rtc_ovf                                                         25Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Decrements rCentisecs until it reaches zero, then sets the
;     GPIO_OPSTAT RTC_DING bit and disables the RTC OVF interrupt.
; Status:
;     Tested  25Jan2020
; Triggered By:
;     RTC Overflow
; General-Purpose Registers:
;     Named    - rCentisecs, rZero
;     Modified - rCentisecs
; I/O Registers Affected:
;     GPIO_OPSTAT
;     RTC_INTCTRL
irq_rtc_ovf:
    push   r16
    in     r16, CPU_SREG
    push   r16

    cp     rCentisecs,  rZero               ; if (rCentisecs == 0)
    breq   irq_rtc_ovf_stop                 ;     goto irq_rtc_ovf_stop
                                            ; else
    dec    rCentisecs                       ;     rCentisecs = rCentisecs - 1
    rjmp   irq_rtc_ovf_exit                 ;     goto exit

irq_rtc_ovf_stop:
    sbi    GPIO_OPSTAT,  RTC_DING_bp        ; RTC_DING = 1
    sts    RTC_INTCTRL,  rZero              ; OVF level = Off
                                            ; fall into exit
irq_rtc_ovf_exit:
;   OVF interrupt flag is cleared automatically

    pop    r16
    out    CPU_SREG, r16
    pop    r16

    reti



; irq_rtc_cmp                                                         20Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Real-Time Counter Compare Match Interrupt Handler
irq_rtc_cmp:
    push   r16
    in     r16, CPU_SREG
    push   r16


    pop    r16
    out    CPU_SREG, r16
    pop    r16

    reti



