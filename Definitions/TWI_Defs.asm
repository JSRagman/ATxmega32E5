;
; TWI_Defs.asm
;
; Created: 17Jan2020
; Updated: 19Jan2020
; Author : JSRagman
;

; Organization:
;     1.  TWI Registers
;     2.  TWI Master Registers
;     3.  TWI Slave Registers
;     4.  *TWI Timeout Registers
;     5.  *TWI Timeout - Related Registers
;     6.  TWI Interrupt Vectors

; Number Formats:
;     1.  Register Addresses    16-bit hex
;     2.  Interrupt Vectors     16-bit hex
;     3.  Bit Positions         decimal (0-7)
;     4.  Bit Masks             8-bit hex
;     5.  Constants             8-bit hex

; References:
;     1.  XMEGA E5 Data Sheet,  DS40002059A, Rev A - 08/2018
;     2.  XMEGA E MANUAL,       Atmel–42005E–AVR–XMEGA E–11/2014
;     3.  ATxmega32E5def.inc,   Version 1.00, 2012-11-02 13:32


; * TWI Timeout definitions do not exist in Ref 3 and have been
;   synthesized here from Refs 1 and 2.
;   SMBUS L1 Compliance is covered in Sect. 18.9 and Sect. 19
;   of Ref 2.




; TWI Registers  (Ref 2, Sect. 18.10)
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ TWIC_CTRL                  = 0x0480    ; Common Control



; TWI_CTRL Register  (Ref 2, Sect. 18.10.1)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_BRIDGEEN_bp            =    7      ; Bridge Mode Enable
.equ TWI_SFMPEN_bp              =    6      ; Slave Fast Mode Plus Enable
.equ TWI_FMPEN_bp               =    3      ; FMPLUS Enable
.equ TWI_EDIEN_bp               =    0      ; External Driver Interface Enable

; SSDA Hold Time (Bridge Mode only)
;                          0b_00nn_0000
; SSDAHOLD constants are not defined.
; These are the same as SDA Hold Time values shifted left by 3 places.

; SDA Hold Time            0b_0000_0nn0
.equ TWI_SDAHOLD_OFF_gc         = 0x00      ; Off
.equ TWI_SDAHOLD_50NS_gc        = 0x02      ;  50 ns
.equ TWI_SDAHOLD_300NS_gc       = 0x04      ; 300 ns
.equ TWI_SDAHOLD_400NS_gc       = 0x06      ; 400 ns



; TWI Master Registers  (Ref 2, Sect. 18.11)
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ TWIC_MASTER_CTRLA          = 0x0481    ; Master Control A
.equ TWIC_MASTER_CTRLB          = 0x0482    ; Master Control B
.equ TWIC_MASTER_CTRLC          = 0x0483    ; Master Control C
.equ TWIC_MASTER_STATUS         = 0x0484    ; Master Status
.equ TWIC_MASTER_BAUD           = 0x0485    ; Master Baud Rate Control
.equ TWIC_MASTER_ADDR           = 0x0486    ; Master Address
.equ TWIC_MASTER_DATA           = 0x0487    ; Master Data


; TWIC_MASTER_CTRLA Register  (Ref 2, Sect. 18.11.1)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_MASTER_RIEN_bp         =    5      ; Read Interrupt Enable
.equ TWI_MASTER_WIEN_bp         =    4      ; Write Interrupt Enable
.equ TWI_MASTER_ENABLE_bp       =    3      ; TWI Master Enable

; Interrupt Level             0b_nn00_0000
.equ TWI_MASTER_INTLVL_OFF_gc   = 0x00      ; Disabled
.equ TWI_MASTER_INTLVL_LO_gc    = 0x40      ; Low Level
.equ TWI_MASTER_INTLVL_MED_gc   = 0x80      ; Medium Level
.equ TWI_MASTER_INTLVL_HI_gc    = 0xC0      ; High Level


; TWIC_MASTER_CTRLB Register  (Ref 2, Sect. 18.11.2)
; -----------------------------------------------------------------------------
; Bit Positions
;    TWI_MASTER_TOIE_bp         =    7      ; Timeout Interrupt Enable (not defined)
;    TWI_MASTER_TMEXTEN_bp      =    6      ; Tlowmext Enable (not defined)
;    TWI_MASTER_TSEXTEN_bp      =    5      ; Tlowsext Enable (not defined)
;    TWI_MASTER_TTOUTEN_bp      =    4      ; Ttimeout Enable (not defined)
.equ TWI_MASTER_QCEN_bp         =    1      ; Quick Command Enable
.equ TWI_MASTER_SMEN_bp         =    0      ; Smart Mode Enable

