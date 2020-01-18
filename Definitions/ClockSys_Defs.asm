;
; ClockSys_Defs.asm
;
; Created: 17Jan2020
; Updated: 18Jan2020
; Author : JSRagman
;

; Organization:
;     1.  Oscillator Registers
;     2.  Oscillator Interrupt Vectors
;     3.  Clock System Registers
;     4.  DFLL 32MHz Registers

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




; Oscillator Registers  (Ref 2, Sect. 7.10)
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ OSC_CTRL              = 0x0050         ; Control
.equ OSC_STATUS            = 0x0051         ; Status
.equ OSC_XOSCCTRL          = 0x0052         ; External Oscillator Control
.equ OSC_XOSCFAIL          = 0x0053         ; Oscillator Failure Detection
.equ OSC_RC32KCAL          = 0x0054         ; 32.768 kHz Internal Oscillator Calibration
.equ OSC_PLLCTRL           = 0x0055         ; PLL Control
.equ OSC_DFLLCTRL          = 0x0056         ; DFLL Control
.equ OSC_RC8MCAL           = 0x0057         ; Internal 8 MHz RC Oscillator Calibration



; OSC_CTRL Register  (Ref 2, Sect. 7.10.1)
; -----------------------------------------------------------------------------
; Bit Positions
.equ OSC_RC8MLPM_bp        =    6           ; Internal 8 MHz RC Low Power Mode Enable
.equ OSC_RC8MEN_bp         =    5           ; Internal 8 MHz RC Oscillator Enable
.equ OSC_PLLEN_bp          =    4           ; PLL Enable
.equ OSC_XOSCEN_bp         =    3           ; External Oscillator Enable
.equ OSC_RC32KEN_bp        =    2           ; Internal 32.768 kHz RC Oscillator Enable
.equ OSC_RC32MEN_bp        =    1           ; Internal 32 MHz RC Oscillator Enable
.equ OSC_RC2MEN_bp         =    0           ; Internal 2 MHz RC Oscillator Enable


; OSC_STATUS Register  (Ref 2, Sect. 7.10.2)
; -----------------------------------------------------------------------------
; Bit Positions
.equ OSC_RC8MRDY_bp        =    5           ; Internal 8 MHz RC Oscillator Ready
.equ OSC_PLLRDY_bp         =    4           ; PLL Ready
.equ OSC_XOSCRDY_bp        =    3           ; External Oscillator Ready
.equ OSC_RC32KRDY_bp       =    2           ; Internal 32.768 kHz RC Oscillator Ready
.equ OSC_RC32MRDY_bp       =    1           ; Internal 32 MHz RC Oscillator Ready
.equ OSC_RC2MRDY_bp        =    0           ; Internal 2 MHz RC Oscillator Ready

; Bit Masks
.equ OSC_RC8MRDY_bm        = 0x20           ; Internal 8 MHz RC Oscillator Ready
.equ OSC_PLLRDY_bm         = 0x10           ; PLL Ready
.equ OSC_XOSCRDY_bm        = 0x08           ; External Oscillator Ready
.equ OSC_RC32KRDY_bm       = 0x04           ; Internal 32.768 kHz RC Oscillator Ready
.equ OSC_RC32MRDY_bm       = 0x02           ; Internal 32 MHz RC Oscillator Ready
.equ OSC_RC2MRDY_bm        = 0x01           ; Internal 2 MHz RC Oscillator Ready


; OSC_XOSCCTRL Register  (Ref 2, Sect. 7.10.3)
; -----------------------------------------------------------------------------
; Bit Positions
.equ OSC_X32KLPM_bp             =    5      ; 32.768 kHz XTAL OSC  Low-power mode
.equ OSC_XOSCPWR_bp             =    4      ; 16     MHz XTAL OSC High-power mode

; 0.4 - 16MHz Crystal Oscillator Frequency Range Selection
;                             0b_nn00_0000
.equ OSC_FRQRANGE_04TO2_gc      = 0x00      ;  0.4 -  2 MHz
.equ OSC_FRQRANGE_2TO9_gc       = 0x40      ;  2   -  9 MHz
.equ OSC_FRQRANGE_9TO12_gc      = 0x80      ;  9   - 12 MHz
.equ OSC_FRQRANGE_12TO16_gc     = 0xC0      ; 12   - 16 MHz

