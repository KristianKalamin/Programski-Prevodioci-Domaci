
main:
			PUSH	%14
			MOV 	%15,%14
@main_body:
			MOV 	$7,-4(%14)
			MOV 	$88,-8(%14)
			ADDS	$1,-4(%14),%0
			MOV 	%0,%13
			JMP 	@main_exit
@main_exit:
			MOV 	%14,%15
			POP 	%14
			RET