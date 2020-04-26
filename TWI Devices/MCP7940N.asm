;
; MCP7940N.asm
;
; Created: 27Jan2020
; Updated: 26Apr2020
;  Author: JSRagman
;
; Hardware:
;     MCU:              ATxmega32E5
;     Real-Time Clock:  Microchip MCP7940N
;     Interface:        TWI
;
; Description:
;     Basic functions for interacting with the MCP7940N Battery-Backed I2C
;     Real-Time Clock/Calendar.
;
; Design Considerations:
;     1. The MCP7940 supports only one TWI address, so it is implemented
;        as a constant.
;     2. The clock is configured to use a 24-hour time format.
;     3. These functions are redundant in many places. The goal was to achieve
;        maximum flexibility. Get out the scissors, if you like.
;     4. I have neglected Oscillator Trim functions. When I get every other
;        function written, I'll worry about trimming the oscillator.


; Function List:
;     MCP7940_Configure   - Loads MCP7940 configuration from EEPROM data
;     MCP7940_GetControl  - Retrieves the MCP7940 CONTROL register contents
;     MCP7940_GetDateTime - Retrieves time and date
;     MCP7940_SetRegister - Updates the value of one MCP7940 register
;     MCP7940_SetSqw      - Sets the MFP square wave output configuration
;     MCP7940_Start       - Starts the MCP7940 clock, preserving RTCSEC value
;     MCP7940_Stop        - Stops the MCP7940 clock, preserving RTCSEC value

; TWI Functions Called:
;     r22,SREG_T = TwiRd_Register ( r20, r21 )
;         SREG_T = TwiRd_Regs     ( r20, r21, r22, X )
;         SREG_T = TwiWr_FromEE   ( r20, r23, X )
;         SREG_T = TwiWr_Register ( r20, r21, r22 )


; *** I prefer to keep all my .includes in main.asm ***
; Thus, the below line is commented out. Your preferences may differ.
;.include "./TwiDevices/MCP7940N_defs.asm"


#ifndef _mcp7940n_funcs
#define _mcp7940n_funcs



; MCP7940_Configure                                                   26Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Sets the device configuration with data from EEPROM.
;
;     The first byte of EEPROM data is expected to indicate the number of
;     registers (bytes) to load. The second byte will be the starting register
;     address.
; Parameters:
;     X - points to EEPROM configuration data
; Constants:
;     MCP7940_SLAW_c
; Functions Called:
;     SREG_T = MCP7940_Start ( )
;     SREG_T = TwiWr_FromEE  ( r20, r23, X )
; Returns:
;     SREG_T - success (0) or error (1)
MCP7940_Configure:
    push   r20
    push   r23
    push   XL
    push   XH

   .def    slaw    = r20
   .def    eecount = r23

    ldi    slaw,     MCP7940_SLAW_c         ; r20    = MCP7940_SLAW_c
    ld     eecount,  X+                     ; r23    = EEPROM[X++]
    rcall  TwiWr_FromEE                     ; SREG_T = TwiWr_FromEE(r20,r23,X)
    rcall  MCP7940_Start                    ; SREG_T = MCP7940_Start()

   .undef  slaw
   .undef  eecount

    pop    XH
    pop    XL
    pop    r23
    pop    r20
    ret


; MCP7940_GetControl                                                  16Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Retrieves the MCP7940 CONTROL register.
; Parameters:
;     None
; Constants:
;     MCP7940_CTRL   - (0x07) CONTROL register address
;     MCP7940_SLAW_c - (0xDE) MCP7940 SLA+W
; Functions Called:
;     r22,SREG_T = TwiRd_Register ( r20, r21 )
; Returns:
;     SREG_T - success (0) or error (1)
;     r22    - CONTROL register
MCP7940_GetControl:
    push   r20
    push   r21

    ldi    r20,    MCP7940_SLAW_c           ; r20 = SLA+W
    ldi    r21,    MCP7940_CTRL             ; r21 = CONTROL register address
    rcall  TwiRd_Register                   ; r22,SREG_T = TwiRd_Register(r20,r21)

    pop    r21
    pop    r20

    ret


