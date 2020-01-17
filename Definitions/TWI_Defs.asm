;
; TWI_Defs.asm
;
; Created: 17Jan2020
; Updated: 17Jan2020
; Author : JSRagman
;



; TWI Registers
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ TWIC_CTRL               = 0x0480       ; Common Control
.equ TWIC_MASTER_CTRLA       = 0x0481       ; Master Control A
.equ TWIC_MASTER_CTRLB       = 0x0482       ; Master Control B
.equ TWIC_MASTER_CTRLC       = 0x0483       ; Master Control C
.equ TWIC_MASTER_STATUS      = 0x0484       ; Master Status
.equ TWIC_MASTER_BAUD        = 0x0485       ; Master Baud Rate Control
.equ TWIC_MASTER_ADDR        = 0x0486       ; Master Address
.equ TWIC_MASTER_DATA        = 0x0487       ; Master Data
.equ TWIC_SLAVE_CTRLA        = 0x0488       ; Slave Control A
.equ TWIC_SLAVE_CTRLB        = 0x0489       ; Slave Control B
.equ TWIC_SLAVE_STATUS       = 0x048A       ; Slave Status
.equ TWIC_SLAVE_ADDR         = 0x048B       ; Slave Address
.equ TWIC_SLAVE_DATA         = 0x048C       ; Slave Data
.equ TWIC_SLAVE_ADDRMASK     = 0x048D       ; Slave Address Mask



; TWI Interrupt Vectors
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ TWIC_TWIS_vect          = 0x0014       ; TWI Slave Interrupt
.equ TWIC_TWIM_vect          = 0x0016       ; TWI Master Interrupt



; TWI Bit Positions/Masks
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

; TWI_CTRL Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_BRIDGEEN_bp         = 7            ; Bridge Enable
.equ TWI_SFMPEN_bp           = 6            ; Slave Fast Mode Plus Enable
.equ TWI_SSDAHOLD1_bp        = 5            ; Slave SDA Hold Time Enable bit 1
.equ TWI_SSDAHOLD0_bp        = 4            ; Slave SDA Hold Time Enable bit 0
.equ TWI_FMPEN_bp            = 3            ; FMPLUS Enable
.equ TWI_SDAHOLD1_bp         = 2            ; SDA Hold Time Enable bit 1
.equ TWI_SDAHOLD0_bp         = 1            ; SDA Hold Time Enable bit 0
.equ TWI_EDIEN_bp            = 0            ; External Driver Interface Enable


; TWI_MASTER_CTRLA Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_MASTER_INTLVL1_bp   = 7            ; Interrupt Level bit 1
.equ TWI_MASTER_INTLVL0_bp   = 6            ; Interrupt Level bit 0
.equ TWI_MASTER_RIEN_bp      = 5            ; Read Interrupt Enable
.equ TWI_MASTER_WIEN_bp      = 4            ; Write Interrupt Enable
.equ TWI_MASTER_ENABLE_bp    = 3            ; TWI Master Enable


; TWI_MASTER_CTRLB Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_MASTER_TIMEOUT1_bp  = 3            ; Inactive Bus Timeout bit 1
.equ TWI_MASTER_TIMEOUT0_bp  = 2            ; Inactive Bus Timeout bit 0
.equ TWI_MASTER_QCEN_bp      = 1            ; Quick Command Enable
.equ TWI_MASTER_SMEN_bp      = 0            ; Smart Mode Enable


; TWI_MASTER_CTRLC Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_MASTER_ACKACT_bp    = 2            ; Acknowledge Action
.equ TWI_MASTER_CMD1_bp      = 1            ; Command bit 1
.equ TWI_MASTER_CMD0_bp      = 0            ; Command bit 0


