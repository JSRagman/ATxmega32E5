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




; TWI Constants                                                       28Jan2020
; -----------------------------------------------------------------------------

; Shortened Register Names
.equ TWIM_ADDR   = TWIC_MASTER_ADDR
.equ TWIM_CTRLB  = TWIC_MASTER_CTRLB
.equ TWIM_CTRLC  = TWIC_MASTER_CTRLC
.equ TWIM_DATA   = TWIC_MASTER_DATA
.equ TWIM_STATUS = TWIC_MASTER_STATUS

; TWI Configuration - BAUD
.equ TWIM_BAUD_400khz_c = 35               ;  32 MHz system clock
.equ TWIM_BAUD_100khz_c = 155               ; 32 MHz system clock

; TWI Master Bit Positions
.equ TWIM_SMEN_bp = TWI_MASTER_SMEN_bp

.equ TWIM_WIF_bp = TWI_MASTER_WIF_bp
.equ TWIM_RIF_bp = TWI_MASTER_RIF_bp

; TWI Master Bit Masks
.equ TWI_WRITEFLAGS_bm = (1<<TWI_MASTER_RXACK_bp)|(1<<TWI_MASTER_ARBLOST_bp)|(1<<TWI_MASTER_BUSERR_bp)
.equ TWI_READFLAGS_bm  = (1<<TWI_MASTER_RIF_bp)|(1<<TWI_MASTER_ARBLOST_bp)|(1<<TWI_MASTER_BUSERR_bp)

.equ TWIM_RIF_bm = TWI_MASTER_RIF_bm

; TWI Master Constants
; Acknowledge Action            0b_0000_0n00
.equ ACKACT_ACK_c  = 0x00    ; Send ACK
.equ ACKACT_NACK_c = 0x04    ; Send NACK

.equ TWIM_BREC_c   = TWI_MASTER_CMD_RECVTRANS_gc
.equ TWIM_STOP_c   = TWI_MASTER_CMD_STOP_gc
.equ TWIM_STOPNACK_c = TWI_MASTER_CMD_STOP_gc | ACKACT_NACK_c


; NHD-0420CW Display Constants:
; -----------------------------------------------------------------------------

; Device Address
.equ NHD0420CW_SLA1 = 0x78                        ; character display 1
.equ NHD0420CW_SLA2 = 0x7A                        ; character display 2


; Control Bytes
.equ NHD0420CW_CTRL_CMD     = 0x00          ; Control Byte (Command)
.equ NHD0420CW_CTRL_CMD_CO  = 0x80          ; Control Byte (Command) + Continue
.equ NHD0420CW_CTRL_DAT     = 0x40          ; Control Byte (Data)
.equ NHD0420CW_CTRL_DAT_CO  = 0xC0          ; Control Byte (Data)    + Continue

; Commands
.equ NHD0420CW_CLEAR = 0x01
.equ NHD0420CW_HOME  = 0x02
.equ NHD0420CW_OFF   = 0x08
.equ NHD0420CW_ON    = 0x0C
.equ NHD0420CW_SET_DDRAM     = 0b_1000_0000

; Cursor State Bit Patterns
.equ NHD0420CW_CURSOR_ON     = 0b_0000_0010
.equ NHD0420CW_CURSOR_BLINK  = 0b_0000_0011
.equ NHD0420CW_CURSOR_OFF    = 0

; Display Position Constants
.equ NHD0420CW_CHARCOUNT     = 80           ; Total number of display characters
.equ NHD0420CW_LINECOUNT     =  4           ; Number of display lines
.equ NHD0420CW_LINELENGTH    = 20           ; Length (characters) of one display line

.equ NHD0420CW_DDRAM_INCR = 0x20            ; DDRAM Increment from one line to the next
.equ NHD0420CW_LINE_1     = 0x00            ; Line 1, Column 0
.equ NHD0420CW_LINE_2     = 0x20            ; Line 2, Column 0
.equ NHD0420CW_LINE_3     = 0x40            ; Line 3, Column 0
.equ NHD0420CW_LINE_4     = 0x60            ; Line 4, Column 0

; Digit Conversion
.equ DIG_TO_ASCII = 0x30     ; Convert a single digit to ASCII character

; ASCII Characters
.equ ASC_COLON  = 0x3A
.equ ASC_DASH   = 0x2D
.equ ASC_FSLASH = 0x2F
.equ ASC_SPACE  = 0x20



; MCP7940N Real-Time Clock Constants:
; -----------------------------------------------------------------------------

.equ MCP7940_SLAW = 0xDE                ; TWI address

.equ MCP7940_BYTES  = 30
.equ MCP7940_TIMEBYTES = 7

; Timekeeping Registers
.equ MCP7940_SEC   = 0x00
.equ MCP7940_MIN   = 0x01
.equ MCP7940_HOUR  = 0x02
.equ MCP7940_WKDAY = 0x03
.equ MCP7940_DATE  = 0x04
.equ MCP7940_MTH   = 0x05
.equ MCP7940_YEAR  = 0x06
.equ MCP7940_CTRL  = 0x07
.equ MCP7940_TRIM  = 0x08

; Alarm Registers
.equ MCP7940_ALM0SEC   = 0x0A
.equ MCP7940_ALM0MIN   = 0x0B
.equ MCP7940_ALM0HOUR  = 0x0C
.equ MCP7940_ALM0WKDAY = 0x0D
.equ MCP7940_ALM0DATE  = 0x0E
.equ MCP7940_ALM0MTH   = 0x0F

