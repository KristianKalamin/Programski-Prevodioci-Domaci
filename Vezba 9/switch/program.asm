
main:
			PUSH	%14
			MOV 	%15,%14
			SUBS	%15,$4,%15
@main_body:
			MOV 	$10,-4(%14)
@switch1:
			JMP		@test1
@case1:		
			MOV 	$1,-4(%14)
			JMP		@switch_exit1
@case2:		
			MOV 	$2,-4(%14)
			JMP		@switch_exit1
@default1:
			MOV 	$0,-4(%14)
			JMP		@switch_exit1
@test1:
			CMPS 	-4(%14),$10
			JEQ		@case1
			CMPS 	-4(%14),$20
			JEQ		@case2
			JMP		@default1
@switch_exit1:
			MOV 	-4(%14),%13
			JMP 	@main_exit
@main_exit:
			MOV 	%14,%15
			POP 	%14
			RET