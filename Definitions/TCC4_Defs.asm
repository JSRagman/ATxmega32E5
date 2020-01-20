;
; TCC4_Defs.asm
;
; Created: 19Jan2020
; Updated: 20Jan2020
; Author : JSRagman
;

; Organization:
;     1.  TCC4 Base Address and Register Offsets
;     2.  TCC4 Register Addresses
;     3.  TC4  Bit and Value Definitions
;     4.  TCC4 Interrupt Vectors

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





; TCC4 Base Address and Register Offsets
; (Ref 1, Sect. 33 and Ref 2, Sects. 13.14, 13.16)
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ TCC4_base               = 0x0800       ; 16-bit Timer/Counter With PWM

.equ TC4_CTRLA_offset        =   0x00       ; Control Register A
.equ TC4_CTRLB_offset        =   0x01       ; Control Register B
.equ TC4_CTRLC_offset        =   0x02       ; Control Register C
.equ TC4_CTRLD_offset        =   0x03       ; Control Register D
.equ TC4_CTRLE_offset        =   0x04       ; Control Register E
.equ TC4_CTRLF_offset        =   0x05       ; Control Register F
.equ TC4_INTCTRLA_offset     =   0x06       ; Interrupt Control Register A
.equ TC4_INTCTRLB_offset     =   0x07       ; Interrupt Control Register B
.equ TC4_CTRLGCLR_offset     =   0x08       ; Control Register G Clear
.equ TC4_CTRLGSET_offset     =   0x09       ; Control Register G Set
.equ TC4_CTRLHCLR_offset     =   0x0A       ; Control Register H Clear
.equ TC4_CTRLHSET_offset     =   0x0B       ; Control Register H Set
.equ TC4_INTFLAGS_offset     =   0x0C       ; Interrupt Flag Register
.equ TC4_TEMP_offset         =   0x0F       ; Temporary Register For 16-bit Access
.equ TC4_CNT_offset          =   0x20       ; Count
.equ TC4_PER_offset          =   0x26       ; Period
.equ TC4_CCA_offset          =   0x28       ; Compare or Capture A
.equ TC4_CCB_offset          =   0x2A       ; Compare or Capture B
.equ TC4_CCC_offset          =   0x2C       ; Compare or Capture C
.equ TC4_CCD_offset          =   0x2E       ; Compare or Capture D
.equ TC4_PERBUF_offset       =   0x36       ; Period Buffer
.equ TC4_CCABUF_offset       =   0x38       ; Compare Or Capture A Buffer
.equ TC4_CCBBUF_offset       =   0x3A       ; Compare Or Capture B Buffer
.equ TC4_CCCBUF_offset       =   0x3C       ; Compare Or Capture C Buffer
.equ TC4_CCDBUF_offset       =   0x3E       ; Compare Or Capture D Buffer



; TCC4 Register Addresses
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ TCC4_CTRLA              = 0x0800       ; Control A
.equ TCC4_CTRLB              = 0x0801       ; Control B
.equ TCC4_CTRLC              = 0x0802       ; Control C
.equ TCC4_CTRLD              = 0x0803       ; Control D
.equ TCC4_CTRLE              = 0x0804       ; Control E
.equ TCC4_CTRLF              = 0x0805       ; Control F
.equ TCC4_INTCTRLA           = 0x0806       ; Interrupt Control A
.equ TCC4_INTCTRLB           = 0x0807       ; Interrupt Control B
.equ TCC4_CTRLGCLR           = 0x0808       ; Control Register G Clear
.equ TCC4_CTRLGSET           = 0x0809       ; Control Register G Set
.equ TCC4_CTRLHCLR           = 0x080A       ; Control Register H Clear
.equ TCC4_CTRLHSET           = 0x080B       ; Control Register H Set
.equ TCC4_INTFLAGS           = 0x080C       ; Interrupt Flags
.equ TCC4_TEMP               = 0x080F       ; Temporary Register For 16-bit Access
.equ TCC4_CNT                = 0x0820       ; Count
.equ TCC4_PER                = 0x0826       ; Period
.equ TCC4_CCA                = 0x0828       ; Compare or Capture A
.equ TCC4_CCB                = 0x082A       ; Compare or Capture B
.equ TCC4_CCC                = 0x082C       ; Compare or Capture C
.equ TCC4_CCD                = 0x082E       ; Compare or Capture D
.equ TCC4_PERBUF             = 0x0836       ; Period Buffer
.equ TCC4_CCABUF             = 0x0838       ; Compare Or Capture A Buffer
.equ TCC4_CCBBUF             = 0x083A       ; Compare Or Capture B Buffer
.equ TCC4_CCCBUF             = 0x083C       ; Compare Or Capture C Buffer
.equ TCC4_CCDBUF             = 0x083E       ; Compare Or Capture D Buffer



