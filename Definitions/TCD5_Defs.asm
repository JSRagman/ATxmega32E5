;
; TCD5_Defs.asm
;
; Created: 20Jan2020
; Updated: 20Jan2020
; Author : JSRagman
;

; Organization:
;     1.  TCD5 Base Address and Register Offsets
;     2.  TCD5 Register Addresses
;     3.  TC5  Bit and Value Definitions
;     4.  TCD5 Interrupt Vectors

; NOTE:
;     There is a lot of duplication between this file and TCC5_Defs.asm
;     and, to a lesser extent, TCC4_Defs.asm.
;
;     However, you don't need to jump back and forth between files
;     to find what you need.

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



; TCD5 Base Address and Register Offsets
; (Ref 1, Sect. 33 and Ref 2, Sects. 13.14, 13.16)
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ TCD5_base               = 0x0940       ; 16-bit Timer/Counter With PWM

.equ TC5_CTRLA_offset        =   0x00       ; Control Register A
.equ TC5_CTRLB_offset        =   0x01       ; Control Register B
.equ TC5_CTRLC_offset        =   0x02       ; Control Register C
.equ TC5_CTRLD_offset        =   0x03       ; Control Register D
.equ TC5_CTRLE_offset        =   0x04       ; Control Register E
.equ TC5_CTRLF_offset        =   0x05       ; Control Register F
.equ TC5_INTCTRLA_offset     =   0x06       ; Interrupt Control Register A
.equ TC5_INTCTRLB_offset     =   0x07       ; Interrupt Control Register B
.equ TC5_CTRLGCLR_offset     =   0x08       ; Control Register G Clear
.equ TC5_CTRLGSET_offset     =   0x09       ; Control Register G Set
.equ TC5_CTRLHCLR_offset     =   0x0A       ; Control Register H Clear
.equ TC5_CTRLHSET_offset     =   0x0B       ; Control Register H Set
.equ TC5_INTFLAGS_offset     =   0x0C       ; Interrupt Flag Register
.equ TC5_TEMP_offset         =   0x0F       ; Temporary Register For 16-bit Access
.equ TC5_CNT_offset          =   0x20       ; Count
.equ TC5_PER_offset          =   0x26       ; Period
.equ TC5_CCA_offset          =   0x28       ; Compare or Capture A
.equ TC5_CCB_offset          =   0x2A       ; Compare or Capture B
.equ TC5_PERBUF_offset       =   0x36       ; Period Buffer
.equ TC5_CCABUF_offset       =   0x38       ; Compare Or Capture A Buffer
.equ TC5_CCBBUF_offset       =   0x3A       ; Compare Or Capture B Buffer




; TCD5 Register Addresses
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ TCD5_CTRLA              = 0x0940        ; Control Register A
.equ TCD5_CTRLB              = 0x0941        ; Control Register B
.equ TCD5_CTRLC              = 0x0942        ; Control Register C
.equ TCD5_CTRLD              = 0x0943        ; Control Register D
.equ TCD5_CTRLE              = 0x0944        ; Control Register E
.equ TCD5_CTRLF              = 0x0945        ; Control Register F
.equ TCD5_INTCTRLA           = 0x0946        ; Interrupt Control Register A
.equ TCD5_INTCTRLB           = 0x0947        ; Interrupt Control Register B
.equ TCD5_CTRLGCLR           = 0x0948        ; Control Register G Clear
.equ TCD5_CTRLGSET           = 0x0949        ; Control Register G Set
.equ TCD5_CTRLHCLR           = 0x094A        ; Control Register H Clear
.equ TCD5_CTRLHSET           = 0x094B        ; Control Register H Set
.equ TCD5_INTFLAGS           = 0x094C        ; Interrupt Flag Register
.equ TCD5_TEMP               = 0x094F        ; Temporary Register For 16-bit Access
.equ TCD5_CNT                = 0x0960        ; Count
.equ TCD5_PER                = 0x0966        ; Period
.equ TCD5_CCA                = 0x0968        ; Compare or Capture A
.equ TCD5_CCB                = 0x096A        ; Compare or Capture B
.equ TCD5_PERBUF             = 0x0976        ; Period Buffer
.equ TCD5_CCABUF             = 0x0978        ; Compare Or Capture A Buffer
.equ TCD5_CCBBUF             = 0x097A        ; Compare Or Capture B Buffer




; TC5  Bit and Value Definitions
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------


