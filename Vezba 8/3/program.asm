
abs:
			PUSH	%14
			MOV 	%15,%14
@abs_body:
			ADDS	8(%14),12(%14),%0
			MOV 	%0,%13
			JMP 	@abs_exit
@abs_exit:
			MOV 	%14,%15
			POP 	%14
			RET
main:
			PUSH	%14
			MOV 	%15,%14
			SUBS	%15,$4,%15
@main_body:
			PUSH	$10
			PUSH	$20
			CALL	abs
			ADDS	%15,$8,%15
			MOV 	%13,%0
			MOV 	%0,-4(%14)
			MOV 	-4(%14),%13
			JMP 	@main_exit
@main_exit:
			MOV 	%14,%15
			POP 	%14
			RET