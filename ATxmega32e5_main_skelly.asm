;
; ATxmega32e5_main_skelly.asm
;
; Created: 26Nov2019
; Updated: 26Jan2020
; Author : JSRagman
;

; Description:
;     ATxmega32E5 interrupt table and main()

; Reference
;     1. ATxmega32e5def.inc - interrupt vector definitions




.cseg

; Interrupt Table                                                     26Nov2019
; -----------------------------------------------------------------------------
.org  0x0000
    rjmp reset
.org  OSC_OSCF_vect                         ; 0x0002  Oscillator Failure (NMI)
.org  PORTR_INT_vect                        ; 0x0004  Port R External
.org  EDMA_CH0_vect                         ; 0x0006  EDMA Channel 0
.org  EDMA_CH1_vect                         ; 0x0008  EDMA Channel 1
.org  EDMA_CH2_vect                         ; 0x000A  EDMA Channel 2
.org  EDMA_CH3_vect                         ; 0x000C  EDMA Channel 3
.org  RTC_OVF_vect                          ; 0x000E  RTC Overflow
.org  RTC_COMP_vect                         ; 0x0010  RTC Compare
.org  PORTC_INT_vect                        ; 0x0012  Port C External
.org  TWIC_TWIS_vect                        ; 0x0014  TWI Slave
.org  TWIC_TWIM_vect                        ; 0x0016  TWI Master
.org  TCC4_OVF_vect                         ; 0x0018  T/C4 (Port C) Overflow
.org  TCC4_ERR_vect                         ; 0x001A  T/C4 (Port C) Error
.org  TCC4_CCA_vect                         ; 0x001C  T/C4 (Port C) Channel A Compare or Capture
.org  TCC4_CCB_vect                         ; 0x001E  T/C4 (Port C) Channel B Compare or Capture
.org  TCC4_CCC_vect                         ; 0x0020  T/C4 (Port C) Channel C Compare or Capture
.org  TCC4_CCD_vect                         ; 0x0022  T/C4 (Port C) Channel D Compare or Capture
.org  TCC5_OVF_vect                         ; 0x0024  T/C5 (Port C) Overflow
.org  TCC5_ERR_vect                         ; 0x0026  T/C5 (Port C) Error
.org  TCC5_CCA_vect                         ; 0x0028  T/C5 (Port C) Channel A Compare or Capture
.org  TCC5_CCB_vect                         ; 0x002A  T/C5 (Port C) Channel B Compare or Capture
.org  SPIC_INT_vect                         ; 0x002C  SPI (Port C)
.org  USARTC0_RXC_vect                      ; 0x002E  USART0 Reception Complete
.org  USARTC0_DRE_vect                      ; 0x0030  USART0 Data Register Empty
.org  USARTC0_TXC_vect                      ; 0x0032  USART0 Transmission Complete
.org  NVM_EE_vect                           ; 0x0034  NVM EE
.org  NVM_SPM_vect                          ; 0x0036  NVM SPM
.org  XCL_UNF_vect                          ; 0x0038  XCL T/C Underflow
.org  XCL_CC_vect                           ; 0x003A  XCL T/C Compare or Capture
.org  PORTA_INT_vect                        ; 0x003C  Port A External
    rjmp irq_port_A
.org  ACA_AC0_vect                          ; 0x003E  AC0
.org  ACA_AC1_vect                          ; 0x0040  AC1
.org  ACA_ACW_vect                          ; 0x0042  ACA Window Mode
.org  ADCA_CH0_vect                         ; 0x0044  ADC Channel
.org  PORTD_INT_vect                        ; 0x0046  Port D External
.org  TCD5_OVF_vect                         ; 0x0048  T/C5 (Port D) Overflow
.org  TCD5_ERR_vect                         ; 0x004A  T/C5 (Port D) Error
.org  TCD5_CCA_vect                         ; 0x004C  Channel A Compare or Capture
.org  TCD5_CCB_vect                         ; 0x004E  Channel B Compare or Capture
.org  USARTD0_RXC_vect                      ; 0x0050  Reception Complete
.org  USARTD0_DRE_vect                      ; 0x0052  Data Register Empty
.org  USARTD0_TXC_vect                      ; 0x0054  Transmission Complete


; irq_fallout
; -----------------------------------------------------------------------------
; Description:
;     You shouldn't be here.
irq_fallout:
;   TODO: Cry for help.

irq_fallout_loop:
    rjmp irq_fallout_loop




; Interrupt Handlers
; -----------------------------------------------------------------------------


; irq_port_A                                                          26Nov2019
; -----------------------------------------------------------------------------
; Description:
;     Port A External Interrupt Handler
; Triggered By:
;     
irq_port_A:
    push   r16
    in     r16, SREG
    push   r16

;   Well? What are you going to do about it?

    pop    r16
    out    SREG, r16
    pop    r16
    reti




; reset                                                               25Jan2020
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
; Status:
;     25Jan2020 - enable oscillators
;               - set system clock = 32 MHz
;               - set RTC clock
;               - configure RTC
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
    
;   Enable Medium- and High-Priority interrupts
    ldi    r16, (1<<PMIC_MEDLVLEN_bp)|(1<<PMIC_HILVLEN_bp)
    sts    PMIC_CTRL, r16

;   Light the fuse
    sei



mainloop:
    rjmp mainloop



; Functions
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------


