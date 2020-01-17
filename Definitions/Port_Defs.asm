;
; Port_Defs.asm
;
; Created: 17Jan2020
; Updated: 17Jan2020
; Author : JSRagman
;



; Port Registers
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

; PORTA
.equ PORTA_DIR                  = 0x0600    ; Data Direction
.equ PORTA_DIRSET               = 0x0601    ; Data Direction Set
.equ PORTA_DIRCLR               = 0x0602    ; Data Direction Clear
.equ PORTA_DIRTGL               = 0x0603    ; Data Direction Toggle
.equ PORTA_OUT                  = 0x0604    ; Output
.equ PORTA_OUTSET               = 0x0605    ; Output Set
.equ PORTA_OUTCLR               = 0x0606    ; Output Clear
.equ PORTA_OUTTGL               = 0x0607    ; Output Toggle
.equ PORTA_IN                   = 0x0608    ; Input
.equ PORTA_INTCTRL              = 0x0609    ; Interrupt Control Register
.equ PORTA_INTMASK              = 0x060A    ; Interrupt Mask Register
.equ PORTA_INTFLAGS             = 0x060C    ; Interrupt Flags
.equ PORTA_REMAP                = 0x060E    ; Pin Remap Register
.equ PORTA_PIN0CTRL             = 0x0610    ; Pin 0 Control Register
.equ PORTA_PIN1CTRL             = 0x0611    ; Pin 1
.equ PORTA_PIN2CTRL             = 0x0612    ; Pin 2
.equ PORTA_PIN3CTRL             = 0x0613    ; Pin 3
.equ PORTA_PIN4CTRL             = 0x0614    ; Pin 4
.equ PORTA_PIN5CTRL             = 0x0615    ; Pin 5
.equ PORTA_PIN6CTRL             = 0x0616    ; Pin 6
.equ PORTA_PIN7CTRL             = 0x0617    ; Pin 7

; PORTC
; -----------------------------------------------------------------------------
.equ PORTC_DIR                  = 0x0640    ; Data Direction
.equ PORTC_DIRSET               = 0x0641    ; Data Direction Set
.equ PORTC_DIRCLR               = 0x0642    ; Data Direction Clear
.equ PORTC_DIRTGL               = 0x0643    ; Data Direction Toggle
.equ PORTC_OUT                  = 0x0644    ; Output
.equ PORTC_OUTSET               = 0x0645    ; Output Set
.equ PORTC_OUTCLR               = 0x0646    ; Output Clear
.equ PORTC_OUTTGL               = 0x0647    ; Output Toggle
.equ PORTC_IN                   = 0x0648    ; Input
.equ PORTC_INTCTRL              = 0x0649    ; Interrupt Control Register
.equ PORTC_INTMASK              = 0x064A    ; Interrupt Mask Register
.equ PORTC_INTFLAGS             = 0x064C    ; Interrupt Flags
.equ PORTC_REMAP                = 0x064E    ; Pin Remap Register
.equ PORTC_PIN0CTRL             = 0x0650    ; Pin 0 Control Register
.equ PORTC_PIN1CTRL             = 0x0651    ; Pin 1
.equ PORTC_PIN2CTRL             = 0x0652    ; Pin 2
.equ PORTC_PIN3CTRL             = 0x0653    ; Pin 3
.equ PORTC_PIN4CTRL             = 0x0654    ; Pin 4
.equ PORTC_PIN5CTRL             = 0x0655    ; Pin 5
.equ PORTC_PIN6CTRL             = 0x0656    ; Pin 6
.equ PORTC_PIN7CTRL             = 0x0657    ; Pin 7

