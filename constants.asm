;
; constants.asm
;
; Created: 16Nov2019
; Updated:  3Dec2019
; Author:  JSRagman
;
; MCU:     ATxmega32E5
;
; Description:
;     Constant definitions


.equ HSTACK_MAXSIZE = 256                   ; Used to initialize the data stack.


; Port Configuration Constants                                         3Dec2019
; -----------------------------------------------------------------------------
.equ ISC_EDGES_c      = PORT_ISC_BOTHEDGES_gc
.equ ISC_FALLING_c    = PORT_ISC_FALLING_gc
.equ ISC_RISING_c     = PORT_ISC_RISING_gc
.equ ISC_DISABLE_c    = PORT_ISC_INPUT_DISABLE_gc

.equ OPC_TOTEM_c      = PORT_OPC_TOTEM_gc
.equ OPC_PULLDOWN_c   = PORT_OPC_PULLDOWN_gc
.equ OPC_PULLUP_c     = PORT_OPC_PULLUP_gc
.equ OPC_WIRED_OR_c   = PORT_OPC_WIREDOR_gc
.equ OPC_WIRED_AND_c  = PORT_OPC_WIREDAND_gc



; Real-Time Counter (RTC) Constants                                   14Dec2019
; -----------------------------------------------------------------------------
.equ RTC_INTF_bm = (RTC_COMPIF_bm | RTC_OVFIF_bm) ; RTC OVF and COMP interrupt flags





; TWI Constants                                                       24Nov2019
; -----------------------------------------------------------------------------

; TWI Registers
.equ TWIM_ADDR   = TWIC_MASTER_ADDR              ; (0x0486) Master Address Register
.equ TWIM_BAUD   = TWIC_MASTER_BAUD              ; (0x0485) Master BAUD Rate Register
.equ TWIM_CTRLA  = TWIC_MASTER_CTRLA             ; (0x0481) Master Control Register A
.equ TWIM_CTRLB  = TWIC_MASTER_CTRLB             ; (0x0482) Master Control Register B
.equ TWIM_CTRLC  = TWIC_MASTER_CTRLC             ; (0x0483) Master Control Register C
.equ TWIM_DATA   = TWIC_MASTER_DATA              ; (0x0487) Master Data Register
.equ TWIM_STATUS = TWIC_MASTER_STATUS            ; (0x0484) Master Status Register

; TWI MASTER CTRLA Register Bits
.equ TWIM_INTLVL1_bp   = TWI_MASTER_INTLVL1_bp   ; Interrupt Level bit 1
.equ TWIM_INTLVL0_bp   = TWI_MASTER_INTLVL0_bp   ; Interrupt Level bit 0
.equ TWIM_RIEN_bp      = TWI_MASTER_RIEN_bp      ; Read Interrupt Enable
.equ TWIM_WIEN_bp      = TWI_MASTER_WIEN_bp      ; Write Interrupt Enable
.equ TWIM_ENABLE_bp    = TWI_MASTER_ENABLE_bp    ; Enable TWI Master

; TWI Configuration - BAUD
.equ TWIM_BAUD_400khz_c = 35               ;  32 MHz system clock
.equ TWIM_BAUD_100khz_c = 155               ; 32 MHz system clock

; TWI Master Flags
.equ TWIM_WIF_bp     = TWI_MASTER_WIF_bp

; TWI Master Bit Masks
.equ TWIM_DWFLAGS_bm = (1<<TWI_MASTER_RXACK_bp)|(1<<TWI_MASTER_ARBLOST_bp)|(1<<TWI_MASTER_BUSERR_bp)

; TWI Master Commands
.equ TWIM_STOP_c = TWI_MASTER_CMD_STOP_gc

; TWI Master State
.equ TWIM_BSTATE_IDLE_c = TWI_MASTER_BUSSTATE_IDLE_gc



; NHD-0420CW Display Constants:
; -----------------------------------------------------------------------------

; Device Address
.equ DISPLAY_ADDR1 = 0x78                        ; character display 1
.equ DISPLAY_ADDR2 = 0x7A                        ; character display 2


; Control Bytes
.equ CTRL_CMD     = 0x00          ; Control Byte (Command)
.equ CTRL_CMD_CO  = 0x80          ; Control Byte (Command) + Continue
.equ CTRL_DAT     = 0x40          ; Control Byte (Data)
.equ CTRL_DAT_CO  = 0xC0          ; Control Byte (Data)    + Continue

; Commands
.equ DISPLAY_CLEAR = 0x01
.equ DISPLAY_HOME  = 0x02
.equ DISPLAY_OFF   = 0x08
.equ DISPLAY_ON    = 0x0C
.equ SET_DDRAM     = 0b_1000_0000

; Cursor State Bit Patterns
.equ CURSOR_ON     = 0b_0000_0010
.equ CURSOR_BLINK  = 0b_0000_0011
.equ CURSOR_OFF    = 0

; Display Position Constants
.equ CHARCOUNT     = 80           ; Total number of display characters
.equ LINECOUNT     =  4           ; Number of display lines
.equ LINELENGTH    = 20           ; Length (characters) of one display line

.equ DDRAM_INCR = 0x20                    ; DDRAM Increment from one line to the next
.equ LINE_1     = 0x00    ; Line 1, Column 0
.equ LINE_2     = 0x20    ; Line 2, Column 0
.equ LINE_3     = 0x40    ; Line 3, Column 0
.equ LINE_4     = 0x60    ; Line 4, Column 0

; Digit Conversion
.equ DIG_TO_ASCII = 0x30     ; Convert a single digit to ASCII character

; ASCII Characters
.equ ASC_COLON  = 0x3A
.equ ASC_DASH   = 0x2D
.equ ASC_FSLASH = 0x2F
.equ ASC_SPACE  = 0x20



