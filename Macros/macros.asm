;
; macros.asm
;
; Created: 24Jan2020
; Updated: 24Jan2020
; Author : JSRagman
;


; Macro List:
;     ButtonLed_On_m
;     ButtonLed_Off_m
;     ButtonLed_Toggle_m
;     UserLed_On_m
;     UserLed_Off_m
;     UserLed_Toggle_m


; Description:
;     These macros exist for two main reasons:
;
;     1. To make functions that use them easier to follow.
;     2. To contain 1- or 2-line sequences that are used in many places but
;        not really worth turning into a function call.


; ButtonLed_On_m                                                      24Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Turns a pushbutton LED on
; Parameters
;     @0 - Bit position of the button LED (Port A)
; Usage:
;     SetButtonLed_On_m  GRNLED_bp
.macro ButtonLed_On_m
    sbi    VPORT0_OUT,  @0
 .endmacro


; ButtonLed_Off_m                                                     24Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Turns a pushbutton LED off
; Parameters
;     @0 - Bit position of the button LED (Port A)
; Usage:
;     SetButtonLed_Off_m  GRNLED_bp
.macro ButtonLed_Off_m
    cbi    VPORT0_OUT,  @0
.endmacro


; ButtonLed_Toggle_m                                                  24Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Toggles a pushbutton LED on/off
; Parameters
;     @0 - Bit position of the button LED (Port A)
; Usage:
;     SetButtonLed_Toggle_m  GRNLED_bp
.macro ButtonLed_Toggle_m
    ldi    r16,           (1<<@0)
    sts    PORTA_OUTTGL,  r16
.endmacro


; UserLed_On_m                                                        24Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Turns a User LED on
; Parameters
;     @0 - Bit position of the user LED (Port D)
.macro UserLed_On_m
    cbi    VPORT2_OUT,  @0
.endmacro


; UserLed_Off_m                                                       24Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Turns a User LED off
; Parameters
;     @0 - Bit position of the user LED (Port D)
.macro UserLed_Off_m
    sbi    VPORT2_OUT,  @0
.endmacro



; UserLed_Toggle_m                                                    24Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Toggles a User LED on/off
; Parameters
;     @0 - Bit position of the user LED (Port D)
.macro UserLed_Toggle_m
    ldi    r16,           (1<<@0)
    sts    PORTD_OUTTGL,  r16
.endmacro



; Cancel_Proc_m                                                       24Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Cancels a running process by setting the GPIO_OPSTAT PROC_CANCEL bit.
;     The process itself needs to periodically check this bit for the Cancel
;     function to work.
.macro Cancel_Proc_m
    sbi    GPIO_OPSTAT,  PROC_CANCEL_bp     ; set PROC_CANCEL bit
.endmacro