;
; ATxmegaE5Starter.asm
;
; Created: 16Nov2019
; Updated:  1Feb2020
; Author : JSRagman
;

; Description:
;     Basic functions for using the ATxmega32E5 MCU.

; Configuration:
;     System Clock      32     MHz internal RC oscillator
;     RTC Clock         32.768  kHz internal oscillator
;     Display           Newhaven Display NHD-0420CW
;                       TWI interface


.include "registers.asm"
.include "constants.asm"
.include "ports.asm"
.include "./Macros/dataxfermacros.asm"
.include "./Macros/initmacros.asm"
.include "./Macros/datastackmacros.asm"
.include "./Macros/macros.asm"


.eseg
.include "esegdata.asm"

.dseg
.include "dsegdata.asm"



.cseg

; Interrupt Table                                                     20Jan2020
; -----------------------------------------------------------------------------
.org  0x0000                                ; 0x0000  Reset Vector
    rjmp reset
.org  RTC_OVF_vect                          ; 0x000E  RTC Overflow
    rjmp irq_rtc_ovf
.org  RTC_COMP_vect                         ; 0x0010  RTC Compare Match
    rjmp irq_rtc_cmp
.org TCC4_OVF_vect                          ; 0x0018  TCC4 Overflow
.org TCC4_ERR_vect                          ; 0x001A  TCC4 Error
.org TCC4_CCA_vect                          ; 0x001C  TCC4 Channel A Compare or Capture
.org TCC4_CCB_vect                          ; 0x001E  TCC4 Channel B Compare or Capture
.org TCC4_CCC_vect                          ; 0x0020  TCC4 Channel C Compare or Capture
.org TCC4_CCD_vect                          ; 0x0022  TCC4 Channel D Compare or Capture
.org  PORTA_INT_vect                        ; 0x003C  Port A Interrupt
    rjmp irq_port_A
.org  PORTD_INT_vect                        ; 0x0046  Port D Interrupt
    rjmp irq_port_D




; irq_fallout
; -----------------------------------------------------------------------------
; Description:
;     You shouldn't be here.
irq_fallout:
;   Cry for help
    cbi    VPORT2_OUT, ULED0_bp                ; User LED0 = ON

irq_fallout_loop:
    rjmp irq_fallout_loop




; Interrupt Handlers
; -----------------------------------------------------------------------------
.include "./IrqHandlers/irq_ioports.asm"
.include "./IrqHandlers/ioport_functions.asm"
.include "./IrqHandlers/irq_rtc.asm"






; reset                                                                1Feb2020
; -----------------------------------------------------------------------------
; Configuration:
;     System Clock      32      MHz internal RC oscillator
;     RTC Clock         32.768  kHz internal oscillator
; Functions Called:
;     RTC_Init    - Initializes the Real-Time Counter (RTC)
; Macros Used:
;     init_ports - Initialize I/O ports
;     init_twi   - Initialize TWI module
;     stsp       - Writes to a Configuration Change Protected (CCP) register
reset:
;   Initialize register constants
    clr    rZero

;   Initialize the Data Stack
    ldi  YL,    low(INTERNAL_SRAM_END - HSTACK_MAXSIZE + 1)
    ldi  YH,   high(INTERNAL_SRAM_END - HSTACK_MAXSIZE + 1)

;   Configure I/O ports
    init_ports

;   Enable oscillators that will be used
    lds    r16,    OSC_CTRL                 ; r16  = OSC_CTRL
    ori    r16,    (1<<OSC_RC32MEN_bp)      ; r16 |=  32     MHz internal
    ori    r16,    (1<<OSC_RC32KEN_bp)      ; r16 |=  32.768 kHz internal
    sts    OSC_CTRL, r16

