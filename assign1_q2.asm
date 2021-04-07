TITLE

; Name: Edxio Kraudy Mora
; Date: October 12, 2020
; ID: 110006224
; Description: Assignment 1 Question 2

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

.data

	bigEndian BYTE 12h, 34h, 56h, 78h
	littleEndian DWORD ?

	; 32-bit number value is 12345678h
	; address: 0     1     2     3
	; value:   78h	 56h   34h	 12h 

.code
main PROC

	; We cannot move elements from bigEndian to littleEndian. 
	; This is so because they are different sizes. This problem
	; can be resolved if we use bigEndian + (higher index than 3) to
	; access littleEndian indirectly. 

	mov AL, bigEndian
	mov bigEndian + 4, AL

	mov AL, bigEndian + 1
	mov bigEndian + 5, Al

	mov AL, bigEndian + 2
	mov bigEndian + 6, AL

	mov AL, bigEndian + 3
	mov bigEndian + 7, Al

	mov EDX, littleEndian	; mov littleEndian to EAX to confirm value after DumRegs is called

	call DumpRegs

	exit

main ENDP
END main