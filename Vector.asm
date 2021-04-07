TITLE

; Names: 
;	Edxio Kraudy Mora (110006224)
;	Eva Mudgal (105178136)
;	Ehabuddin Mohammed (110057542)
;	Sumeet Bhogal (104418592)
; Date: November 12, 2020
; Description: Assignment 3 Question 1

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

.data

	; Start and exit prompts
	startPrompt BYTE "What do you want to do now? > ", 0
	exitPrompt BYTE "I am exiting... Thank you Honey... and Get lost...", 0

	; Vector prompts
	vecPrompt BYTE "Vector = ", 0
	vecIs BYTE "Vector is ", 0
	
	; Stack prompt
	stackIs BYTE "Stack is ", 0

	; Empty and not empty prompts
	emptyOutput BYTE "Stack is empty", 0
	notEmptyOutput BYTE "Stack not empty", 0

	; Size prompts
	sizePrompt BYTE "What is the size N of Vector? > ", 0
	sizePrompt2 BYTE "Size of Vector is N = ", 0

	; Input values for vector prompts
	valuesPrompt BYTE "What are the ", 0
	valuesPrompt2 BYTE " values in Vector? > ", 0

	; Prompts for ArrayToStack
	AtoSPromptBefore BYTE " before ArrayToStack", 0
	AtoSPromptAfter BYTE " after ArrayToStack", 0

	; Prompts for StackToArray
	StoAPromptBefore BYTE " before StackToArray", 0
	StoAPromptAfter BYTE " after StackToArray", 0

	; Prompts for StackReverse
	stackReverseBefore BYTE " before StackReverse", 0
	stackReverseAfter BYTE " after StackReverse", 0

	; Misc
	insertSpace BYTE "   ", 0

	; Variables and arrays 
	Vector DWORD 20 DUP(?)
	optionNUM SBYTE ?
	isEmpty DWORD 1
	sizeN DWORD ?
	temp DWORD ?

.code
main PROC ; This PROC is the option interface for the user's input

	; Label that marks the beginning such that it may be jumped to after a PROC is executed
	start: 
		; Displaying the start prompt
		mov EDX, offset startPrompt
		call WriteString
		call ReadInt
		
		call Crlf

		cmp AL, 0  ; 0 is to create a new Vector
		je create

		cmp AL, 1 ; 1 is to fill in a stack from a vector
		je ArrayToStackPrep

		cmp AL, 2 ; 2 is to fill in a vector from a stack
		je StackToArrayPrep

		cmp AL, 3 ; 3 is to reverse a vector using the stack
		je StackReversePrep

		cmp AL, -1 ; -1 is to exit
		je exitFinal

	; For option(0), creates Vector by calling a PROC
	create:
		LEA ESI, Vector
		call Init	; Call to Init PROC
		jmp start	; Return to asking user input

	; For option(1), array to stack by calling a PROC
	ArrayToStackPrep:
		LEA ESI, Vector
		call ArrayToStack	; Call to ArrayToStack PROC
		jmp start			; Return to asking user input

	; For option(2), stack to array by calling a PROC
	StackToArrayPrep:
		LEA ESI, Vector
		call StackToArray	; Call to StackToArray PROC
		jmp start			; Return to asking user input

	; For option(3), reverse stack by calling a PROC
	StackReversePrep:
		LEA ESI, Vector		
		call StackReverse	; Call to StackReverse PROC
		jmp start			; Return to asking user input

	; For option(-1), exit main PROC and display message
	exitFinal:
		mov EDX, offset exitPrompt
		call WriteString
		call Crlf

		exit

main ENDP

Init PROC	; PROC initializes Vector and its size
	; Ask user for size input
	mov EDX, offset sizePrompt
	call WriteString
	call ReadDec
	mov sizeN, EAX

	; Ask user to input vector values
	mov EDX, offset valuesPrompt
	call WriteString
	mov EAX, sizeN
	call WriteDec
	mov EDX, offset valuesPrompt2
	call WriteString
	call ReadVector					; Read all values inputted by user by calling a PROC

	; Display the size of the vector and its prompt
	mov EDX, offset sizePrompt2
	call WriteString
	mov EAX, sizeN
	call WriteDec
	call Crlf

	; Display the vector values and its prompt
	mov EDX, offset vecPrompt
	call WriteString
	LEA ESI, Vector
	call WriteVector				; Write all values within Vector by calling a PROC
	call Crlf

	; Determine if stack is empty or not and display appropriate prompt
	cmp isEmpty, 1
	jne notEmpty
	mov EDX, offset emptyOutput
	call WriteString
	call Crlf
	call Crlf

	ret
	
	notEmpty:
		mov EDX, offset notEmptyOutput
		call WriteString
		call Crlf
		call Crlf

		ret

Init ENDP

