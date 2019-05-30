
main:
			PUSH	%14
			MOV 	%15,%14
			SUBS	%15,$12,%15
@main_body:
			MOV 	$1,-4(%14)
			MOV 	$2,-8(%14)
			MOV 	$4,-12(%14)
@if0:
			CMPS 	-4(%14),$1
			JNE 	@false0
@true0:
			CMPS 	-12(%14),$3
			JLES	@false0
@true1:
			ADDS	-8(%14),$1,%0
			MOV 	%0,-4(%14)
			JMP 	@exit0
@false0:
@exit0:
@if1:
			CMPS 	-4(%14),$1
			JEQ 	@true2
			CMPS 	-12(%14),-8(%14)
			JNE 	@false1
@true2:
			ADDS	-12(%14),$2,%0
			MOV 	%0,-4(%14)
			JMP 	@exit1
@false1:
@exit1:
			MOV 	-4(%14),%13
			JMP 	@main_exit
@main_exit:
			MOV 	%14,%15
			POP 	%14
			RET