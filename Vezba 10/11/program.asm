
main:
			PUSH	%14
			MOV 	%15,%14
			SUBS	%15,$32,%15
@main_body:
			MOV 	$1,-4(%14)
			MOV 	$2,-28(%14)
			MOV 	$5,-8(%14)
			MOV 	$1,-12(%14)
			MOV 	-8(%14),-12(%14)
			SUBS	-4(%14),-28(%14),%0
			MOV 	%0,-32(%14)
			ADDS	-4(%14),-8(%14),%0
			ADDS	%0,-12(%14),%0
			MOV 	%0,-4(%14)
			MOV 	-4(%14),%13
			JMP 	@main_exit
@main_exit:
			MOV 	%14,%15
			POP 	%14
			RET