; TWI_MASTER_STATUS Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_MASTER_RIF_bp       = 7            ; Read Interrupt Flag
.equ TWI_MASTER_WIF_bp       = 6            ; Write Interrupt Flag
.equ TWI_MASTER_CLKHOLD_bp   = 5            ; Clock Hold
.equ TWI_MASTER_RXACK_bp     = 4            ; Received Acknowledge
.equ TWI_MASTER_ARBLOST_bp   = 3            ; Arbitration Lost
.equ TWI_MASTER_BUSERR_bp    = 2            ; Bus Error
.equ TWI_MASTER_BUSSTATE1_bp = 1            ; Bus State bit 1
.equ TWI_MASTER_BUSSTATE0_bp = 0            ; Bus State bit 0

; Bit Masks
.equ TWI_MASTER_RIF_bm       = 0x80         ; Read Interrupt Flag bit mask
.equ TWI_MASTER_WIF_bm       = 0x40         ; Write Interrupt Flag bit mask
.equ TWI_MASTER_CLKHOLD_bm   = 0x20         ; Clock Hold bit mask
.equ TWI_MASTER_RXACK_bm     = 0x10         ; Received Acknowledge bit mask
.equ TWI_MASTER_ARBLOST_bm   = 0x08         ; Arbitration Lost bit mask
.equ TWI_MASTER_BUSERR_bm    = 0x04         ; Bus Error bit mask
.equ TWI_MASTER_BUSSTATE_gm  = 0x03         ; Bus State group mask


; TWI_SLAVE_CTRLA Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_SLAVE_INTLVL1_bp    = 7            ; Interrupt Level bit 1
.equ TWI_SLAVE_INTLVL0_bp    = 6            ; Interrupt Level bit 0
.equ TWI_SLAVE_DIEN_bp       = 5            ; Data Interrupt Enable
.equ TWI_SLAVE_APIEN_bp      = 4            ; Address/Stop Interrupt Enable
.equ TWI_SLAVE_ENABLE_bp     = 3            ; TWI Slave Enable
.equ TWI_SLAVE_PIEN_bp       = 2            ; Stop Interrupt Enable
.equ TWI_SLAVE_PMEN_bp       = 1            ; Promiscuous Mode Enable
.equ TWI_SLAVE_SMEN_bp       = 0            ; Smart Mode Enable


; TWI_SLAVE_CTRLB Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_SLAVE_ACKACT_bp     = 2            ; Acknowledge Action
.equ TWI_SLAVE_CMD1_bp       = 1            ; Command bit 1
.equ TWI_SLAVE_CMD0_bp       = 0            ; Command bit 0


; TWI_SLAVE_STATUS Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_SLAVE_DIF_bp        = 7            ; Data Interrupt Flag
.equ TWI_SLAVE_APIF_bp       = 6            ; Address/Stop Interrupt Flag
.equ TWI_SLAVE_CLKHOLD_bp    = 5            ; Clock Hold
.equ TWI_SLAVE_RXACK_bp      = 4            ; Received Acknowledge
.equ TWI_SLAVE_COLL_bp       = 3            ; Collision
.equ TWI_SLAVE_BUSERR_bp     = 2            ; Bus Error
.equ TWI_SLAVE_DIR_bp        = 1            ; Read/Write Direction
.equ TWI_SLAVE_AP_bp         = 0            ; Slave Address or Stop bit

; Bit Masks
.equ TWI_SLAVE_DIF_bm        = 0x80         ; Data Interrupt Flag bit mask
.equ TWI_SLAVE_APIF_bm       = 0x40         ; Address/Stop Interrupt Flag bit mask
.equ TWI_SLAVE_CLKHOLD_bm    = 0x20         ; Clock Hold bit mask
.equ TWI_SLAVE_RXACK_bm      = 0x10         ; Received Acknowledge bit mask
.equ TWI_SLAVE_COLL_bm       = 0x08         ; Collision bit mask
.equ TWI_SLAVE_BUSERR_bm     = 0x04         ; Bus Error bit mask
.equ TWI_SLAVE_DIR_bm        = 0x02         ; Read/Write Direction bit mask
.equ TWI_SLAVE_AP_bm         = 0x01         ; Slave Address or Stop bit mask