; TCD5_CTRLA Register  (Ref 2, Sect. 13.12.1)
; -----------------------------------------------------------------------------
; Bit Postions
.equ TC5_SYNCHEN_bp          =    6         ; Synchronization Enabled
.equ TC5_EVSTART_bp          =    5         ; Start on Next Event
.equ TC5_UPSTOP_bp           =    4         ; Stop on Next Update

; Clock Selection          0b_0000_nnnn
.equ TC45_CLKSEL_OFF_gc      = 0x00         ; Timer Off
.equ TC45_CLKSEL_DIV1_gc     = 0x01         ; System Clock
.equ TC45_CLKSEL_DIV2_gc     = 0x02         ; System Clock / 2
.equ TC45_CLKSEL_DIV4_gc     = 0x03         ; System Clock / 4
.equ TC45_CLKSEL_DIV8_gc     = 0x04         ; System Clock / 8
.equ TC45_CLKSEL_DIV64_gc    = 0x05         ; System Clock / 64
.equ TC45_CLKSEL_DIV256_gc   = 0x06         ; System Clock / 256
.equ TC45_CLKSEL_DIV1024_gc  = 0x07         ; System Clock / 1024
.equ TC45_CLKSEL_EVCH0_gc    = 0x08         ; Event Channel 0
.equ TC45_CLKSEL_EVCH1_gc    = 0x09         ; Event Channel 1
.equ TC45_CLKSEL_EVCH2_gc    = 0x0A         ; Event Channel 2
.equ TC45_CLKSEL_EVCH3_gc    = 0x0B         ; Event Channel 3
.equ TC45_CLKSEL_EVCH4_gc    = 0x0C         ; Event Channel 4
.equ TC45_CLKSEL_EVCH5_gc    = 0x0D         ; Event Channel 5
.equ TC45_CLKSEL_EVCH6_gc    = 0x0E         ; Event Channel 6
.equ TC45_CLKSEL_EVCH7_gc    = 0x0F         ; Event Channel 7


; TCD5_CTRLB Register  (Ref 2, Sect. 13.12.2)
; -----------------------------------------------------------------------------
; Byte Mode Selection         0b_nn00_0000
.equ TC45_BYTEM_NORMAL_gc       = 0x00      ; 16-bit mode (normal)
.equ TC45_BYTEM_BYTEMODE_gc     = 0x40      ; Byte Mode

; Circular Buffer Selection
;                             0b_00nn_0000
.equ TC45_CIRCEN_DISABLE_gc     = 0x00      ; Circular Buffer Disabled
.equ TC45_CIRCEN_PER_gc         = 0x10      ; Enabled on PER/PERBUF
.equ TC45_CIRCEN_CCA_gc         = 0x20      ; Enabled on CCA/CCABUF
.equ TC45_CIRCEN_BOTH_gc        = 0x30      ; Enabled on All Buffered Registers

; Waveform Generation Mode    0b_0000_0nnn
.equ TC45_WGMODE_NORMAL_gc      = 0x00      ; Normal Mode
.equ TC45_WGMODE_FRQ_gc         = 0x01      ; Frequency Generation Mode
.equ TC45_WGMODE_SINGLESLOPE_gc = 0x03      ; Single Slope
.equ TC45_WGMODE_DSTOP_gc       = 0x05      ; Dual Slope, Update on TOP
.equ TC45_WGMODE_DSBOTH_gc      = 0x06      ; Dual Slope, Update on Both
.equ TC45_WGMODE_DSBOTTOM_gc    = 0x07      ; Dual Slope, Update on BOTTOM



; TCD5_CTRLC Register (Normal 16-bit Mode)  (Ref 2, Sect. 13.12.3)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC5_POLB_bp             =    5         ; Channel B Output Polarity
.equ TC5_POLA_bp             =    4         ; Channel A Output Polarity
.equ TC5_CMPB_bp             =    1         ; Channel B Compare Output Value
.equ TC5_CMPA_bp             =    0         ; Channel A Compare Output Value


; TCD5_CTRLC Register (Byte Mode)  (Ref 2, Sect. 13.13.3)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC5_HCMPB_bp            =    5         ; High Channel B Compare Output Value
.equ TC5_HCMPA_bp            =    4         ; High Channel A Compare Output Value
.equ TC5_LCMPB_bp            =    1         ; Low Channel B Compare Output Value
.equ TC5_LCMPA_bp            =    0         ; Low Channel A Compare Output Value


; TCD5_CTRLD Register  (Ref 2, Sect. 13.12.4)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC5_EVDLY_bp            =    4         ; Event Delay