; PORTD
; -----------------------------------------------------------------------------
.equ PORTD_DIR                  = 0x0660    ; Data Direction
.equ PORTD_DIRSET               = 0x0661    ; Data Direction Set
.equ PORTD_DIRCLR               = 0x0662    ; Data Direction Clear
.equ PORTD_DIRTGL               = 0x0663    ; Data Direction Toggle
.equ PORTD_OUT                  = 0x0664    ; Output
.equ PORTD_OUTSET               = 0x0665    ; Output Set
.equ PORTD_OUTCLR               = 0x0666    ; Output Clear
.equ PORTD_OUTTGL               = 0x0667    ; Output Toggle
.equ PORTD_IN                   = 0x0668    ; Input
.equ PORTD_INTCTRL              = 0x0669    ; Interrupt Control Register
.equ PORTD_INTMASK              = 0x066A    ; Interrupt Mask Register
.equ PORTD_INTFLAGS             = 0x066C    ; Interrupt Flags
.equ PORTD_REMAP                = 0x066E    ; Pin Remap Register
.equ PORTD_PIN0CTRL             = 0x0670    ; Pin 0 Control Register
.equ PORTD_PIN1CTRL             = 0x0671    ; Pin 1
.equ PORTD_PIN2CTRL             = 0x0672    ; Pin 2
.equ PORTD_PIN3CTRL             = 0x0673    ; Pin 3
.equ PORTD_PIN4CTRL             = 0x0674    ; Pin 4
.equ PORTD_PIN5CTRL             = 0x0675    ; Pin 5
.equ PORTD_PIN6CTRL             = 0x0676    ; Pin 6
.equ PORTD_PIN7CTRL             = 0x0677    ; Pin 7

; PORTR
; -----------------------------------------------------------------------------
.equ PORTR_DIR                  = 0x07E0    ; Data Direction
.equ PORTR_DIRSET               = 0x07E1    ; Data Direction Set
.equ PORTR_DIRCLR               = 0x07E2    ; Data Direction Clear
.equ PORTR_DIRTGL               = 0x07E3    ; Data Direction Toggle
.equ PORTR_OUT                  = 0x07E4    ; Output
.equ PORTR_OUTSET               = 0x07E5    ; Output Set
.equ PORTR_OUTCLR               = 0x07E6    ; Output Clear
.equ PORTR_OUTTGL               = 0x07E7    ; Output Toggle
.equ PORTR_IN                   = 0x07E8    ; Input
.equ PORTR_INTCTRL              = 0x07E9    ; Interrupt Control Register
.equ PORTR_INTMASK              = 0x07EA    ; Interrupt Mask Register
.equ PORTR_INTFLAGS             = 0x07EC    ; Interrupt Flags
.equ PORTR_REMAP                = 0x07EE    ; Pin Remap Register
.equ PORTR_PIN0CTRL             = 0x07F0    ; Pin 0 Control Register
.equ PORTR_PIN1CTRL             = 0x07F1    ; Pin 1
.equ PORTR_PIN2CTRL             = 0x07F2    ; Pin 2
.equ PORTR_PIN3CTRL             = 0x07F3    ; Pin 3
.equ PORTR_PIN4CTRL             = 0x07F4    ; Pin 4
.equ PORTR_PIN5CTRL             = 0x07F5    ; Pin 5
.equ PORTR_PIN6CTRL             = 0x07F6    ; Pin 6
.equ PORTR_PIN7CTRL             = 0x07F7    ; Pin 7



; Virtual Port Registers
; -----------------------------------------------------------------------------

; VPORT0 (Virtual Port A)
.equ VPORT0_DIR                 = 0x0010    ; Data Direction
.equ VPORT0_OUT                 = 0x0011    ; Output
.equ VPORT0_IN                  = 0x0012    ; Input
.equ VPORT0_INTFLAGS            = 0x0013    ; Interrupt Flags

; VPORT1 (Virtual Port C)
.equ VPORT1_DIR                 = 0x0014    ; Data Direction
.equ VPORT1_OUT                 = 0x0015    ; Output
.equ VPORT1_IN                  = 0x0016    ; Input
.equ VPORT1_INTFLAGS            = 0x0017    ; Interrupt Flags

; VPORT2 (Virtual Port D)
.equ VPORT2_DIR                 = 0x0018    ; I/O Port Data Direction
.equ VPORT2_OUT                 = 0x0019    ; I/O Port Output
.equ VPORT2_IN                  = 0x001A    ; I/O Port Input
.equ VPORT2_INTFLAGS            = 0x001B    ; Interrupt Flag Register

