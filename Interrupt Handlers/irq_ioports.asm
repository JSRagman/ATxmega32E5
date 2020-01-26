;
; irq_ioports.asm
;
; Created: 16Nov2019
; Updated:  7Dec2019
; Author : JSRagman
;


; I/O Port Interrupt Handlers:
;     irq_port_A
;     irq_port_D




; irq_port_A                                                           7Dec2019
; -----------------------------------------------------------------------------
; Description:
;     Port A Interrupt Handler
;
;     Examines Port A interrupt flags and branches accordingly.
;     Clears the offending interrupt flags on exit.
; Triggered By:
;     PA0 - rising-edge      Green illuminated button switch
;     PA1 - rising-edge      Red illuminated button switch
;     PA5 - falling-edge     Rotary encoder push switch
;     PA6 - both edges       Rotary encoder A contacts
;     PA7 - both edges       Rotary encoder B contacts
; Constants Used (Non-standard)
;     xxxxx_bp  -  Port A bit position
;     GRNSW_bp  -  Green illuminated button switch
;     QENCA_bp  -  Rotary encoder A contacts
;     QENCB_bp  -  Rotary encoder B contacts
;     QENCSW_bp -  Rotary encoder push switch
;     REDSW_bp  -  Red illuminated button switch
; Notes:
;     1. VPORT0 is the virtual port associated with Port A.
;     2. The illuminated pushbutton switches have been debounced
;        in hardware.
;     3. Contacts associated with the rotary encoder have NOT
;        been debounced and require further processing.
irq_port_A:
    push   r16
    in     r16, CPU_SREG
    push   r16

;   Examine Port A interrupt flags and branch accordingly
    sbic   VPORT0_INTFLAGS, GRNSW_bp        ; if (GRNSW_IF == 1)
    rjmp   irq_port_A_grnsw                 ;     goto irq_port_A_grnsw
    sbic   VPORT0_INTFLAGS, REDSW_bp        ; if (REDSW_IF == 1)
    rjmp   irq_port_A_redsw                 ;     goto irq_port_A_redsw
    sbic   VPORT0_INTFLAGS, QENCSW_bp       ; if (QENCSW_IF == 1)
    rjmp   irq_port_A_qencsw                ;     goto irq_port_A_qencsw
    sbic   VPORT0_INTFLAGS, QENCA_bp        ; if (QENCA_IF == 1)
    rjmp   irq_port_A_qenca                 ;     goto irq_port_A_qenca
    sbic   VPORT0_INTFLAGS, QENCB_bp        ; if (QENCB_IF == 1)
    rjmp   irq_port_A_qencb                 ;     goto irq_port_A_qencb

    rjmp   irq_port_A_exit                  ; goto exit
;   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;   no fall-through

; Green illuminated button press
irq_port_A_grnsw:
    rcall  grnbutton_push                   ; call green button switch handler
    sbi    VPORT0_INTFLAGS, GRNSW_bp        ; clear GRNSW interrupt flag
    rjmp   irq_port_A_exit                  ; goto exit

; Red illuminated button press
irq_port_A_redsw:
    rcall  redbutton_push                   ; call red button switch handler
    sbi    VPORT0_INTFLAGS, REDSW_bp        ; clear REDSW interrupt flag
    rjmp   irq_port_A_exit                  ; goto exit

; Rotary encoder push-switch press
irq_port_A_qencsw:
    rcall  qencsw_push                      ; rotary encoder push-switch handler
    sbi    VPORT0_INTFLAGS, QENCSW_bp       ; clear QENCSW interrupt flag
    rjmp   irq_port_A_exit                  ; goto exit

; Rotary encoder A contacts
irq_port_A_qenca:
    rcall  qencab_change                    ; rotary encoder A/B contacts handler
    sbi    VPORT0_INTFLAGS, QENCA_bp        ; clear QENCA interrupt flag
    rjmp   irq_port_A_exit                  ; goto exit

; Rotary encoder B contacts
irq_port_A_qencb:
    rcall  qencab_change                    ; rotary encoder A/B contacts handler
    sbi    VPORT0_INTFLAGS, QENCB_bp        ; clear QENCB interrupt flag
    rjmp   irq_port_A_exit                  ; goto exit


irq_port_A_exit:
    pop    r16
    out    CPU_SREG, r16
    pop    r16

    reti


; irq_port_D                                                           7Dec2019
; -----------------------------------------------------------------------------
; Description:
;     Port D Interrupt Handler
;
;     Examines Port D interrupt flags and branches accordingly.
;     Clears the offending interrupt flags on exit.
; Triggered By:
;     PD0 - falling-edge     User switch 0
;     PD2 - falling-edge     User switch 1
; Constants Used (Non-standard)
;     xxxxx_bp  -  Port D bit position
;     USW0_bp   -  User switch 0 (pushbutton)
;     USW1_bp   -  User switch 1 (pushbutton)
; Notes:
;     1. VPORT2 is the virtual port associated with Port D.
;     2. The user switches are not debounced.
irq_port_D:
    push   r16
    in     r16, CPU_SREG
    push   r16

    sbic   VPORT2_INTFLAGS, USW0_bp         ; if (USW0_IF == 1)
    rjmp   irq_port_D_usw0                  ;     goto irq_port_D_usw0
    sbic   VPORT2_INTFLAGS, USW1_bp         ; if (USW1_IF == 1)
    rjmp   irq_port_D_usw1                  ;     goto irq_port_D_usw1

    rjmp   irq_port_D_exit                  ; goto exit
;   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;   no fall-through

; User switch 0 press
irq_port_D_usw0:
    rcall  usersw0_push                     ; call user switch 0 handler
    sbi    VPORT2_INTFLAGS, USW0_bp         ; clear USW0 interrupt flag
    rjmp   irq_port_D_exit                  ; goto exit

; User switch 1 press
irq_port_D_usw1:
    rcall  usersw1_push                     ; call user switch 1 handler
    sbi    VPORT2_INTFLAGS, USW1_bp         ; clear USW1 interrupt flag
    rjmp   irq_port_D_exit                  ; goto exit

irq_port_D_exit:
    pop    r16
    out    CPU_SREG, r16
    pop    r16

    reti




