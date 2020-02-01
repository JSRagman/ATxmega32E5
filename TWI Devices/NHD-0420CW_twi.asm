;
; NHD_0420CW_twi.asm
;
; Created: 23Nov2019
; Updated:  1Feb2020
; Author : JSRagman
;

; Description:
;     Basic functions for interacting with a TWI-connected NHD-0420CW
;     OLED character display.
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
; .equ NHD0420CW_SLA1 = 0x78
; .equ NHD0420CW_SLA2 = 0x7A


; Function List:
;     NHD0420CW_Init         - Initializes the NHD-0420CW display
;     NHD0420CW_Reset        - Resets the NHD-0420CW display
;     NHD0420CW_SetPosition  - Sets the display line and column position
;     NHD0420CW_ShowPage     - Displays one page of text from an SRAM or EEPROM address



; NHD0420CW_Init                                                      26Jan2020
; -----------------------------------------------------------------------------
; Status:
;     tested  1Feb2020
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
    ldi    XL,      low(MAPPED_EEPROM_START + ee_us2066_initdata)
    ldi    XH,     high(MAPPED_EEPROM_START + ee_us2066_initdata)
    rcall  TwiDw_FromEeprom                 ; SREG_T = TwiDw_FromEeprom(r20,X)

NHD0420CW_Init_exit:

    pop    XH
    pop    XL
    ret


; NHD0420CW_Reset                                                     31Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Resets the NHD-0420CW display.
;
;     Pulls the !RESET line low for 10 milliseconds and then releases.
;     Delays 100 milliseconds before returning.
; Initial Conditions:
;     The display !RESET line is connected to Port A (VPORT0) at bit position
;     DRESET_bp.
;     When two displays are used, both !RESET lines are connected here.
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



; NHD0420CW_ShowText                                                   1Feb2020
; -----------------------------------------------------------------------------
; Description:
;     Displays one or more text characters, starting at a position specified
;     by line- and column-number parameters.
; Parameters:
;     r20     - SLA+W for the targeted display
;     r21     - line number (0, 1, 2, or 3).
;     r22     - column number (0, 1, 2, ..., 19).
;     r23     - character count
;     X       - SRAM/EEPROM data address pointer
NHD0420CW_ShowText:



    ret



; NHD0420CW_SetPosition                                                1Feb2020
; -----------------------------------------------------------------------------
; Description:
;     Sets the display line and column position.
; Assumptions:
;     1. DDRAM address 0 corresponds to Line 1, Column 1 of the display.
;     2. Line and Column parameters are zero-based:
;          a. Line Number will be 0, 1, 2, or 3.
;          b. Column Number will be in the range (0, 1, 2, ..., 19).
;     3. The DDRAM_INCR constant is the DDRAM address increment required
;        to pass from one display line to the next.
; Parameters:
;     r20     - SLA+W for the targeted display
;     r21     - line number (0, 1, 2, or 3).
;     r22     - column number (0, 1, 2, ..., 19).
; Note:
;     The SET_DDRAM command is composed of bit 7 plus a 7-bit address in bits 6:0
;     ( 0x80 | [7-bit address] )
NHD0420CW_SetPosition:
    push   r0
    push   r1
    push   r16
    push   r17

   .def    slaw   = r20                     ; param: SLA+W
   .def    linndx = r21                     ; param: display line index
   .def    colndx = r22                     ; param: display column index

   .def    lininc = r16                     ; DDRAM line increment
   .def    ddram  = r17                     ; DDRAM command + address

;   Calculate the DDRAM address.
    ldi     lininc,  NHD0420CW_DDRAM_INCR   ;   r16 = line increment
    mul     linndx,  lininc                 ; r1:r0 = linndx * lininc
    mov     ddram,   r0                     ; ddram = r0
    add     ddram,   colndx                 ; ddram = ddram + colndx

;   Set the display DDRAM address
    ori     ddram,   NHD0420CW_SET_DDRAM    ; ddram |= SET_DDRAM
    pushd   ddram                           ; datastack[--Y] = Set DDRAM Address command
    pushdi  NHD0420CW_CTRL_CMD              ; datastack[--Y] = Control Byte (Command)
    pushdi  2                               ; datastack[--Y] = 2
    rcall   TwiDw_FromDataStack             ; TwiDw_FromDataStack(count, data, SLA+W)

   .undef  slaw
   .undef  linndx
   .undef  colndx
   .undef  lininc
   .undef  ddram

    pop    r17
    pop    r16
    pop    r1
    pop    r0
    ret


; NHD0420CW_ShowPage                                                   1Feb2020
; -----------------------------------------------------------------------------
; Status:
;     Tested  1Feb2020
; Description:
;     Displays one page of text from a specified SRAM/EEPROM address.
; Parameters:
;     r20    - SLA+W for the targeted display
;     X      - Points to 80 contiguous bytes of text (EEPROM/SRAM)
; General-Purpose Registers:
;     Named      - 
;     Parameters - r20, X
;     Modified   - Y
; Constants (Non-Standard):
;     NHD0420CW_CLEAR        -  DISPLAY_CLEAR command
;     NHD0420CW_CTRL_CMD_CO  -  Control Byte (Command) + Continue
;     NHD0420CW_CTRL_DAT     -  Control Byte (Data)
; Functions Called:
;     TwiDw_FromSram(r20,r21,r22,X)
; Returns:
;     SREG_T - success (0) or fail (1)
NHD0420CW_ShowPage:
    push   r16
    push   r21
    push   r22

   .def    slaw    = r20                    ; param: target SLA+W
   .def    dscount = r21                    ; Data Stack byte count
   .def    srcount = r22                    ; SRAM data byte count

    pushdi  NHD0420CW_CTRL_DAT              ; datastack[--Y] = Control Byte (Data)
    pushdi  NHD0420CW_CLEAR                 ; datastack[--Y] = DISPLAY_CLEAR
    pushdi  NHD0420CW_CTRL_CMD_CO           ; datastack[--Y] = Control Byte (Command) + Continue
    ldi     dscount,    3                   ;    arg: r21 = 3
    ldi     srcount,    80                  ;    arg: r22 = 80
    rcall   TwiDw_FromSram                  ; TwiDw_FromSram(r20,r21,r22,X)

   .undef  slaw
   .undef  dscount
   .undef  srcount

    pop    r22
    pop    r21
    pop    r16
    ret