; Event Action Selection   0b_nnn0_0000
.equ TC45_EVACT_OFF_gc       = 0x00         ; No Event Action
.equ TC45_EVACT_FMODE1_gc    = 0x20         ; Fault Mode 1 capture
.equ TC45_EVACT_FMODE2_gc    = 0x40         ; Fault Mode 2 capture
.equ TC45_EVACT_UPDOWN_gc    = 0x60         ; Up/down count
.equ TC45_EVACT_QDEC_gc      = 0x80         ; Quadrature decode
.equ TC45_EVACT_RESTART_gc   = 0xA0         ; Restart
.equ TC45_EVACT_PWF_gc       = 0xC0         ; Pulse-width Capture

; Event Source Selection   0b_0000_nnnn
.equ TC45_EVSEL_OFF_gc       = 0x00         ; No Event Source
.equ TC45_EVSEL_CH0_gc       = 0x08         ; Event Channel 0
.equ TC45_EVSEL_CH1_gc       = 0x09         ; Event Channel 1
.equ TC45_EVSEL_CH2_gc       = 0x0A         ; Event Channel 2
.equ TC45_EVSEL_CH3_gc       = 0x0B         ; Event Channel 3
.equ TC45_EVSEL_CH4_gc       = 0x0C         ; Event Channel 4
.equ TC45_EVSEL_CH5_gc       = 0x0D         ; Event Channel 5
.equ TC45_EVSEL_CH6_gc       = 0x0E         ; Event Channel 6
.equ TC45_EVSEL_CH7_gc       = 0x0F         ; Event Channel 7


; TCD5_CTRLE Register (Normal 16-bit Mode)  (Ref 2, Sect. 13.12.5)
; -----------------------------------------------------------------------------
; Compare or Capture Channel A Mode
;                             0b_0000_00nn
.equ TC45_CCAMODE_DISABLE_gc    = 0x00      ; Channel Disabled
.equ TC45_CCAMODE_COMP_gc       = 0x01      ; Ouput Compare enabled
.equ TC45_CCAMODE_CAPT_gc       = 0x02      ; Input Capture enabled
.equ TC45_CCAMODE_BOTHCC_gc     = 0x03      ; Both Compare and Capture enabled

; Compare or Capture Channel B Mode
;                             0b_0000_nn00
.equ TC45_CCBMODE_DISABLE_gc    = 0x00      ; Channel Disabled
.equ TC45_CCBMODE_COMP_gc       = 0x04      ; Ouput Compare enabled
.equ TC45_CCBMODE_CAPT_gc       = 0x08      ; Input Capture enabled
.equ TC45_CCBMODE_BOTHCC_gc     = 0x0C      ; Both Compare and Capture enabled


; TCD5_CTRLE Register (Byte Mode)  (Ref 2, Sect. 13.13.5)
; -----------------------------------------------------------------------------
; Compare or Capture Low Channel A Mode
;                             0b_0000_00nn
.equ TC45_LCCAMODE_DISABLE_gc   = 0x00      ; Channel Disabled
.equ TC45_LCCAMODE_COMP_gc      = 0x01      ; Ouput Compare enabled
.equ TC45_LCCAMODE_CAPT_gc      = 0x02      ; Input Capture enabled
.equ TC45_LCCAMODE_BOTHCC_gc    = 0x03      ; Both Compare and Capture enabled

; Compare or Capture Low Channel B Mode
;                             0b_0000_nn00
.equ TC45_LCCBMODE_DISABLE_gc   = 0x00      ; Channel Disabled
.equ TC45_LCCBMODE_COMP_gc      = 0x04      ; Ouput Compare enabled
.equ TC45_LCCBMODE_CAPT_gc      = 0x08      ; Input Capture enabled
.equ TC45_LCCBMODE_BOTHCC_gc    = 0x0C      ; Both Compare and Capture enabled


; TCD5_CTRLF Register (Byte Mode)  (Ref 2, Sect. 13.13.6)
; -----------------------------------------------------------------------------
; Compare or Capture High Channel A Mode
;                             0b_0000_00nn
.equ TC45_HCCAMODE_DISABLE_gc   = 0x00      ; Channel Disabled
.equ TC45_HCCAMODE_COMP_gc      = 0x01      ; Ouput Compare enabled
.equ TC45_HCCAMODE_CAPT_gc      = 0x02      ; Input Capture enabled
.equ TC45_HCCAMODE_BOTHCC_gc    = 0x03      ; Both Compare and Capture enabled

; Compare or Capture High Channel B Mode
;                             0b_0000_nn00
.equ TC45_HCCBMODE_DISABLE_gc   = 0x00      ; Channel Disabled
.equ TC45_HCCBMODE_COMP_gc      = 0x04      ; Ouput Compare enabled
.equ TC45_HCCBMODE_CAPT_gc      = 0x08      ; Input Capture enabled
.equ TC45_HCCBMODE_BOTHCC_gc    = 0x0C      ; Both Compare and Capture enabled


