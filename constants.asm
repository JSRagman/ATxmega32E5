;
; constants.asm
;
; Created: 16Nov2019
; Updated: 26Jan2020
; Author:  JSRagman
;
; MCU:     ATxmega32E5
;
; Description:
;     Constant definitions


.equ HSTACK_MAXSIZE = 256                   ; Used to initialize the data stack.


; Real-Time Counter (RTC) Constants                                   26Jan2020
; -----------------------------------------------------------------------------
.equ RTC_INTF_bm = (RTC_COMPIF_bm | RTC_OVFIF_bm) ; RTC OVF and COMP interrupt flags


; TWI Constants                                                       26Jan2020
; -----------------------------------------------------------------------------

; TWI Configuration - BAUD
.equ TWIM_BAUD_400khz_c = 35               ;  32 MHz system clock
.equ TWIM_BAUD_100khz_c = 155               ; 32 MHz system clock

; TWI Master Bit Masks
.equ TWIM_DWFLAGS_bm = (1<<TWI_MASTER_RXACK_bp)|(1<<TWI_MASTER_ARBLOST_bp)|(1<<TWI_MASTER_BUSERR_bp)


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
