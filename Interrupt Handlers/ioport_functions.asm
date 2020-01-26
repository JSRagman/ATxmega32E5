;
; ioport_functions.asm
;
; Created:  3Dec2019
; Updated: 25Jan2020
; Author : JSRagman
;

; Description:
;     Functions called from I/O Port interrupt handlers.

; Function List:
;     grnbutton_push  - 
;     qencab_change   - 
;     qencsw_push     - 
;     redbutton_push  - 
;     usersw0_push    - 
;     usersw1_push    - 



; grnbutton_push                                                      25Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Turns the red illuminated button LED on for 1 second.
;
;     The RTC OVF interrupt level must be higher than the button push
;     interrupt level for this to work.
; Status:
;     Tested  25Jan2020
grnbutton_push:

    ButtonLed_On_m   REDLED_bp              ; red   button LED = On

    ldi    r20,    100
    ldi    r21,    RTC_OVFINTLVL_HI_gc
    rcall  RTC_Wait

    ButtonLed_Off_m  REDLED_bp              ; red   button LED = Off

    ret


; qencab_change                                                        3Dec2019
; -----------------------------------------------------------------------------
; Description:
;     Responds to the rotary encoder A/B contacts changing state.
qencab_change:


    ret



; qencsw_push                                                          3Dec2019
; -----------------------------------------------------------------------------
; Description:
;     Takes action appropriate for the rotary encoder push-switch.
qencsw_push:


    ret


; redbutton_push                                                      25Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Sets the GPIO_OPSTAT PROC_CANCEL flag.
redbutton_push:

    sbi    GPIO_OPSTAT,  PROC_CANCEL_bp     ; set PROC_CANCEL bit

    ret


usersw0_push:

    UserLed_Toggle_m  ULED0_bp           ; Toggle user LED 0

    ret


usersw1_push:

    UserLed_Toggle_m  ULED1_bp           ; Toggle user LED 1

    ret

