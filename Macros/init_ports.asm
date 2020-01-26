
; XMEGA E5 Xplained Port Usage                                                    3Dec2019
; ----------------------------------------------------------------------------------------
; Pin    Dir   Header   Name                                Input Sense      Configuration
; ----------------------------------------------------------------------------------------
; *PA7   In    J2       QENCB                              both edges        wired pull-up
; *PA6   In    J2       QENCA                              both edges        wired pull-up
; *PA5   In    J2       Rotary encoder push switch         falling-edge      internal pull-up
;  PA4   In    J2       External Display RESET#                              wired pull-up
;  PA3   Out   J2       External Red button LED                              wired pull-down
;  PA2   Out   J2       External Green button LED                            wired pull-down
;  PA1   In    J2       External Red button switch          rising-edge      driven high/low
;  PA0   Out   J2       External Green button switch        rising-edge      driven high/low
;
; *PC7   In    J1       (SPI MOSI) OLED SDIIN signal                         internal pull-up
;  PC6   In    J1       (SPI MISO)                                           internal pull-up
; *PC5   In    J1       (SPI SCK)  OLED SCLK  signal                         internal pull-up
;  PC4   In    J1       (SPI SS)                                             internal pull-up
;  PC3   In    J1       (USART TXD0)                                         internal pull-up
;  PC2   In    J1       (USART RXD0)                                         internal pull-up
;  PC1         J1       TWI SCL                                              wired pull-up
;  PC0         J1       TWI SDA                                              wired pull-up
;
; *PD7         J4       TXD  BC UART
; *PD6         J4       RXD  BC UART
; *PD5   Out   J4       User LED 1
; *PD4   Out   J4       User LED 0
; *PD3   Out   J4       OLED RES# signal                                    wired pull-up
; *PD2   In    J4       User Switch 1                      falling-edge     internal pull-up
; *PD1   In    J4       Phototransistor                                     wired pull-up
; *PD0   In    J4       User Switch 0                      falling-edge     internal pull-up
;
; *PR1   Out   J3       OLED CS# signal                                     wired pull-up
; *PR0   Out   J3       OLED D/C# signal
;
; * Connected to onboard components.


; init_ports                                                                        26Jan2020
; -------------------------------------------------------------------------------------------
.macro init_ports
; PORT A
;   Pin   Dir   Lvl        OPC              ISC          Configuration      Connected To
;   ---   ---   ---   -------------     ------------     ------------------------------------
;    7    In     1                      both edges       10K pull-up        QENC B
;    6    In     1                      both edges       10K pull-up        QENC A
;    5    In     1     pull-up          falling-edge                        QENC push switch
;    4    Out    1     wired-AND                         10K pull-up        Display !RESET
;    3    Out    0     wired-OR                          10K pull-down      Red   LED on/off
;    2    Out    0     wired-OR                          10K pull-down      Green LED on/off
;    1    In     0                      rising-edge      driven high/low    Red   PB switch
;    0    In     0                      rising-edge      driven high/low    Green PB switch
; -------------------------------------------------------------------------------------------
;   Port A Inputs
    ldi    r16,             ISC_EDGES_c          ; ISC = both edges
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


; PORT C
;   Pin   Dir   Lvl        OPC              ISC          Configuration      Connected To
;   ---   ---   ---   -------------     ------------     ------------------------------------
;    7    In     -     pull-up          input disabled                      SPI MOSI
;    6    In     -     pull-up          input disabled                      SPI MISO
;    5    In     -     pull-up          input disabled                      SPI SCK
;    4    In     -     pull-up          input disabled                      SPI SS
;    3    In     -     pull-up          input disabled                      USART TXD0
;    2    In     -     pull-up          input disabled                      USART RXD0
;    1     -     -                                       10K pull-up        TWI SCL
;    0     -     -                                       10K pull-up        TWI SDA
; -----------------------------------------------------------------------------
    ldi    r16,              0b_1111_1100        ; PC7:PC2
    sts    PORTCFG_MPCMASK,  r16                 ; Multi-Pin Configuration
    ldi    r16,              OPC_PULLUP_c        ; OPC = pull-up
    ori    r16,              ISC_DISABLE_c       ; ISC = input disabled
    sts    PORTC_PIN2CTRL,   r16                 ; 


; PORT D
;   Pin   Dir   Lvl        OPC              ISC          Configuration      Connected To
;   ---   ---   ---   -------------     ------------     ------------------------------------
;    7     In    -                      input disabled                      TXD  BC UART
;    6     In    -                      input disabled                      RXD  BC UART
;    5    Out    1     wired-AND                                            User LED 1
;    4    Out    1     wired-AND                                            User LED 0
;    3    Out    1     wired-AND                                            OLED100 RES#
;    2     In    1     pull-up          falling-edge                        User Switch SW101
;    1     In    -                      input disabled   100K pull-up       Phototransistor
;    0     In    1     pull-up          falling-edge                        User Switch SW100
; -------------------------------------------------------------------------------------------
;   Port D Inputs
    ldi    r16,             ISC_DISABLE_c        ; ISC = Disabled
    sts    PORTD_PIN7CTRL,  r16                  ;     PD7
    sts    PORTD_PIN6CTRL,  r16                  ;     PD6
    sts    PORTD_PIN1CTRL,  r16                  ;     PD1
    ldi    r16,             OPC_PULLUP_c         ; OPC = pull-up
    ori    r16,             ISC_FALLING_c        ; ISC = falling-edge
    sts    PORTD_PIN2CTRL,  r16                  ;     PD2
    sts    PORTD_PIN0CTRL,  r16                  ;     PD0

;   Port D Outputs
    ldi    r16,             0b_0011_1000         ; PD5,PD4,PD3
    sts    PORTD_OUT,       r16                  ;     output = high
    sts    PORTD_DIR,       r16                  ;     DIR    = output
    ldi    r16,             OPC_WIRED_AND_c      ; OPC = Wired-AND
    sts    PORTD_PIN5CTRL,  r16                  ;     PD5
    sts    PORTD_PIN4CTRL,  r16                  ;     PD4
    sts    PORTD_PIN3CTRL,  r16                  ;     PD3

;   Port D Interrupt Mask and Level
    ldi    r16,             0b_0000_0101         ; PD2, PD0
    sts    PORTD_INTMASK,   r16                  ;     interrupt mask
    ldi    r16,             PORT_INTLVL_MED_gc   ; INTLVL = medium
    sts    PORTD_INTCTRL,   r16                  ;     Port D


; PORT R
;   Pin   Dir   Out        OPC              ISC          Configuration      Connected To
;   ---   ---   ---   -------------     ------------     ------------------------------------
;    1    Out    1     wired-AND                         100K pull-up       OLED100 CS#
;    0    Out    1     totem-pole                                           OLED100 D/C#
; -----------------------------------------------------------------------------
    ldi    r16,             0b_0000_0011         ; PR1,PR0
    sts    PORTR_OUT,       r16                  ;     output = high
    sts    PORTR_DIR,       r16                  ;     DIR    = output
    ldi    r16,             OPC_WIRED_AND_c      ; OPC = Wired-AND
    sts    PORTR_PIN1CTRL,  r16                  ;     PR1
    ldi    r16,             OPC_TOTEM_c          ; OPC = Totem-Pole
    sts    PORTR_PIN0CTRL,  r16                  ;     PR0


.endmacro
