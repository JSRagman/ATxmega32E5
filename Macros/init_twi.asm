
; init_twi                                                            26Jan2020
; -----------------------------------------------------------------------------
; Description:
;     Initializes the ATxmega32E5 TWI module.
;
;     1. Set the Master BAUD value for a 400 kHz SCL
;     2. Enable the Master Write (WIEN) and Read (RIEN) Interrupts, leaving the
;        interrupt level configuration at zero (disabled)
;     3. Set the Master CTRLA Enable bit
;     4. Set TWI bus state = Idle
; Parameters:
;     None
; General-Purpose Registers:
;     Modified  - r16
; I/O Registers Affected:
;     TWIC_MASTER_BAUD   (0x0485) - TWI Master Baud Rate Register
;     TWIC_MASTER_CTRLA  (0x0481) - TWI Master Control Register A
;     TWIC_MASTER_STATUS (0x0484) - TWI Master Status Register
; Constants:
;     TWI_MASTER_ENABLE_bp - Enable TWI Master
;     TWI_MASTER_RIEN_bp   - Read Interrupt Enable
;     TWI_MASTER_WIEN_bp   - Write Interrupt Enable
;     TWIM_BAUD_100khz_c   - Master BAUD value for a 100 kHz SCL
.macro init_twi
    ldi    r16,                 TWIM_BAUD_400khz_c
    sts    TWIC_MASTER_BAUD,    r16
    ldi    r16,                     (1<<TWI_MASTER_ENABLE_bp) \
                                  | (1<<TWI_MASTER_WIEN_bp)   \
                                  | (1<<TWI_MASTER_RIEN_bp)
    sts    TWIC_MASTER_CTRLA,   r16
    ldi    r16,                 TWI_MASTER_BUSSTATE_IDLE_gc
    sts    TWIC_MASTER_STATUS,  r16
.endmacro

