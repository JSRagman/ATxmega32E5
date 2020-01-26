;
; datastackmacros.asm
;
; Created: 12May2019
; Updated: 20Jul2019
; Author:  JSRagman
;
; Description:
;     Macros for implementing a data stack using the Y register.
;


; Macro List:
;     peekd      Peeks the top byte on the data stack.
;     peekdd     Peeks one byte from a given displacement into the data stack.
;     popd       Pops the top byte from the data stack into a register.
;     pushd      Pushes a register onto the data stack.
;     pushdi     Pushes an immediate value onto the data stack.



; peekd                                                               28May2019
; -----------------------------------------------------------------------------
; Description:
;     Retrieves the top value from the data stack without popping it.
;     The data stack pointer is not changed.
; Parameters:
;     @0   A general-purpose working register (r0-r31).
; General-Purpose Registers:
;     Modified  - @0
; Returns:
;     Returns the top byte from the data stack via the general-purpose
;     register specified by the @0 parameter.
; Usage:
;     peekd r16
.MACRO peekd
    ld @0, Y
.ENDMACRO


; peekdd                                                              28May2019
; -----------------------------------------------------------------------------
; Description:
;     Peeks one byte from a given displacement into the data stack.
;     The data stack pointer is not changed.
; Parameters:
;     @0   A general-purpose working register (r0-r31).
;     @1   An immediate value displacement (0 to 63).
; General-Purpose Registers:
;     Modified  - @0
; Returns:
;     Returns one byte from a given displacement into the data stack.
;     The register specified by @0 will contain the return value.
; Usage:
;     peekdd r16, 2
.MACRO peekdd
    ldd @0, Y+@1
.ENDMACRO


; popd                                                                28May2019
; -----------------------------------------------------------------------------
; Description:
;     Pops the top value from the data stack into a specified register.
; Parameters:
;     @0   A general-purpose working register (r0-r31).
; General-Purpose Registers:
;     Modified  - @0, Y
; Returns:
;     Returns the top byte from the data stack via a general-purpose
;     register specified by the @0 parameter.
; Usage:
;     popd r16
.MACRO popd
    ld @0, Y+
.ENDMACRO


; pushd                                                               28May2019
; -----------------------------------------------------------------------------
; Description:
;     Pushes a general-purpose register onto the data stack.
; Parameters:
;     @0   A general-purpose working register (r0-r31).
; General-Purpose Registers:
;     Modified  - Y
; Returns:
;     Nothing.
; Usage:
;     pushd r16
.MACRO pushd
    st -Y, @0
.ENDMACRO


; pushdi                                                              28May2019
; -----------------------------------------------------------------------------
; Function:
;     Push an immediate value onto the data stack.
; Parameters:
;     @0   A one-byte immediate value.
; General-Purpose Registers:
;     Modified  - r16, Y
; Returns:
;     Nothing.
; Usage:
;     pushdi 0xFF
.MACRO pushdi
    ldi r16, @0
    st -Y, r16
.ENDMACRO

