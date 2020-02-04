;
; twifuncs_write.asm
;
; Created: 17Nov2019
; Updated:  2Feb2020
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
;     TwiDw_FromDataStack  -  Transmits one or more bytes from the Data Stack
;     TwiDw_FromEeprom     -  Transmits a block of data from EEPROM
;     TwiDw_FromSram       -  Transmits a block of data from SRAM

; Depends On:
;      ATxmega32e5def.inc
;      constants.asm
;      datastackmacros.asm
;      twifuncs_common.asm



.include "./TwiFunctions/twifuncs_common.asm"


; TwiDw_FromDataStack                                                  1Feb2020
; -----------------------------------------------------------------------------
; Status:
;     tested  1Feb2020
; Description:
;     Transmits one or more bytes from the Data Stack to a TWI device.
; Parameters:
;     r20        - SLA+W for the targeted device
;     Data Stack - byte count + data
;                  The top byte on the data stack is expected to indicate
;                  the number of data bytes that follow
; General-Purpose Registers:
;     Parameters   - r20, X
;     Constants    - 
;     Modified     - Y
; Data Stack:
;     Incoming     - byte count (n) plus 1 to n bytes of data
;     Final        - empty
; I/O Registers Affected:
;     TWIC_MASTER_ADDR  (0x0486)
;     TWIC_MASTER_CTRLC (0x0483)
;     TWIC_MASTER_DATA  (0x0487)
; Constants (Non-Standard):
;     TWIM_ADDR    -  TWIC_MASTER_ADDR
;     TWIM_CTRLC   -  TWIC_MASTER_CTRLC
;     TWIM_DATA    -  TWIC_MASTER_DATA
;     TWIM_STOP_c  -  TWI_MASTER_CMD_STOP_gc
; Functions Called:
;     TwiWrite_Wait ( )
; Macros Used:
;     popd - Pop from the data stack into a register
; Returns:
;     SREG_T - pass (0) or fail (1)
TwiDw_FromDataStack:
    push   r16
    push   r17

   .def    slaw    = r20                    ; param: target SLA+W
   .def    datbyt  = r16                    ; data byte
   .def    dscount = r17                    ; data stack byte count

;   Get byte count from the data stack
    popd   dscount                          ; dscount = datastack[Y++]

;   Connect
    sts    TWIM_ADDR,   slaw                ; ADDR = SLA+W
    rcall  TwiWrite_Wait                    ; SREG_T = TwiWrite_Wait()
    brts   TwiDw_FromDataStack_error        ; if (SREG_T == 1) goto error

    tst    dscount                          ; compare(dscount, zero)
TwiDw_FromDataStack_loop:
    breq   TwiDw_FromDataStack_exit         ; if (dscount == 0)  goto exit
    popd   datbyt                           ; datbyt    = datastack[Y++]
    sts    TWIM_DATA,   datbyt              ; TWIM_DATA = datbyt
    rcall  TwiWrite_Wait                    ; SREG_T    = TwiWrite_Wait()
    dec    dscount                          ; dscount--
    brtc   TwiDw_FromDataStack_loop         ; if (SREG_T == 0)  next byte
                                            ; else  fall into error
TwiDw_FromDataStack_error:
    tst    dscount                          ; compare(dscount, zero)
TwiDw_FromDataStack_popall:
    breq   TwiDw_FromDataStack_exit         ; if (count == 0) goto exit
    popd   datbyt                           ; datbyt = datastack[Y++]
    dec    dscount                          ; dscount--
    rjmp   TwiDw_FromDataStack_popall       ; next byte

TwiDw_FromDataStack_exit:
    ldi    r16,         TWIM_STOP_c         ; CTRLC: command = STOP
    sts    TWIM_CTRLC,  r16


   .undef  slaw
   .undef  dscount
   .undef  datbyt

    pop    r17
    pop    r16
    ret



; TwiDw_FromEeprom                                                    31Jan2020
; -----------------------------------------------------------------------------
; Status:
;     tested  1Feb2020
; Description:
;     Transmits a block of data from EEPROM to a TWI device.
; Initial Conditions:
;     1. TWI Master is configured and enabled
; Parameters:
;     r20    -  SLA+W for the targeted TWI device
;     X      -  Pointer to EEPROM data
;     Count  -  The first byte of EEPROM data is expected to indicate the
;               number of data bytes that follow
; General-Purpose Registers:
;     Named      - 
;     Parameters - r20, X
;     Modified   - 
; I/O Registers Affected:
;     TWIC_MASTER_ADDR  (0x0486)
;     TWIC_MASTER_CTRLC (0x0483)
;     TWIC_MASTER_DATA  (0x0487)
; Constants (Non-Standard):
;     TWIM_ADDR    -  TWIC_MASTER_ADDR
;     TWIM_CTRLC   -  TWIC_MASTER_CTRLC
;     TWIM_DATA    -  TWIC_MASTER_DATA
;     TWIM_STOP_c  -  TWI_MASTER_CMD_STOP_gc
; Functions Called:
;     TwiWrite_Wait ( )
; Returns:
;     SREG_T - success (0) or fail (1)
; Notes:
;     1. XMEGA EEPROM always starts at address 0x1000.  This means that you
;        must add 0x1000 (MAPPED_EEPROM_START) to an EEPROM address label,
;        because the assembler won't do it for you.
TwiDw_FromEeprom:
    push   r16
    push   r17
    push   XL
    push   XH

   .def    slaw   = r20                     ; param: SLA+W
   .def    datbyt = r16                     ; data byte
   .def    count  = r17                     ; byte count

