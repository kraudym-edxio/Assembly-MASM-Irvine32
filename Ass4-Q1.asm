TITLE

; Names:
;	Edxio Kraudy Mora (110006224)
;	Eva Mudgal (105178136)
; Date: November 25, 2020
; ID: 110006224
; Description: Assignment 4 Question 1

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

.data

	pairs DWORD 5, 20, 24, 18, 11, 7, 432, 226, 0, 0
	gcdPrompt BYTE "GCD is ", 0

.code
main PROC
	
	mov ESI, offset pairs
	mov ECX, lengthof pairs / 2		; Initialize the loop counter

	elementPairs:
		mov EAX, [ESI]	
		mov EBX, [ESI + 4]

		call GCD	; Call to GCD PROC
		
		; Display the GCD of a pair from pairs array
		mov EDX, offset gcdPrompt
		call WriteString
		call WriteDec
		call Crlf

		add ESI, TYPE pairs * 2 ; Need to move by two DWORD spaces to attain next pair in array

		loop elementPairs

	exit

main ENDP

GCD PROC ; PROC that defines the GCD of a pair recursively

	push EBP
	mov EBP, ESP

	cmp EBX, 0
	jne iterate
	jmp isZero

	iterate:
		mov EDX, 0		; Clear remainder
		div EBX			; Quotient is in EAX, EBX is the divisor

		cmp EDX, 0		; Testing if remainder (which is in EDX after div) is 0
		je isZero
		
		mov EAX, EBX
		mov EBX, EDX	

		call GCD
		
	isZero:
		mov EAX, EBX
		pop EBP

	ret

GCD ENDP

END main