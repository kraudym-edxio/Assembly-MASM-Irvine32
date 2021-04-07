TITLE

; Name: Edxio Kraudy Mora
; Date: October 11, 2010
; ID: 110006224
; Description: Assignment 1 Question 1

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

.data
	
	varA SDWORD 543210
	varB SWORD -3210
	varC SDWORD ?
	varD SBYTE ?
	varZ SDWORD ?

	cPrompt BYTE "What is the value of C? ", 0
	dPrompt BYTE "What is the value of D? ", 0

	equation BYTE "Z = (-A - B) - (-C - D)", 0
	space BYTE "   ;   ", 0

	varAText BYTE "A = ", 0
	varBText BYTE "B = ", 0
	varCText BYTE "C = ", 0
	varDText BYTE "D = ", 0

	message_b BYTE "The final result in binary: ", 0
	message_d BYTE "The final result in decimal: ", 0
	message_h BYTE "The final result in hexadecimal: ", 0

.code
main PROC
	
	; Reading value of C
	mov EDX, offset cPrompt
	call WriteString
	call ReadInt
	mov varC, EAX

	; Reading value of D
	mov EDX, offset dPrompt
	call WriteString
	call ReadInt
	mov varD, AL

	; Displaying the equation
	mov EDX, offset equation
	call WriteString
	
	; Displaying the values of the variables
	call Crlf
	
	mov EAX, varA
	mov EDX, offset varAText
	call WriteString
	call WriteInt
	
	mov EDX, offset space
	call WriteString
	
	movsx EAX, varB
	mov EDX, offset varBText
	call WriteString
	call WriteInt
	
	mov EDX, offset space
	call WriteString

	mov EAX, varC
	mov EDX, offset varCText
	call WriteString
	call WriteInt
	
	mov EDX, offset space
	call WriteString
	
	movsx EAX, varD
	mov EDX, offset varDText
	call WriteString
	call WriteInt
	
	; Display Empty Line
	call Crlf

	; Display the final result
	
	; (-A - B)
	NEG varA			
	movsx EDX, varB				
	sub varA, EDX

	mov ECX, varA
	mov varZ, ECX				; varZ hold (-A - B)

	; (-C - D)
	NEG varC					
	movsx EDX, varD
	sub varC, EDX

	mov EAX, varC				; register EAX holds (-C - D)

	; (-A - B) - (-C - D)
	sub varZ, EAX				

	; Displaying the final result
	mov EAX, varZ
	
	mov EDX, offset message_b
	call WriteString
	call WriteBinB ; result in binary

	call Crlf

	mov EDX, offset message_d
	call WriteString
	call WriteInt ; result in decimal

	call Crlf

	mov EDX, offset message_h
	call WriteString
	call WriteHexB ; result in hexadecimal

	call Crlf

	exit

main ENDP
END main