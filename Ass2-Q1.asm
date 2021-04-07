TITLE

; Name: Edxio Kraudy Mora
; Date: November 2, 2020
; ID: 110006224
; Description: Assignment 2 Question 1

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

.data

	inputPrompt BYTE "Enter an integer number N to display the first N terms of the Fibonacci sequence: ", 0
	sequencePrompt BYTE "Fibonacci sequence with N = ", 0
	isPrompt BYTE " is: ", 0
	space BYTE " ", 0
	
	input BYTE ?
	sequence DWORD 50 DUP(?)

.code
main PROC

	; Reading user input
	mov EDX, offset inputPrompt
	call WriteString
	call ReadInt
	movzx ECX, AL		; setting loop counter for next:
	inc ECX				; incremented because N+1 terms must be displayed
	
	mov input, AL		; input holds the value of N (user input)

	mov EAX, 0			; registers holds term zero of sequence
	mov EBX, 1			; register holds term one of sequence

	mov ESI, 0			; index starts from zero

	next: 
		add EBX, EAX
		xchg EAX, EBX

		; Populating sequence array
		mov sequence[ESI], EBX
		add ESI, TYPE sequence

		loop next

	; "Fibonacci sequence is..." prompt
	mov EDX, offset sequencePrompt
	call WriteString
	movzx EAX, input
	call WriteDec
	mov EDX, offset isPrompt
	call WriteString

	movzx ECX, input
	inc ECX
	
	; Printing sequence in reverse
	printing:
	
		sub ESI, TYPE sequence
		mov EAX, sequence[ESI]
		call WriteDec

		mov EDX, offset space
		call WriteString

		loop printing

	exit

main ENDP
END main