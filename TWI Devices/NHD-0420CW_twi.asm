;
; NHD_0420CW_twi.asm
;
; Created: 23Nov2019
; Updated: 26Jan2020
; Author : JSRagman
;

; Description:
;     Basic functions for interacting with a TWI-connected NHD-0420CW
;     OLED character display (Newhaven Display).
;
; Hardware:
;           MCU:  ATxmega32E5
;       Display:  Newhaven Display NHD-0420CW
;     Interface:  TWI
;
; Connections:
;     DRESET - The display !RESET line is connected to Port A at bit
;              position DRESET_bp.

; NHD_0420CW TWI Address Options
; ------------------------------
; .equ DISPLAY_ADDR1 = 0x78
; .equ DISPLAY_ADDR2 = 0x7A




; NHD0420CW_Reset                                                     26Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Resets the NHD-0420CW display.
;
;     Pulls the !RESET line low for 1 millisecond and then releases.
;     Delays 100 milliseconds before returning.
; Initial Conditions:
;     The display !RESET line is connected to Port A (VPORT0) at bit position
;     DRESET_bp.
;     An external pull-up resistor is present.
; Parameters:
;     None
; General-Purpose Registers:
;     Named      - 
;     Parameters - 
;     Modified   - 
; I/O Registers Affected:
;     PA4        - !RESET signal
; Constants Used:
;     DRESET_bp - bit position for the display !RESET line on Port A
; Functions Called:
;     RTC_Wait(r20, r21) - Returns after a specified number of centiseconds.
; Returns:
;     Nothing
NHD0420CW_Reset:

    cbi    VPORT0_OUT,  DRESET_bp           ; !RESET = Low
    ldi    r20,    1                        ; arg: delay time = 10 milliseconds
    ldi    r21,    RTC_OVFINTLVL_HI_gc      ; arg: RTC OVF level = high
    rcall  RTC_Wait                         ; RTC_Wait(r20, r21)

    sbi    VPORT0_OUT,  DRESET_bp           ; !RESET = High
    ldi    r20,    10                       ; arg: delay time = 100 milliseconds
    ldi    r21,    RTC_OVFINTLVL_HI_gc      ; arg: RTC OVF level = high
    rcall  RTC_Wait                         ; RTC_Wait(r20, r21)

    ret



; NHD0420CW_Init                                                      26Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Initializes the NHD-0420CW display.
; Parameters:
;     r20    - SLA+W for the targeted TWI device
; Address Labels Used:
;     ee_us2066_initdata - EEPROM address of initialization data
; Note:
;     EEPROM always starts at address 0x1000.  This means that you must add
;     MAPPED_EEPROM_START (0x1000) to your EEPROM address label, because the
;     assembler won't do it for you.
NHD0420CW_Init:
    push   XL
    push   XH

;   Send initialization data
    ldi    XL,      low(MAPPED_EEPROM_START + ee_us2066_initdata)  ; X = init data address
    ldi    XH,     high(MAPPED_EEPROM_START + ee_us2066_initdata)
    rcall  TwiDw_FromEeprom                           ; SREG_T = TwiDw_FromEeprom(r20,X)

NHD0420CW_Init_exit:

    pop    XH
    pop    XL
    ret



; NHD0420CW_ShowStartup                                               26Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Shows a startup message.
; Parameters:
;     r20    - SLA+W for the targeted TWI device
; Address Labels Used:
;     ee_us2066_initdata - EEPROM address of initialization data
NHD0420CW_ShowStartup:
    push   XL
    push   XH

;   Show startup message
    ldi    XL,      low(MAPPED_EEPROM_START + ee_sutext) ; X = startup text address
    ldi    XH,     high(MAPPED_EEPROM_START + ee_sutext)
    rcall  TwiDw_FromEeprom                 ; SREG_T = TwiDw_FromEeprom(r20,X)

    pop    XH
    pop    XL
    ret

