;
; twifuncs.asm
;
; Created: 14Mar2020
; Updated: 23Apr2020
; Author : JSRagman
;

; Description:
;     XMEGA E5 TWI functions - Single Master.
;
; Notes:
;     1. These functions are written for a single-master TWI bus.
;        There is only one TWI master - you.
;     2. SLA+W means Slave TWI address plus Write bit (0).
;     3. Error Handling - The Status Register T bit (SREG_T) is used to
;        indicate whether a function has completed normally (SREG_T = 0)
;        or has encountered an error (SREG_T = 1).
;        When a function returns, brts or brtc can be used to select an
;        appropriate action.

; Abbreviations:
;     DS       Data Stack
;     EE       EEPROM
;     SR       SRAM
;     SREG_T   Status Register T bit
;     TwiRd    TWI Read
;     TWiWr    TWI Write

; Function List:
;     TwiRd_ConnectReg  - Establishes a connection and selects a device
;                         register for reading
;     TwiRd_Register    - Retrieves the contents of one device register
;     TwiRd_Regs        - Reads one or more consecutive device registers
;                         and writes the data to SRAM
;     TwiRd_Wait        - Waits for MSTATUS.RIF, .ARBLOST, or .BUSERR
;     TwiWr_FromDS      - Transmits one or more bytes from the Data Stack
;     TwiWr_FromEE      - Transmits a block of data from EEPROM
;     TwiWr_FromSR      - Transmits a block of data from SRAM and/or
;                         the Data Stack
;     TwiWr_Register    - Writes to a single device register
;     TwiWr_Wait        - Waits for MSTATUS.WIF



#ifndef _xmega32e5_twifuncs
#define _xmega32e5_twifuncs



; TwiRd_ConnectReg                                                    11Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Establishes a connection and selects a device register for reading.
;
;     Generates a START condition and transmits SLA+W.
;     Upon receiving ACK, transmits the device register address.
;     After receiving a second ACK, generates a repeated START condition
;     and transmits SLA+R.
;
;     If an error is encountered at any step of this process, SREG_T is set
;     and the function returns.
; Parameters:
;     r20          - device SLA+W
;     r21          - device register address
; General-Purpose Registers:
;     Parameters   - r20, r21
;     Modified     - 
; I/O Registers Affected:
;     CPU_SREG
;     TWIC_MASTER_ADDR
;     TWIC_MASTER_DATA
; Constants:
;     TWIM_ADDR    - TWIC_MASTER_ADDR
;     TWIM_DATA    - TWIC_MASTER_DATA
; Functions Called:
;     SREG_T = TwiWr_Wait ( )
; Returns:
;     SREG_T - success (0) or error (1)
TwiRd_ConnectReg:
    push   r20

   .def    slarw   = r20                    ; param: SLA+W
   .def    regaddr = r21                    ; param: register address

    sts    TWIM_ADDR,   slarw               ; ADDR   = SLA+W
    rcall  TwiWr_Wait                       ; SREG_T = TwiWr_Wait()
    brts   TwiRd_ConnectReg_exit

    sts    TWIM_DATA,   regaddr             ; DATA   = regaddr
    rcall  TwiWr_Wait                       ; SREG_T = TwiWr_Wait()
    brts   TwiRd_ConnectReg_exit

    sbr    slarw,       1                   ; R/W bit = Read
    sts    TWIM_ADDR,   slarw               ; ADDR    = SLA+R

TwiRd_ConnectReg_exit:

   .undef  slarw
   .undef  regaddr

    pop    r20
    ret


; TwiRd_Register                                                      15Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Retrieves the value of one device register into r22.
; Parameters:
;     r20          - device SLA+W
;     r21          - register address
; General-Purpose Registers:
;     Parameters   - r20, r21
;     Modified     - r22
; Constants:
;     TWIM_DATA         - TWIC_MASTER_DATA
;     TWIM_CTRLC        - TWIC_MASTER_CTRLC
;     TWIM_STOPNACK_c   - NACK + STOP
; Functions Called:
;     SREG_T = TwiRd_ConnectReg ( r20, r21 )
;     SREG_T = TwiRd_Wait       ( )
; Returns:
;     SREG_T - success (0) or error (1)
;     r22    - register value
TwiRd_Register:
    push   r16

    rcall  TwiRd_ConnectReg                 ; SREG_T = TwiRd_ConnectReg(r20,r21)
    brts   TwiRd_Register_exit              ; if (error)  goto exit
    rcall  TwiRd_Wait                       ; SREG_T = TwiRd_Wait()
    brts   TwiRd_Register_exit              ; if (error)  goto exit
    lds    r22,    TWIM_DATA                ; r22 = DATA