; Inactive Timeout                0b_0000_nn00
.equ TWI_MASTER_TIMEOUT_DISABLED_gc = 0x00  ; Disabled
.equ TWI_MASTER_TIMEOUT_50US_gc     = 0x04  ; 50 Microseconds
.equ TWI_MASTER_TIMEOUT_100US_gc    = 0x08  ; 100 Microseconds
.equ TWI_MASTER_TIMEOUT_200US_gc    = 0x0C  ; 200 Microseconds


; TWIC_MASTER_CTRLC Register  (Ref 2, Sect. 18.11.3)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_MASTER_ACKACT_bp         =    2    ; Acknowledge Action (ACK or NACK)

; Acknowledge Action            0b_0000_0n00
;    TWI_MASTER_ACKACT_ACK        = 0x00    ; Send ACK (not defined)
;    TWI_MASTER_ACKACT_NACK       = 0x04    ; Send NACK (not defined)

; Master Command                0b_0000_00nn
.equ TWI_MASTER_CMD_NOACT_gc      = 0x00    ; No Action
.equ TWI_MASTER_CMD_REPSTART_gc   = 0x01    ; Issue Repeated Start Condition
.equ TWI_MASTER_CMD_RECVTRANS_gc  = 0x02    ; Receive or Transmit Data
.equ TWI_MASTER_CMD_STOP_gc       = 0x03    ; Issue Stop Condition


; TWIC_MASTER_STATUS Register  (Ref 2, Sect. 18.11.4)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_MASTER_RIF_bp            =    7    ; Read Interrupt Flag
.equ TWI_MASTER_WIF_bp            =    6    ; Write Interrupt Flag
.equ TWI_MASTER_CLKHOLD_bp        =    5    ; Clock Hold
.equ TWI_MASTER_RXACK_bp          =    4    ; Received Acknowledge
.equ TWI_MASTER_ARBLOST_bp        =    3    ; Arbitration Lost
.equ TWI_MASTER_BUSERR_bp         =    2    ; Bus Error

; Bit Masks
.equ TWI_MASTER_RIF_bm            = 0x80    ; Read Interrupt Flag
.equ TWI_MASTER_WIF_bm            = 0x40    ; Write Interrupt Flag
.equ TWI_MASTER_CLKHOLD_bm        = 0x20    ; Clock Hold
.equ TWI_MASTER_RXACK_bm          = 0x10    ; Received Acknowledge
.equ TWI_MASTER_ARBLOST_bm        = 0x08    ; Arbitration Lost
.equ TWI_MASTER_BUSERR_bm         = 0x04    ; Bus Error
.equ TWI_MASTER_BUSSTATE_gm       = 0x03    ; Bus State

; Bus State                       0b_0000_00nn
.equ TWI_MASTER_BUSSTATE_UNKNOWN_gc = 0x00  ; Unknown Bus State
.equ TWI_MASTER_BUSSTATE_IDLE_gc    = 0x01  ; Bus is Idle
.equ TWI_MASTER_BUSSTATE_OWNER_gc   = 0x02  ; This Module Controls The Bus
.equ TWI_MASTER_BUSSTATE_BUSY_gc    = 0x03  ; The Bus is Busy




; TWI Slave Registers  (Ref 2, Sect. 18.12)
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ TWIC_SLAVE_CTRLA           = 0x0488    ; Slave Control A
.equ TWIC_SLAVE_CTRLB           = 0x0489    ; Slave Control B
.equ TWIC_SLAVE_STATUS          = 0x048A    ; Slave Status
.equ TWIC_SLAVE_ADDR            = 0x048B    ; Slave Address
.equ TWIC_SLAVE_DATA            = 0x048C    ; Slave Data
.equ TWIC_SLAVE_ADDRMASK        = 0x048D    ; Slave Address Mask



; TWIC_SLAVE_CTRLA Register  (Ref 2, Sect. 18.12.1)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_SLAVE_DIEN_bp          =    5      ; Data Interrupt Enable
.equ TWI_SLAVE_APIEN_bp         =    4      ; Address/Stop Interrupt Enable
.equ TWI_SLAVE_ENABLE_bp        =    3      ; TWI Slave Enable
.equ TWI_SLAVE_PIEN_bp          =    2      ; Stop Interrupt Enable
.equ TWI_SLAVE_PMEN_bp          =    1      ; Promiscuous Mode Enable
.equ TWI_SLAVE_SMEN_bp          =    0      ; Smart Mode Enable

; Interrupt Level             0b_nn00_0000
.equ TWI_SLAVE_INTLVL_OFF_gc    = 0x00      ; Disabled
.equ TWI_SLAVE_INTLVL_LO_gc     = 0x40      ; Low Level
.equ TWI_SLAVE_INTLVL_MED_gc    = 0x80      ; Medium Level
.equ TWI_SLAVE_INTLVL_HI_gc     = 0xC0      ; High Level