; VPORT3 (Virtual Port R)
.equ VPORT3_DIR                 = 0x001C    ; Data Direction
.equ VPORT3_OUT                 = 0x001D    ; Output
.equ VPORT3_IN                  = 0x001E    ; Input
.equ VPORT3_INTFLAGS            = 0x001F    ; Interrupt Flags



; PORTCFG - Port Configuration Registers
; -----------------------------------------------------------------------------
.equ PORTCFG_MPCMASK            = 0x00B0    ; Multi-pin Configuration Mask
.equ PORTCFG_CLKOUT             = 0x00B4    ; Clock Out
.equ PORTCFG_ACEVOUT            = 0x00B6    ; Analog Comparator and Event Out
.equ PORTCFG_SRLCTRL            = 0x00B7    ; Slew Rate Limit Control



; Port Interrupt Vectors
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ PORTA_INT_vect             = 0x003C    ; Port A Interrupt Vector
.equ PORTC_INT_vect             = 0x0012    ; Port C Interrupt Vector
.equ PORTD_INT_vect             = 0x0046    ; Port D Interrupt Vector
.equ PORTR_INT_vect             = 0x0004    ; Port R Interrupt Vector



; Bit Positions
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

; PORTx_INTCTRL Register
.equ PORT_INTLVL0_bp            =    0      ; Port Interrupt Level bit 0
.equ PORT_INTLVL1_bp            =    1      ; Port Interrupt Level bit 1

; PORTx_INTFLAGS Register
.equ PORT_INT7IF_bp             =    7      ; Pin 7 Interrupt Flag
.equ PORT_INT6IF_bp             =    6      ; Pin 6
.equ PORT_INT5IF_bp             =    5      ; Pin 5
.equ PORT_INT4IF_bp             =    4      ; Pin 4
.equ PORT_INT3IF_bp             =    3      ; Pin 3
.equ PORT_INT2IF_bp             =    2      ; Pin 2
.equ PORT_INT1IF_bp             =    1      ; Pin 1
.equ PORT_INT0IF_bp             =    0      ; Pin 0

; PORTx_PINnCTRL Register
.equ PORT_INVEN_bp              =    6      ; Inverted I/O Enable
.equ PORT_OPC2_bp               =    5      ; Output/Pull bit 2
.equ PORT_OPC1_bp               =    4      ; Output/Pull bit 1
.equ PORT_OPC0_bp               =    3      ; Output/Pull bit 0
.equ PORT_ISC2_bp               =    2      ; Input/Sense bit 2
.equ PORT_ISC1_bp               =    1      ; Input/Sense bit 1
.equ PORT_ISC0_bp               =    0      ; Input/Sense bit 0

; PORTC_REMAP Register
; PORTD_REMAP Register
.equ PORT_USART0_bp             =    4      ; Usart0
.equ PORT_TC4D_bp               =    3      ; Timer/Counter 4 Output Compare D
.equ PORT_TC4C_bp               =    2      ; Timer/Counter 4 Output Compare C
.equ PORT_TC4B_bp               =    1      ; Timer/Counter 4 Output Compare B
.equ PORT_TC4A_bp               =    0      ; Timer/Counter 4 Output Compare A

; VPORTn_INTFLAGS Register
.equ VPORT_INT7IF_bp            =    7      ; Pin 7 Interrupt Flag
.equ VPORT_INT6IF_bp            =    6      ; Pin 6
.equ VPORT_INT5IF_bp            =    5      ; Pin 5
.equ VPORT_INT4IF_bp            =    4      ; Pin 4
.equ VPORT_INT3IF_bp            =    3      ; Pin 3
.equ VPORT_INT2IF_bp            =    2      ; Pin 2
.equ VPORT_INT1IF_bp            =    1      ; Pin 1
.equ VPORT_INT0IF_bp            =    0      ; Pin 0


