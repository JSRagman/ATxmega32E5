;
; ClockSys_Defs.asm
;
; Created: 17Jan2020
; Updated: 17Jan2020
; Author : JSRagman
;




; CLK - Clock System Registers
; -----------------------------------------------------------------------------
.equ CLK_CTRL              = 0x0040         ; Control
.equ CLK_PSCTRL            = 0x0041         ; Prescaler Control
.equ CLK_LOCK              = 0x0042         ; Lock
.equ CLK_RTCCTRL           = 0x0043         ; RTC Control

; PR - Clock System Registers
.equ PR_PRGEN              = 0x0070         ; General Power Reduction
.equ PR_PRPA               = 0x0071         ; Power Reduction Port A
.equ PR_PRPC               = 0x0073         ; Power Reduction Port C
.equ PR_PRPD               = 0x0074         ; Power Reduction Port D


; SLEEP - Sleep Controller Registers
; -----------------------------------------------------------------------------
.equ SLEEP_CTRL            = 0x48           ; Control


; OSC - Oscillator Registers
; -----------------------------------------------------------------------------
.equ OSC_CTRL              = 0x0050         ; Control
.equ OSC_STATUS            = 0x0051         ; Status
.equ OSC_XOSCCTRL          = 0x0052         ; External Oscillator Control
.equ OSC_XOSCFAIL          = 0x0053         ; Oscillator Failure Detection
.equ OSC_RC32KCAL          = 0x0054         ; 32.768 kHz Internal Oscillator Calibration
.equ OSC_PLLCTRL           = 0x0055         ; PLL Control
.equ OSC_DFLLCTRL          = 0x0056         ; DFLL Control
.equ OSC_RC8MCAL           = 0x0057         ; Internal 8 MHz RC Oscillator Calibration


; DFLLRC32M - DFLL Registers
; -----------------------------------------------------------------------------
.equ DFLLRC32M_CTRL        = 0x0060         ; Control Register
.equ DFLLRC32M_CALA        = 0x0062         ; Calibration Register A
.equ DFLLRC32M_CALB        = 0x0063         ; Calibration Register B
.equ DFLLRC32M_COMP0       = 0x0064         ; Oscillator Compare Register 0
.equ DFLLRC32M_COMP1       = 0x0065         ; Oscillator Compare Register 1
.equ DFLLRC32M_COMP2       = 0x0066         ; Oscillator Compare Register 2




; System Clock Selection Constants
.equ CLK_SCLKSEL_RC2M_gc   = (0<<0)         ; Internal 2 MHz RC Oscillator
.equ CLK_SCLKSEL_RC32M_gc  = (1<<0)         ; Internal 32 MHz RC Oscillator
.equ CLK_SCLKSEL_RC32K_gc  = (2<<0)         ; Internal 32.768 kHz RC Oscillator
.equ CLK_SCLKSEL_XOSC_gc   = (3<<0)         ; External Crystal Oscillator or Clock
.equ CLK_SCLKSEL_PLL_gc    = (4<<0)         ; Phase Locked Loop
.equ CLK_SCLKSEL_RC8M_gc   = (5<<0)         ; Internal 8 MHz RC Oscillator

; Prescaler A Division Factor Constants
.equ CLK_PSADIV_1_gc       = (0x00<<2)      ; /1
.equ CLK_PSADIV_2_gc       = (0x01<<2)      ; /2
.equ CLK_PSADIV_4_gc       = (0x03<<2)      ; /4
.equ CLK_PSADIV_8_gc       = (0x05<<2)      ; /8
.equ CLK_PSADIV_16_gc      = (0x07<<2)      ; /16
.equ CLK_PSADIV_32_gc      = (0x09<<2)      ; /32
.equ CLK_PSADIV_64_gc      = (0x0B<<2)      ; /64
.equ CLK_PSADIV_128_gc     = (0x0D<<2)      ; /128
.equ CLK_PSADIV_256_gc     = (0x0F<<2)      ; /256
.equ CLK_PSADIV_512_gc     = (0x11<<2)      ; /512
.equ CLK_PSADIV_6_gc       = (0x13<<2)      ; /6
.equ CLK_PSADIV_10_gc      = (0x15<<2)      ; /10
.equ CLK_PSADIV_12_gc      = (0x17<<2)      ; /12
.equ CLK_PSADIV_24_gc      = (0x19<<2)      ; /24
.equ CLK_PSADIV_48_gc      = (0x1B<<2)      ; /48