.equ MCP7940_ALM1SEC   = 0x11
.equ MCP7940_ALM1MIN   = 0x12
.equ MCP7940_ALM1HOUR  = 0x13
.equ MCP7940_ALM1WKDAY = 0x14
.equ MCP7940_ALM1DATE  = 0x15
.equ MCP7940_ALM1MTH   = 0x16

.equ MCP7940_PWRDNMIN  = 0x18
.equ MCP7940_PWRDNHOUR = 0x18
.equ MCP7940_PWRDNDATE = 0x18
.equ MCP7940_PWRDNMTH  = 0x18

.equ MCP7940_PWRUPMIN  = 0x1C
.equ MCP7940_PWRUPHOUR = 0x1D
.equ MCP7940_PWRUPDATE = 0x1E
.equ MCP7940_PWRUPMTH  = 0x1F

; Timekeeping Register Index Values
.equ MCP7940_SEC_NDX = 0
.equ MCP7940_MIN_NDX = 1
.equ MCP7940_HOU_NDX = 2
.equ MCP7940_DAY_NDX = 3
.equ MCP7940_DAT_NDX = 4
.equ MCP7940_MTH_NDX = 5
.equ MCP7940_YEA_NDX = 6



; Register Bits
; ------------------------
; RTCSEC
.equ   MCP7940_ST_bp        = 7             ; RW  Oscillator Start bit
; RTCHOUR
.equ   MCP7940_HOUR_12_bp    = 6            ; RW  Time Format bit
.equ   MCP7940_HOUR_PM_bp    = 5
; RTCWKDAY
.equ   MCP7940_OSCRUN_bp    = 5             ; R   Oscillator Status bit
.equ   MCP7940_PWRFAIL_bp   = 4             ; RW  Power Failure bit
.equ   MCP7940_VBATEN_bp    = 3             ; RW  Enable Battery bit
; RTCCTRL
.equ   MCP7940_OUT_bp       = 7             ; RW  General-Purpose Output logic
.equ   MCP7940_SQWEN_bp     = 6             ; RW  Square Wave Output enable
.equ   MCP7940_ALM1EN_bp    = 5             ; RW  Alarm 1 enable
.equ   MCP7940_ALM0EN_bp    = 4             ; RW  Alarm 0 enable
.equ   MCP7940_EXTOSC_bp    = 3             ; RW  External Oscillator enable
.equ   MCP7940_CRSTRIM_bp   = 2             ; RW  Coarse Trim Mode enable
.equ   MCP7940_SQWFS1_bp    = 1             ; RW  Square Wave Output Frequency Select 1
.equ   MCP7940_SQWFS0_bp    = 0             ; RW  Square Wave Output Frequency Select 0
; RTCALM0_WKDAY
.equ   MCP7940_ALM0_POL_bp   = 7            ; RW  Alarm Polarity for both Alarm 0 and Alarm 1
.equ   MCP7940_ALM0_MSK2_bp  = 6            ; RW  Alarm 0 Mask Bits
.equ   MCP7940_ALM0_MSK1_bp  = 5
.equ   MCP7940_ALM0_MSK0_bp  = 4
.equ   MCP7940_ALM0_IF_bp    = 3            ; RW  Alarm 0 Interrupt Flag
; RTCALM1_WKDAY
;      RTCALM1_POL   = 7                    ; R   Set by the ALM0WKDAY register ALMPOL bit
.equ   MCP7940_ALM1_MSK2_bp  = 6            ; Alarm 1 Mask Bits
.equ   MCP7940_ALM1_MSK1_bp  = 5
.equ   MCP7940_ALM1_MSK0_bp  = 4
.equ   MCP7940_ALM1_IF_bp    = 3            ; Alarm 1 Interrupt Flag


; Square Wave Output
; RTCCTRL SQWFS1:SQWFS0 Bits
;   00  1 Hz
;   01  4.096 kHz
;   10  8.192 kHz
;   11  32.768 kHz
.equ MCP7940_SQW_1  = 0
.equ MCP7940_SQW_4  = (1<<MCP7940_SQWFS0_bp)
.equ MCP7940_SQW_8  = (1<<MCP7940_SQWFS1_bp)
.equ MCP7940_SQW_32 = (1<<MCP7940_SQWFS0_bp)|(1<<MCP7940_SQWFS1_bp)


; RTCWKDAY Register Constants
.equ MCP7940_MONDAY    = 1
.equ MCP7940_TUESDAY   = 2
.equ MCP7940_WEDNESDAY = 3
.equ MCP7940_THURSDAY  = 4
.equ MCP7940_FRIDAY    = 5
.equ MCP7940_SATURDAY  = 6
.equ MCP7940_SUNDAY    = 7

; RTCMTH Register Constants
.equ MCP7940_JANUARY   = 1
.equ MCP7940_FEBRUARY  = 2
.equ MCP7940_MARCH     = 3
.equ MCP7940_APRIL     = 4
.equ MCP7940_MAY       = 5
.equ MCP7940_JUNE      = 6
.equ MCP7940_JULY      = 7
.equ MCP7940_AUGUST    = 8
.equ MCP7940_SEPTEMBER = 9
.equ MCP7940_OCTOBER   = 0x10
.equ MCP7940_NOVEMBER  = 0x11
.equ MCP7940_DECEMBER  = 0x12