ArrayToStack PROC ; PROC pushes array to stack
	LEA ESI, Vector
	mov isEmpty, 0

	mov ECX, sizeN	; Initialize loop counter
	toStack:
		mov EBX, [ESI]
		push EBX
		add ESI, TYPE Vector

		loop toStack

	; Display Vector and its prompt
	mov EDX, offset vecIs
	call WriteString
	LEA ESI, Vector
	call WriteVector	

	; Display before message
	mov EDX, offset AtoSPromptBefore
	call WriteString
	call Crlf

	; Displaying the stack
	mov EDX, offset stackIs
	call WriteString

	mov ECX, sizeN	; initialize loop counter
	printingStack:
		pop EAX
		call WriteInt

		mov EDX, offset insertSpace
		call WriteString

		loop printingStack

	; Display after message
	mov EDX, offset AtoSPromptAfter
	call WriteString
	call Crlf

	; Display Vector 
	mov EDX, offset vecIs
	call WriteString
	call WriteVector
	mov EDX, offset insertSpace
	call WriteString
	mov EDX, offset AtoSPromptAfter
	call WriteString
	call Crlf

	; Determine if stack is empty or not and display appropriate prompt
	cmp isEmpty, 1
	jne notEmpty
	mov EDX, offset emptyOutput
	call WriteString
	call Crlf
	call Crlf

	ret

	notEmpty:
		mov EDX, offset notEmptyOutput
		call WriteString
		call Crlf
		call Crlf

		ret

ArrayToStack ENDP

StackToArray PROC ; PROC moves stack to array
	mov isEmpty, 1
	LEA ESI, Vector

	mov ECX, sizeN	; Initialize loop counter
	pushingStack:
		mov EBX, [ESI]
		push EBX
		add ESI, TYPE Vector

		loop pushingStack

	; Diplay stack and its prompt
	mov EDX, offset stackIs
	call WriteString

	mov ECX, sizeN
	printingStack:
		pop EAX	
		call WriteInt
		
		mov EDX, offset insertSpace
		call WriteString

		loop printingStack

	; Display before message
	mov EDX, offset StoAPromptBefore
	call WriteString
	call Crlf

	; Push values back onto the stack
	LEA ESI, Vector
	mov ECX, sizeN	; Initialize loop counter
	restoreStack:
		mov EBX, [ESI]
		push EBX
		add ESI, TYPE Vector
		loop restoreStack 

	LEA ESI, Vector

	; Acquire last number of array
	mov EAX, sizeN
	mov EDX, 4	
	mul EDX			; Last number is (sizeN * 4) since Vector is of type DWORD

	sub EAX, 4		; Need to subtract 4 because we need the location of the beginning of last number in memory 
	mov temp, EAX
	add ESI, temp
	mov ECX, sizeN
	toArray:
		pop EAX
		mov [ESI], EAX
		sub ESI, TYPE Vector

		loop toArray

	; Display Vector and its prompt
	mov EDX, offset vecIs
	call WriteString
	LEA ESI, Vector
	call WriteVector

	; Display after message 
	mov EDX, offset StoAPromptAfter
	call WriteString
	call Crlf

	; Determine if stack is empty or not and display appropriate prompt
	cmp isEmpty, 1
	jne notEmpty
	mov EDX, offset emptyOutput
	call WriteString
	call Crlf
	call Crlf

	ret

	notEmpty:
		mov EDX, offset notEmptyOutput
		call WriteString
		call Crlf
		call Crlf

		ret

StackToArray ENDP

StackReverse PROC ; PROC that reverses stack 
	mov isEmpty, 0
	LEA ESI, Vector

	mov ECX, sizeN	; Initialize loop counter
	pushingStack:
		mov EBX, [ESI]
		push EBX
		add ESI, TYPE Vector

		loop pushingStack

	; Display Vector and its prompt
	mov EDX, offset vecIs
	call WriteString
	LEA ESI, Vector
	call WriteVector

	; Display before message
	mov EDX, offset stackReverseBefore
	call WriteString
	call Crlf

	; Determine if stack is empty or not and display appropriate prompt
	cmp isEmpty, 1
	jne notEmpty
	mov EDX, offset emptyOutput
	call WriteString
	call Crlf
	jmp option1
	
	notEmpty:
		mov EDX, offset notEmptyOutput
		call WriteString
		call Crlf

	; Populate Vector with reversed stack values
	option1:
		inc isEmpty
		LEA ESI, Vector

		mov ECX, sizeN
		toArray:
			pop EAX
			mov [ESI], EAX
			add ESI, TYPE Vector

			loop toArray

	; Display Vector and its prompt
	mov EDX, offset vecIs
	call WriteString
	LEA ESI, Vector
	call WriteVector

	; Display after message 
	mov EDX, offset stackReverseAfter
	call WriteString
	call Crlf
	
	; Determine if stack is empty or not and display appropriate prompt
	cmp isEmpty, 1
	jne notEmpty2
	mov EDX, offset emptyOutput
	call WriteString
	call Crlf
	call Crlf

	ret

	notEmpty2:
		mov EDX, offset notEmptyOutput
		call WriteString
		call Crlf
		call Crlf

		ret

StackReverse ENDP

ReadVector PROC	; PROC reads user inputted values and populates Vector
	mov ECX, sizeN	; initialize loop counter

	nextNum:
		call ReadInt
		mov [ESI], EAX
		add ESI, TYPE Vector

		loop nextNum

	ret 

ReadVector ENDP

WriteVector PROC ; PROC writes all values within Vector array 
	mov ECX, sizeN	; initialize loop counter

	writeNum:
		mov EAX, [ESI]
		call WriteInt

		mov edx, offset insertSpace
		call WriteString

		add ESI, TYPE Vector

		loop writeNum

	ret

WriteVector ENDP

END main