; Prescaler B and C Division Factor Constants
.equ CLK_PSBCDIV_1_1_gc    = (0<<0)         ; Divide B by 1 and C by 1
.equ CLK_PSBCDIV_1_2_gc    = (1<<0)         ; Divide B by 1 and C by 2
.equ CLK_PSBCDIV_4_1_gc    = (2<<0)         ; Divide B by 4 and C by 1
.equ CLK_PSBCDIV_2_2_gc    = (3<<0)         ; Divide B by 2 and C by 2

; RTC Clock Source Constants
.equ CLK_RTCSRC_ULP_gc     = (0<<1)         ; 1.024 kHz from internal 32kHz ULP
.equ CLK_RTCSRC_TOSC_gc    = (1<<1)         ; 1.024 kHz from 32.768 kHz crystal oscillator on TOSC
.equ CLK_RTCSRC_RCOSC_gc   = (2<<1)         ; 1.024 kHz from internal 32.768 kHz RC oscillator
.equ CLK_RTCSRC_TOSC32_gc  = (5<<1)         ; 32.768 kHz from 32.768 kHz crystal oscillator on TOSC
.equ CLK_RTCSRC_RCOSC32_gc = (6<<1)         ; 32.768 kHz from internal 32.768 kHz RC oscillator
.equ CLK_RTCSRC_EXTCLK_gc  = (7<<1)         ; External Clock from TOSC1




; OSC_CTRL Register Bit Positions
.equ OSC_RC8MLPM_bp        = 6              ; Internal 8 MHz RC Low Power Mode Enable
.equ OSC_RC8MEN_bp         = 5              ; Internal 8 MHz RC Oscillator Enable
.equ OSC_PLLEN_bp          = 4              ; PLL Enable
.equ OSC_XOSCEN_bp         = 3              ; External Oscillator Enable
.equ OSC_RC32KEN_bp        = 2              ; Internal 32.768 kHz RC Oscillator Enable
.equ OSC_RC32MEN_bp        = 1              ; Internal 32 MHz RC Oscillator Enable
.equ OSC_RC2MEN_bp         = 0              ; Internal 2 MHz RC Oscillator Enable

; OSC_STATUS Register Bit Positions
.equ OSC_RC8MRDY_bp        = 5              ; Internal 8 MHz RC Oscillator Ready
.equ OSC_PLLRDY_bp         = 4              ; PLL Ready
.equ OSC_XOSCRDY_bp        = 3              ; External Oscillator Ready
.equ OSC_RC32KRDY_bp       = 2              ; Internal 32.768 kHz RC Oscillator Ready
.equ OSC_RC32MRDY_bp       = 1              ; Internal 32 MHz RC Oscillator Ready
.equ OSC_RC2MRDY_bp        = 0              ; Internal 2 MHz RC Oscillator Ready


; OSC_STATUS Register bit masks
.equ OSC_RC8MRDY_bm        = 0x20           ; Internal 8 MHz RC Oscillator Ready
.equ OSC_PLLRDY_bm         = 0x10           ; PLL Ready
.equ OSC_XOSCRDY_bm        = 0x08           ; External Oscillator Ready
.equ OSC_RC32KRDY_bm       = 0x04           ; Internal 32.768 kHz RC Oscillator Ready
.equ OSC_RC32MRDY_bm       = 0x02           ; Internal 32 MHz RC Oscillator Ready
.equ OSC_RC2MRDY_bm        = 0x01           ; Internal 2 MHz RC Oscillator Ready