; External Oscillator Selection
; NOTE:
;     Table 7-6 of Ref 2 should be titled 'Crystal Oscillator Selection'.
;
; XOSCPWR/XOSCSEL[4] bit (bit position 4)
;     1. When an external clock input is selected, the XOSCSEL[4] bit
;        selects the incoming external clock pin (PR1 or PC4).
;     2. When a crystal oscillator is selected, the XOSCPWR bit increases the
;        drive output from the XTAL2 pin.
;                             0b_000n_nnn     External Clock Input
.equ OSC_XOSCSEL_EXTCLK_gc      = 0x00      ; External Clock from PR1 (XTAL1) -  6  CLK
.equ OSC_XOSCSEL_EXTCLK_C4_gc   = 0x14      ; External Clock from PC4         -  6  CLK
;                             0b_0000_nnn     Crystal Oscillator
.equ OSC_XOSCSEL_32KHz_gc       = 0x02      ; 32.768 kHz XTAL -  32K CLK
.equ OSC_XOSCSEL_XTAL_256CLK_gc = 0x03      ; 0.4-16 MHz XTAL - 256  CLK
.equ OSC_XOSCSEL_XTAL_1KCLK_gc  = 0x07      ; 0.4-16 MHz XTAL -   1K CLK
.equ OSC_XOSCSEL_XTAL_16KCLK_gc = 0x0B      ; 0.4-16 MHz XTAL -  16K CLK


; OSC_XOSCFAIL Register  (Ref 2, Sect. 7.10.4)
; -----------------------------------------------------------------------------
; Bit Positions
.equ OSC_PLLFDIF_bp             =    3      ; PLL Failure Detection Interrupt Flag
.equ OSC_PLLFDEN_bp             =    2      ; PLL Failure Detection Enable
.equ OSC_XOSCFDIF_bp            =    1      ; XOSC Failure Detection Interrupt Flag
.equ OSC_XOSCFDEN_bp            =    0      ; XOSC Failure Detection Enable

; Bit Masks
.equ OSC_PLLFDIF_bm             = 0x08      ; PLL Failure Detection Interrupt Flag
.equ OSC_XOSCFDIF_bm            = 0x02      ; XOSC Failure Detection Interrupt Flag


; OSC_PLLCTRL Register  (Ref 2, Sect. 7.10.6)
; -----------------------------------------------------------------------------
; Bit Positions
.equ OSC_PLLDIV_bp              =    5      ; Divide PLL output by 2

; PLL Clock Source Selection
;                             0b_nn00_0000
.equ OSC_PLLSRC_RC2M_gc         = 0x00      ; Internal 2 MHz RC Oscillator
.equ OSC_PLLSRC_RC8M_gc         = 0x40      ; Internal 8 MHz RC Oscillator
.equ OSC_PLLSRC_RC32M_gc        = 0x80      ; Internal 32 MHz RC Oscillator
.equ OSC_PLLSRC_XOSC_gc         = 0xC0      ; External Oscillator

; PLL Multiplication Factor
;                             0b_000n_nnnn
; Bits [4:0] select a multiplication factor from 1 (0x01) to 31 (0x1F)


; OSC_DFLLCTRL Register  (Ref 2, Sect. 7.10.7)
; -----------------------------------------------------------------------------
; 32 MHz DFLL Calibration Reference
.equ OSC_RC32MCREF_RC32K_gc     = 0x00      ; Internal 32.768 kHz RC Oscillator
.equ OSC_RC32MCREF_XOSC32K_gc   = 0x02      ; External 32.768 kHz Crystal Oscillator





; OSC interrupt vectors
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ OSC_OSCF_vect              = 0x0002    ; Oscillator Failure Interrupt (NMI)




; CLK - Clock System Registers
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ CLK_CTRL                   = 0x0040    ; Control
.equ CLK_PSCTRL                 = 0x0041    ; Prescaler Control
.equ CLK_LOCK                   = 0x0042    ; Lock
.equ CLK_RTCCTRL                = 0x0043    ; RTC Control