; TC4 Bit and Value Definitions
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------

; TCC4_CTRLA Register  (Ref 2, Sect. 13.12.1)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC4_SYNCHEN_bp          =    6         ; Synchronization Enabled
.equ TC4_EVSTART_bp          =    5         ; Start on Next Event
.equ TC4_UPSTOP_bp           =    4         ; Stop on Next Update

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


; TCC4_CTRLB Register  (Ref 2, Sect. 13.12.2)
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


; TCC4_CTRLC Register (Normal 16-bit Mode)  (Ref 2, Sect. 13.12.3)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC4_POLD_bp                =    7      ; Channel D Output Polarity
.equ TC4_POLC_bp                =    6      ; Channel C Output Polarity
.equ TC4_POLB_bp                =    5      ; Channel B Output Polarity
.equ TC4_POLA_bp                =    4      ; Channel A Output Polarity
.equ TC4_CMPD_bp                =    3      ; Channel D Compare Output Value
.equ TC4_CMPC_bp                =    2      ; Channel C Compare Output Value
.equ TC4_CMPB_bp                =    1      ; Channel B Compare Output Value
.equ TC4_CMPA_bp                =    0      ; Channel A Compare Output Value

; TCC4_CTRLC Register (Byte Mode)  (Ref 2, Sect. 13.13.3)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC4_HCMPD_bp               =    7      ; High Channel D Compare Output Value
.equ TC4_HCMPC_bp               =    6      ; High Channel C Compare Output Value
.equ TC4_HCMPB_bp               =    5      ; High Channel B Compare Output Value
.equ TC4_HCMPA_bp               =    4      ; High Channel A Compare Output Value
.equ TC4_LCMPD_bp               =    3      ; Low Channel D Compare Output Value
.equ TC4_LCMPC_bp               =    2      ; Low Channel C Compare Output Value
.equ TC4_LCMPB_bp               =    1      ; Low Channel B Compare Output Value
.equ TC4_LCMPA_bp               =    0      ; Low Channel A Compare Output Value


; TCC4_CTRLD Register  (Ref 2, Sect. 13.12.4)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC4_EVDLY_bp               =    4      ; Event Delay

; Event Action Selection      0b_nnn0_0000
.equ TC45_EVACT_OFF_gc          = 0x00      ; No Event Action
.equ TC45_EVACT_FMODE1_gc       = 0x20      ; Fault Mode 1 capture
.equ TC45_EVACT_FMODE2_gc       = 0x40      ; Fault Mode 2 capture
.equ TC45_EVACT_UPDOWN_gc       = 0x60      ; Up/down count
.equ TC45_EVACT_QDEC_gc         = 0x80      ; Quadrature decode
.equ TC45_EVACT_RESTART_gc      = 0xA0      ; Restart
.equ TC45_EVACT_PWF_gc          = 0xC0      ; Pulse-width Capture

; Event Source Selection      0b_0000_nnnn
.equ TC45_EVSEL_OFF_gc          = 0x00      ; No Event Source
.equ TC45_EVSEL_CH0_gc          = 0x08      ; Event Channel 0
.equ TC45_EVSEL_CH1_gc          = 0x09      ; Event Channel 1
.equ TC45_EVSEL_CH2_gc          = 0x0A      ; Event Channel 2
.equ TC45_EVSEL_CH3_gc          = 0x0B      ; Event Channel 3
.equ TC45_EVSEL_CH4_gc          = 0x0C      ; Event Channel 4
.equ TC45_EVSEL_CH5_gc          = 0x0D      ; Event Channel 5
.equ TC45_EVSEL_CH6_gc          = 0x0E      ; Event Channel 6
.equ TC45_EVSEL_CH7_gc          = 0x0F      ; Event Channel 7


