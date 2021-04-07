TITLE

; Names:	
;	Edxio Kraudy Mora (110006224)
;	Eva Mudgal (105178136)
;	Ehabuddin Mohammed (110057542)
;	Sumeet Bhogal (104418592)
; Date: November 10, 2020
; Description: Assignment 3 Question 2

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

.data

	firstPrompt BYTE "What do you want to do, Lovely? ", 0

	array1 BYTE 8 DUP(?), 0
	array2 BYTE 10 DUP(?), 0

	toHexPrompt BYTE "Enter a 32-bit decimal number to convert to hexadecimal: ", 0
	toBinPrompt BYTE "Enter a string to convert to binary: ", 0

	exitMessage BYTE "Get Lost, you Sweetey Honey Bun", 0
	mainMessage BYTE "Thank you, Sweetey Honey Bun", 0

.code
main PROC

	mov EDX, offset firstPrompt
	call WriteString

	call ReadChar ; Reads char input from user
	call WriteChar ; Displays the char user wrote

	; Comparing input cases- including case sensitive options
	cmp AL, 'W'
	je toHex

	cmp AL, 'w'
	je toHex

	cmp AL, 'R'
	je toBin

	cmp AL, 'r'
	je toBin

	; User did not input a char that is either W (or w) or R (or r)
	jmp exiting

	toHex:
	call Crlf
	mov EAX, 0

	; Ask user to input a 32-bit decimal number
	mov EDX, offset toHexPrompt
	call WriteString
	call ReadDec

	mov EBX, EAX
	call HexOutput ; Convert to hexadecimal PROC call
	jmp goodbye ; Jumping to goodbye message block

	toBin:
	call Crlf

	; Ask user to inputn a string to convert to binary
	mov EDX, offset toBinPrompt
	call WriteString

	call HexInput ; Convert to binary PROC call
	jmp goodbye ; Jumping to goodbye message block

	jmp exitFinal ; Jumping to block which exits from main

	; User did not choose appropriate input char exit block
	exiting:
	call Crlf

	mov EDX, offset exitMessage
	call WriteString
	call Crlf

	jmp exitFinal

	; Goodbye message after PROC call
	goodbye:
	call Crlf

	mov EDX, offset mainMessage
	call WriteString
	call Crlf

	; Exiting from main block
	exitFinal:
	exit

main ENDP

; PROC that converts 32-bit decimal number to hexadecimal output
HexOutput PROC

	mov ECX, 8 ; Setting for loop counter
	mov ESI, offset array1

	changingByRotation: ; Beginning of for loop
		ROL EBX, 4 ; The most significant 4 bits goes into least significant 4 bits
		mov DL, BL
		AND DL, 0Fh ; DL contains number value of 4 bits

		cmp DL, 0Ah ; If Dl < 10 then convert to '0' ... '9'
		jb belowTen ; Else convert to 'A' ... 'F'
		add DL, 37h

		mov [ESI], DL
		jmp nextIteration

		belowTen:
			add DL, 30h
			mov [ESI], DL
			jmp nextIteration

		nextIteration:
			add ESI, TYPE array1

	loop changingByRotation ; Loop again

	mov BYTE PTR[ESI], 68h ; Add 'h' to the end of number

	call Crlf

	mov EDX, offset array1
	call WriteString ; Display hexadecimal output

	ret

HexOutput ENDP

; PROC that converts hexadecimal to binary
HexInput PROC

	mov EDX, offset array2
	mov ECX, sizeof array2	; Initialize loop counter to array size 

	call ReadString
	xor EAX, EAX ; EAX = 0

	nextNum:
		mov BL, [EDX]

		; Hexadecimal ends with 'h', stop once 'h' is hit
		cmp BL, 'h'
		je done

		cmp BL, 'A'
		jb other

		sub BL, 37h
		shl EAX, 4
		OR AL, BL

		inc EDX

		jmp nextNum

	other:
		sub BL, 30h
		shl EAX, 4
		OR AL, BL

		inc EDX

		jmp nextNum

	; Displaying result
	done:
		call Crlf
		call WriteBin ; Write the converted binary number to the screen
		call Crlf

	ret

HexInput ENDP

END main