; CLK_CTRL Register  (Ref 2, Sect. 7.9.1)
; -----------------------------------------------------------------------------
; System Clock Selection
;                             0b_0000_0nnn
.equ CLK_SCLKSEL_RC2M_gc        = 0x00      ; Internal 2 MHz RC Oscillator
.equ CLK_SCLKSEL_RC32M_gc       = 0x01      ; Internal 32 MHz RC Oscillator
.equ CLK_SCLKSEL_RC32K_gc       = 0x02      ; Internal 32.768 kHz RC Oscillator
.equ CLK_SCLKSEL_XOSC_gc        = 0x03      ; External Crystal or Clock
.equ CLK_SCLKSEL_PLL_gc         = 0x04      ; Phase Locked Loop
.equ CLK_SCLKSEL_RC8M_gc        = 0x05      ; Internal 8 MHz RC Oscillator


; CLK_PSCTRL Register  (Ref 2, Sect. 7.9.2)
; -----------------------------------------------------------------------------
; Prescaler A Division Factor
;                             0b_0nnn_nn00
.equ CLK_PSADIV_1_gc            = 0x00      ; /1
.equ CLK_PSADIV_2_gc            = 0x04      ; /2
.equ CLK_PSADIV_4_gc            = 0x0C      ; /4
.equ CLK_PSADIV_8_gc            = 0x14      ; /8
.equ CLK_PSADIV_16_gc           = 0x1C      ; /16
.equ CLK_PSADIV_32_gc           = 0x24      ; /32
.equ CLK_PSADIV_64_gc           = 0x2C      ; /64
.equ CLK_PSADIV_128_gc          = 0x34      ; /128
.equ CLK_PSADIV_256_gc          = 0x3C      ; /256
.equ CLK_PSADIV_512_gc          = 0x44      ; /512
.equ CLK_PSADIV_6_gc            = 0x4C      ; /6
.equ CLK_PSADIV_10_gc           = 0x54      ; /10
.equ CLK_PSADIV_12_gc           = 0x5C      ; /12
.equ CLK_PSADIV_24_gc           = 0x64      ; /24
.equ CLK_PSADIV_48_gc           = 0x6C      ; /48

; Prescaler B and C Division Factor
;                             0b_0000_00nn
.equ CLK_PSBCDIV_1_1_gc         = 0x00      ; B/1 and C/1
.equ CLK_PSBCDIV_1_2_gc         = 0x01      ; B/1 and C/2
.equ CLK_PSBCDIV_4_1_gc         = 0x02      ; B/4 and C/1
.equ CLK_PSBCDIV_2_2_gc         = 0x03      ; B/2 and C/2


; CLK_LOCK Register  (Ref 2, Sect. 7.9.3)
; -----------------------------------------------------------------------------
; Bit Positions
.equ CLK_LOCK_bp                = 0         ; Clock System Lock


; CLK_RTCCTRL Register  (Ref 2, Sect. 7.9.4)
; -----------------------------------------------------------------------------
; Bit Positions
.equ CLK_RTCEN_bp               =    0      ; Clock Source Enable

; RTC Clock Source Selection   0b_0000_nnn0
.equ CLK_RTCSRC_ULP_gc          = 0x00      ; 1     kHz from internal 32kHz ULP
.equ CLK_RTCSRC_TOSC_gc         = 0x02      ; 1.024 kHz from 32.768 kHz crystal oscillator on TOSC
.equ CLK_RTCSRC_RCOSC_gc        = 0x04      ; 1.024 kHz from internal 32.768 kHz RC oscillator
.equ CLK_RTCSRC_TOSC32_gc       = 0x0A      ; 32.768 kHz from 32.768 kHz crystal oscillator on TOSC
.equ CLK_RTCSRC_RCOSC32_gc      = 0x0C      ; 32.768 kHz from internal 32.768 kHz RC oscillator
.equ CLK_RTCSRC_EXTCLK_gc       = 0x0E      ; External Clock from TOSC1 (PR1) or PC4






; DFLLRC32M - DFLL Registers
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ DFLLRC32M_CTRL             = 0x0060    ; Control Register
.equ DFLLRC32M_CALA             = 0x0062    ; Calibration Register A
.equ DFLLRC32M_CALB             = 0x0063    ; Calibration Register B
.equ DFLLRC32M_COMP0            = 0x0064    ; Oscillator Compare Register 0
.equ DFLLRC32M_COMP1            = 0x0065    ; Oscillator Compare Register 1
.equ DFLLRC32M_COMP2            = 0x0066    ; Oscillator Compare Register 2



; DFLL_CTRL Register
; -----------------------------------------------------------------------------
.equ DFLL_ENABLE_bp             =    0      ; DFLL Enable