; PORTCFG_CLKOUT Register
.equ PORTCFG_CLKEVPIN_bp        =    7      ; Clock and Event Output Pin Select
.equ PORTCFG_RTCOUT1_bp         =    6      ; RTC Clock Output Enable bit 1
.equ PORTCFG_RTCOUT0_bp         =    5      ; RTC Clock Output Enable bit 0
.equ PORTCFG_CLKOUTSEL1_bp      =    3      ; Clock Output Select bit 1
.equ PORTCFG_CLKOUTSEL0_bp      =    2      ; Clock Output Select bit 0
.equ PORTCFG_CLKOUT1_bp         =    1      ; Clock Output Port bit 1
.equ PORTCFG_CLKOUT0_bp         =    0      ; Clock Output Port bit 0

; PORTCFG_ACEVOUT Register
.equ PORTCFG_ACOUT1_bp          =    7      ; Analog Comparator Output Port bit 1
.equ PORTCFG_ACOUT0_bp          =    6      ; Analog Comparator Output Port bit 0
.equ PORTCFG_EVOUT1_bp          =    5      ; Event Channel Output Port bit 1
.equ PORTCFG_EVOUT0_bp          =    4      ; Event Channel Output Port bit 0
.equ PORTCFG_EVASYEN_bp         =    3      ; Asynchronous Event Enabled
.equ PORTCFG_EVOUTSEL2_bp       =    2      ; Event Channel Output Selection bit 2
.equ PORTCFG_EVOUTSEL1_bp       =    1      ; Event Channel Output Selection bit 1
.equ PORTCFG_EVOUTSEL0_bp       =    0      ; Event Channel Output Selection bit 0

; PORTCFG_SRLCTRL Register
.equ PORTCFG_SRLENRR_bp         =    7      ; Slew Rate Limit Enable on PORTR
.equ PORTCFG_SRLENRD_bp         =    3      ; Slew Rate Limit Enable on PORTD
.equ PORTCFG_SRLENRC_bp         =    2      ; Slew Rate Limit Enable on PORTC
.equ PORTCFG_SRLENRA_bp         =    0      ; Slew Rate Limit Enable on PORTA




; Constants
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------


; Clarification:
;     To make sense of the following settings, please note
;         1. The Real-Time Clock can be output to PC6, PD6, or PR0
;         2. A selected peripheral clock can be output to PC7(4), PD7(4), or PR0
;         3. A selected event channel can be output to PC7(4), PD7(4), or PR0
;         4. A number in parentheses (above) indicates that an alternate pin can
;            be selected
;         5. Configuration is done via the PORTCFG_CLKOUT and PORTCFG_ACEVOUT
;            registers


; PORTCFG_CLKOUT Register
; -----------------------------------------------------------------------------
; Note: The RTCCLKOUT comments are misleading in ATxmega32e5def.inc
;       (corrected here).  By 'corrected', I mean updated to agree with
;       the datasheet but not operationally tested.
; RTC Clock Output Selection
.equ PORTCFG_RTCCLKOUT_OFF_gc   =    0      ; RTC Clock Output Disabled
.equ PORTCFG_RTCCLKOUT_PC6_gc   = 0x20      ; Port C, Pin 6
.equ PORTCFG_RTCCLKOUT_PD6_gc   = 0x40      ; Port D, Pin 6
.equ PORTCFG_RTCCLKOUT_PR0_gc   = 0x60      ; Port R, Pin 0

; Peripheral Clock Output Selection
.equ PORTCFG_CLKOUTSEL_CLK1X_gc =    0      ; 1x Peripheral Clock
.equ PORTCFG_CLKOUTSEL_CLK2X_gc =    4      ; 2x Peripheral Clock
.equ PORTCFG_CLKOUTSEL_CLK4X_gc =    8      ; 4x Peripheral Clock

; Peripheral Clock Output Port Selection
.equ PORTCFG_CLKOUT_OFF_gc      =    0      ; Peripheral Clock Output Disabled
.equ PORTCFG_CLKOUT_PC7_gc      =    1      ; Port C, Pin 7(4)
.equ PORTCFG_CLKOUT_PD7_gc      =    2      ; Port D, Pin 7(4)
.equ PORTCFG_CLKOUT_PR0_gc      =    3      ; Port R, Pin 0