; TCC4_CTRLE Register (Normal 16-bit Mode)  (Ref 2, Sect. 13.12.5)
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

; Compare or Capture Channel C Mode
;                             0b_00nn_0000
.equ TC45_CCCMODE_DISABLE_gc    = 0x00      ; Channel Disabled
.equ TC45_CCCMODE_COMP_gc       = 0x10      ; Ouput Compare enabled
.equ TC45_CCCMODE_CAPT_gc       = 0x20      ; Input Capture enabled
.equ TC45_CCCMODE_BOTHCC_gc     = 0x30      ; Both Compare and Capture enabled

; Compare or Capture Channel D Mode
;                             0b_nn00_0000
.equ TC45_CCDMODE_DISABLE_gc    = 0x00      ; Channel Disabled
.equ TC45_CCDMODE_COMP_gc       = 0x40      ; Ouput Compare enabled
.equ TC45_CCDMODE_CAPT_gc       = 0x80      ; Input Capture enabled
.equ TC45_CCDMODE_BOTHCC_gc     = 0xC0      ; Both Compare and Capture enabled


; TCC4_CTRLE Register (Byte Mode)  (Ref 2, Sect. 13.13.5)
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

; Compare or Capture Low Channel C Mode
;                             0b_00nn_0000
.equ TC45_LCCCMODE_DISABLE_gc   = 0x00      ; Channel Disabled
.equ TC45_LCCCMODE_COMP_gc      = 0x10      ; Ouput Compare enabled
.equ TC45_LCCCMODE_CAPT_gc      = 0x20      ; Input Capture enabled
.equ TC45_LCCCMODE_BOTHCC_gc    = 0x30      ; Both Compare and Capture enabled

; Compare or Capture Low Channel D Mode
;                             0b_nn00_0000
.equ TC45_LCCDMODE_DISABLE_gc   = 0x00      ; Channel Disabled
.equ TC45_LCCDMODE_COMP_gc      = 0x40      ; Ouput Compare enabled
.equ TC45_LCCDMODE_CAPT_gc      = 0x80      ; Input Capture enabled
.equ TC45_LCCDMODE_BOTHCC_gc    = 0xC0      ; Both Compare and Capture enabled


; TCC4_CTRLF Register (Byte Mode)  (Ref 2, Sect. 13.13.6)
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

; Compare or Capture High Channel C Mode
;                             0b_00nn_0000
.equ TC45_HCCCMODE_DISABLE_gc   = 0x00      ; Channel Disabled
.equ TC45_HCCCMODE_COMP_gc      = 0x10      ; Ouput Compare enabled
.equ TC45_HCCCMODE_CAPT_gc      = 0x20      ; Input Capture enabled
.equ TC45_HCCCMODE_BOTHCC_gc    = 0x30      ; Both Compare and Capture enabled

; Compare or Capture High Channel D Mode
;                             0b_nn00_0000
.equ TC45_HCCDMODE_DISABLE_gc   = 0x00      ; Channel Disabled
.equ TC45_HCCDMODE_COMP_gc      = 0x40      ; Ouput Compare enabled
.equ TC45_HCCDMODE_CAPT_gc      = 0x80      ; Input Capture enabled
.equ TC45_HCCDMODE_BOTHCC_gc    = 0xC0      ; Both Compare and Capture enabled


; TCC4_INTCTRLA Register  (Ref 2, Sect. 13.12.6)
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


; TCC4_INTCTRLB Register (Normal 16-bit Mode)  (Ref 2, Sect. 13.12.7)
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

; Compare or Capture Channel C Interrupt Level
;                             0b_00nn_0000
.equ TC45_CCCINTLVL_OFF_gc      = 0x00 ; Interrupt Disabled
.equ TC45_CCCINTLVL_LO_gc       = 0x10 ; Low Level
.equ TC45_CCCINTLVL_MED_gc      = 0x20 ; Medium Level
.equ TC45_CCCINTLVL_HI_gc       = 0x30 ; High Level

; Compare or Capture Channel D Interrupt Level
;                             0b_nn00_0000
.equ TC45_CCDINTLVL_OFF_gc      = 0x00 ; Interrupt Disabled
.equ TC45_CCDINTLVL_LO_gc       = 0x40 ; Low Level
.equ TC45_CCDINTLVL_MED_gc      = 0x80 ; Medium Level
.equ TC45_CCDINTLVL_HI_gc       = 0xC0 ; High Level