; TCD5_INTCTRLA Register  (Ref 2, Sect. 13.12.6)
; -----------------------------------------------------------------------------
; Timer Trigger Restart Interrupt Level
;                             0b_00nn_0000
.equ TC45_TRGINTLVL_OFF_gc      = 0x00      ; Interrupt Disabled
.equ TC45_TRGINTLVL_LO_gc       = 0x10      ; Low Level
.equ TC45_TRGINTLVL_MED_gc      = 0x20      ; Medium Level
.equ TC45_TRGINTLVL_HI_gc       = 0x30      ; High Level

; Error Interrupt Level
;                             0b_0000_nn00
.equ TC45_ERRINTLVL_OFF_gc      = 0x00      ; Interrupt Disabled
.equ TC45_ERRINTLVL_LO_gc       = 0x04      ; Low Level
.equ TC45_ERRINTLVL_MED_gc      = 0x08      ; Medium Level
.equ TC45_ERRINTLVL_HI_gc       = 0x0C      ; High Level

; Overflow Interrupt Level
;                             0b_0000_00nn
.equ TC45_OVFINTLVL_OFF_gc      = 0x00      ; Interrupt Disabled
.equ TC45_OVFINTLVL_LO_gc       = 0x01      ; Low Level
.equ TC45_OVFINTLVL_MED_gc      = 0x02      ; Medium Level
.equ TC45_OVFINTLVL_HI_gc       = 0x03      ; High Level


; TCD5_INTCTRLB Register (Normal 16-bit Mode)  (Ref 2, Sect. 13.12.7)
; -----------------------------------------------------------------------------
; Compare or Capture Channel A Interrupt Level
;                             0b_0000_00nn
.equ TC45_CCAINTLVL_OFF_gc      = 0x00 ; Interrupt Disabled
.equ TC45_CCAINTLVL_LO_gc       = 0x01 ; Low Level
.equ TC45_CCAINTLVL_MED_gc      = 0x02 ; Medium Level
.equ TC45_CCAINTLVL_HI_gc       = 0x03 ; High Level

; Compare or Capture Channel B Interrupt Level
;                             0b_0000_nn00
.equ TC45_CCBINTLVL_OFF_gc      = 0x00 ; Interrupt Disabled
.equ TC45_CCBINTLVL_LO_gc       = 0x04 ; Low Level
.equ TC45_CCBINTLVL_MED_gc      = 0x08 ; Medium Level
.equ TC45_CCBINTLVL_HI_gc       = 0x0C ; High Level


; TCD5_INTCTRLB Register (Byte Mode)  (Ref 2, Sect. 13.13.8)
; -----------------------------------------------------------------------------
; Compare or Capture Low Channel A Interrupt Level
;                             0b_0000_00nn
.equ TC45_LCCAINTLVL_OFF_gc     = 0x00      ; Interrupt Disabled
.equ TC45_LCCAINTLVL_LO_gc      = 0x01      ; Low Level
.equ TC45_LCCAINTLVL_MED_gc     = 0x02      ; Medium Level
.equ TC45_LCCAINTLVL_HI_gc      = 0x03      ; High Level

; Compare or Capture Low Channel B Interrupt Level
;                             0b_0000_nn00
.equ TC45_LCCBINTLVL_OFF_gc     = 0x00      ; Interrupt Disabled
.equ TC45_LCCBINTLVL_LO_gc      = 0x04      ; Low Level
.equ TC45_LCCBINTLVL_MED_gc     = 0x08      ; Medium Level
.equ TC45_LCCBINTLVL_HI_gc      = 0x0C      ; High Level


; TCD5_CTRLGCLR Register  (Ref 2, Sect. 13.12.8)
; TCD5_CTRLGSET Register
; -----------------------------------------------------------------------------
; Bit Positions
;*******************************************************************
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.equ TC5_STOP_bp                =    4      ; Timer/Counter Stop
; Conflict:
;     Ref 2, Sect. 13.12.8 and Sect. 13.13.9 indicate that TC5_STOP
;     is at bit position 5.
;     So. Which is it?
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;*******************************************************************
.equ TC5_LUPD_bp                =    1      ; Lock Update
.equ TC5_DIR_bp                 =    0      ; Counter Direction