; Peripheral Clock/Event Output Pin Selection
.equ PORTCFG_CLKEVPIN_PIN7_gc   =    0      ; PIN 7 (PC7 or PD7)
.equ PORTCFG_CLKEVPIN_PIN4_gc   = 0x80      ; PIN 4 (PC4 or PD4)


; PORTCFG_ACEVOUT Register
; -----------------------------------------------------------------------------
; Analog Comparator (Pair) Output Port Selection
.equ PORTCFG_ACOUT_PA_gc        =    0      ; Port A, Pin 6-7
.equ PORTCFG_ACOUT_PC_gc        = 0x40      ; Port C, Pin 6-7
.equ PORTCFG_ACOUT_PD_gc        = 0x80      ; Port D, Pin 6-7
.equ PORTCFG_ACOUT_PR_gc        = 0xC0      ; Port R, Pin 0-1

; Event Channel Output Port Selection
.equ PORTCFG_EVOUT_OFF_gc       =    0      ; Event Output Disabled
.equ PORTCFG_EVOUT_PC7_gc       = 0x10      ; Port C pin 7
.equ PORTCFG_EVOUT_PD7_gc       = 0x20      ; Port D pin 7
.equ PORTCFG_EVOUT_PR0_gc       = 0x30      ; Port R pin 0

; Event Channel Selection
.equ PORTCFG_EVOUTSEL_0_gc      =    0      ; Channel 0
.equ PORTCFG_EVOUTSEL_1_gc      =    1      ; Channel 1
.equ PORTCFG_EVOUTSEL_2_gc      =    2      ; Channel 2
.equ PORTCFG_EVOUTSEL_3_gc      =    3      ; Channel 3
.equ PORTCFG_EVOUTSEL_4_gc      =    4      ; Channel 4
.equ PORTCFG_EVOUTSEL_5_gc      =    5      ; Channel 5
.equ PORTCFG_EVOUTSEL_6_gc      =    6      ; Channel 6
.equ PORTCFG_EVOUTSEL_7_gc      =    7      ; Channel 7


; Port Interrupt Level
.equ PORT_INTLVL_OFF_gc         =    0      ; Interrupt Disabled
.equ PORT_INTLVL_LO_gc          =    1      ; Low Level
.equ PORT_INTLVL_MED_gc         =    2      ; Medium Level
.equ PORT_INTLVL_HI_gc          =    3      ; High Level

; Output/Pull Configuration
.equ PORT_OPC_TOTEM_gc          =    0      ; Totempole
.equ PORT_OPC_BUSKEEPER_gc      = 0x08      ; Totempole w/ Bus keeper on Input and Output
.equ PORT_OPC_PULLDOWN_gc       = 0x10      ; Totempole w/ Pull-down on Input
.equ PORT_OPC_PULLUP_gc         = 0x18      ; Totempole w/ Pull-up on Input
.equ PORT_OPC_WIREDOR_gc        = 0x20      ; Wired OR
.equ PORT_OPC_WIREDAND_gc       = 0x28      ; Wired AND
.equ PORT_OPC_WIREDORPULL_gc    = 0x30      ; Wired OR w/ Pull-down
.equ PORT_OPC_WIREDANDPULL_gc   = 0x38      ; Wired AND w/ Pull-up

; Input/Sense Configuration
.equ PORT_ISC_BOTHEDGES_gc      =    0      ; Both Edges
.equ PORT_ISC_RISING_gc         =    1      ; Rising Edge
.equ PORT_ISC_FALLING_gc        =    2      ; Falling Edge
.equ PORT_ISC_LEVEL_gc          =    3      ; Sense Level (Transparent For Events)
.equ PORT_ISC_FORCE_ENABLE_gc   =    6      ; Digital Input Buffer Forced Enable
.equ PORT_ISC_INPUT_DISABLE_gc  =    7      ; Disable Digital Input Buffer

