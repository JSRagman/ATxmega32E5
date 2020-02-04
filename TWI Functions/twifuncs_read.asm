;
; twifuncs_read.asm
;
; Created: 27Jan2020
; Updated:  4Feb2020
;  Author: JSRagman
;
;
; Description:
;     TWI Data Read functions for the ATxmega32E5



.include "./TwiFunctions/twifuncs_common.asm"



; TwiDr_RegToSram                                                      4Feb2020
; -----------------------------------------------------------------------------
; Status:
;     tested  4Feb2020
; Description:
;     Receives a specified number of bytes from a TWI-connected device,
;     starting at a given device register address.
; Initial Conditions:
;     1. TWI Master is configured and enabled
;     2. Smart Mode is *disabled*
; Parameters:
;     r20  - SLA+W for the targeted device
;     r21  - device register address
;     r22  - number of bytes to receive
;     X    - SRAM destination address pointer
; Constants (Non-Standard):
;     ACKACT_ACK_c     - (0x00) ACK action = ACK
;     ACKACT_NACK_c    - (0x04) ACK action = NACK
;     TWIM_ADDR        - TWIC_MASTER_ADDR
;     TWIM_DATA        - TWIC_MASTER_DATA
;     TWIM_CTRLC       - TWIC_MASTER_CTRLC
;     TWIM_BREC_c      - TWI_MASTER_CMD_RECVTRANS_gc
;     TWIM_STOPNACK_c  - TWI_MASTER_CMD_STOP_gc | ACKACT_NACK_c
; Functions Called:
;     TwiRead_Wait  ( )
;     TwiWrite_Wait ( )
; Returns:
;     SREG_T - pass (0) or fail (1)
TwiDr_RegToSram:
    push   r16
    push   r19
    push   r20
    push   r22

   .def    slarw  = r20                     ; param: targeted device SLA+W
   .def    devreg = r21                     ; param: device register address
   .def    count  = r22                     ; param: byte count

   .def    datbyt  = r16                    ; data byte
   .def    command = r19                    ; command for CTRLC register

;   Start - direction = write
    sts    TWIM_ADDR,   slarw               ; ADDR = SLA+W
    rcall  TwiWrite_Wait                    ; SREG_T = TwiWrite_Wait()
    brts   TwiDr_RegToSram_exit             ; if (SREG_T == 1) goto exit

;   Transmit device register address
    sts    TWIM_DATA,   devreg              ; DATA = device register address
    rcall  TwiWrite_Wait                    ; SREG_T = TwiWrite_Wait()
    brts   TwiDr_RegToSram_exit             ; if (SREG_T == 1) goto exit

;   Repeated Start - direction = read
    sbr    slarw,  1                        ; SLA+R/W bit = Read
    sts    TWIM_ADDR,   slarw               ; ADDR  = SLA+R

    ldi    command,     TWIM_BREC_c         ; command = Receive + ACK
TwiDr_RegToSram_readloop:
    rcall  TwiRead_Wait                     ; SREG_T = TwiRead_Wait(r22)
    brts   TwiDr_RegToSram_exit             ; if (SREG_T == 1) goto exit

    lds    datbyt,      TWIM_DATA           ; r16 = TWIC_MASTER_DATA
    st     X+,          datbyt              ; SRAM[X++] = r16
    dec    count                            ; if (--count == 0)
    breq   TwiDr_RegToSram_exit             ;     goto exit
                                            ; else
    sts    TWIM_CTRLC,  command             ;     transmit ACK
    rjmp   TwiDr_RegToSram_readloop         ;     next byte

TwiDr_RegToSram_exit:
    ldi    command,     TWIM_STOPNACK_c     ; command = STOP + NACK
    sts    TWIM_CTRLC,  command

   .undef  slarw
   .undef  devreg
   .undef  count
   .undef  datbyt
   .undef  command

    pop    r22
    pop    r20
    pop    r19
    pop    r16
    ret


