.data

.balign	4
scan_pattern:	.asciz "%d"

.balign	4
print_pattern:	.asciz "Sum=%d\n"

.balign	4
number1:	.word 0

.balign	4
number2:	.word 0

.balign	4
number3:	.word 0

.balign	4
return:		.word 0

.text
.global main
.func main
main:	LDR R1, =return
	STR LR, [R1]

/*	scanf("%d", &number1); */
	LDR R0, =scan_pattern
	LDR R1, =number1
	BL scanf

/*	scanf("%d", &number2); */
	LDR R0, =scan_pattern
	LDR R1, =number2
	BL scanf

	LDR R1, =number1	
	LDR R1, [R1]

	LDR R2, =number2	
	LDR R2, [R2]

	ADD R3, R2, R1

	LDR R1, =number3
	STR R3, [R1]

/*	printf("Sum=%d\n", number3); */
	LDR R0, =print_pattern
	LDR R1, =number3
	LDR R1, [R1] 
	BL printf

	LDR LR, =return
	LDR LR, [LR]
	BX LR

.global scanf
.global printf
.end
