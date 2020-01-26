;
; esegdata.asm
;
; Created: 18Nov2019
; Updated: 26Jan2020
; Author:  JSRagman


;.eseg
ee_us2066_initdata:                         ; Display initialization data
.db 62
.db 0x80, 0x2A
.db 0x80, 0x71
.db 0xC0, 0x00
.db 0x80, 0x28
.db 0x80, 0x08
.db 0x80, 0x2A
.db 0x80, 0x79
.db 0x80, 0xD5
.db 0x80, 0x70
.db 0x80, 0x78
.db 0x80, 0x09
.db 0x80, 0x06
.db 0x80, 0x72
.db 0xC0, 0x00
.db 0x80, 0x2A
.db 0x80, 0x79
.db 0x80, 0xDA
.db 0x80, 0x10
.db 0x80, 0xDC
.db 0x80, 0x00
.db 0x80, 0x81
.db 0x80, 0x7F
.db 0x80, 0xD9
.db 0x80, 0xF1
.db 0x80, 0xDB
.db 0x80, 0x40
.db 0x80, 0x78
.db 0x80, 0x28
.db 0x80, 0x01
.db 0x80, 0x80
.db 0x80, 0x0C
ee_sutext:                                  ; Startup display text
.db 81                                      ; 80 characters, 20 per line
.db 0x40                                    ; NHD0420CW Control Byte (Data)
.db "Look at me! Zee!    "
.db "I am te Angel ov    "
.db "te Odd!             "
.db "         - E.A. Poe "
;   "                    "