; TWIC_SLAVE_CTRLB Register  (Ref 2, Sect. 18.12.2)
; -----------------------------------------------------------------------------
; Bit Positions
;    TWI_SLAVE_TOIE_bp          =    7        Timeout Interrupt Enable (not defined)
;    TWI_SLAVE_TTOUTEN_bp       =    4        Ttimeout Enable (not defined)
.equ TWI_SLAVE_ACKACT_bp        =    2      ; Acknowledge Action

; Acknowledge Action          0b_0000_0n00
;    TWI_SLAVE_ACKACT_ACK       = 0x00      ; Send ACK (not defined)
;    TWI_SLAVE_ACKACT_NACK      = 0x04      ; Send NACK (not defined)

; Command                     0b_0000_00nn
.equ TWI_SLAVE_CMD_NOACT_gc     = 0x00      ; No Action
.equ TWI_SLAVE_CMD_COMPTRANS_gc = 0x02      ; Complete a Transaction
.equ TWI_SLAVE_CMD_RESPONSE_gc  = 0x03      ; Response to Address/Data Interrupt


; TWIC_SLAVE_STATUS Register  (Ref 2, Sect. 18.12.3)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_SLAVE_DIF_bp           =    7      ; Data Interrupt Flag
.equ TWI_SLAVE_APIF_bp          =    6      ; Address/Stop Interrupt Flag
.equ TWI_SLAVE_CLKHOLD_bp       =    5      ; Clock Hold
.equ TWI_SLAVE_RXACK_bp         =    4      ; Received Acknowledge
.equ TWI_SLAVE_COLL_bp          =    3      ; Collision
.equ TWI_SLAVE_BUSERR_bp        =    2      ; Bus Error
.equ TWI_SLAVE_DIR_bp           =    1      ; Read/Write Direction
.equ TWI_SLAVE_AP_bp            =    0      ; Slave Address or Stop bit

; Bit Masks
.equ TWI_SLAVE_DIF_bm           = 0x80      ; Data Interrupt Flag
.equ TWI_SLAVE_APIF_bm          = 0x40      ; Address/Stop Interrupt Flag
.equ TWI_SLAVE_CLKHOLD_bm       = 0x20      ; Clock Hold
.equ TWI_SLAVE_RXACK_bm         = 0x10      ; Received Acknowledge
.equ TWI_SLAVE_COLL_bm          = 0x08      ; Collision
.equ TWI_SLAVE_BUSERR_bm        = 0x04      ; Bus Error
.equ TWI_SLAVE_DIR_bm           = 0x02      ; Read/Write Direction
.equ TWI_SLAVE_AP_bm            = 0x01      ; Slave Address or Stop


; TWIC_SLAVE_ADDRMASK Register  (Ref 2, Sect. 18.12.6)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_SLAVE_ADDREN_bp        =    0      ; Address Enable





; TWI Timeout Registers  (Ref 2, Sects. 18.13, 19.7)
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
;
; PROBLEM STATEMENT:
;    Ref 3 defines absolutely NOTHING with regard to TWI_TIMEOUT
;    or SMBUS L1 compliance. Nay, not even register addresses.
;
; SOLUTION:
;     Ref 2, Sect. 19.8 gives us a TWI_TIMEOUT offset value of +0x0E.
;     Given a TWIC_base address of 0x0480, TOS and TOCONF addresses
;     are calculated below.
;     Related definitions are plucked from Ref 2, Sect. 19.7.

;    TWIC_base           = 0x0480  ; Ref 2, Table 30-1
;    TWI_MASTER_offset   =   0x01  ; Ref 2, Sect. 19.8
;    TWI_SLAVE_offset    =   0x08  ; Ref 2, Sect. 19.8
;    TWI_TIMEOUT_offset  =   0x0E  ; Ref 2, Sect. 19.8


; DISCLAIMER:
; ****************************************************************
;    The following definitions don't exist in ATxmega32E5def.inc.
;    Constant names are formatted to resemble existing names,
;    that is to say - too damn long.
;    Constant values are transcribed from the cited references.
;
;    These definitions have not been operationally tested.
; ****************************************************************

;                                             Ref 2, Sect. 19.11
.equ TWIC_TIMEOUT_TOS           = 0x048E    ; Timeout Status Register
.equ TWIC_TIMEOUT_TOCONF        = 0x048F    ; Timeout Configuration Register