TwiRd_Register_exit:
    ldi    r16,         TWIM_STOPNACK_c     ; CTRLC = TWIM_STOPNACK_c
    sts    TWIM_CTRLC,  r16

    pop    r16
    ret


; TwiRd_Regs                                                          15Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Reads one or more registers from a TWI-connected device and writes the
;     data to SRAM.
; Parameters:
;     r20         - device SLA+W
;     r21         - device register address
;     r22         - byte count
;     X           - SRAM destination pointer
; General-Purpose Registers:
;     Parameters       - r20, r21, r22, X
;     Modified         - 
; Constants:
;     TWIM_BREC_c      - TWI_MASTER_CMD_RECVTRANS_gc
;     TWIM_CTRLC       - TWIC_MASTER_CTRLC
;     TWIM_DATA        - TWIC_MASTER_DATA
;     TWIM_STOPNACK_c  - STOP command + NACK response
; Functions Called:
;     SREG_T = TwiRd_ConnectReg ( r20, r21 )
;     SREG_T = TwiRd_Wait       ( )
; Returns:
;     SREG_T - success (0) or error (1)
TwiRd_Regs:
    push   r18
    push   r19
    push   r22
    push   XL
    push   XH

   .def    datbyt  = r18                    ; data byte
   .def    command = r19                    ; CTRLC register command
   .def    slaw    = r20                    ; param: device SLA+W
   .def    regaddr = r21                    ; param: register address
   .def    count   = r22                    ; param: byte count

    ldi    command,     TWIM_BREC_c         ; command = TWIM_BREC_c
    rcall  TwiRd_ConnectReg                 ; SREG_T  = TwiRd_ConnectReg(r20,r21)
    brts   TwiRd_Regs_exit

TwiRd_Regs_loop:
    rcall  TwiRd_Wait                       ; SREG_T = TwiRd_Wait()
    brts   TwiRd_Regs_exit                  ; if (SREG_T == 1)
                                            ;     goto _exit
    lds    datbyt,      TWIM_DATA           ; datbyt    = DATA
    st     X+,          datbyt              ; SRAM[X++] = datbyt
    dec    count                            ; if (--count == 0)
    breq   TwiRd_Regs_exit                  ;     goto _exit

    sts    TWIM_CTRLC,  command             ; CTRLC = TWIM_BREC_c
    rjmp   TwiRd_Regs_loop                  ; goto _loop

TwiRd_Regs_exit:
    ldi    command,     TWIM_STOPNACK_c     ; CTRLC = TWIM_STOPNACK_c
    sts    TWIM_CTRLC,  command

   .undef  datbyt
   .undef  command
   .undef  slaw
   .undef  regaddr
   .undef  count

    pop    XH
    pop    XL
    pop    r22
    pop    r19
    pop    r18
    ret



; TwiRd_Wait                                                          11Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Waits for a RIF, ARBLOST, or BUSERR status flag to be set.
;     Returns the SREG T flag to indicate success (0) or error (1).
;
;     Success is defined as:
;         - MSTATUS.RIF is set
; Parameters:
;     None
; General-Purpose Registers:
;     Parameters - 
;     Modified   - 
; I/O Registers Affected:
;     CPU_SREG
; Constants:
;     TWIM_RDFLAGS_bm  - (0b_1000_1100)  RIF, ARBLOST, and BUSERR flags
;     TWIM_STATUS      - TWIC_MASTER_STATUS
; Returns:
;     SREG_T - success (0) or error (1)
TwiRd_Wait:
    push   r16

    clt                                     ; SREG_T = 0
TwiRd_Wait_wait:
    lds    r16,    TWIM_STATUS              ; r16 = STATUS
    andi   r16,    TWIM_RDFLAGS_bm          ; if (RDFLAGS == 0)
    breq   TwiRd_Wait_wait                  ;     goto TwiRd_Wait_wait
    sbrs   r16,    TWIM_RIF_bp              ; if (RIF == 0)
    set                                     ;     error: SREG_T = 1

    pop    r16
    ret


