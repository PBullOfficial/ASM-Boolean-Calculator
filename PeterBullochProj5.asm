; // Peter Bulloch's Project 6 for CSCI321_VA!
; // This program functions as a simple 
; // Boolean calculator for 32-bit integers

INCLUDE Irvine32.inc
.386
; // .model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data

boolCalc BYTE "---- Boolean Calculator ----------", 13, 10, 0; // Displays and formats menu. 13,10 creates a new line
optionOne BYTE "1. x AND y", 13, 10, 0
optionTwo BYTE "2. x OR y", 13, 10, 0
optionThree BYTE "3. NOT x", 13, 10, 0
optionFour BYTE "4. x XOR y", 13, 10, 0
optionFive BYTE "5. Exit program", 13, 10, 0
prompt BYTE "Enter integer> ", 0
testMsg BYTE "Test complete", 0

; // Table-Driven Selection technique
CaseTable BYTE '1'; // lookup value
		DWORD Process_1; // adress of procedure
EntrySize = ($ - CaseTable)
		BYTE '2'
		DWORD Process_2
		BYTE '3'
		DWORD Process_3
		BYTE '4'
		DWORD Process_4
		BYTE '5'
		DWORD Process_5
NumberOfEntries = ($ - CaseTable) / EntrySize;// Acts as loop counter for table

;// Messages to display after a menu selection is made
msg1 BYTE "Boolean AND", 13, 10, 0
msg2 BYTE "Boolean OR", 13, 10, 0
msg3 BYTE "Boolean NOT", 13, 10, 0
msg4 BYTE "Boolean XOR", 13, 10, 0
msg5 BYTE "Thank you for using FHSU Boolean Calculator. Good-bye!", 13, 10, 0

input32Msg1 BYTE "Input the first 32-bit hexadecimal operand:  ", 0
input32Msg2 BYTE "Input the second 32-bit hexadecimal operand: ", 0
output32Msg BYTE "The 32-bit hexadecimal result is:            ", 0
hexVal1 DWORD ?
hexVal2 DWORD ?

.code
main PROC

repeatMenu:
	call Clrscr
	call menu
	call ReadChar
	call WriteChar

	mov ebx, OFFSET CaseTable; // point EBX to the menu table
	mov ecx, NumberOfEntries; // set loop counter

L1: 
	cmp al, [ebx]
	jne L2
	call NEAR PTR [ebx + 1]
	call WriteString
	call Crlf
	jmp L3
L2:
	add ebx, EntrySize
	loop L1
L3: 
	loop repeatMenu

main ENDP

;// displays menu
;// Receives: nothing
;// Returns: nothing
menu PROC 
	mov edx, offset boolCalc
	call WriteString
	call Crlf;// New line
	mov edx, offset optionOne
	call WriteString
	mov edx, offset optionTwo
	call WriteString
	mov edx, offset optionThree
	call WriteString
	mov edx, offset optionFour
	call WriteString
	mov edx, offset optionFive
	call WriteString
	call Crlf
	mov edx, offset prompt
	call WriteString
	ret
menu ENDP

;// Boolean AND procedure
;// Receives: two 32-bit hexadecimal numbers
;// Returns: nothing (written to screen in-process)
Process_1 PROC
	call Crlf
	call Crlf
	mov edx, offset msg1
	call WriteString
	call Crlf
	mov edx, offset input32Msg1
	call WriteString
	call ReadHex
	mov hexVal1, eax
	mov edx, offset input32Msg2
	call WriteString
	call ReadHex
	AND eax, hexVal1
	mov edx, offset output32Msg
	call WriteString
	call WriteHex
	call Crlf
	call WaitMsg
	ret
Process_1 ENDP

;// Boolean OR procedure
;// Receives: two 32-bit hexadecimal numbers
;// Returns: nothing (written to screen in-process)
Process_2 PROC
	call Crlf
	call Crlf
	mov edx, offset msg2
	call WriteString
	call Crlf
	mov edx, offset input32Msg1
	call WriteString
	call ReadHex
	mov hexVal1, eax
	mov edx, offset input32Msg2
	call WriteString
	call ReadHex
	OR eax, hexVal1
	mov edx, offset output32Msg
	call WriteString
	call WriteHex
	call Crlf
	call WaitMsg
	ret
Process_2 ENDP

;// Boolean NOT procedure
;// Receives: one 32-bit hexadecimal number
;// Returns: nothing (written to screen in-process)
Process_3 PROC
	call Crlf
	call Crlf
	mov edx, offset msg3
	call WriteString
	call Crlf
	mov edx, offset input32Msg1
	call WriteString
	call ReadHex
	NOT eax
	mov edx, offset output32Msg
	call WriteString
	call WriteHex
	call Crlf
	call WaitMsg
	ret
Process_3 ENDP

;// Boolean XOR procedure
;// Receives: two 32-bit hexadecimal numbers
;// Returns: nothing (written to screen in-process)
Process_4 PROC
	call Crlf
	call Crlf
	mov edx, offset msg4
	call WriteString
	call Crlf
	mov edx, offset input32Msg1
	call WriteString
	call ReadHex
	mov hexVal1, eax
	mov edx, offset input32Msg2
	call WriteString
	call ReadHex
	XOR eax, hexVal1
	mov edx, offset output32Msg
	call WriteString
	call WriteHex
	call Crlf
	call WaitMsg
	ret
Process_4 ENDP

;// Exit process
;// Receives: nothing
;// Returns: nothing
Process_5 PROC
	call Crlf
	call Crlf
	mov edx, offset msg5
	call WriteString
	call WaitMsg
	INVOKE ExitProcess, 0
Process_5 ENDP

END main