; Timer/Counter Command       0b_0000_nn00
.equ TC45_CMD_NONE_gc           = 0x00      ; No Command
.equ TC45_CMD_UPDATE_gc         = 0x04      ; Force Update
.equ TC45_CMD_RESTART_gc        = 0x08      ; Force Restart
.equ TC45_CMD_RESET_gc          = 0x0C      ; Force Hard Reset


; TCD5_CTRLHCLR Register (Normal 16-bit Mode)  (Ref 2, Sect. 13.12.9)
; TCD5_CTRLHSET Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC5_CCBBV_bp               =    2      ; Channel B Compare or Capture Buffer Valid
.equ TC5_CCABV_bp               =    1      ; Channel A Compare or Capture Buffer Valid
.equ TC5_PERBV_bp               =    0      ; Period Buffer Valid

; Bit Masks
.equ TC5_CCBBV_bm               = 0x04      ; Channel B Compare or Capture Buffer Valid
.equ TC5_CCABV_bm               = 0x02      ; Channel A Compare or Capture Buffer Valid
.equ TC5_PERBV_bm               = 0x01      ; Period Buffer Valid


; TCD5_CTRLHCLR Register (Byte Mode)  (Ref 2, Sect. 13.13.10)
; TCD5_CTRLHSET Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC5_LCCBBV_bp              =    2      ; Channel Low B Compare or Capture Buffer Valid
.equ TC5_LCCABV_bp              =    1      ; Channel Low A Compare or Capture Buffer Valid
.equ TC5_LPERBV_bp              =    0      ; Period Low Buffer Valid

; Bit Masks
.equ TC5_LCCBBV_bm              = 0x04      ; Channel Low B Compare or Capture Buffer Valid
.equ TC5_LCCABV_bm              = 0x02      ; Channel Low A Compare or Capture Buffer Valid
.equ TC5_LPERBV_bm              = 0x01      ; Period Low Buffer Valid


; TCD5_INTFLAGS Register (Normal 16-bit Mode)  (Ref 2, Sect. 13.12.10)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC5_CCBIF_bp               =    5      ; Channel B Compare or Capture Interrupt Flag
.equ TC5_CCAIF_bp               =    4      ; Channel A Compare or Capture Interrupt Flag
.equ TC5_TRGIF_bp               =    2      ; Trigger Restart Interrupt Flag
.equ TC5_ERRIF_bp               =    1      ; Error Interrupt Flag
.equ TC5_OVFIF_bp               =    0      ; Overflow/Underflow Interrupt Flag

; Bit Masks
.equ TC5_CCBIF_bm               = 0x20      ; Channel B Compare or Capture Interrupt Flag
.equ TC5_CCAIF_bm               = 0x10      ; Channel A Compare or Capture Interrupt Flag
.equ TC5_TRGIF_bm               = 0x04      ; Trigger Restart Interrupt Flag
.equ TC5_ERRIF_bm               = 0x02      ; Error Interrupt Flag
.equ TC5_OVFIF_bm               = 0x01      ; Overflow/Underflow Interrupt Flag


; TCD5_INTFLAGS Register (Byte Mode)  (Ref 2, Sect. 13.13.11)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC5_LCCBIF_bp              =    5      ; Channel Low B Compare or Capture Interrupt Flag
.equ TC5_LCCAIF_bp              =    4      ; Channel Low A Compare or Capture Interrupt Flag
.equ TC5_TRGIF_bp               =    2      ; Trigger Restart Interrupt Flag
.equ TC5_ERRIF_bp               =    1      ; Error Interrupt Flag
.equ TC5_OVFIF_bp               =    0      ; Overflow/Underflow Interrupt Flag

; Bit Masks
.equ TC5_LCCBIF_bm              = 0x20      ; Channel Low B Compare or Capture Interrupt Flag
.equ TC5_LCCAIF_bm              = 0x10      ; Channel Low A Compare or Capture Interrupt Flag
.equ TC5_TRGIF_bm               = 0x04      ; Trigger Restart Interrupt Flag
.equ TC5_ERRIF_bm               = 0x02      ; Error Interrupt Flag
.equ TC5_OVFIF_bm               = 0x01      ; Overflow/Underflow Interrupt Flag




; TCD5 interrupt vectors
; (Ref 1, Sect. 15.3 and Ref 2, Sects. 13.15, 13.17)
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ TCD5_OVF_vect           = 0x0048       ; Overflow Interrupt
.equ TCD5_ERR_vect           = 0x004A       ; Error Interrupt
.equ TCD5_CCA_vect           = 0x004C       ; Channel A Compare or Capture Interrupt
.equ TCD5_CCB_vect           = 0x004E       ; Channel B Compare or Capture Interrupt
