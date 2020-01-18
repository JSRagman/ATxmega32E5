;
; Port_Defs.asm
;
; Created: 17Jan2020
; Updated: 18Jan2020
; Author : JSRagman
;

; Organization:
;     1.  Port Registers
;     2.  Virtual Port Registers
;     3.  Port Configuration Registers
;     4.  Port Interrupt Vectors

; Number Formats:
;     1.  Register Addresses    16-bit hex
;     2.  Bit Positions         decimal (0-7)
;     3.  Bit Masks             8-bit hex
;     4.  Constants             8-bit hex

; References:
;     1.  XMEGA E5 Data Sheet,  DS40002059A, Rev A - 08/2018
;     2.  XMEGA E MANUAL,       Atmel–42005E–AVR–XMEGA E–11/2014
;     3.  ATxmega32E5def.inc,   Version 1.00, 2012-11-02 13:32





; Port Registers
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

; PORTA
; -----------------------------------------------------------------------------
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



; PORTx_INTCTRL Register
; -----------------------------------------------------------------------------
; Port Interrupt Level       0b_0000_00nn
.equ PORT_INTLVL_OFF_gc         = 0x00      ; Interrupt Disabled
.equ PORT_INTLVL_LO_gc          = 0x01      ; Low Level
.equ PORT_INTLVL_MED_gc         = 0x02      ; Medium Level
.equ PORT_INTLVL_HI_gc          = 0x03      ; High Level


; PORTx_INTFLAGS Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ PORT_INT7IF_bp             =    7      ; Pin 7 Interrupt Flag
.equ PORT_INT6IF_bp             =    6      ; Pin 6
.equ PORT_INT5IF_bp             =    5      ; Pin 5
.equ PORT_INT4IF_bp             =    4      ; Pin 4
.equ PORT_INT3IF_bp             =    3      ; Pin 3
.equ PORT_INT2IF_bp             =    2      ; Pin 2
.equ PORT_INT1IF_bp             =    1      ; Pin 1
.equ PORT_INT0IF_bp             =    0      ; Pin 0

; Bit Masks
.equ PORT_INT7IF_bm             = 0x80      ; Pin 7 Interrupt Flag
.equ PORT_INT6IF_bm             = 0x40      ; Pin 6
.equ PORT_INT5IF_bm             = 0x20      ; Pin 5
.equ PORT_INT4IF_bm             = 0x10      ; Pin 4
.equ PORT_INT3IF_bm             = 0x08      ; Pin 3
.equ PORT_INT2IF_bm             = 0x04      ; Pin 2
.equ PORT_INT1IF_bm             = 0x02      ; Pin 1
.equ PORT_INT0IF_bm             = 0x01      ; Pin 0


; PORTx_REMAP Register ( Port C and Port D only )
; -----------------------------------------------------------------------------
; Remap Functions:  (Ref 2, Sect. 12.13.13 - Pin Remap Register)
;     USART0  -  moves USART0 from Px[3:0] to Px[7:4]
;     TC4D    -  moves OC4D from Px3 to Px7
;     TC4C    -  moves OC4C from Px2 to Px6
;     TC4B    -  moves OC4B from Px1 to Px5
;                * affects T/C4 and T/C5 PWM output (see Ref 2)
;     TC4A    -  moves OC4A from Px0 to Px4
;                * affects T/C4 and T/C5 PWM output (see Ref 2)

; Bit Positions
.equ PORT_USART0_bp             =    4      ; Usart0
.equ PORT_TC4D_bp               =    3      ; Timer/Counter 4 Output Compare D
.equ PORT_TC4C_bp               =    2      ; Timer/Counter 4 Output Compare C
.equ PORT_TC4B_bp               =    1      ; Timer/Counter 4 Output Compare B
.equ PORT_TC4A_bp               =    0      ; Timer/Counter 4 Output Compare A


; PORTx_PINnCTRL Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ PORT_INVEN_bp              =    6      ; Inverted I/O Enable

; Output/Pull Configuration   0b_00nn_n000
.equ PORT_OPC_TOTEM_gc          = 0x00      ; Totempole
.equ PORT_OPC_BUSKEEPER_gc      = 0x08      ; Totempole w/ Bus keeper on Input and Output
.equ PORT_OPC_PULLDOWN_gc       = 0x10      ; Totempole w/ Pull-down on Input
.equ PORT_OPC_PULLUP_gc         = 0x18      ; Totempole w/ Pull-up on Input
.equ PORT_OPC_WIREDOR_gc        = 0x20      ; Wired OR
.equ PORT_OPC_WIREDAND_gc       = 0x28      ; Wired AND
.equ PORT_OPC_WIREDORPULL_gc    = 0x30      ; Wired OR  w/ Pull-down
.equ PORT_OPC_WIREDANDPULL_gc   = 0x38      ; Wired AND w/ Pull-up

