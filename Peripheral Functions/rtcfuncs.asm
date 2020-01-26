;
; rtcfunctions.asm
;
; Created: 15Dec2019
; Updated: 25Jan2020
; Author:  JSRagman
;
; MCU:     ATxmega32E5
;


; Description:
;     ATxmega32E5 Integrated Real-Time Counter (RTC) functions.
;


; Function List:
;     RTC_Init       - Sets the RTC Period, Compare, and Prescaler
;     RTC_Wait       - Returns after a specified number of milliseconds has elapsed
;     RTC_WaitSync   - Returns when the RTC_STATUS SYNCBUSY flag is cleared




; RTC_Init                                                            25Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Sets RTC Period and Compare registers, and sets the
;     RTC Prescaler.
;
;     RTC Correction is disabled.
; Initial Conditions:
;     The RTC clock source has been selected.
; Parameters:
;     r20 - Compare high byte
;     r21 - Compare low byte
;     r22 - Period high byte
;     r23 - Period low byte
;     r24 - RTC clock prescaling
; General-Purpose Registers:
;     Named      - rZero
;     Parameters - r20, r21, r22, r23, r24
;     Modified   - 
; I/O Registers Affected:
;     RTC_COMP     -  RTC Compare
;     RTC_CTRL     -  RTC Control
;     RTC_PER      -  RTC Period
; Functions Called:
;     RTC_WaitSync - Returns when the RTC_STATUS SYNCBUSY flag is cleared
; Returns:
;     Nothing
RTC_Init:

   .def    comphigh = r20                   ; param: Compare high byte
   .def    complow  = r21                   ; param: Compare low byte
   .def    perhigh  = r22                   ; param: Period high byte
   .def    perlow   = r23                   ; param: Period low byte
   .def    prescale = r24                   ; param: RTC prescaler

    sts    RTC_CTRL,    rZero               ; RTC Prescaler = OFF

;   Set RTC Period
    rcall  RTC_WaitSync                     ; wait for (SYNCBUSY == 0)
    sts    RTC_PER,      perlow             ; set Period Low value
    sts    RTC_PER+1,    perhigh            ; set Period High value

;   Set RTC Compare
    rcall  RTC_WaitSync                     ; wait for (SYNCBUSY == 0)
    sts    RTC_COMP,     complow            ; set Compare Low value
    sts    RTC_COMP+1,   comphigh           ; set Compare High value

    sts    RTC_CTRL,    prescale            ; RTC Prescaler = prescale

   .undef  comphigh
   .undef  complow
   .undef  perhigh
   .undef  perlow
   .undef  prescale

    ret



; RTC_Wait                                                            25Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Returns after a delay of 10 to 2550 milliseconds (1 to 255 centiseconds).
; Initial Conditions:
;     1. The RTC is configured to overflow at 10-millisecond (1-centisecond)
;        intervals.
; Parameters:
;     r20 - delay time, 1 to 255 centiseconds
;     r21 - RTC OVF interrupt level
; General-Purpose Registers:
;     Named      - rCentisecs
;     Parameters - r20, r21
;     Modified   - rCentisecs
; Note:
;     The OVF handler decrements rCentisecs until it reaches zero, then sets
;     the RTC_DING flag and disables the OVF interrupt.
RTC_Wait:
   .def    centsecs  = r20                  ; param: centiseconds
   .def    ovfirqlev = r21                  ; param: OVF interrupt level

    cbi    GPIO_OPSTAT, RTC_DING_bp         ; RTC_DING   = 0
    mov    rCentisecs,  centsecs            ; rCentisecs = centsecs

;   Set RTC Count = 0
    rcall  RTC_WaitSync                     ; wait for (SYNCBUSY == 0)
    sts    RTC_CNT,      rZero              ; RTC count = 0
    sts    RTC_CNT+1,    rZero

;   Enable the RTC OVF interrupt
    sts    RTC_INTCTRL, ovfirqlev           ; OVF level  = ovfirqlev

RTC_Wait_wait:                              ; Wait
    sbis   GPIO_OPSTAT, RTC_DING_bp         ; if (RTC_DING == 0)
    rjmp   RTC_Wait_wait                    ;     goto RTC_Wait_wait

RTC_Wait_exit:
   .undef  centsecs
   .undef  ovfirqlev

    ret


; RTC_WaitSync                                                        29Dec2019
; -----------------------------------------------------------------------------
; Description:
;     Returns when the RTC_STATUS SYNCBUSY flag is cleared.
;     Waiting for SYNCBUSY is required when setting the Real-Time Counter (RTC)
;     Count, Period, and Compare registers.
; Parameters:
;     None
; General-Purpose Registers:
;     Named      - 
;     Parameters - 
;     Modified   - 
RTC_WaitSync:
    push   r16

RTC_WaitSync_wait:
    lds    r16,    RTC_STATUS               ; r16 = RTC_STATUS
    andi   r16,    RTC_SYNCBUSY_bm          ; mask out all but SYNCBUSY flag
    brne   RTC_WaitSync_wait                ; if (SYNCBUSY == 1)
                                            ;     goto  RTC_WaitSync_wait
                                            ; else
    pop    r16                              ;     fall into exit
    ret



