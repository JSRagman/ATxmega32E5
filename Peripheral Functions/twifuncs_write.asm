;
; twifuncs_write.asm
;
; Created: 17Nov2019
; Updated: 26Jan2020
; Author : JSRagman
;

; Description:
;     TWI Write (dw) functions for the ATxmega32E5U as a single TWI Master.
;
; Notes:
;     1. These functions are written for a single-master TWI bus.
;        It is assumed that there is only one TWI master - you.
;     2. SLA+W (used in comments) means Slave TWI address plus Write bit.



; Function List:
;     TwiDw_FromEeprom    Transmits a block of data from EEPROM to a TWI device.
;     TwiDw_Wait          Waits for MSTATUS.WIF to be set.




; TwiDw_FromEeprom                                                    26Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Transmits a block of data from EEPROM to a TWI device.
; Initial Conditions:
;     1. TWI Master Baud Rate is set.
;     2. TWI Master is enabled.
; Parameters:
;     r20    - SLA+W for the targeted TWI device
;     X      - Points to EEPROM data
;     Count  - The first byte of EEPROM data is expected to indicate the
;              number of data bytes that follow
; I/O Registers Affected:
;     TWIC_MASTER_ADDR  (0x0486)
;     TWIC_MASTER_CTRLC (0x0483)
;     TWIC_MASTER_DATA  (0x0487)
; Functions Called:
;     TwiDw_Wait ( )
; Returns:
;     SREG_T - success (0) or fail (1)
; Notes:
;     1. XMEGA EEPROM always starts at address 0x1000.  This means that you
;        must add 0x1000 (MAPPED_EEPROM_START) to an EEPROM address label,
;        because the assembler won't do it for you.
;     2. This function is probably good for SRAM data also, but I'm not
;        there, yet.
TwiDw_FromEeprom:
    push   r17
    push   r21

   .def    count  = r17
   .def    slaw   = r20
   .def    datbyt = r21

;   Connect
    sts    TWIC_MASTER_ADDR,   slaw         ; ADDR = SLA+W
    rcall  TwiDw_Wait                       ; SREG_T = TwiDw_Wait()
    brts   TwiDw_FromEeprom_exit            ; if (SREG_T == 1) goto exit

;   Send Data
    ld     count,  X+                       ; EEPROM: count = byte count, X=X+1
    cp     count,  rZero                    ; compare(count, zero)
TwiDw_FromEeprom_loop:
    breq   TwiDw_FromEeprom_exit            ; if (count == 0) goto exit

    ld     datbyt,           X+             ; EEPROM: datbyt = data, X=X+1
    sts    TWIC_MASTER_DATA, datbyt         ; DATA = datbyt
    rcall  TwiDw_Wait                       ; SREG_T = TwiDw_Wait()
    dec    count                            ; count = count - 1
    brtc   TwiDw_FromEeprom_loop            ; if (SREG_T == 0) goto TwiDw_FromEeprom_loop
                                            ; else  fall into exit
TwiDw_FromEeprom_exit:
;   Stop
    ldi    r17,                TWI_MASTER_CMD_STOP_gc  ; CTRLC: command = STOP
    sts    TWIC_MASTER_CTRLC,  r17

   .undef  count
   .undef  slaw
   .undef  datbyt

    pop    r21
    pop    r17
    ret

; TwiDw_Wait                                                          26Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Called after starting transmission of a TWI address (SLA+W) or data.
;
;     This function waits for MSTATUS.WIF to be set, checks .ARBLOST, .BUSERR,
;     and .RXACK, and then returns the SREG T flag to indicate success (0) or
;     failure (1).
;
;     Success is defined as:
;         - MSTATUS.WIF     is set
;         - MSTATUS.ARBLOST is cleared
;         - MSTATUS.BUSERR  is cleared
;         - MSTATUS.RXACK   is cleared (ACK)
; Parameters:
;     None.
; I/O Registers Affected:
;     TWIC_MASTER_STATUS  (0x0484)
; Constants (Non-Standard):
;     TWIM_DWFLAGS_bm  -  Masks all STATUS register bits except
;                         RXACK, ARBLOST, and BUSERR, all of which should
;                         be zero following a successful transmission.
; Returns:
;     SREG_T - success (0) or fail (1)
TwiDw_Wait:
    push   r19

TwiDw_Wait_wait:
    lds    r19,    TWIC_MASTER_STATUS       ; r19 = STATUS
    sbrs   r19,    TWI_MASTER_WIF_bp        ; if (WIF == 0)
    rjmp   TwiDw_Wait_wait                  ;     goto TwiDw_Wait_wait

    andi   r19,    TWIM_DWFLAGS_bm          ; if (DWFLAGS == 0)
    breq   TwiDw_Wait_exit                  ;     success: goto exit
                                            ; else
    set                                     ;     error: SREG_T = 1
                                            ;     fall into exit
TwiDw_Wait_exit:

    pop    r19
    ret
