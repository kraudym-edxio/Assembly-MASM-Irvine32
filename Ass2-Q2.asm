TITLE

; Name: Edxio Kraudy Mora
; Date: November 2, 2020
; ID: 110006224
; Description: Assignment 2 Question 2

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

.data

	inputPrompt BYTE "Enter a string of at most 128 characters: ", 0
	outputPrompt BYTE "Here it is, with all lowercases and uppercases flipped, and in reverse order: ", 0

	lowercasePrompt BYTE "There are ", 0
	lowercasePrompt2 BYTE " lower-case letters after conversion.", 0

	characterPrompt BYTE "There are ", 0
	characterPrompt2 BYTE " characters in the string.", 0

	inputString BYTE 128 DUP (?)
	outputString BYTE 128 DUP (?)

	lowercaseCount BYTE 0
	stringSize DWORD ?

.code
main PROC

	; Printing input message and reading user input
	mov EDX, offset inputPrompt
	call WriteString

	mov EDX, offset inputString
	mov ECX, (sizeof inputString + 1)
	call ReadString
	mov stringSize, EAX

	; Printing output message which presents new string 
	call Crlf
	mov EDX, offset outputPrompt 
	call WriteString
	call Crlf

	mov ECX, stringSize		; setting for loop counter
	mov ESI, 0				; indexing begins at position zero

	; This loop will reverse and flip lowercases and uppercases
	iterate:
		movzx EAX, inputString[ECX - 1]

		;cmp EAX, 'A'
		;jae upperCase
		;jmp save

		cmp EAX, 'a'
		jae lowerCase

		cmp EAX, 'A'
		jae upperCase
		jmp save
		
		lowerCase:
			cmp EAX, 'z'
			jb toUpperCase
			;jmp save

		upperCase:
			cmp EAX, 'Z'
			jb toLowerCase
			;jmp save

		toUpperCase:
			inc lowerCaseCount
			mov AL, inputString[ECX - 1]
			sub AL, 20h
			mov inputString[ECX - 1], AL

		toLowerCase:
			mov AL, inputString[ECX - 1]
			add AL, (20h + 1)
			mov inputString[ECX - 1], AL

		save: 
			movzx EAX, inputString[ECX - 1]
			mov outputString[ESI], AL
			inc ESI

		loop iterate

	; Printing the new string
	mov EDX, offset outputString
	call WriteString
	call Crlf

	; Displaying the upper-case count
	mov EDX, offset lowercasePrompt
	call WriteString
	
	movzx EAX, lowercaseCount
	call WriteDec
	
	mov EDX, offset lowercasePrompt2
	call WriteString
	call Crlf

	; Displaying the character count
	mov EDX, offset characterPrompt
	call WriteString
	
	mov EAX, stringSize
	call WriteDec
	
	mov EDX, offset characterPrompt2
	call WriteString
	call Crlf

	exit

main ENDP
END main