; TwiWr_FromDS                                                        11Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Transmits one or more bytes from the Data Stack to a TWI-connected device.
; Parameters:
;     r20        - device SLA+W
;     r22        - (n) data stack byte count
;     Data Stack - n bytes of data
; General-Purpose Registers:
;     Parameters   - r20, r22, Y
;     Modified     - Y
; Data Stack:
;     Initial      - n bytes of data
;     Final        - empty
; I/O Registers Affected:
;     TWIC_MASTER_ADDR
;     TWIC_MASTER_CTRLC
;     TWIC_MASTER_DATA
; Constants:
;     TWIM_ADDR    -  TWIC_MASTER_ADDR
;     TWIM_CTRLC   -  TWIC_MASTER_CTRLC
;     TWIM_DATA    -  TWIC_MASTER_DATA
;     TWIM_STOP_c  -  TWI_MASTER_CMD_STOP_gc
; Functions Called:
;     SREG_T = TwiWr_Wait ( )
; Macros Used:
;     popd - Pops the top byte from the data stack into a register
; Returns:
;     SREG_T - success (0) or error (1)
TwiWr_FromDS:
    push   r18
    push   r19
    push   r20
    push   r22

   .def    datbyt  = r18                    ; data byte
   .def    command = r19                    ; CTRLC register command
   .def    slaw    = r20                    ; param: device SLA+W
   .def    count   = r22                    ; param: byte count

    sts    TWIM_ADDR,   slaw                ; ADDR   = SLA+W
    rcall  TwiWr_Wait                       ; SREG_T = TwiWr_Wait()
    brts   TwiWr_FromDS_error

    tst    count                            ; compare(count, zero)
TwiWr_FromDS_loop:
    breq   TwiWr_FromDS_exit                ; if (count == 0)
                                            ;     goto exit
    popd   datbyt                           ; datbyt = DS[Y++]
    sts    TWIM_DATA,   datbyt              ; DATA   = datbyt
    rcall  TwiWr_Wait                       ; SREG_T = TwiWr_Wait()
    dec    count                            ; count--
    brtc   TwiWr_FromDS_loop                ; if (SREG_T == 0)
                                            ;     goto TwiWr_FromDS_loop
TwiWr_FromDS_error:
    tst    count                            ; compare(count, zero)
TwiWr_FromDS_popall:
    breq   TwiWr_FromDS_exit                ; if (count == 0) goto exit
    popd   datbyt                           ; datbyt = DS[Y++]
    dec    count                            ; count--
    rjmp   TwiWr_FromDS_popall              ; goto  TwiWr_FromDS_popall

TwiWr_FromDS_exit:
    ldi    command,     TWIM_STOP_c         ; CTRLC = TWIM_STOP_c
    sts    TWIM_CTRLC,  command

   .undef  datbyt
   .undef  command
   .undef  count
   .undef  slaw

    pop    r22
    pop    r20
    pop    r19
    pop    r18
    ret


; TwiWr_FromEE                                                        11Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Transmits a block of data from EEPROM to a TWI-connected device.
; Parameters:
;     r20    -  target device SLA+W
;     r23    -  EEPROM data byte count
;     X      -  Points to EEPROM source data
; General-Purpose Registers:
;     Parameters - r20, r22, X
;     Modified   - 
; I/O Registers Affected:
;     TWIC_MASTER_ADDR
;     TWIC_MASTER_CTRLC
;     TWIC_MASTER_DATA
; Constants:
;     TWIM_ADDR    -  TWIC_MASTER_ADDR
;     TWIM_CTRLC   -  TWIC_MASTER_CTRLC
;     TWIM_DATA    -  TWIC_MASTER_DATA
;     TWIM_STOP_c  -  TWI_MASTER_CMD_STOP_gc
; Functions Called:
;     SREG_T = TwiWr_Wait ( )
; Returns:
;     SREG_T - success (0) or error (1)
; Note:
;     Count is checked prior to entering the data loop. You can call this
;     prudence or paranoia. How likely is it that the incoming count parameter
;     will be zero?
TwiWr_FromEE:
    push   r18
    push   r19
    push   r23
    push   XL
    push   XH

   .def    datbyt  = r18                    ; data byte
   .def    command = r19                    ; CTRLC register command
   .def    slaw    = r20                    ; param: SLA+W
   .def    count   = r23                    ; param: byte count

    sts    TWIM_ADDR,   slaw                ; ADDR   = SLA+W
    rcall  TwiWr_Wait                       ; SREG_T = TwiWr_Wait()
    brts   TwiWr_FromEE_exit

    tst    count                            ; compare(count, zero)