;   Connect
    sts    TWIM_ADDR,   slaw                ; ADDR = SLA+W
    rcall  TwiWrite_Wait                    ; SREG_T = TwiWrite_Wait()
    brts   TwiDw_FromEeprom_exit            ; if (SREG_T == 1) goto exit

;   Get byte count
    ld     count,       X+                  ; count = EEPROM[X++]
    tst    count                            ; compare(count, zero)
TwiDw_FromEeprom_loop:
    breq   TwiDw_FromEeprom_exit            ; if (count == 0) goto exit
    ld     datbyt,      X+                  ; datbyt    = EEPROM[X++]
    sts    TWIM_DATA,   datbyt              ; TWIM_DATA = datbyt
    rcall  TwiWrite_Wait                    ; SREG_T    = TwiWrite_Wait()
    dec    count                            ; count--
    brtc   TwiDw_FromEeprom_loop            ; if (SREG_T == 0)  next byte
                                            ; else  fall into exit
TwiDw_FromEeprom_exit:
    ldi    r16,         TWIM_STOP_c         ; CTRLC: command = STOP
    sts    TWIM_CTRLC,  r16

   .undef  slaw
   .undef  datbyt
   .undef  count

    pop    XH
    pop    XL
    pop    r17
    pop    r16
    ret



; TwiDw_FromSram                                                       1Feb2020
; -----------------------------------------------------------------------------
; Status:
;     tested  1Feb2020
; Description:
;     Transmits a block of data from SRAM to a TWI device.
;     Data can be sourced from the Data Stack, an SRAM address, or both.
;     The Data Stack is transmitted first, followed by SRAM data.
;
;     This is useful if you have some nice clean data in SRAM but need to
;     preface it with some commands before sending it off.
; Parameters:
;     r20          - SLA+W for the targeted TWI device
;     r21          - Data Stack Byte Count
;                    This parameter can be zero
;     r22          - SRAM Data Byte Count
;                    This parameter can be zero
;     X            - SRAM data address pointer
; General-Purpose Registers:
;     Parameters   - r20, r21, r22, X
;     Constants    - 
;     Modified     - Y
; Data Stack:
;     Incoming     - zero to x bytes of data
;     Final        - empty
; Constants (Non-Standard):
;     TWIM_ADDR    -  TWIC_MASTER_ADDR
;     TWIM_CTRLC   -  TWIC_MASTER_CTRLC
;     TWIM_DATA    -  TWIC_MASTER_DATA
;     TWIM_STOP_c  -  TWI_MASTER_CMD_STOP_gc
; Functions Called:
;     TwiWrite_Wait ( )
; Macros Used:
;     popd - Pop from the data stack into a register
; Returns:
;     SREG_T - success (0) or fail (1)
TwiDw_FromSram:
    push   r16
    push   r21
    push   r22
    push   XL
    push   XH

   .def    slaw    = r20                    ; param: target SLA+W
   .def    dscount = r21                    ; param: Data Stack byte count
   .def    srcount = r22                    ; param: SRAM data byte count
   .def    datbyt  = r16                    ; data byte

;   Connect
    sts    TWIM_ADDR,   slaw                ; ADDR = SLA+W
    rcall  TwiWrite_Wait                    ; SREG_T = TwiWrite_Wait()
    brts   TwiDw_FromSram_error             ; if (SREG_T == 1) goto error

; Data Stack Section
TwiDw_FromSram_dstack:
    tst    dscount                          ; if (dscount == 0)
    breq   TwiDw_FromSram_addr              ;     goto SRAM Address Section
TwiDw_FromSram_dstack_loop:
    popd   datbyt                           ; datbyt    = datastack[Y++]
    sts    TWIM_DATA,   datbyt              ; TWIM_DATA = datbyt
    rcall  TwiWrite_Wait                    ; SREG_T    = TwiWrite_Wait()
    dec    dscount                          ; dscount--
    brts   TwiDw_FromSram_error             ; if (SREG_T == 1)  goto error
    brne   TwiDw_FromSram_dstack_loop       ; if (dscount > 0)  next data stack byte
                                            ; else fall into:
; SRAM Address Section
TwiDw_FromSram_addr:
    tst    srcount                          ; if (srcount == 0)
    breq   TwiDw_FromSram_exit              ;     goto exit
TwiDw_FromSram_addr_loop:
    ld     datbyt, X+                       ; datbyt    = SRAM[X++]
    sts    TWIM_DATA,   datbyt              ; TWIM_DATA = datbyt
    rcall  TwiWrite_Wait                    ; SREG_T    = TwiWrite_Wait()
    dec    srcount                          ; srcount--
    brts   TwiDw_FromSram_exit              ; if (SREG_T == 1)  goto exit
    brne   TwiDw_FromSram_addr_loop         ; if (srcount > 0)  next SRAM data byte
    rjmp   TwiDw_FromSram_exit              ; else              goto exit
;   xxxxxxxxxxxxxxx No fall-through xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

TwiDw_FromSram_error:
    tst    dscount                          ; if (dscount == 0)
    breq   TwiDw_FromSram_exit              ;     goto exit
TwiDw_FromSram_popall:                      ; Ensures the data stack is empty before returning.
    popd   datbyt                           ; datbyt  = datastack[Y++]
    dec    dscount                          ; dscount--
    brne   TwiDw_FromSram_popall            ; if (dscount > 0)  next data stack byte
                                            ; else
                                            ;     fall into exit
TwiDw_FromSram_exit:
    ldi    r16,         TWIM_STOP_c         ; CTRLC: command = STOP
    sts    TWIM_CTRLC,  r16


   .undef  dscount
   .undef  srcount
   .undef  slaw
   .undef  datbyt

    pop    XH
    pop    XL
    pop    r22
    pop    r21
    pop    r16
    ret