; Input/Sense Configuration   0b_0000_0nnn
.equ PORT_ISC_BOTHEDGES_gc      = 0x00      ; Both Edges
.equ PORT_ISC_RISING_gc         = 0x01      ; Rising Edge
.equ PORT_ISC_FALLING_gc        = 0x02      ; Falling Edge
.equ PORT_ISC_LEVEL_gc          = 0x03      ; Sense Level (Transparent For Events)
.equ PORT_ISC_FORCE_ENABLE_gc   = 0x06      ; Digital Input Buffer Force Enable
.equ PORT_ISC_INPUT_DISABLE_gc  = 0x07      ; Digital Input Buffer Disable




; Virtual Port Registers
; -----------------------------------------------------------------------------
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


; VPORTn_INTFLAGS Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ VPORT_INT7IF_bp            =    7      ; Pin 7 Interrupt Flag
.equ VPORT_INT6IF_bp            =    6      ; Pin 6
.equ VPORT_INT5IF_bp            =    5      ; Pin 5
.equ VPORT_INT4IF_bp            =    4      ; Pin 4
.equ VPORT_INT3IF_bp            =    3      ; Pin 3
.equ VPORT_INT2IF_bp            =    2      ; Pin 2
.equ VPORT_INT1IF_bp            =    1      ; Pin 1
.equ VPORT_INT0IF_bp            =    0      ; Pin 0

; Bit Masks
.equ VPORT_INT7IF_bm            = 0x80      ; Pin 7 Interrupt Flag
.equ VPORT_INT6IF_bm            = 0x40      ; Pin 6
.equ VPORT_INT5IF_bm            = 0x20      ; Pin 5
.equ VPORT_INT4IF_bm            = 0x10      ; Pin 4
.equ VPORT_INT3IF_bm            = 0x08      ; Pin 3
.equ VPORT_INT2IF_bm            = 0x04      ; Pin 2
.equ VPORT_INT1IF_bm            = 0x02      ; Pin 1
.equ VPORT_INT0IF_bm            = 0x01      ; Pin 0




; PORTCFG - Port Configuration Registers
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ PORTCFG_MPCMASK            = 0x00B0    ; Multi-pin Configuration Mask
.equ PORTCFG_CLKOUT             = 0x00B4    ; Clock Out
.equ PORTCFG_ACEVOUT            = 0x00B6    ; Analog Comparator and Event Out
.equ PORTCFG_SRLCTRL            = 0x00B7    ; Slew Rate Limit Control


; NOTE: (Ref 2, Sect.12.14.2)
;     Tables 12-7 and 12-8 are mistitled.
;     Table 12-7 should be titled 'RTC Clock Output Port Selection'.
;     Table 12-8 should be titled 'Peripheral Clock Output Selection'.
;     Table 12-9, to be consistent, should be titled 'Peripheral Clock Output Port Selection'.
;     This is made clear in the related text of Sect. 12.14.2.

; Clarification, Clock Output:  (Ref 2, Sect. 12.14.2 - Clock Output Register)
;     To make sense of the following settings, please note
;         1. The Real-Time Clock can be output to PC6, PD6, or PR0
;         2. A selected peripheral clock can be output to PC7(4), PD7(4), or PR0
;         3. A selected event channel can be output to PC7(4), PD7(4), or PR0
;         4. A number in parentheses (above) indicates that an alternate pin can
;            be selected via the CLKEVPIN bit.
;         5. If the above settings are in conflict, peripheral clock output
;            will prevail over event channel output.

; NOTE:
;     The RTCCLKOUT comments are misleading in ATxmega32e5def.inc
;     (corrected here).  By 'corrected', I mean updated to agree with
;     the datasheet but not operationally tested.

; PORTCFG_CLKOUT Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ PORTCFG_CLKEVPIN_bp        =    7      ; Clock/Event Output Pin Select