TwiWr_FromEE_loop:
    breq   TwiWr_FromEE_exit                ; if (count == 0)
                                            ;     goto exit
    ld     datbyt,      X+                  ; datbyt = EEPROM[X++]
    sts    TWIM_DATA,   datbyt              ; DATA   = datbyt
    rcall  TwiWr_Wait                       ; SREG_T = TwiWr_Wait()
    dec    count                            ; count--
    brtc   TwiWr_FromEE_loop                ; if (SREG_T == 0)
                                            ;     goto TwiWr_FromEE_loop
TwiWr_FromEE_exit:
    ldi    command,     TWIM_STOP_c         ; CTRLC = TWIM_STOP_c
    sts    TWIM_CTRLC,  command

   .undef  datbyt
   .undef  command
   .undef  slaw
   .undef  count

    pop    XH
    pop    XL
    pop    r23
    pop    r19
    pop    r18
    ret


; TwiWr_FromSR                                                        11Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Transmits a block of data from SRAM to a TWI-connected device.
;     Data can be sourced from the Data Stack, an SRAM address, or both.
;     The Data Stack is transmitted first, followed by SRAM data.
;
;     This is useful if you have some nice clean data in SRAM but need to
;     preface it with a command or two before sending it off.
; Parameters:
;     r20          - device SLA+W
;     r22          - (n) data stack byte count
;     r23          - (p) SRAM data byte count
;     X            - points to p bytes of SRAM data
;     DS           - n bytes of data
; General-Purpose Registers:
;     Parameters   - r20, r22, r23, X, Y
;     Modified     - Y
; Data Stack:
;     Initial      - n bytes of data (n can be zero)
;     Final        - empty
; Constants:
;     TWIM_ADDR    -  TWIC_MASTER_ADDR
;     TWIM_CTRLC   -  TWIC_MASTER_CTRLC
;     TWIM_DATA    -  TWIC_MASTER_DATA
;     TWIM_STOP_c  -  TWI_MASTER_CMD_STOP_gc
; Functions Called:
;     SREG_T = TwiWr_Wait ( )
; Macros Used:
;     popd - Pops the top byte from the data stack into a register
; Returns:
;     SREG_T - success (0) or error (1)
TwiWr_FromSR:
    push   r18
    push   r19
    push   r22
    push   r23
    push   XL
    push   XH

   .def    datbyt  = r18                    ; data byte
   .def    command = r19                    ; CTRLC register command
   .def    slaw    = r20                    ; param: device SLA+W
   .def    dscount = r22                    ; param: Data Stack byte count
   .def    srcount = r23                    ; param: SRAM data byte count

; Connect with device
    sts    TWIM_ADDR,   slaw                ; ADDR   = SLA+W
    rcall  TwiWr_Wait                       ; SREG_T = TwiWr_Wait()
    brts   TwiWr_FromSR_error

; Data Stack Section
TwiWr_FromSR_dstack:
    tst    dscount                          ; compare(dscount, zero)
TwiWr_FromSR_dstack_loop:
    breq   TwiWr_FromSR_addr                ; if (dscount == 0)
                                            ;     goto SRAM section
    popd   datbyt                           ; datbyt = DS[Y++]
    sts    TWIM_DATA,   datbyt              ; DATA   = datbyt
    rcall  TwiWr_Wait                       ; SREG_T = TwiWr_Wait()
    dec    dscount                          ; dscount--
    brtc   TwiWr_FromSR_dstack_loop         ; if (SREG_T == 0)
                                            ;     goto TwiWr_FromSR_dstack_loop
    rjmp   TwiWr_FromSR_error               ; goto TwiWr_FromSR_error

; SRAM Section
TwiWr_FromSR_addr:
    tst    srcount                          ; compare(srcount, zero)
TwiWr_FromSR_addr_loop:
    breq   TwiWr_FromSR_exit                ; if (srcount == 0)
                                            ;     goto exit
    ld     datbyt,      X+                  ; datbyt = SRAM[X++]
    sts    TWIM_DATA,   datbyt              ; DATA   = datbyt
    rcall  TwiWr_Wait                       ; SREG_T = TwiWr_Wait()
    dec    srcount                          ; srcount--
    brtc   TwiWr_FromSR_addr_loop           ; if (SREG_T == 0)
                                            ;     goto TwiWr_FromSR_addr_loop
    rjmp   TwiWr_FromSR_exit                ; goto exit

; Error Section - Ensures the data stack is empty before returning
TwiWr_FromSR_error:
    tst    dscount                          ; compare(dscount, zero)
