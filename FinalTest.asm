; Final Project: Test Score Calculator
; Team: Banana
; Qi Qi, Denisse Espinoza
; This program displays the minimum, maximum, and average grade
; of five test scores and displays the letter grade associated 
; with the test score.
; Input: User inputs test scores
; Output: Displays Maximum, Minimum, Average score and letter
;	  grade equivalence on console
;	  0 - 50 = F, 60 - 69 = D, 70 - 79 = C, 80 - 89 = B, 90 - 100 = A

.ORIG x3000


LDI R1, A									;Load A into R1
LDI R2, B									;Load B into R2
LDI R3, C									;Load C into R3
LDI R4, D									;Load D into R4
LDI R5, E									;Load E into R5
JSR LOOP1									;LOOP subroutine
JSR Loop2									;LOOP subroutine
JSR AVERAGE									;Average subroutine

;Find the Average of these numbers:

AVERAGE	ADD R1, R1, R2						;R1=R1+R2
	ADD R1, R1, R3							;R1=R1+R2+R3
	ADD R1, R1, R4							;R1=R1+R2+R3+R4
	ADD R1, R1, R5							;R1=R1+R2+R3+R4+R5
	AND R6, R6, x0							;Clear R6
	ADD R6, R6, #5							;Put 5 into R6
	LD R2, AVG
	JSR DIV

DIV	ST R6, SAVE1							;Store SAVE1 into R1
	ST R1, SAVE2							;Store SAVE2 into R2
	AND R4, R4, x0	
	NOT R6, R6
	ADD R6, R6, #1							;2's compliment
	ST R4, AVG

HALT										; stops

SAVE1 .FILL x0
SAVE2 .FILL x0

;Find the MAX number:

LOOP1	AND R6, R6, #0						;Clear R6
		NOT R2, R2							;2's compliment
		ADD R2, R2, #1						;2's compliment
		ADD R6, R1, R2						;R6=R1-R2
		BRzp ZP								;branch if zero or positive
		BRn NEG								;branch if negative

ZP	ADD R1, R1, x0
	LEA R1, MAX


NEG	AND R6, R6, #0							;Clear R6
	ADD R6, R1, x0							;move the data in R1 into R6
	ADD R1, R2, x0							;Store the data in R2, into R1(Max number)
	ADD R2, R6, x0							;Move the data from R6 into R2(Min number)
	LEA R1, MAX								;Store R1(max number to MAX)
	

AND R2, R2, #0								;Clear R2
ADD R2, R2, R3								;Move the data from R3 into R3
BR LOOP1
											;Back to the loop to find the max number.


; Find the MIN number

Loop2	AND R7, R7, #0
		NOT R2, R2
		ADD R2, R2, #1
		ADD R7, R1, R2
		BRzp ZP								; branch if zero or positive 
		BRn NEG								; branch if negative

ZP	ADD R2, R2, x0
	LEA R2, Min
	
BR Loop2



A .FILL x3100
B .FILL x3101
C .FILL x3102
D .FILL x3103
E .FILL x3104

MAX .FILL x3105
MIN .FILL x3106
AVG .FILL x3107


.END
