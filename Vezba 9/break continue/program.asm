
main:
			PUSH	%14
			MOV 	%15,%14
			SUBS	%15,$8,%15
@main_body:
			MOV 	$1,-4(%14)
			MOV 	$2,-8(%14)
@while0:
			CMPS 	-4(%14),$5
			JGES	@while_false0
@if1:
			CMPS 	-4(%14),-8(%14)
			JNE 	@false1
@true1:
			JMP		@while_false0
			JMP 	@exit1
@false1:
@exit1:
			ADDS	-4(%14),$1,%0
			MOV 	%0,-4(%14)
			JMP		@while0
@while_false0:
			MOV 	-4(%14),%13
			JMP 	@main_exit
@main_exit:
			MOV 	%14,%15
			POP 	%14
			RET