TwiWr_FromSR_popall:
    breq   TwiWr_FromSR_exit                ; if (dscount == 0)
                                            ;     goto exit
    popd   datbyt                           ; datbyt = DS[Y++]
    dec    dscount                          ; dscount--
    rjmp   TwiWr_FromSR_popall              ; goto TwiWr_FromSR_popall

TwiWr_FromSR_exit:
    ldi    command,     TWIM_STOP_c         ; CTRLC = TWIM_STOP_c
    sts    TWIM_CTRLC,  command

   .undef  datbyt
   .undef  command
   .undef  slaw
   .undef  dscount
   .undef  srcount

    pop    XH
    pop    XL
    pop    r23
    pop    r22
    pop    r19
    pop    r18
    ret


; TwiWr_Register                                                      12Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Writes to a single TWI-connected device register.
;
;     Establishes a connection with the device, transmits the register address,
;     then the register value.
; Parameters:
;     r20          - device SLA+W
;     r21          - register address
;     r22          - register value
; General-Purpose Registers:
;     Parameters   - r20, r21, r22
;     Modified     - 
; I/O Registers Affected:
;     TWIC_MASTER_ADDR
;     TWIC_MASTER_CTRLC
;     TWIC_MASTER_DATA
; Constants:
;     TWIM_ADDR    -  TWIC_MASTER_ADDR
;     TWIM_CTRLC   -  TWIC_MASTER_CTRLC
;     TWIM_DATA    -  TWIC_MASTER_DATA
;     TWIM_STOP_c  -  TWI_MASTER_CMD_STOP_gc
; Functions Called:
;     SREG_T = TwiWr_Wait ( )
; Returns:
;     SREG_T - success (0) or error (1)
TwiWr_Register:
    push   r18

   .def    command = r18                    ; CTRLC register command
   .def    slaw    = r20                    ; param: SLA+W
   .def    regaddr = r21                    ; param: register address
   .def    regval  = r22                    ; param: register value

    sts    TWIM_ADDR,   slaw                ; ADDR   = SLA+W
    rcall  TwiWr_Wait                       ; SREG_T = TwiWr_Wait()
    brts   TwiWr_Register_exit

    sts    TWIM_DATA,   regaddr             ; DATA   = regaddr
    rcall  TwiWr_Wait                       ; SREG_T = TwiWr_Wait()
    brts   TwiWr_Register_exit

    sts    TWIM_DATA,   regval              ; DATA   = regval
    rcall  TwiWr_Wait                       ; SREG_T = TwiWr_Wait()

TwiWr_Register_exit:
    ldi    command,     TWIM_STOP_c         ; CTRLC = STOP
    sts    TWIM_CTRLC,  command

   .undef  command
   .undef  slaw
   .undef  regaddr
   .undef  regval

    pop    r18

    ret



; TwiWr_Wait                                                          11Apr2020
; -----------------------------------------------------------------------------
; Description:
;     Waits for MSTATUS.WIF to be set. Checks ARBLOST, BUSERR, and RXACK, and
;     then returns SREG_T to indicate success (0) or error (1).
;
;     Success is defined as:
;         - WIF     = 1, and
;         - ARBLOST = 0, and
;         - BUSERR  = 0, and
;         - RXACK   = 0 (ACK)
; Parameters:
;     None.
; General-Purpose Registers:
;     Parameters - 
;     Modified   - 
; Constants:
;     TWIM_WRFLAGS_bm    -  (0b_0001_1100)  RXACK, ARBLOST, and BUSERR flags
;     TWIM_STATUS        -  TWIC_MASTER_STATUS
;     TWIM_WIF_bp        -  TWI_MASTER_WIF_bp
; Returns:
;     SREG_T - success (0) or error (1)
; Note:
;     If STATUS.WIF is never set, this function never returns.
;     Just so you know.
TwiWr_Wait:
    push   r16

TwiWr_Wait_wait:
    lds    r16,    TWIM_STATUS              ; r16 = STATUS
    sbrs   r16,    TWIM_WIF_bp              ; if (WIF == 0)
    rjmp   TwiWr_Wait_wait                  ;     goto TwiWr_Wait_wait

    andi   r16,    TWIM_WRFLAGS_bm          ; if (WRFLAGS == 0)
    breq   TwiWr_Wait_exit                  ;     success: goto exit
                                            ; else
    set                                     ;     error: SREG_T = 1

TwiWr_Wait_exit:

    pop    r16
    ret



#endif

