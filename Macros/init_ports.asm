; init_ports                                                                         2Dec2019
; -------------------------------------------------------------------------------------------
.macro init_ports
; PORT A
;   Pin   Dir   Lvl        OPC              ISC          Configuration      Connected To
;   ---   ---   ---   -------------     ------------     ------------------------------------
;    7    In     1                      falling-edge     10K pull-up        QENC B
;    6    In     1                      falling-edge     10K pull-up        QENC A
;    5    In     1     pull-up          falling-edge                        QENC push switch
;    4    Out    1     wired-AND                         10K pull-up        Display !RESET
;    3    Out    0     wired-OR                          10K pull-down      Red   LED on/off
;    2    Out    0     wired-OR                          10K pull-down      Green LED on/off
;    1    In     0                      rising-edge      driven high/low    Red   PB switch
;    0    In     0                      rising-edge      driven high/low    Green PB switch
; -------------------------------------------------------------------------------------------
;   Port A Inputs
    ldi    r16,             ISC_FALLING_c        ; ISC = falling-edge
    sts    PORTA_PIN7CTRL,  r16                  ;     PA7
    sts    PORTA_PIN6CTRL,  r16                  ;     PA6
    ldi    r16,             ISC_FALLING_c        ; ISC = falling-edge,
    ori    r16,             OPC_PULLUP_c         ; OPC = pull-up
    sts    PORTA_PIN5CTRL,  r16                  ;     PA5
    ldi    r16,             ISC_RISING_c         ; ISC = rising-edge
    sts    PORTA_PIN1CTRL,  r16                  ;     PA1
    sts    PORTA_PIN0CTRL,  r16                  ;     PA0

;   Port A Interrupt Mask and Level
    ldi    r16,             0b_1110_0011         ; PA7,6,5,1,0
    sts    PORTA_INTMASK,   r16                  ;     interrupt mask
    ldi    r16,             PORT_INTLVL_MED_gc   ; INTLVL = medium
    sts    PORTA_INTCTRL,   r16                  ;     Port A

;   Port A Outputs
    ldi    r16,             0b_0001_0000         ; PA4
    sts    PORTA_OUT,       r16                  ;     output = high
    ldi    r16,             0b_0001_1100         ; PA4, PA3, PA2
    sts    PORTA_DIR,       r16                  ;     DIR = output
    ldi    r16,             OPC_WIRED_AND_c      ; OPC = Wired-AND
    sts    PORTA_PIN4CTRL,  r16                  ;     PA4
    ldi    r16,             OPC_WIRED_OR_c       ; OPC = Wired-OR
    sts    PORTA_PIN3CTRL,  r16                  ;     PA3
    sts    PORTA_PIN2CTRL,  r16                  ;     PA2


.endmacro
