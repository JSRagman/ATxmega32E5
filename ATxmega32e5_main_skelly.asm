;
; ATxmega32e5_main_skelly.asm
;
; Created: 26Nov2019
; Updated: 17Jan2020
; Author : JSRagman
;

; Description:
;     ATxmega32E5 interrupt table with a bare main() outline which sets
;     the system clock source.


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




; reset                                                               17Jan2020
; -----------------------------------------------------------------------------
; Configuration:
;     System Clock      32      MHz internal RC oscillator
;     RTC Clock         32.768  kHz internal oscillator
reset:
;   Initialize register constants
    clr    rZero

;   Set System Clock to 32 MHz internal RC oscillator
;   CPU_CCP  (0x0034) - Configuration Change Protection (CCP)
;   CLK_CTRL (0x0040) - Clock Control Register

;   Enable oscillators that will be used
    ldi    r20,      (1<<OSC_RC2MEN_bp)     ;   2 MHz internal
    ori    r20,      (1<<OSC_RC32MEN_bp)    ;  32 MHz internal
    ori    r20,      (1<<OSC_RC32KEN_bp)    ;  32.768 kHz internal
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

;   Clock is ready - Set system clock
    ldi    r16,       CCP_IOREG_gc          ; CCP - Write to protected I/O register
    ldi    r17,       CLK_SCLKSEL_RC32M_gc  ; CLK - 32 MHz internal RC oscillator
    sts    CPU_CCP,   r16
    sts    CLK_CTRL,  r17



mainloop:
    rjmp mainloop



; Functions
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------