;   Wait for stable 32 MHz oscillator.
;   Note: This section assumes that the 32MHz oscillator WILL be ready.
;         It could be written to select an alternate configuration if
;         32MHz fails to show up within a given time limit.
;         As it is, you would be stuck here on a 32MHz failure.
reset_sysclock_wait:
    lds    r16,    OSC_STATUS               ; r16 = OSC_STATUS
    andi   r16,    OSC_RC32MRDY_bm          ; if (32MHz != READY)
    breq   reset_sysclock_wait              ;     goto reset_sysclock_wait
                                            ; else
    stsp CLK_CTRL, CLK_SCLKSEL_RC32M_gc     ;     sysclock = 32 MHz


;   Configure RTC - Wait for internal 32.768 kHz oscillator to be ready.
;   Note: See the 8 MHz oscillator Note, above.
reset_rtcclock_wait:
    lds    r16,    OSC_STATUS               ; r16 = OSC_STATUS
    andi   r16,    OSC_RC32KRDY_bm          ; if (32.768kHz != READY)
    breq   reset_rtcclock_wait              ;     goto reset_rtcclock_wait

;   Set the RTC clock source = 32.768 kHz internal oscillator
    ldi    r16,    CLK_RTCSRC_RCOSC32_gc    ; RTC clock = 32.768 kHz
    ori    r16,    (1<<CLK_RTCEN_bp)        ; RTC clock = enabled
    sts    CLK_RTCCTRL,  r16


;   Configure the RTC to overflow at 10-millisecond intervals.
    ldi    r20,    0                        ; arg: CompareH = 0
    ldi    r21,    0                        ; arg: CompareL = 0
    ldi    r22,    high(330)                ; arg: PeriodH  = high(330)
    ldi    r23,     low(330)                ; arg: PeriodL  =  low(330)
    ldi    r24,    RTC_PRESCALER_DIV1_gc    ; arg: RTC Prescaler = RTC Clock/1
    rcall  RTC_Init                         ; RTC_Init(r20,r21,r22,r23)


;   Initialize TWI Module
    init_twi

;   Enable Medium- and High-Priority interrupts
    ldi    r16, (1<<PMIC_MEDLVLEN_bp)|(1<<PMIC_HILVLEN_bp)
    sts    PMIC_CTRL, r16

;   Light the fuse
    sei


;   Reset the display(s)
    rcall  NHD0420CW_Reset                  ; reset the display

;   Send initialization data
    ldi    r20,    NHD0420CW_SLA1           ; r20 = display 1 TWI address
    rcall  NHD0420CW_Init                   ; SREG_T = NHD0420CW_Init(r20)
    brts   reset_error                      ; if (SREG_T == 1)  goto  reset_error

    ldi    r20,    NHD0420CW_SLA2           ; r20 = display 2 TWI address
    rcall  NHD0420CW_Init                   ; SREG_T = NHD0420CW_Init(r20)
    brts   reset_error                      ; if (SREG_T == 1)  goto  reset_error

;   Show startup message
    ldi    XL,      low(MAPPED_EEPROM_START + ee_sutext) ; X = startup text address
    ldi    XH,     high(MAPPED_EEPROM_START + ee_sutext)
    rcall  TwiDw_FromEeprom                 ; SREG_T = TwiDw_FromEeprom(r20,X)
    brts   reset_error




;    rcall  main_ShowTime



reset_success:
    ButtonLed_Off_m  REDLED_bp              ; red   button LED = Off
    ButtonLed_On_m   GRNLED_bp              ; green button LED = On
    rjmp mainloop

reset_error:
    ButtonLed_On_m   REDLED_bp              ; red   button LED = On
    ButtonLed_Off_m  GRNLED_bp              ; green button LED = Off

mainloop:

    rjmp mainloop


; Functions
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

.include "mainfunctions.asm"
.include "./PeripheralFunctions/rtcfuncs.asm"
.include "./TwiFunctions/twifuncs_common.asm"
.include "./TwiFunctions/twifuncs_read.asm"
.include "./TwiFunctions/twifuncs_write.asm"
.include "./TwiDevices/NHD-0420CW_twi.asm"
.include "./TwiDevices/MCP7940N.asm"


