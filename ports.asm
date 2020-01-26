;
; ports.asm
;
; Created: 16Nov2019
; Updated: 17Jan2020
; Author:  JSRagman
;
; MCU:     ATxmega32E5
;
; Description:
;     Port configuration.


; PORT A
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

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

; Bit Positions
.equ  QENCB_bp  = 7          ; Rotary encoder B contacts
.equ  QENCA_bp  = 6          ; Rotary encoder A contacts
.equ  QENCSW_bp = 5          ; Rotary encoder push switch
.equ  DRESET_bp = 4          ; TWI-connected display !RESET
.equ  REDLED_bp = 3          ; Red illuminated pushbutton LED
.equ  GRNLED_bp = 2          ; Green illuminated pushbutton LED
.equ  REDSW_bp  = 1          ; Red illuminated pushbutton switch
.equ  GRNSW_bp  = 0          ; Green illuminated pushbutton switch



; PORT C
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

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



; PORT D
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

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

; Onboard User LEDs
.equ  ULED1_bp = 5           ; PD5 - pull LOW to light LED
.equ  ULED0_bp = 4           ; PD4 - pull LOW to light LED

; Onboard User Pushbuttons
.equ  USW1_bp = 2            ; PD2 - pulls LOW when switch is depressed ( through a 39-ohm resistor )
.equ  USW0_bp = 0            ; PD0 - pulls LOW when switch is depressed ( through a 39-ohm resistor )

; Onboard Graphic OLED Display
.equ  OLED_RES = 3           ; PD3 - RES#, pull LOW to reset the display



; PORT R
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

;   Pin   Dir   Out        OPC              ISC          Configuration      Connected To
;   ---   ---   ---   -------------     ------------     ------------------------------------
;    1    Out    1     wired-AND                         100K pull-up       OLED100 CS#
;    0    Out    1     totem-pole                                           OLED100 D/C#

; Onboard Graphic OLED Display
.equ  OLED_CS_bp  = 1        ; PR1 - CS#,  pull LOW to select
.equ  OLED_DC_bp  = 0        ; PR0 - D/C#, high = data, low = command