; MCP7940_GetDateTime                                                 23Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Retrieves time and date registers. Writes the data to SRAM as 7 bytes
;     of packed BCD.
; Parameters:
;     X    - points to SRAM destination
; Constants:
;     MCP7940_DTREGS_c - date/time register count
;     MCP7940_SEC      - RTCSEC register address
;     MCP7940_SLAW_c   - TWI SLA+W
; Functions Called:
;     SREG_T = TwiRd_Regs ( r20, r21, r22, X )
; Returns:
;     SREG_T - success (0) or error (1)
MCP7940_GetDateTime:
    push   r20
    push   r21
    push   r22

    ldi    r20,    MCP7940_SLAW_c           ; r20 = MCP7940 SLA+W
    ldi    r21,    MCP7940_SEC              ; r21 = MCP7940_SEC
    ldi    r22,    MCP7940_DTREGS_c         ; r22 = MCP7940_DTREGS_c
    rcall  TwiRd_Regs                       ; SREG_T = TwiRd_Regs(r20,r21,r22,X)

    pop    r22
    pop    r21
    pop    r20
    ret


; MCP7940_SetRegister                                                 23Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Updates the value of one MCP7940 register, changing only the bits
;     specified by the bit mask parameter.
;
;     To configure only the MFP square wave output in the CONTROL register, the
;     bit mask would be 0b_0100_0011. Only the SQWEN, SQWFS1, and SQWFS2 bits
;     would be changed.
;
;     This is useful when updating registers that have, in addition to
;     timekeeping bits, configuration bits that should not be changed.
; Parameters:
;     r21 - MCP7940 register address
;     r24 - new register bits
;     r25 - bit mask
; General-Purpose Registers:
;     Parameters   - r21, r22, r23
;     Modified     - 
; Functions Called:
;     DS,SREG_T = TwiRd_Register ( r20, r21 )
;        SREG_T = TwiWr_Register ( r20, r21, r22 )
; Macros Used:
;     popd    - Pops the top byte from the data stack into a register
; Returns:
;     SREG_T - success (0) or error (1)
MCP7940_SetRegister:
    push   r20
    push   r22
    push   r24
    push   r25

   .def    slaw    = r20                    ; device SLA+W
   .def    regaddr = r21                    ; param: register address
   .def    regval  = r22                    ; register value
   .def    newval  = r24                    ; param: new value
   .def    mask    = r25                    ; param: bit mask

    ldi    r20,    MCP7940_SLAW_c           ; r20 = SLA+W
    rcall  TwiRd_Register                   ; r22,SREG_T = TwiRd_Register(r20,r21)
    brts   MCP7940_SetRegister_exit         ; if (error)  goto exit

    and    newval, mask                     ; r24    = r24 & r25
    com    mask                             ; r25    = complement(r25)
    and    regval, mask                     ; r22    = r22 & r25
    or     regval, newval                   ; r22    = r22 | r24
    rcall  TwiWr_Register                   ; SREG_T = TwiWr_Register(r20,r21,r22)

MCP7940_SetRegister_exit:

   .undef  regval
   .undef  mask
   .undef  newval
   .undef  slaw
   .undef  regaddr

    pop    r25
    pop    r24
    pop    r22
    pop    r20
    ret


; MCP7940_SetSqw                                                      12Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Sets the Multifunction Pin (MFP) square wave output configuration. Only
;     the CONTROL register SQWEN, SQWFS1, and SQWFS0 bits are affected.
; Parameters:
;     r24 - MFP configuration byte (0b_0n00_00nn)
; General-Purpose Registers:
;     Parameters        - r24
;     Modified          - 
; Constants:
;     MCP7940_CTRL      - MCP7940 CONTROL register address
;     MCP7940_SLAW_c    - MCP7940 SLA+W
;     MCP7940_SQW_bm    - (0b_0100_0011) SQWEN, SQWFS1, and SQWFS0 bit mask
; Parameter Constants:
;     MCP7940_SQWEN_c   - (0x40) Square wave output enable (bit 6)
;     MCP7940_SQW_1_c   -    (0)  1 Hz
;     MCP7940_SQW_4_c   -    (1)  4.096 kHz
;     MCP7940_SQW_8_c   -    (2)  8.192 kHz
;     MCP7940_SQW_32_c  -    (3) 32.768 kHz
; Functions Called:
;     r22,SREG_T = TwiRd_Register ( r20, r21 )
;         SREG_T = TwiWr_Register ( r20, r21, r22 )
; Returns:
;     SREG_T - success (0) or error (1)
; Notes:
;     1.  The MCP7940_SetRegister(r21,DS) function could also be used to
;         accomplish this.
MCP7940_SetSqw:
    push   r17
    push   r20
    push   r21
    push   r22
    push   r24

   .def    sqwmask = r17                    ; SQW bit mask
   .def    ctrlreg = r22                    ; control register content
   .def    newsqw  = r24                    ; param: new SQW config bits

