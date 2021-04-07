TITLE

; Names:
;	Edxio Kraudy Mora (110006224)
;	Eva Mudgal (105178136)
; Date: November 25, 2020
; Description: Assignment 4 Question 2

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

.data

	insertSpace BYTE " ", 0

	startPrompt BYTE "Enter an number N to determine Fibonacci sequence: ", 0

	sequencePrompt BYTE "Fibonacci sequence with N = ", 0
	sequencePrompt2 BYTE " is: ", 0

	sizeN DWORD ?

.code
main PROC

	; Display starting prompt
	mov EDX, offset startPrompt
	call WriteString
	call ReadInt
	mov sizeN, EAX	; Also store the user input into a variable 

	mov ECX, EAX	
	mov EDX, EAX

	; Pushing the following two regisers to have a temporary save after manipulating them
	push ECX
	push EDX

	call Fib	; Call to Fib PROC
	add ESP, 4	; Clean stack after call

	; Display the sequence prompts
	mov EDX, offset sequencePrompt
	call WriteString
	mov EAX, sizeN
	call WriteDec
	mov EDX, offset sequencePrompt2
	call WriteString

	; Base case values for f(0) and f(1)
	mov EAX, 0
	mov EBX, 1

	; Popping the two register that were previously pushed, original values are restored
	pop EDX
	pop ECX

	mov ECX, EDX ; Initialize loop counter and add one since N needs to display (N + 1) numbers
	inc ECX

	; Looping in order to print every number of the sequence with size N
	iterate:
		jecxz done	; Check if ECX = 0, loop counter finished

		add EBX, EAX
		call WriteDec

		mov EDX, offset insertSpace
		call WriteString

		xchg EAX, EBX

		loop iterate

	done:
		exit

main ENDP

Fib PROC

	; Base two steps before proceeding
	push EBP
	mov EBP, ESP

	inc ECX
	sub ESP, 4
	mov EAX, [EBP + 8]	; Get initial N- f(n)

	; Determining if f(n) = f(2)
	cmp EAX, 2
	je nextNum

	; Determing if f(n) = f(1)
	cmp EAX, 1
	je nextNum

	dec EAX
	push EAX	; Need to push f(n - 1)
	call Fib	; Recursive call

	mov [EBP - 4], EAX	; Store first result
	dec DWORD PTR [ESP]	
	call Fib			; Recursive call

	add ESP, 4			; Clean the stack
	add EAX, [EBP - 4]	; Store the first result once added together
	jmp done
	
	nextNum:
		mov EAX, 1

	done: 
		mov ESP, EBP
		pop EBP
		
		ret 

Fib ENDP

END main