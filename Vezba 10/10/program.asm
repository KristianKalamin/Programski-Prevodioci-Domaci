
main:
			PUSH	%14
			MOV 	%15,%14
			SUBS	%15,$28,%15
@main_body:
			MOV 	$2,-4(%14)
			MOV 	$5,-12(%14)
			MOV 	$1,-16(%14)
			MOV 	$6,-24(%14)
			MOV 	$11,-28(%14)
			MOV 	$1,-20(%14)
			ADDS	-12(%14),-24(%14),%0
			ADDS	%0,-20(%14),%0
			ADDS	%0,-16(%14),%0
			SUBS	%0,-28(%14),%0
			MOV 	%0,-4(%14)
			MOV 	-4(%14),%13
			JMP 	@main_exit
@main_exit:
			MOV 	%14,%15
			POP 	%14
			RET