; TWI_SLAVE_ADDRMASK Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ TWI_SLAVE_ADDRMASK6_bp  = 7            ; Address Mask bit 6
.equ TWI_SLAVE_ADDRMASK5_bp  = 6            ; Address Mask bit 5
.equ TWI_SLAVE_ADDRMASK4_bp  = 5            ; Address Mask bit 4
.equ TWI_SLAVE_ADDRMASK3_bp  = 4            ; Address Mask bit 3
.equ TWI_SLAVE_ADDRMASK2_bp  = 3            ; Address Mask bit 2
.equ TWI_SLAVE_ADDRMASK1_bp  = 2            ; Address Mask bit 1
.equ TWI_SLAVE_ADDRMASK0_bp  = 1            ; Address Mask bit 0
.equ TWI_SLAVE_ADDREN_bp     = 0            ; Address Enable



; TWI Constants
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

; SDA Hold Time (TWI_CTRL)
.equ TWI_SDAHOLD_OFF_gc             = (0<<1) ; SDA Hold Time off
.equ TWI_SDAHOLD_50NS_gc            = (1<<1) ; SDA Hold Time 50 ns
.equ TWI_SDAHOLD_300NS_gc           = (2<<1) ; SDA Hold Time 300 ns
.equ TWI_SDAHOLD_400NS_gc           = (3<<1) ; SDA Hold Time 400 ns

; Master Interrupt Level (TWI_MASTER_CTRLA)
.equ TWI_MASTER_INTLVL_OFF_gc       = (0<<6) ; Interrupt Disabled
.equ TWI_MASTER_INTLVL_LO_gc        = (1<<6) ; Low Level
.equ TWI_MASTER_INTLVL_MED_gc       = (2<<6) ; Medium Level
.equ TWI_MASTER_INTLVL_HI_gc        = (3<<6) ; High Level

; Inactive Timeout (TWI_MASTER_CTRLB)
.equ TWI_MASTER_TIMEOUT_DISABLED_gc = (0<<2) ; Bus Timeout Disabled
.equ TWI_MASTER_TIMEOUT_50US_gc     = (1<<2) ; 50 Microseconds
.equ TWI_MASTER_TIMEOUT_100US_gc    = (2<<2) ; 100 Microseconds
.equ TWI_MASTER_TIMEOUT_200US_gc    = (3<<2) ; 200 Microseconds

; Master Command (TWI_MASTER_CTRLC)
.equ TWI_MASTER_CMD_NOACT_gc        = (0<<0) ; No Action
.equ TWI_MASTER_CMD_REPSTART_gc     = (1<<0) ; Issue Repeated Start Condition
.equ TWI_MASTER_CMD_RECVTRANS_gc    = (2<<0) ; Receive or Transmit Data
.equ TWI_MASTER_CMD_STOP_gc         = (3<<0) ; Issue Stop Condition

; Master Bus State (TWI_MASTER_STATUS)
.equ TWI_MASTER_BUSSTATE_UNKNOWN_gc = (0<<0) ; Unknown Bus State
.equ TWI_MASTER_BUSSTATE_IDLE_gc    = (1<<0) ; Bus is Idle
.equ TWI_MASTER_BUSSTATE_OWNER_gc   = (2<<0) ; This Module Controls The Bus
.equ TWI_MASTER_BUSSTATE_BUSY_gc    = (3<<0) ; The Bus is Busy

; Slave Interrupt Level (TWI_SLAVE_CTRLA)
.equ TWI_SLAVE_INTLVL_OFF_gc        = (0<<6) ; Interrupt Disabled
.equ TWI_SLAVE_INTLVL_LO_gc         = (1<<6) ; Low Level
.equ TWI_SLAVE_INTLVL_MED_gc        = (2<<6) ; Medium Level
.equ TWI_SLAVE_INTLVL_HI_gc         = (3<<6) ; High Level

; Slave Command (TWI_SLAVE_CTRLB)
.equ TWI_SLAVE_CMD_NOACT_gc         = (0<<0) ; No Action
.equ TWI_SLAVE_CMD_COMPTRANS_gc     = (2<<0) ; Used To Complete a Transaction
.equ TWI_SLAVE_CMD_RESPONSE_gc      = (3<<0) ; Used in Response to Address/Data Interrupt