; TWIC_TIMEOUT_TOS Register  (Ref 2, Sect. 19.7.1)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_TIMEOUT_TTOUTSIF_bp    =    4      ; Slave Ttimeout Interrupt Flag
.equ TWI_TIMEOUT_TMEXTIF_bp     =    2      ; Tlowmext Interrupt Flag
.equ TWI_TIMEOUT_TSEXTIF_bp     =    1      ; Tlowsext Interrupt Flag
.equ TWI_TIMEOUT_TTOUTMIF_bp    =    0      ; Master Ttimeout Interrupt Flag


; TWIC_TIMEOUT_TOCONF Register  (Ref 2, Sect. 19.7.2)
; Table 19-3.  Ttimeout Configuration
; Table 19-4.  Tlowsext/Tlowmext Configuration
; -----------------------------------------------------------------------------
; Slave Ttimeout Selection                0b_nnn0_0000
.equ TWI_TIMEOUT_TTOUTSSEL_25MS_gc      = 0b_0000_0000  ; 0x00
.equ TWI_TIMEOUT_TTOUTSSEL_24MS_gc      = 0b_0010_0000  ; 0x20
.equ TWI_TIMEOUT_TTOUTSSEL_23MS_gc      = 0b_0100_0000  ; 0x40
.equ TWI_TIMEOUT_TTOUTSSEL_22MS_gc      = 0b_0110_0000  ; 0x60
.equ TWI_TIMEOUT_TTOUTSSEL_26MS_gc      = 0b_1000_0000  ; 0x80
.equ TWI_TIMEOUT_TTOUTSSEL_27MS_gc      = 0b_1010_0000  ; 0xA0
.equ TWI_TIMEOUT_TTOUTSSEL_28MS_gc      = 0b_1100_0000  ; 0xC0
.equ TWI_TIMEOUT_TTOUTSSEL_29MS_gc      = 0b_1110_0000  ; 0xE0

; Master Tlowsext/Tlowmext selection      0b_000n_n000
.equ TWI_TIMEOUT_TMSEXTSEL_25MS_10MS_gc = 0b_0000_0000  ; 0x00
.equ TWI_TIMEOUT_TMSEXTSEL_24MS_9MS_gc  = 0b_0000_1000  ; 0x08
.equ TWI_TIMEOUT_TMSEXTSEL_26MS_11MS_gc = 0b_0001_0000  ; 0x10
.equ TWI_TIMEOUT_TMSEXTSEL_27MS_12MS_gc = 0b_0001_1000  ; 0x18

; Master Ttimeout Selection               0b_0000_0nnn
.equ TWI_TIMEOUT_TTOUTMSEL_25MS_gc      = 0b_0000_0000  ; 0x00
.equ TWI_TIMEOUT_TTOUTMSEL_24MS_gc      = 0b_0000_0001  ; 0x01
.equ TWI_TIMEOUT_TTOUTMSEL_23MS_gc      = 0b_0000_0010  ; 0x02
.equ TWI_TIMEOUT_TTOUTMSEL_22MS_gc      = 0b_0000_0011  ; 0x03
.equ TWI_TIMEOUT_TTOUTMSEL_26MS_gc      = 0b_0000_0100  ; 0x04
.equ TWI_TIMEOUT_TTOUTMSEL_27MS_gc      = 0b_0000_0101  ; 0x05
.equ TWI_TIMEOUT_TTOUTMSEL_28MS_gc      = 0b_0000_0110  ; 0x06
.equ TWI_TIMEOUT_TTOUTMSEL_29MS_gc      = 0b_0000_0111  ; 0x07


; TWI Timeout - Related Registers
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
; Description:
;     These are TIMEOUT definitions that apply to registers from
;     preceding sections.


; TWIC_MASTER_CTRLB Register  (Ref 2, Sect. 18.11.2)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_MASTER_TOIE_bp         =    7      ; Timeout Interrupt Enable
.equ TWI_MASTER_TMEXTEN_bp      =    6      ; Tlowmext Enable
.equ TWI_MASTER_TSEXTEN_bp      =    5      ; Tlowsext Enable
.equ TWI_MASTER_TTOUTEN_bp      =    4      ; Ttimeout Enable
;.equ TWI_MASTER_QCEN_bp         =    1      ; Quick Command Enable
;.equ TWI_MASTER_SMEN_bp         =    0      ; Smart Mode Enable


; TWIC_SLAVE_CTRLB Register  (Ref 2, Sect. 18.12.2)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_SLAVE_TOIE_bp          =    7      ; Timeout Interrupt Enable
.equ TWI_SLAVE_TTOUTEN_bp       =    4      ; Ttimeout Enable
;.equ TWI_SLAVE_ACKACT_bp        =    2      ; Acknowledge Action




; TWI Interrupt Vectors
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ TWIC_TWIS_vect             = 0x0014    ; TWI Slave Interrupt
.equ TWIC_TWIM_vect             = 0x0016    ; TWI Master Interrupt