; TCC4_INTCTRLB Register (Byte Mode)  (Ref 2, Sect. 13.13.8)
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

; Compare or Capture Low Channel C Interrupt Level
;                             0b_00nn_0000
.equ TC45_LCCCINTLVL_OFF_gc     = 0x00      ; Interrupt Disabled
.equ TC45_LCCCINTLVL_LO_gc      = 0x10      ; Low Level
.equ TC45_LCCCINTLVL_MED_gc     = 0x20      ; Medium Level
.equ TC45_LCCCINTLVL_HI_gc      = 0x30      ; High Level

; Compare or Capture Low Channel D Interrupt Level
;                             0b_nn00_0000
.equ TC45_LCCDINTLVL_OFF_gc     = 0x00      ; Interrupt Disabled
.equ TC45_LCCDINTLVL_LO_gc      = 0x40      ; Low Level
.equ TC45_LCCDINTLVL_MED_gc     = 0x80      ; Medium Level
.equ TC45_LCCDINTLVL_HI_gc      = 0xC0      ; High Level


; TCC4_CTRLGCLR Register  (Ref 2, Sect. 13.12.8)
; TCC4_CTRLGSET Register
; -----------------------------------------------------------------------------
; Bit Positions
;*******************************************************************
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.equ TC4_STOP_bp                =    4      ; Timer/Counter Stop
; Conflict:
;     Ref 2, Sect. 13.12.8 and Sect. 13.13.9 indicate that TC4_STOP
;     is at bit position 5.
;     So. Which is it?
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;*******************************************************************
.equ TC4_LUPD_bp                =    1      ; Lock Update
.equ TC4_DIR_bp                 =    0      ; Counter Direction

; Timer/Counter Command       0b_0000_nn00
.equ TC45_CMD_NONE_gc           = 0x00      ; No Command
.equ TC45_CMD_UPDATE_gc         = 0x04      ; Force Update
.equ TC45_CMD_RESTART_gc        = 0x08      ; Force Restart
.equ TC45_CMD_RESET_gc          = 0x0C      ; Force Hard Reset


; TCC4_CTRLHCLR Register (Normal 16-bit Mode)  (Ref 2, Sect. 13.12.9)
; TCC4_CTRLHSET Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC4_CCDBV_bp               =    4      ; Channel D Compare or Capture Buffer Valid
.equ TC4_CCCBV_bp               =    3      ; Channel C Compare or Capture Buffer Valid
.equ TC4_CCBBV_bp               =    2      ; Channel B Compare or Capture Buffer Valid
.equ TC4_CCABV_bp               =    1      ; Channel A Compare or Capture Buffer Valid
.equ TC4_PERBV_bp               =    0      ; Period Buffer Valid

; Bit Masks
.equ TC4_CCDBV_bm               = 0x10      ; Channel D Compare or Capture Buffer Valid
.equ TC4_CCCBV_bm               = 0x08      ; Channel C Compare or Capture Buffer Valid
.equ TC4_CCBBV_bm               = 0x04      ; Channel B Compare or Capture Buffer Valid
.equ TC4_CCABV_bm               = 0x02      ; Channel A Compare or Capture Buffer Valid
.equ TC4_PERBV_bm               = 0x01      ; Period Buffer Valid


; TCC4_CTRLHCLR Register (Byte Mode)  (Ref 2, Sect. 13.13.10)
; TCC4_CTRLHSET Register
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC4_LCCDBV_bp              =    4      ; Channel Low D Compare or Capture Buffer Valid
.equ TC4_LCCCBV_bp              =    3      ; Channel Low C Compare or Capture Buffer Valid
.equ TC4_LCCBBV_bp              =    2      ; Channel Low B Compare or Capture Buffer Valid
.equ TC4_LCCABV_bp              =    1      ; Channel Low A Compare or Capture Buffer Valid
.equ TC4_LPERBV_bp              =    0      ; Period Low Buffer Valid