;   Mask the newsqw parameter (just to be sure)
    ldi    sqwmask,   MCP7940_SQW_bm        ; r17 = MCP7940_SQW_bm
    and    newsqw,    sqwmask               ; r24 = r24 & r17
    com    sqwmask                          ; r17 = complement(r17)

;   Get the existing CONTROL register content
    ldi    r20,       MCP7940_SLAW_c        ; r20 = MCP7940 SLA+W
    ldi    r21,       MCP7940_CTRL          ; r21 = MCP7940_CTRL
    rcall  TwiRd_Register                   ; r22,SREG_T = TwiRd_Register(r20,r21)
    brts   MCP7940_SetSqw_exit              ; if (error)  goto exit

;   Apply the change
    and    ctrlreg,   sqwmask               ; r22 = r22 & r17
    or     ctrlreg,    newsqw               ; r22 = r22 | r24
    rcall  TwiWr_Register                   ; SREG_T  = TwiWr_Register(r20,r21,r22)

MCP7940_SetSqw_exit:

   .undef  sqwmask
   .undef  ctrlreg
   .undef  newsqw

    pop    r24
    pop    r22
    pop    r21
    pop    r20
    pop    r17

    ret


; MCP7940_Start                                                       23Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Starts the MCP7940 clock, preserving the RTCSEC register value.
;
;     The RTCSEC register contains the ST (Start Oscillator) bit in addition
;     to the timekeeping seconds value.
; Parameters:
;     None
; Constants:
;     MCP7940_SEC    - RTCSEC register address
;     MCP7940_ST_bp  - RTCSEC register ST bit position
; Functions Called:
;     r22,SREG_T = TwiRd_Register ( r20, r21 )
;         SREG_T = TwiWr_Register ( r20, r21, r22 )
; Returns:
;     SREG_T - success (0) or error (1)
MCP7940_Start:
    push   r20
    push   r21
    push   r22

    ldi    r20,    MCP7940_SLAW_c           ; r20 = MCP7940_SLAW_c
    ldi    r21,    MCP7940_SEC              ; r21 = MCP7940_SEC
    rcall  TwiRd_Register                   ; r22,SREG_T = TwiRd_Register(r20,r21)
    brts   MCP7940_Start_exit               ; if (error)  goto exit

    sbr    r22,    (1<<MCP7940_ST_bp)       ; r22[ST] = 1
    rcall  TwiWr_Register                   ; SREG_T  = TwiWr_Register(r20,r21,r22)

MCP7940_Start_exit:

    pop    r22
    pop    r21
    pop    r20
    ret


; MCP7940_Stop                                                        23Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Stops the MCP7940 clock, preserving the RTCSEC register value.
;
;     The RTCSEC register contains the ST (Start Oscillator) bit in addition
;     to the timekeeping seconds value.
; Parameters:
;     None
; Constants:
;     MCP7940_SEC    - RTCSEC register address
;     MCP7940_ST_bp  - RTCSEC register ST bit position
; Functions Called:
;     r22,SREG_T = TwiRd_Register ( r20, r21 )
;         SREG_T = TwiWr_Register ( r20, r21, r22 )
; Returns:
;     SREG_T  - success (0) or error (1)
MCP7940_Stop:
    push   r20
    push   r21
    push   r22

    ldi    r20,    MCP7940_SLAW_c           ; r20 = MCP7940_SLAW_c
    ldi    r21,    MCP7940_SEC              ; r21 = MCP7940_SEC
    rcall  TwiRd_Register                   ; r22,SREG_T = TwiRd_Register(r20,r21)
    brts   MCP7940_Stop_exit                ; if (SREG_T == 1) goto exit

    cbr    r22,    (1<<MCP7940_ST_bp)       ; r22[ST] = 0
    rcall  TwiWr_Register                   ; SREG_T  = TwiWr_Register(r20,r21,r22)

MCP7940_Stop_exit:

    pop    r22
    pop    r21
    pop    r20
    ret




#endif