; RTC Clock Output Port Selection
;                               0b_0nn0_0000
.equ PORTCFG_RTCCLKOUT_OFF_gc   = 0x00      ; RTC Clock Output Disabled
.equ PORTCFG_RTCCLKOUT_PC6_gc   = 0x20      ; Port C, Pin 6
.equ PORTCFG_RTCCLKOUT_PD6_gc   = 0x40      ; Port D, Pin 6
.equ PORTCFG_RTCCLKOUT_PR0_gc   = 0x60      ; Port R, Pin 0

; Peripheral Clock Output Selection
;                               0b_0000_nn00
.equ PORTCFG_CLKOUTSEL_CLK1X_gc = 0x00      ; 1x Peripheral Clock
.equ PORTCFG_CLKOUTSEL_CLK2X_gc = 0x04      ; 2x Peripheral Clock
.equ PORTCFG_CLKOUTSEL_CLK4X_gc = 0x08      ; 4x Peripheral Clock

; Peripheral Clock Output Port Selection
;                               0b_0000_00nn
.equ PORTCFG_CLKOUT_OFF_gc      = 0x00      ; Peripheral Clock Output Disabled
.equ PORTCFG_CLKOUT_PC7_gc      = 0x01      ; Port C, Pin 7(4)
.equ PORTCFG_CLKOUT_PD7_gc      = 0x02      ; Port D, Pin 7(4)
.equ PORTCFG_CLKOUT_PR0_gc      = 0x03      ; Port R, Pin 0

; Peripheral Clock/Event Output Pin Selection
;                               0b_n000_0000
.equ PORTCFG_CLKEVPIN_PIN7_gc   = 0x00      ; PIN 7 (PC7 or PD7)
.equ PORTCFG_CLKEVPIN_PIN4_gc   = 0x80      ; PIN 4 (PC4 or PD4)


; PORTCFG_ACEVOUT Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ PORTCFG_EVASYEN_bp         =    3      ; Asynchronous Event Enable

; Analog Comparator (Pair) Output Port Selection
;                               0b_nn00_0000
.equ PORTCFG_ACOUT_PA_gc        = 0x00      ; Port A, Pin 6-7
.equ PORTCFG_ACOUT_PC_gc        = 0x40      ; Port C, Pin 6-7
.equ PORTCFG_ACOUT_PD_gc        = 0x80      ; Port D, Pin 6-7
.equ PORTCFG_ACOUT_PR_gc        = 0xC0      ; Port R, Pin 0-1

; Event Channel Output Port Selection
;                               0b_00nn_0000
.equ PORTCFG_EVOUT_OFF_gc       =    0      ; Event Output Disabled
.equ PORTCFG_EVOUT_PC7_gc       = 0x10      ; Port C pin 7(4)
.equ PORTCFG_EVOUT_PD7_gc       = 0x20      ; Port D pin 7(4)
.equ PORTCFG_EVOUT_PR0_gc       = 0x30      ; Port R pin 0

; Event Channel Selection       0b_0000_0nnn
.equ PORTCFG_EVOUTSEL_0_gc      = 0x00      ; Channel 0
.equ PORTCFG_EVOUTSEL_1_gc      = 0x01      ; Channel 1
.equ PORTCFG_EVOUTSEL_2_gc      = 0x02      ; Channel 2
.equ PORTCFG_EVOUTSEL_3_gc      = 0x03      ; Channel 3
.equ PORTCFG_EVOUTSEL_4_gc      = 0x04      ; Channel 4
.equ PORTCFG_EVOUTSEL_5_gc      = 0x05      ; Channel 5
.equ PORTCFG_EVOUTSEL_6_gc      = 0x06      ; Channel 6
.equ PORTCFG_EVOUTSEL_7_gc      = 0x07      ; Channel 7


; PORTCFG_SRLCTRL Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ PORTCFG_SRLENRR_bp         =    7      ; Slew Rate Limit Enable on PORTR
.equ PORTCFG_SRLENRD_bp         =    3      ; Slew Rate Limit Enable on PORTD
.equ PORTCFG_SRLENRC_bp         =    2      ; Slew Rate Limit Enable on PORTC
.equ PORTCFG_SRLENRA_bp         =    0      ; Slew Rate Limit Enable on PORTA





; Port Interrupt Vectors
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ PORTA_INT_vect             = 0x003C    ; Port A Interrupt Vector
.equ PORTC_INT_vect             = 0x0012    ; Port C Interrupt Vector
.equ PORTD_INT_vect             = 0x0046    ; Port D Interrupt Vector
.equ PORTR_INT_vect             = 0x0004    ; Port R Interrupt Vector


