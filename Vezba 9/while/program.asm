
main:
			PUSH	%14
			MOV 	%15,%14
			SUBS	%15,$8,%15
@main_body:
			MOV 	$1,-4(%14)
			MOV 	$3,-8(%14)
@while0:
			CMPS 	-4(%14),-8(%14)
			JGES	@true0
			ADDS	-4(%14),-4(%14),%0
			MOV 	%0,-4(%14)
			JMP		@while0
@true0:
			MOV 	-4(%14),%13
			JMP 	@main_exit
@main_exit:
			MOV 	%14,%15
			POP 	%14
			RET