; Bit Masks
.equ TC4_LCCDBV_bm              = 0x10      ; Channel Low D Compare or Capture Buffer Valid
.equ TC4_LCCCBV_bm              = 0x08      ; Channel Low C Compare or Capture Buffer Valid
.equ TC4_LCCBBV_bm              = 0x04      ; Channel Low B Compare or Capture Buffer Valid
.equ TC4_LCCABV_bm              = 0x02      ; Channel Low A Compare or Capture Buffer Valid
.equ TC4_LPERBV_bm              = 0x01      ; Period Low Buffer Valid


; TCC4_INTFLAGS Register (Normal 16-bit Mode)  (Ref 2, Sect. 13.12.10)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC4_CCDIF_bp               =    7      ; Channel D Compare or Capture Interrupt Flag
.equ TC4_CCCIF_bp               =    6      ; Channel C Compare or Capture Interrupt Flag
.equ TC4_CCBIF_bp               =    5      ; Channel B Compare or Capture Interrupt Flag
.equ TC4_CCAIF_bp               =    4      ; Channel A Compare or Capture Interrupt Flag
.equ TC4_TRGIF_bp               =    2      ; Trigger Restart Interrupt Flag
.equ TC4_ERRIF_bp               =    1      ; Error Interrupt Flag
.equ TC4_OVFIF_bp               =    0      ; Overflow/Underflow Interrupt Flag

; Bit Masks
.equ TC4_CCDIF_bm               = 0x80      ; Channel D Compare or Capture Interrupt Flag
.equ TC4_CCCIF_bm               = 0x40      ; Channel C Compare or Capture Interrupt Flag
.equ TC4_CCBIF_bm               = 0x20      ; Channel B Compare or Capture Interrupt Flag
.equ TC4_CCAIF_bm               = 0x10      ; Channel A Compare or Capture Interrupt Flag
.equ TC4_TRGIF_bm               = 0x04      ; Trigger Restart Interrupt Flag
.equ TC4_ERRIF_bm               = 0x02      ; Error Interrupt Flag
.equ TC4_OVFIF_bm               = 0x01      ; Overflow/Underflow Interrupt Flag


; TCC4_INTFLAGS Register (Byte Mode)  (Ref 2, Sect. 13.13.11)
; -----------------------------------------------------------------------------
; Bit Positions
.equ TC4_LCCDIF_bp              =    7      ; Channel Low D Compare or Capture Interrupt Flag
.equ TC4_LCCCIF_bp              =    6      ; Channel Low C Compare or Capture Interrupt Flag
.equ TC4_LCCBIF_bp              =    5      ; Channel Low B Compare or Capture Interrupt Flag
.equ TC4_LCCAIF_bp              =    4      ; Channel Low A Compare or Capture Interrupt Flag
.equ TC4_TRGIF_bp               =    2      ; Trigger Restart Interrupt Flag
.equ TC4_ERRIF_bp               =    1      ; Error Interrupt Flag
.equ TC4_OVFIF_bp               =    0      ; Overflow/Underflow Interrupt Flag

; Bit Masks
.equ TC4_LCCDIF_bm              = 0x80      ; Channel Low D Compare or Capture Interrupt Flag
.equ TC4_LCCCIF_bm              = 0x40      ; Channel Low C Compare or Capture Interrupt Flag
.equ TC4_LCCBIF_bm              = 0x20      ; Channel Low B Compare or Capture Interrupt Flag
.equ TC4_LCCAIF_bm              = 0x10      ; Channel Low A Compare or Capture Interrupt Flag
.equ TC4_TRGIF_bm               = 0x04      ; Trigger Restart Interrupt Flag
.equ TC4_ERRIF_bm               = 0x02      ; Error Interrupt Flag
.equ TC4_OVFIF_bm               = 0x01      ; Overflow/Underflow Interrupt Flag




; TCC4 Interrupt Vectors
; (Ref 1, Sect. 15.3 and Ref 2, Sects. 13.15, 13.17)
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
.equ TCC4_OVF_vect              = 0x18      ; Overflow
.equ TCC4_ERR_vect              = 0x1A      ; Error
.equ TCC4_CCA_vect              = 0x1C      ; Channel A Compare or Capture
.equ TCC4_CCB_vect              = 0x1E      ; Channel B Compare or Capture
.equ TCC4_CCC_vect              = 0x20      ; Channel C Compare or Capture
.equ TCC4_CCD_vect              = 0x22      ; Channel D Compare or Capture


