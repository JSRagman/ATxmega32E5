;
; twifuncs_common.asm
;
; Created: 27Jan2020
; Updated:  4Feb2020
; Author : JSRagman
;

; Description:
;     TWI functions common to read and write operations.
;
; Notes:
;     1. These functions are written for a single-master TWI bus.
;        It is assumed that there is only one TWI master - you.
;     2. SLA+W (used in comments) means Slave TWI address plus Write bit.


; Function List:
;     TwiWrite_Wait      Called after starting transmission of a TWI address (SLA+W) or data
;     TwiRead_Wait       Called after starting transmission of SLA+R


; Depends On:
;      ATxmega32e5def.inc
;      constants.asm


#ifndef _twifuncs_common
#define _twifuncs_common


; TwiRead_Wait                                                         4Feb2020
; -----------------------------------------------------------------------------
; Description:
;     Waits for a RIF, ARBLOST, or BUSERR status flag to be set.
; Parameters:
;     None
; General-Purpose Registers:
;     Named      - 
;     Parameters - 
;     Modified   - 
; Constants (Non-Standard):
;     TWI_READFLAGS_bm - mask out all but RIF, ARBLOST, and BUSERR
;     TWIM_STATUS      - TWIC_MASTER_STATUS
; Returns:
;     r23    - ACK action
;     SREG_T - success (0) or fail (1)
TwiRead_Wait:
    push   r19

TwiRead_Wait_wait:
    lds    r19,    TWIM_STATUS              ; r19 = STATUS
    andi   r19,    TWI_READFLAGS_bm         ; if (READFLAGS == 0)
    breq   TwiRead_Wait_wait                ;     goto TwiRead_Wait_wait

    sbrc   r19,    TWIM_RIF_bp              ; if (RIF == 1)
    rjmp   TwiRead_Wait_exit                ;     goto exit
                                            ; else
    set                                     ;     error: SREG_T = 1
                                            ;     fall into exit
TwiRead_Wait_exit:

    pop    r19
    ret





; TwiWrite_Wait                                                        1Feb2020
; -----------------------------------------------------------------------------
; Status:
;     tested  1Feb2020
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
; General-Purpose Registers:
;     Named      - 
;     Parameters - 
;     Modified   - 
; Constants (Non-Standard):
;     TWI_WRITEFLAGS_bm  -  Masks out all STATUS register bits except
;                           RXACK, ARBLOST, and BUSERR, all of which should
;                           be zero following a successful transmission.
;     TWIM_STATUS        -  TWIC_MASTER_STATUS
;     TWIM_WIF_bp        -  TWI_MASTER_WIF_bp
; Returns:
;     SREG_T - success (0) or fail (1)
; Note:
;     If STATUS.WIF is never set, this function never returns.
;     Just so you know.
TwiWrite_Wait:
    push   r16

TwiWrite_Wait_wait:
    lds    r16,    TWIM_STATUS              ; r16 = STATUS
    sbrs   r16,    TWIM_WIF_bp              ; if (WIF == 0)
    rjmp   TwiWrite_Wait_wait               ;     goto TwiWrite_Wait_wait

    andi   r16,    TWI_WRITEFLAGS_bm        ; if (WRITEFLAGS == 0)
    breq   TwiWrite_Wait_exit               ;     success: goto exit
                                            ; else
    set                                     ;     error: SREG_T = 1
                                            ;     fall into exit
TwiWrite_Wait_exit:

    pop    r16
    ret


#endif
